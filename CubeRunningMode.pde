
#define RESET  0
byte CountState;
byte currentMode;

/*********** setup_cube ***********/
//Function:	setup_cube()
//Parameter:	none
//Return value:	none
//Description:	first init for ledcube, be called in stup()
/********************************/
void setup_cube()
{
  byte i,j,k;
  CountState =0;
  Mode =0;
  for(i=0;i<5;i++)
    for(j=0;j<5;j++)
      for(k=0;k<5;k++)   cube[i][j][k] = OFF;
}

/*********** running ***********/
//Function:	running()
//Parameter:	none
//Return value:	none
//Description:	running function, main function for ledcube, be called in loop()
/********************************/
void running()
{
  byte x,y,z;
  byte tmp;
  if(currentMode != Mode) 
  {
    //do some reset here
    CountState = RESET;
    currentMode = Mode;
  }
  switch (currentMode){
  case DONOTHING: 
    CountState = 0;
    tmp = 0;
    break;
  case LIGHTONUP:
    if(CountState == RESET) {
      set_face(TOP);
      CountState++;
    }
    else if(CountState <LEDCUBESIZE)  shift_to(BOT); 
    else if(CountState == LEDCUBESIZE *1) set_face(BOT);
    else if(CountState< LEDCUBESIZE*2) shift_to(TOP);
    else if(CountState == LEDCUBESIZE *2) set_face(LEFT);
    else if(CountState < LEDCUBESIZE*3) shift_to(RIGHT);
    else if(CountState == LEDCUBESIZE*3) set_face(RIGHT);
    else if(CountState <LEDCUBESIZE*4) shift_to(LEFT);
    else if(CountState == LEDCUBESIZE *4) set_face(FRONT);
    else if(CountState < LEDCUBESIZE*5) shift_to(REAR);
    else if(CountState == LEDCUBESIZE*5) set_face(REAR);
    else if(CountState <LEDCUBESIZE*6) shift_to(FRONT);    
    else if(CountState >=LEDCUBESIZE*6) Mode = DONOTHING;
    break;
  case LIGHTOFFUP:

    break;
  case TEST:
    Serial.println("begin test data" );
    for(byte i=0;i<125;i++){
      Serial.print("Du lieu thu ");  
      Serial.print(i,DEC);
      Serial.print("la :");
      Serial.println(cube[i/5][i%5][i/25],DEC);
      delay(100);
    }    
  case SHIFTDOWN:
    if(CountState == RESET) 
    {
      set_face(TOP);
      CountState ++;  
    }
    else shift_to(BOT);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case SHIFTUP:
    if(CountState == RESET) 
    {
      set_face(BOT);
      CountState ++; 
    }
    else shift_to(TOP);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case SHIFTLEFT:
    if(CountState == RESET) 
    {
      set_face(RIGHT);
      CountState ++; 
    }
    else shift_to(LEFT);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case SHIFTRIGHT:
    if(CountState == RESET) 
    {
      set_face(LEFT);
      CountState ++; 
    }
    else  shift_to(RIGHT);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case SHIFTFRONT:
    if(CountState == RESET) 
    {
      set_face(REAR);
      CountState++; 
    }
    else shift_to(FRONT);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case SHIFTREAR:    
    if(CountState == RESET) 
    {
      set_face(FRONT);
      CountState++; 
    }
    else shift_to(REAR);
    if(CountState> LEDCUBESIZE) Mode = DONOTHING;
    break;
  case TESTEACH:
    clear_all();
    if(CountState > 125) CountState = 0;
    set_value(CountState%5, CountState/25, (CountState/5)%5 ,ON);      
    break;
  case RAIN:
    if(CountState == RESET)
    {
      clear_all();
      CountState++; 
    }
    rain();
    if(CountState > 200) Mode = DONOTHING;
    break;
  case MAKECUBE:    // make cube from center
    clear_all();
    if(CountState == RESET) 
    {
      clear_all();
      CountState++; 
    }
    else if(CountState ==1)  make_cube2(1,0,0,0);
    else if(CountState ==2)  make_cube2(2,0,0,0);
    else if(CountState ==3)  make_cube2(3,0,0,0);
    else if(CountState ==4)  make_cube2(4,0,0,0);
    else if(CountState ==5)  make_cube2(5,0,0,0);
    else if(CountState ==6)  make_cube2(4,1,1,1);
    else if(CountState ==7)  make_cube2(3,2,2,2);
    else if(CountState ==8)  make_cube2(2,3,3,3);
    else if(CountState ==9)  make_cube2(1,4,4,4);
    else if(CountState ==10)  make_cube2(2,3,3,3);
    else if(CountState ==11)  make_cube2(3,2,2,2);
    else if(CountState ==12)  make_cube2(4,1,1,1);
    else if(CountState ==13)  make_cube2(5,0,0,0);
    else if(CountState ==14)  make_cube2(4,1,0,0);
    else if(CountState ==15)  make_cube2(3,2,0,0);
    else if(CountState ==16)  make_cube2(2,3,0,0);
    else if(CountState ==17)  make_cube2(1,4,0,0);
    else if(CountState ==18)  make_cube2(2,3,0,0);
    else if(CountState ==19)  make_cube2(3,2,0,0);
    else if(CountState ==20)  make_cube2(4,1,0,0);
    else if(CountState ==21)  make_cube2(5,0,0,0);
    else if(CountState ==22)  make_cube2(4,0,1,1);
    else if(CountState ==23)  make_cube2(3,0,2,2);
    else if(CountState ==24)  make_cube2(2,0,3,3);
    else if(CountState ==25)  make_cube2(1,0,4,4);
    else if(CountState ==26)  make_cube2(2,0,3,3);
    else if(CountState ==27)  make_cube2(2,1,3,3);
    else if(CountState ==28)  make_cube2(2,2,3,3);
    else if(CountState ==29)  make_cube2(2,2,2,3);
    else if(CountState ==30)  make_cube2(2,2,1,3);
    else if(CountState ==31)  make_cube2(2,2,1,2);
    else if(CountState ==32)  make_cube2(2,2,1,1);
    else if(CountState ==33)  make_cube2(2,1,1,1);
    else if(CountState ==34)  make_cube2(3,1,1,1);
    else if(CountState ==35)  make_cube2(2,1,1,1);
    else if(CountState ==36)  make_cube2(1,2,2,2);    
    else if(CountState ==37)  make_cube2(0,3,3,3);
    else Mode = DONOTHING;    
    break;
  case MAKECUBE1:  //make cube from a first point
//    clear_all();
    if(CountState == RESET) 
    {
      clear_all();
      CountState++; 
    }
    else if(CountState ==1)  make_cube2(1,2,2,2);
    else if(CountState ==2)  make_cube2(2,1,1,1);
    else if(CountState <100)
    {
      move_random();
    }
    else Mode = DONOTHING;
    break;
  case MAKECUBE2:  // make cube from point
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(5,0,0,0);
    break;
  case MAKECUBE2_1:
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(1,0,0,0);
    if(CountState >3) Mode = DONOTHING;
    break;
  case MAKECUBE2_2:
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(2,0,0,0);
    if(CountState >3) Mode = DONOTHING;
    break;
  case MAKECUBE2_3:
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(3,0,0,0);
    if(CountState >3) Mode = DONOTHING;
    break;
  case MAKECUBE2_4:
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(4,0,0,0);    
    if(CountState >3) Mode = DONOTHING;
    break;
  case MAKECUBE2_5:
    if(CountState == RESET)  
    {
      clear_all();
      CountState++; 
    }
    else    make_cube2(5,0,0,0);
    if(CountState >3) Mode = DONOTHING;
    break;
  default: 
    break;
  }
  if(CountState != RESET) CountState ++;  //if not in reset state, it will self increase value
}








