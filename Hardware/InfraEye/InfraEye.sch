EESchema Schematic File Version 4
LIBS:InfraEye-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L InfraEye:MLX90640 U1
U 1 1 5E2A1863
P 1300 1050
F 0 "U1" H 1450 1225 50  0000 C CNN
F 1 "MLX90640" H 1450 1134 50  0000 C CNN
F 2 "InfraEye:MLX90614" H 1350 1200 50  0001 C CNN
F 3 "" H 1350 1200 50  0001 C CNN
	1    1300 1050
	1    0    0    -1  
$EndComp
$Comp
L InfraEye:TFT_SPI_24_LCD U3
U 1 1 5E2A99BF
P 6700 2850
F 0 "U3" H 7025 3015 50  0000 C CNN
F 1 "TFT_SPI_24_LCD" H 7025 2924 50  0000 C CNN
F 2 "InfraEye:TFT_LCD_24" H 8950 2800 50  0001 C CNN
F 3 "" H 8950 2800 50  0001 C CNN
	1    6700 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1300 1850 1300
Wire Wire Line
	1000 1300 1200 1300
Wire Wire Line
	1700 1100 2500 1100
Wire Wire Line
	1200 1100 1150 1100
$Comp
L Device:C C1
U 1 1 5E2B3FCF
P 1850 1550
F 0 "C1" H 1965 1596 50  0000 L CNN
F 1 "10nF" H 1965 1505 50  0000 L CNN
F 2 "OLIMEX_RLC-FP:C_1206_5MIL_DWS_ISO" H 1888 1400 50  0001 C CNN
F 3 "~" H 1850 1550 50  0001 C CNN
	1    1850 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5E2B489C
P 2300 1550
F 0 "C2" H 2415 1596 50  0000 L CNN
F 1 "100nF" H 2415 1505 50  0000 L CNN
F 2 "OLIMEX_RLC-FP:C_1206_5MIL_DWS_ISO" H 2338 1400 50  0001 C CNN
F 3 "~" H 2300 1550 50  0001 C CNN
	1    2300 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 1400 2300 1300
Wire Wire Line
	1850 1400 1850 1300
Connection ~ 1850 1300
Wire Wire Line
	1850 1300 2300 1300
Wire Wire Line
	1850 1700 1850 1800
Wire Wire Line
	1850 1800 1000 1800
Connection ~ 1000 1800
Wire Wire Line
	1000 1800 1000 1300
Wire Wire Line
	2300 1700 2300 1800
Wire Wire Line
	2300 1800 1850 1800
Connection ~ 1850 1800
$Comp
L Device:R R1
U 1 1 5E2B9457
P 4600 5900
F 0 "R1" V 4393 5900 50  0000 C CNN
F 1 "R" V 4484 5900 50  0000 C CNN
F 2 "OLIMEX_RLC-FP:R_1206_5MIL_DWS_ISO" V 4530 5900 50  0001 C CNN
F 3 "~" H 4600 5900 50  0001 C CNN
	1    4600 5900
	0    1    1    0   
$EndComp
$Comp
L Device:Q_NPN_BCE Q1
U 1 1 5E2BA2F2
P 4950 5900
F 0 "Q1" H 5141 5946 50  0000 L CNN
F 1 "Q_NPN_BCE" H 5141 5855 50  0000 L CNN
F 2 "OLIMEX_Diodes-FP:SOT23-3" H 5150 6000 50  0001 C CNN
F 3 "~" H 4950 5900 50  0001 C CNN
	1    4950 5900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5E2BB6A2
P 5300 6200
F 0 "R2" H 5230 6154 50  0000 R CNN
F 1 "R" H 5230 6245 50  0000 R CNN
F 2 "OLIMEX_RLC-FP:R_1206_5MIL_DWS_ISO" V 5230 6200 50  0001 C CNN
F 3 "~" H 5300 6200 50  0001 C CNN
	1    5300 6200
	0    -1   -1   0   
$EndComp
$Comp
L InfraEye:MLX90640 U4
U 1 1 5E336D8C
P 1300 2150
F 0 "U4" H 1450 2325 50  0000 C CNN
F 1 "MLX90640" H 1450 2234 50  0000 C CNN
F 2 "InfraEye:MLX90614" H 1350 2300 50  0001 C CNN
F 3 "" H 1350 2300 50  0001 C CNN
	1    1300 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5E337496
P 1800 2650
F 0 "C3" H 1915 2696 50  0000 L CNN
F 1 "10nF" H 1915 2605 50  0000 L CNN
F 2 "OLIMEX_RLC-FP:C_1206_5MIL_DWS_ISO" H 1838 2500 50  0001 C CNN
F 3 "~" H 1800 2650 50  0001 C CNN
	1    1800 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5E337BD5
P 2300 2650
F 0 "C4" H 2415 2696 50  0000 L CNN
F 1 "100nF" H 2415 2605 50  0000 L CNN
F 2 "OLIMEX_RLC-FP:C_1206_5MIL_DWS_ISO" H 2338 2500 50  0001 C CNN
F 3 "~" H 2300 2650 50  0001 C CNN
	1    2300 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 2200 1150 2200
Wire Wire Line
	1000 1800 1000 2400
Wire Wire Line
	1200 2400 1000 2400
Connection ~ 1000 2400
Wire Wire Line
	1000 2400 1000 2850
Wire Wire Line
	2300 2800 2300 2850
Wire Wire Line
	2300 2850 1800 2850
Connection ~ 1000 2850
Wire Wire Line
	1000 2850 1000 2900
Wire Wire Line
	1800 2800 1800 2850
Connection ~ 1800 2850
Wire Wire Line
	1800 2850 1000 2850
Wire Wire Line
	1700 2400 1800 2400
Wire Wire Line
	1800 2400 1800 2500
Wire Wire Line
	1800 2400 2300 2400
Wire Wire Line
	2300 2400 2300 2500
Connection ~ 1800 2400
$Comp
L power:+3V3 #PWR0101
U 1 1 5E3D5A6D
P 1850 1300
F 0 "#PWR0101" H 1850 1150 50  0001 C CNN
F 1 "+3V3" H 1865 1473 50  0000 C CNN
F 2 "" H 1850 1300 50  0001 C CNN
F 3 "" H 1850 1300 50  0001 C CNN
	1    1850 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 2200 2500 1100
Wire Wire Line
	1150 1100 1150 1900
$Comp
L power:+3V3 #PWR0102
U 1 1 5E3EA727
P 1800 2400
F 0 "#PWR0102" H 1800 2250 50  0001 C CNN
F 1 "+3V3" H 1815 2573 50  0000 C CNN
F 2 "" H 1800 2400 50  0001 C CNN
F 3 "" H 1800 2400 50  0001 C CNN
	1    1800 2400
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0103
U 1 1 5E3EBF07
P 5050 5700
F 0 "#PWR0103" H 5050 5550 50  0001 C CNN
F 1 "+3V3" H 5065 5873 50  0000 C CNN
F 2 "" H 5050 5700 50  0001 C CNN
F 3 "" H 5050 5700 50  0001 C CNN
	1    5050 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 4400 4100 4400
Wire Wire Line
	4200 4800 4200 4500
Wire Wire Line
	7000 4800 7000 4900
Wire Wire Line
	7100 4800 7100 5000
Wire Wire Line
	7100 5000 3900 5000
Wire Wire Line
	7200 4800 7200 5100
Wire Wire Line
	7200 5100 3800 5100
Wire Wire Line
	7300 4800 7300 5200
Wire Wire Line
	7300 5200 3700 5200
Wire Wire Line
	7400 4800 7400 5300
Wire Wire Line
	7400 5300 3600 5300
Wire Wire Line
	5050 6100 5050 6200
Wire Wire Line
	5050 6200 5150 6200
Wire Wire Line
	5450 6200 7500 6200
Wire Wire Line
	7500 6200 7500 5900
Wire Wire Line
	4100 4400 4100 6450
Wire Wire Line
	4100 6450 5500 6450
Wire Wire Line
	5950 6450 5950 6500
Wire Wire Line
	5950 6450 6900 6450
Wire Wire Line
	6900 6450 6900 4800
Connection ~ 5950 6450
Wire Wire Line
	5400 4400 5500 4400
Wire Wire Line
	5500 4400 5500 6450
Connection ~ 5500 6450
Wire Wire Line
	5500 6450 5950 6450
Wire Wire Line
	8200 4800 8200 5500
Wire Wire Line
	8200 5500 5600 5500
Wire Wire Line
	5600 5500 5600 4300
Wire Wire Line
	5600 4300 5400 4300
Wire Wire Line
	7900 4800 7900 5600
Wire Wire Line
	7900 5600 5700 5600
Wire Wire Line
	5700 5600 5700 4200
Wire Wire Line
	5700 4200 5400 4200
Wire Wire Line
	8100 4800 8100 4900
Wire Wire Line
	8100 4900 8400 4900
Wire Wire Line
	8400 4900 8400 2650
Wire Wire Line
	8400 2650 7450 2650
Wire Wire Line
	7450 2650 7450 2750
Wire Wire Line
	8000 4800 8000 5000
Wire Wire Line
	8000 5000 8500 5000
Wire Wire Line
	8500 5000 8500 2550
Wire Wire Line
	8500 2550 7550 2550
Wire Wire Line
	7550 2550 7550 2750
Wire Wire Line
	7800 4800 7800 5100
Wire Wire Line
	7800 5100 8600 5100
Wire Wire Line
	8600 5100 8600 2450
Wire Wire Line
	8600 2450 7650 2450
Wire Wire Line
	7650 2450 7650 2750
Wire Wire Line
	7350 2750 7350 2650
Wire Wire Line
	7450 2650 7450 2550
Wire Wire Line
	7450 2550 5600 2550
Wire Wire Line
	5600 3600 5400 3600
Connection ~ 7450 2650
Wire Wire Line
	7550 2550 7550 2450
Wire Wire Line
	7550 2450 5700 2450
Wire Wire Line
	5700 2450 5700 3700
Wire Wire Line
	5700 3700 5400 3700
Connection ~ 7550 2550
Wire Wire Line
	7650 2450 7650 2350
Wire Wire Line
	7650 2350 5800 2350
Wire Wire Line
	5800 2350 5800 3800
Wire Wire Line
	5800 3800 5400 3800
Connection ~ 7650 2450
Wire Wire Line
	3500 5900 4450 5900
Wire Wire Line
	1700 2200 2500 2200
Connection ~ 2500 2200
Wire Wire Line
	2500 2200 3400 2200
Wire Wire Line
	5600 2550 5600 3600
Wire Wire Line
	5400 3400 6000 3400
Wire Wire Line
	6000 3400 6000 2650
Wire Wire Line
	6000 2650 7350 2650
Wire Wire Line
	3400 2200 3400 3100
Wire Wire Line
	3500 3500 4200 3500
Wire Wire Line
	3500 3500 3500 5900
Wire Wire Line
	4200 3100 3400 3100
Wire Wire Line
	4200 3200 3300 3200
Wire Wire Line
	3300 3200 3300 1900
Wire Wire Line
	3300 1900 1150 1900
Connection ~ 1150 1900
Wire Wire Line
	1150 1900 1150 2200
Wire Wire Line
	5400 3500 5900 3500
Wire Wire Line
	5900 3500 5900 5400
Wire Wire Line
	5900 5400 7600 5400
Wire Wire Line
	7600 5400 7600 4800
Wire Wire Line
	4200 3600 3600 3600
Wire Wire Line
	3600 3600 3600 5300
Wire Wire Line
	4200 3700 3700 3700
Wire Wire Line
	3700 3700 3700 5200
Wire Wire Line
	4200 3800 3800 3800
Wire Wire Line
	3800 3800 3800 5100
Wire Wire Line
	4000 4900 7000 4900
$Comp
L InfraEye-rescue:ESP32-WROOM-32-InfraEye U2
U 1 1 5E2A6228
P 5300 2950
F 0 "U2" H 5350 3000 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 5800 2900 50  0000 C CNN
F 2 "InfraEye:ESP32-WROOM-32-30pin" H 5300 1450 50  0001 C CNN
F 3 "" H 5000 3000 50  0001 C CNN
	1    5300 2950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3900 4100 4200 4100
Wire Wire Line
	3900 4100 3900 5000
Wire Wire Line
	4000 4900 4000 4300
Wire Wire Line
	4000 4300 4200 4300
Text Notes 1000 6800 0    50   ~ 0
Component placement legend:\nB - Basic components - always populated\nW - WIFI version\nL - LCD version\nA - AC power supply\nR - Relay\nO - LCD backlight always on
$Comp
L Regulator_Linear:LT1129-3.3_SOT223 U5
U 1 1 5E49B10B
P 10050 1400
F 0 "U5" H 10050 1642 50  0000 C CNN
F 1 "LT1129-3.3_SOT223" H 10050 1551 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 10050 1625 50  0001 C CIN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/112935ff.pdf" H 10050 1350 50  0001 C CNN
	1    10050 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C6
U 1 1 5E49BC11
P 10650 1550
F 0 "C6" H 10768 1596 50  0000 L CNN
F 1 "CP" H 10768 1505 50  0000 L CNN
F 2 "Capacitor_THT:C_Radial_D5.0mm_H11.0mm_P2.00mm" H 10688 1400 50  0001 C CNN
F 3 "~" H 10650 1550 50  0001 C CNN
	1    10650 1550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5E49C3A2
P 10050 1850
F 0 "#PWR0106" H 10050 1600 50  0001 C CNN
F 1 "GND" H 10055 1677 50  0000 C CNN
F 2 "" H 10050 1850 50  0001 C CNN
F 3 "" H 10050 1850 50  0001 C CNN
	1    10050 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0107
U 1 1 5E49CDEE
P 10650 1250
F 0 "#PWR0107" H 10650 1100 50  0001 C CNN
F 1 "+5V" H 10665 1423 50  0000 C CNN
F 2 "" H 10650 1250 50  0001 C CNN
F 3 "" H 10650 1250 50  0001 C CNN
	1    10650 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 4800 4200 4800
Wire Wire Line
	6550 4800 6800 4800
Connection ~ 6550 4800
Wire Wire Line
	6550 4650 6550 4800
$Comp
L power:+3V3 #PWR0104
U 1 1 5E3CF96E
P 6550 4650
F 0 "#PWR0104" H 6550 4500 50  0001 C CNN
F 1 "+3V3" H 6565 4823 50  0000 C CNN
F 2 "" H 6550 4650 50  0001 C CNN
F 3 "" H 6550 4650 50  0001 C CNN
	1    6550 4650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0108
U 1 1 5E49F5F8
P 5400 4600
F 0 "#PWR0108" H 5400 4450 50  0001 C CNN
F 1 "+5V" H 5415 4773 50  0000 C CNN
F 2 "" H 5400 4600 50  0001 C CNN
F 3 "" H 5400 4600 50  0001 C CNN
	1    5400 4600
	-1   0    0    1   
$EndComp
Wire Wire Line
	5400 4500 5400 4600
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 5E4A3F51
P 7850 1050
F 0 "J1" H 7958 1331 50  0000 C CNN
F 1 "Conn_01x03_Male" H 7958 1240 50  0000 C CNN
F 2 "Connector:FanPinHeader_1x03_P2.54mm_Vertical" H 7850 1050 50  0001 C CNN
F 3 "~" H 7850 1050 50  0001 C CNN
	1    7850 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:D D3
U 1 1 5E4A527D
P 8800 1100
F 0 "D3" V 8754 1179 50  0000 L CNN
F 1 "D" V 8845 1179 50  0000 L CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 8800 1100 50  0001 C CNN
F 3 "~" H 8800 1100 50  0001 C CNN
	1    8800 1100
	0    1    1    0   
$EndComp
$Comp
L Device:D D4
U 1 1 5E4A5A94
P 8800 1650
F 0 "D4" V 8754 1729 50  0000 L CNN
F 1 "D" V 8845 1729 50  0000 L CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 8800 1650 50  0001 C CNN
F 3 "~" H 8800 1650 50  0001 C CNN
	1    8800 1650
	0    1    1    0   
$EndComp
$Comp
L Device:D D1
U 1 1 5E4A63D7
P 8550 1100
F 0 "D1" H 8550 1316 50  0000 C CNN
F 1 "D" H 8550 1225 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 8550 1100 50  0001 C CNN
F 3 "~" H 8550 1100 50  0001 C CNN
	1    8550 1100
	0    -1   -1   0   
$EndComp
$Comp
L Device:D D2
U 1 1 5E4A6C25
P 8550 1650
F 0 "D2" H 8550 1866 50  0000 C CNN
F 1 "D" H 8550 1775 50  0000 C CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 8550 1650 50  0001 C CNN
F 3 "~" H 8550 1650 50  0001 C CNN
	1    8550 1650
	0    -1   -1   0   
$EndComp
$Comp
L Device:D_Zener D5
U 1 1 5E4A7633
P 9250 1550
F 0 "D5" V 9204 1629 50  0000 L CNN
F 1 "D_Zener" V 9295 1629 50  0000 L CNN
F 2 "Diode_SMD:D_1206_3216Metric" H 9250 1550 50  0001 C CNN
F 3 "~" H 9250 1550 50  0001 C CNN
	1    9250 1550
	0    1    1    0   
$EndComp
$Comp
L Device:CP C5
U 1 1 5E4A8600
P 9600 1550
F 0 "C5" H 9718 1596 50  0000 L CNN
F 1 "CP" H 9718 1505 50  0000 L CNN
F 2 "Capacitor_THT:C_Radial_D5.0mm_H11.0mm_P2.00mm" H 9638 1400 50  0001 C CNN
F 3 "~" H 9600 1550 50  0001 C CNN
	1    9600 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1400 9600 1400
Wire Wire Line
	9250 1400 9600 1400
Connection ~ 9600 1400
Wire Wire Line
	8800 1250 8800 1450
Wire Wire Line
	9250 1400 8550 1400
Wire Wire Line
	8550 1400 8550 1500
Connection ~ 9250 1400
Wire Wire Line
	8550 1400 8550 1250
Connection ~ 8550 1400
Wire Wire Line
	10050 1700 10050 1750
Wire Wire Line
	10050 1750 9600 1750
Wire Wire Line
	9600 1750 9600 1700
Connection ~ 10050 1750
Wire Wire Line
	10050 1750 10050 1850
Wire Wire Line
	9600 1750 9250 1750
Wire Wire Line
	9250 1750 9250 1700
Connection ~ 9600 1750
Wire Wire Line
	8800 1450 9050 1450
Wire Wire Line
	9050 1450 9050 1750
Wire Wire Line
	9050 1750 9250 1750
Connection ~ 8800 1450
Wire Wire Line
	8800 1450 8800 1500
Connection ~ 9250 1750
Wire Wire Line
	8550 1800 8800 1800
Wire Wire Line
	8550 950  8800 950 
Wire Wire Line
	8050 950  8550 950 
Connection ~ 8550 950 
Wire Wire Line
	8050 1050 8250 1050
Wire Wire Line
	8250 1050 8250 1800
Wire Wire Line
	8250 1800 8550 1800
Connection ~ 8550 1800
Wire Wire Line
	10350 1400 10650 1400
Wire Wire Line
	10650 1250 10650 1400
Connection ~ 10650 1400
Wire Wire Line
	10050 1750 10650 1750
Wire Wire Line
	10650 1750 10650 1700
Wire Notes Line
	7550 600  11000 600 
Wire Notes Line
	11000 600  11000 2100
Wire Notes Line
	11000 2100 7550 2100
Wire Notes Line
	7550 2150 7550 650 
Text Notes 7600 700  0    50   ~ 0
Power supply
$Comp
L Device:R R3
U 1 1 5E4BC0CF
P 7150 5900
F 0 "R3" V 6943 5900 50  0000 C CNN
F 1 "R" V 7034 5900 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 7080 5900 50  0001 C CNN
F 3 "~" H 7150 5900 50  0001 C CNN
	1    7150 5900
	0    1    1    0   
$EndComp
Wire Wire Line
	7300 5900 7500 5900
Connection ~ 7500 5900
Wire Wire Line
	7500 5900 7500 4800
Wire Wire Line
	7000 5900 6550 5900
Wire Wire Line
	6550 5900 6550 4800
$Comp
L power:GND #PWR?
U 1 1 5E4BD978
P 1000 2900
F 0 "#PWR?" H 1000 2650 50  0001 C CNN
F 1 "GND" H 1005 2727 50  0000 C CNN
F 2 "" H 1000 2900 50  0001 C CNN
F 3 "" H 1000 2900 50  0001 C CNN
	1    1000 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E4CE5C2
P 5950 6500
F 0 "#PWR?" H 5950 6250 50  0001 C CNN
F 1 "GND" H 5955 6327 50  0000 C CNN
F 2 "" H 5950 6500 50  0001 C CNN
F 3 "" H 5950 6500 50  0001 C CNN
	1    5950 6500
	1    0    0    -1  
$EndComp
$EndSCHEMATC