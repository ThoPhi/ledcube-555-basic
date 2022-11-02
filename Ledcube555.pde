
/*----------INCLUDE SECTION----------*/
#include <SPI.h>
#include <TimerOne.h>
//#include <CShiftPWM.h>
//#include <pins_arduino_compile_time.h>

/*----------DEFINE SECTION----------*/
#define LEDCUBESIZE 5
#define ON 0x00
#define OFF 0xff

#define DONOTHING 0
#define LIGHTONUP  1
#define LIGHTOFFUP  2
#define TEST  3
#define SHIFTDOWN  10
#define SHIFTUP  11
#define SHIFTLEFT  12
#define SHIFTRIGHT  13
#define SHIFTFRONT  14
#define SHIFTREAR  15
#define TESTEACH    100
#define FIREWORK    110
#define FIREWORK1    111
#define FIREWORK2    112
#define FIREWORK3    113
#define RAIN         120
#define MAKECUBE      130
#define MAKECUBE1      131
#define  MAKECUBE2      132
#define MAKECUBE2_1     141
#define MAKECUBE2_2     142
#define MAKECUBE2_3     143
#define MAKECUBE2_4     144
#define MAKECUBE2_5     145


#define TOP      1
#define BOT      2
#define LEFT     3
#define RIGHT    4
#define FRONT    5
#define REAR     6

#define LAYERX0  0
#define LAYERX1  1
#define LAYERX2  2
#define LAYERX3  3
#define LAYERX4  4
#define LAYERY0  10
#define LAYERY1  11
#define LAYERY2  12
#define LAYERY3  13
#define LAYERY4  14
#define LAYERZ0  20
#define LAYERZ1  21
#define LAYERZ2  22
#define LAYERZ3  23
#define LAYERZ4  24

/*----------VARIABLE DEFINITION----------*/
const byte slaveSelectPin = 10;
const int ShiftPWM_latchPin = 10;
long previousMillis =0;
int interval = 500;
byte cube[5][5][5] ;
byte Mode;
byte LayerToScanTemp;
byte scanOrNot=1;
byte ControlState;

/*----------MAIN FUNCTION SECTION----------*/
/**************** Setup ****************/
//name:    setup()
//Parametter :  none
//Return     :  none
//Description:  The first init for every thing
/******************************************/
void setup(){
  byte i,j,k;
  ControlState = 0;
  Serial.begin(9600);
  Serial.println("begin setup");
  pinMode(ShiftPWM_latchPin, OUTPUT);
  //SPI.setBitOrder(MSBFIRST);
  //SPI.setClockDivide(SPI_CLOCK_DIV4);
  SPI.begin();
  //select layer pin init
  for(i=0;i<5;i++) pinMode(i+2, OUTPUT);
  for(i=0;i<5;i++) digitalWrite(i+2, HIGH);
  //ready to run  
  setup_cube();
  //setup for interrupt routine
  Timer1.initialize(2000);
  Timer1.attachInterrupt(timerIsr);
  Serial.println("ready to run now");
}
/****** timer interrupt routine ******/
//name timerIsr()
//Parametter:  none
//Return:      none
//Description:  interrupt timer call each time set in setup, using timer 1
/******************************************/
void timerIsr()
{
  scan_led_cube();  
}
/**************** main ****************/
//name:  main()
//Parametter:  none
//Return:      none
//Description:  main function here
/******************************************/
void loop(){
  //main program run in here and update every interval
  unsigned long currentMillis = millis();
  if(currentMillis - previousMillis > interval){
    previousMillis = currentMillis;  
    running();
  }
  //if(Serial.available())read_serial();  
  //delay(1);    //good for serial communication

  if(Mode == DONOTHING) ControlState++;

  switch(ControlState)
  {
  case 0:
    ControlState++;
    break;
  case 1:
    set_speed(70);
    Mode = SHIFTDOWN;
    break;
  case 2:
    Mode = SHIFTUP;
    break;
  case 3:
    Mode = SHIFTREAR;
    break;
  case 4:
    Mode = SHIFTFRONT;
    break;
  case 5:
    Mode = SHIFTLEFT;
    break;
  case 6:
    Mode = SHIFTRIGHT;
    break;
  case 7:
    Mode = RAIN;
    set_speed(90);
    break;
  case 8:
    ControlState=17;
    set_speed(90);
    break;
  case 9:
    Mode = MAKECUBE2_1;

    break;
  case 10:
    Mode = MAKECUBE2_2;
    break;
  case 11:
    Mode = MAKECUBE2_3;
    break;
  case 12:
    Mode = MAKECUBE2_4;
    break;
  case 13:
    Mode = MAKECUBE2_5;
    break;
  case 14:
    Mode = MAKECUBE2_4;
    break;
  case 15:
    Mode = MAKECUBE2_3;
    break;
  case 16:
    Mode = MAKECUBE2_2;
    break;
  case 17:
    Mode = MAKECUBE2_1;
    set_speed(95);
    break;
  case 18:
    Mode = MAKECUBE;
    break;
  case 19:
    Mode = MAKECUBE1;    
    break;
  case 20:
    ControlState = 0;
    break;
  case 21:

    break;
  case 22:

    break;
  case 23:

    break;
  case 24:

    break;
  case 25:

    break;
  case 26:

    break;
  case 27:

    break;
  case 28:

    break;
  case 29:

    break;
  case 30:

    break;
  case 31:

    break;
  case 32:

    break;
  case 33:

    break;
  default: 
    break;
  }
}
/*********** read_serial ***********/
//name:    read_serial()
//Parametter: none
//Return:     none
//Description: read serial data from computer softwareto control ledcube
/******************************************/
void read_serial()
{
  switch(Serial.read()){
  case '0':
    Mode = DONOTHING;
    clear_all();
    break;
  case '1':
    Mode = DONOTHING;
    set_all();
    break;
  case '2':
    Mode = TESTEACH;
    break;
  case '3':
    clear_all();
    Mode = SHIFTLEFT;
    break; 
  case '4':
    clear_all();
    Mode = SHIFTRIGHT;
    break; 
  case '5':
    clear_all();
    Mode  = SHIFTFRONT;
    break; 
  case '6':
    clear_all();
    Mode = SHIFTREAR;
    break; 
  case '7':
    clear_all();
    Mode = SHIFTUP;
    break; 
  case '8':
    clear_all();
    Mode = SHIFTDOWN;
    break; 
  case '9':

    break; 
  case 'a':

    break; 
  case 'b':

    break; 
  case 'c':
    Mode = LIGHTONUP;
    break; 
  case 'd':
    Mode  = LIGHTOFFUP;
    break; 
  case 'e':
    clear_all();
    Mode = FIREWORK2;
    break; 
  case 'f':
    clear_all();
    Mode = TEST;
    break; 
  case 'g':
    clear_all();
    Mode = DONOTHING;
    make_cube(1);
    break;  
  case 'h':
    clear_all();
    Mode = DONOTHING;
    make_cube(3);
    break; 
  case 'i':
    clear_all();
    Mode = DONOTHING;
    make_cube(5);
    break; 
  case 'j':

    break;
  case 'k':

    break;
  case 'l':

    break;
  case 'm':
    Mode = RAIN;
    break;
  case 'n':
    Mode = MAKECUBE;
    break;
  case 'o':
    Mode = MAKECUBE1;
    break;
  case 'p':
    Mode = MAKECUBE2;
    break;
  case 'q':

    break;
  case 'r':

    break;
  case 's':

  case 't':

    break;
  case 'u':


    break;
  case 'v':


    break;
  case 'x':
    if(interval<1070) interval +=50;

    break;
  case 'y':
    if(interval>52) interval -= 50;

    break;
  case 'z':
    break;
  case '+':
    if(interval >60) interval -= 50;
    break;
  case '-':
    if(interval < 970) interval += 50;
    break;
  }
}





