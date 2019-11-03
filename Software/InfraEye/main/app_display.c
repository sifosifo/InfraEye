/*
 * app_display.c
 *
 * Created on: 		01-05-2019
 * Author: 			Martin Humaj
 *
 */


/************************************************************************************/
/* INCLUDES																			*/
/************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "esp_system.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/spi_master.h"
#include "soc/gpio_struct.h"
#include "driver/gpio.h"
#include "esp32/rom/tjpgd.h"
#include "esp_log.h"

#include "app_display.h"

/************************************************************************************/
/* DEFINES																			*/
/************************************************************************************/

/************************************************************************************/
/* MODULE VARIABLES																	*/
/************************************************************************************/

DRAM_ATTR static const lcd_init_cmd_t app_disp_sILI_InitCmds[] =
{
    /* Power contorl B, power control = 0, DC_ENA = 1 */
    {0xCF, {0x00, 0x83, 0X30}, 3},
    /* Power on sequence control,
     * cp1 keeps 1 frame, 1st frame enable
     * vcl = 0, ddvdh=3, vgh=1, vgl=2
     * DDVDH_ENH=1
     */
    {0xED, {0x64, 0x03, 0X12, 0X81}, 4},
    /* Driver timing control A,
     * non-overlap=default +1
     * EQ=default - 1, CR=default
     * pre-charge=default - 1
     */
    {0xE8, {0x85, 0x01, 0x79}, 3},
    /* Power control A, Vcore=1.6V, DDVDH=5.6V */
    {0xCB, {0x39, 0x2C, 0x00, 0x34, 0x02}, 5},
    /* Pump ratio control, DDVDH=2xVCl */
    {0xF7, {0x20}, 1},
    /* Driver timing control, all=0 unit */
    {0xEA, {0x00, 0x00}, 2},
    /* Power control 1, GVDD=4.75V */
    {0xC0, {0x26}, 1},
    /* Power control 2, DDVDH=VCl*2, VGH=VCl*7, VGL=-VCl*3 */
    {0xC1, {0x11}, 1},
    /* VCOM control 1, VCOMH=4.025V, VCOML=-0.950V */
    {0xC5, {0x35, 0x3E}, 2},
    /* VCOM control 2, VCOMH=VMH-2, VCOML=VML-2 */
    {0xC7, {0xBE}, 1},
    /* Memory access contorl, MX=MY=0, MV=1, ML=0, BGR=1, MH=0 */
    {0x36, {0x28}, 1},
    /* Pixel format, 16bits/pixel for RGB/MCU interface */
    {0x3A, {0x55}, 1},
    /* Frame rate control, f=fosc, 70Hz fps */
    {0xB1, {0x00, 0x1B}, 2},
    /* Enable 3G, disabled */
    {0xF2, {0x08}, 1},
    /* Gamma set, curve 1 */
    {0x26, {0x01}, 1},
    /* Positive gamma correction */
    {0xE0, {0x1F, 0x1A, 0x18, 0x0A, 0x0F, 0x06, 0x45, 0X87, 0x32, 0x0A, 0x07, 0x02, 0x07, 0x05, 0x00}, 15},
    /* Negative gamma correction */
    {0XE1, {0x00, 0x25, 0x27, 0x05, 0x10, 0x09, 0x3A, 0x78, 0x4D, 0x05, 0x18, 0x0D, 0x38, 0x3A, 0x1F}, 15},
    /* Column address set, SC=0, EC=0xEF */
    {0x2A, {0x00, 0x00, 0x00, 0xEF}, 4},
    /* Page address set, SP=0, EP=0x013F */
    {0x2B, {0x00, 0x00, 0x01, 0x3f}, 4},
    /* Memory write */
    {0x2C, {0}, 0},
    /* Entry mode set, Low vol detect disabled, normal display */
    {0xB7, {0x07}, 1},
    /* Display function control */
    {0xB6, {0x0A, 0x82, 0x27, 0x00}, 4},
    /* Sleep out */
    {0x11, {0}, 0x80},
    /* Display on */
    {0x29, {0}, 0x80},
    {0, {0}, 0xff},
};

#if 0
//Reference the binary-included jpeg file
extern const uint8_t image_jpg_start[]   asm("_binary_image_jpg_start");
extern const uint8_t image_jpg_end[]     asm("_binary_image_jpg_end");

const char *TAG="ImageDec";
#endif

static spi_device_handle_t app_disp_psSPI_Device;

static spi_bus_config_t app_disp_sBusCfg =
{
	.miso_io_num = PIN_NUM_MISO,
	.mosi_io_num = PIN_NUM_MOSI,
	.sclk_io_num = PIN_NUM_CLK,
	.quadwp_io_num = -1,
	.quadhd_io_num = -1,
	.max_transfer_sz = app_disp_PARALLEL_LINES_D*DISP_COLUMNS_D*2 + 8
};

static spi_device_interface_config_t app_disp_sDevCfg =
{

	.clock_speed_hz = 26*1000*1000,           //Clock out at 26 MHz
	.mode = 0,                                //SPI mode 0
	.spics_io_num = PIN_NUM_CS,               //CS pin
	.queue_size = 7,                          //We want to be able to queue 7 transactions at a time
	.pre_cb = app_disp_vLCD_SPI_PreTransferCallback,  //Specify pre-transfer callback to handle D/C line
};

static uint16_t* app_disp_pu16DispPixels;

#if ENABLE_DISP_FRAME_RATE_MEASURE_D
	static uint32_t app_disp_u32FrameTime_ms = 0uL;
#endif

/************************************************************************************/
/* FUNCTION PROTOTYPES																*/
/************************************************************************************/

static void app_disp_vLCD_Init(spi_device_handle_t psSPI_Device);

static void app_disp_vLCD_Cmd(spi_device_handle_t psSPI_Device, const uint8_t u8Cmd);

static void app_disp_vLCD_SendData(spi_device_handle_t psSPI_Device, const uint8_t *pu8Data, int intLength);

static void app_disp_vSendLines(spi_device_handle_t psSPI_Device, int intPosY, uint16_t *pu16LineData);

static void app_disp_vSendLineFinish(spi_device_handle_t spi);

/************************************************************************************/
/* FUNCTION DEFINITIONS																*/
/************************************************************************************/

void app_disp_vInitialize(void)
{

	esp_err_t i32Return;

	/* Initialize the SPI bus */
	i32Return = spi_bus_initialize(HSPI_HOST, &app_disp_sBusCfg, 1);
	ESP_ERROR_CHECK(i32Return);

	/* Attach the LCD to the SPI bus */
	i32Return = spi_bus_add_device(HSPI_HOST, &app_disp_sDevCfg, &app_disp_psSPI_Device);
	ESP_ERROR_CHECK(i32Return);

	/* Initialize the LCD */
	app_disp_vLCD_Init(app_disp_psSPI_Device);
	heap_caps_print_heap_info(MALLOC_CAP_DMA);
	app_disp_pu16DispPixels = heap_caps_malloc(DISP_COLUMNS_D*DISP_ROWS_D*sizeof(uint16_t), MALLOC_CAP_DMA);
	heap_caps_print_heap_info(MALLOC_CAP_DMA);
    assert(app_disp_pu16DispPixels != NULL);

}


/* Send a command to the LCD. Uses spi_device_polling_transmit, which waits
 * until the transfer is complete.
 *
 * Since command transactions are usually small, they are handled in polling
 * mode for higher speed. The overhead of interrupt transactions is more than
 * just waiting for the transaction to complete.
 */
static void app_disp_vLCD_Cmd(spi_device_handle_t psSPI_Device, const uint8_t u8Cmd)
{
    esp_err_t i32Return;
    spi_transaction_t sTransaction;

    memset(&sTransaction, 0, sizeof(sTransaction)); 		//Zero out the transaction
    sTransaction.length = 8;                     			//Command is 8 bits
    sTransaction.tx_buffer = &u8Cmd;               			//The data is the cmd itself
    sTransaction.user = (void*)0;                			//D/C needs to be set to 0
    i32Return = spi_device_polling_transmit(psSPI_Device, &sTransaction);  //Transmit!
    assert(i32Return == ESP_OK);            				//Should have had no issues.
}

/* Send data to the LCD. Uses spi_device_polling_transmit, which waits until the
 * transfer is complete.
 *
 * Since data transactions are usually small, they are handled in polling
 * mode for higher speed. The overhead of interrupt transactions is more than
 * just waiting for the transaction to complete.
 */
static void app_disp_vLCD_SendData(spi_device_handle_t psSPI_Device, const uint8_t *pu8Data, int intLength)
{
    esp_err_t i32Return;
    spi_transaction_t sTransaction;

    if (intLength == 0)
    {
        //no need to send anything
    	return;
    }

    memset(&sTransaction, 0, sizeof(sTransaction));     //Zero out the transaction
    sTransaction.length = intLength*8;                 	//Len is in bytes, transaction length is in bits.
    sTransaction.tx_buffer = pu8Data;               	//Data
    sTransaction.user = (void*)1;                		//D/C needs to be set to 1
    i32Return = spi_device_polling_transmit(psSPI_Device, &sTransaction);  //Transmit!

    assert(i32Return == ESP_OK);            //Should have had no issues.
}

//This function is called (in irq context!) just before a transmission starts. It will
//set the D/C line to the value indicated in the user field.
void app_disp_vLCD_SPI_PreTransferCallback(spi_transaction_t *psTransaction)
{
    int intDC = (int)psTransaction->user;

    gpio_set_level(PIN_NUM_DC, intDC);
}

uint32_t app_disp_u32LCD_GetID(void)
{
    // get_id command
    app_disp_vLCD_Cmd(app_disp_psSPI_Device, 0x04);

    spi_transaction_t sTransaction;
    memset(&sTransaction, 0, sizeof(sTransaction));
    sTransaction.length = 8*3;
    sTransaction.flags = SPI_TRANS_USE_RXDATA;
    sTransaction .user = (void*)1;

    esp_err_t ret = spi_device_polling_transmit(app_disp_psSPI_Device, &sTransaction);
    assert( ret == ESP_OK );

    return *(uint32_t*)sTransaction.rx_data;
}

//Initialize the display
static void app_disp_vLCD_Init(spi_device_handle_t psSPI_Device)
{
    int intCmd = 0;
    const lcd_init_cmd_t* psLCD_InitCmds;

    // Initialize non-SPI GPIOs
    gpio_set_direction(PIN_NUM_DC, GPIO_MODE_OUTPUT);
    gpio_set_direction(PIN_NUM_RST, GPIO_MODE_OUTPUT);
    gpio_set_direction(PIN_NUM_BCKL, GPIO_MODE_OUTPUT);

    // Reset the display
    gpio_set_level(PIN_NUM_RST, 0);
    vTaskDelay(100 / portTICK_RATE_MS);
    gpio_set_level(PIN_NUM_RST, 1);
    vTaskDelay(100 / portTICK_RATE_MS);

    psLCD_InitCmds = app_disp_sILI_InitCmds;

    //Send all the commands
    while (psLCD_InitCmds[intCmd].databytes != 0xFF)
    {
        app_disp_vLCD_Cmd(psSPI_Device, psLCD_InitCmds[intCmd].cmd);

        app_disp_vLCD_SendData(psSPI_Device, psLCD_InitCmds[intCmd].data, psLCD_InitCmds[intCmd].databytes & 0x1F);
        if (psLCD_InitCmds[intCmd].databytes & 0x80)
        {
            vTaskDelay(100 / portTICK_RATE_MS);
        }
        intCmd ++;
    }

    ///Enable backlight
    gpio_set_level(PIN_NUM_BCKL, 0);
}


/* To send a set of lines we have to send a command, 2 data bytes, another command, 2 more data bytes and another command
 * before sending the line data itself; a total of 6 transactions. (We can't put all of this in just one transaction
 * because the D/C line needs to be toggled in the middle.)
 * This routine queues these commands up as interrupt transactions so they get
 * sent faster (compared to calling spi_device_transmit several times), and at
 * the mean while the lines for next transactions can get calculated.
 */
static void app_disp_vSendLines(spi_device_handle_t psSPI_Device, int intPosY, uint16_t *pu16LineData)
{
    esp_err_t i32Return;
    int x;
    //Transaction descriptors. Declared static so they're not allocated on the stack; we need this memory even when this
    //function is finished because the SPI driver needs access to it even while we're already calculating the next line.
    static spi_transaction_t asTransaction[6];

    //In theory, it's better to initialize trans and data only once and hang on to the initialized
    //variables. We allocate them on the stack, so we need to re-init them each call.
    for (x = 0; x < 6; x++)
    {
        memset(&asTransaction[x], 0, sizeof(spi_transaction_t));
        if ((x & 1) == 0)
        {
            //Even transfers are commands
            asTransaction[x].length = 8;
            asTransaction[x].user = (void*)0;
        }
        else
        {
            //Odd transfers are data
            asTransaction[x].length = 8*4;
            asTransaction[x].user = (void*)1;
        }
        asTransaction[x].flags = SPI_TRANS_USE_TXDATA;
    }

    asTransaction[0].tx_data[0] = 0x2A;           //Column Address Set
    asTransaction[1].tx_data[0] = 0;              //Start Col High
    asTransaction[1].tx_data[1] = 0;              //Start Col Low
    asTransaction[1].tx_data[2] = (DISP_COLUMNS_D) >> 8;     //End Col High
    asTransaction[1].tx_data[3] = (DISP_COLUMNS_D) & 0xFF;   //End Col Low
    asTransaction[2].tx_data[0] = 0x2B;           //Page address set
    asTransaction[3].tx_data[0] = intPosY >> 8;        //Start page high
    asTransaction[3].tx_data[1] = intPosY & 0xFF;      //start page low
    asTransaction[3].tx_data[2] = (intPosY + app_disp_PARALLEL_LINES_D) >> 8;    	//end page high
    asTransaction[3].tx_data[3] = (intPosY + app_disp_PARALLEL_LINES_D) & 0xFF;  	//end page low
    asTransaction[4].tx_data[0] = 0x2C;           //memory write
    asTransaction[5].tx_buffer = pu16LineData;    //finally send the line data
    asTransaction[5].length = DISP_COLUMNS_D*2*8*app_disp_PARALLEL_LINES_D;          //Data length, in bits
    asTransaction[5].flags = 0; //undo SPI_TRANS_USE_TXDATA flag

    //Queue all transactions.
    for (x = 0; x < 6; x++)
    {
    	i32Return = spi_device_queue_trans(psSPI_Device, &asTransaction[x], portMAX_DELAY);
        assert(i32Return == ESP_OK);
    }

    //When we are here, the SPI driver is busy (in the background) getting the transactions sent. That happens
    //mostly using DMA, so the CPU doesn't have much to do here. We're not going to wait for the transaction to
    //finish because we may as well spend the time calculating the next line. When that is done, we can call
    //send_line_finish, which will wait for the transfers to be done and check their status.
}


static void app_disp_vSendLineFinish(spi_device_handle_t psSPI_Device)
{
    spi_transaction_t *psTransaction;
    esp_err_t i32Return;

    //Wait for all 6 transactions to be done and get back the results.
    for (int x = 0; x < 6; x++)
    {
        i32Return = spi_device_get_trans_result(psSPI_Device, &psTransaction, portMAX_DELAY);

        assert(i32Return == ESP_OK);
        //We could inspect rtrans now if we received any info back. The LCD is treated as write-only, though.
    }
}


void app_disp_vRunDisplayTask(void)
{

	static uint16_t u16DispColumnsCounter = 0u;
	static uint8_t u8FirstTime = 1u;
	static uint32_t u32StartTime = 0uL;
	static uint32_t u32EndTime = 0uL;

	uint16_t* pu16Pixels;

	if(u8FirstTime == 0u)
	{
		/* Wait for finishing previous transaction */
		app_disp_vSendLineFinish(app_disp_psSPI_Device);
	}
	else
	{
#if ENABLE_DISP_FRAME_RATE_MEASURE_D
		/* Start to measure time */
		u32StartTime = (uint32_t)xTaskGetTickCount();
#endif
		u8FirstTime = 0u;
	}

	if(u16DispColumnsCounter == DISP_COLUMNS_D)
	{
#if ENABLE_DISP_FRAME_RATE_MEASURE_D
		/* Stop measuring time after one frame was displayed */
		u32EndTime = (uint32_t)xTaskGetTickCount();
		/* Calculate elapsed time */
		app_disp_u32FrameTime_ms = u32EndTime - u32StartTime;
#endif
		u16DispColumnsCounter = 0u;
#if ENABLE_DISP_FRAME_RATE_MEASURE_D
		/* Start to measure time */
		u32StartTime = (uint32_t)xTaskGetTickCount();
#endif
	}

	pu16Pixels = app_disp_pu16DispPixels + (u16DispColumnsCounter*DISP_ROWS_D);

	/* Display section */
	app_disp_vSendLines(app_disp_psSPI_Device, u16DispColumnsCounter, pu16Pixels);
	/* Increment column counter */
	u16DispColumnsCounter += app_disp_PARALLEL_LINES_D;

}

void app_disp_vSetRectangleColour(uint16_t u16ColPos, uint16_t u16RowPos, uint16_t u16ColLength, uint16_t u16RowLength, uint16_t u16Colour)
{
	uint16_t u16ColIterator;
	uint16_t u16RowIterator;
	uint16_t* pu16Pixels;

	for(u16ColIterator = u16ColPos; u16ColIterator < (u16ColPos + u16ColLength); u16ColIterator++)
	{
		for(u16RowIterator = u16RowPos; u16RowIterator < (u16RowPos + u16RowLength); u16RowIterator++)
		{
			pu16Pixels = app_disp_pu16DispPixels + ((u16ColIterator * DISP_ROWS_D) + u16RowIterator);
			*pu16Pixels = u16Colour;
		}
	}

}

#if ENABLE_DISP_FRAME_RATE_MEASURE_D
uint16_t app_disp_u16GetFrameRate(void)
{
	return(1000/app_disp_u32FrameTime_ms);
}
#endif
