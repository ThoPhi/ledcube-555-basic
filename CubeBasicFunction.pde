

byte LayerToScan;
byte MessDataToScan[3] = { 
  0xff,0xff,0xff};

/*********************scan_led_cube()*********************/
//Function Name:    scan_led_cube
//Parameter:        none
//Return:          
//Description:      convert data from 3d to 3 byte physic
/********************************************************/
void scan_led_cube()
{
  byte i;
  for(i=0;i<3;i++) MessDataToScan[i] = 0x00;

  if(cube[0][2][LayerToScan]>0) MessDataToScan[0] |= 1;
  if(cube[0][1][LayerToScan]>0) MessDataToScan[0] |= 1<<1;
  if(cube[0][0][LayerToScan]>0) MessDataToScan[0] |= 1<<2;
  if(cube[0][3][LayerToScan]>0) MessDataToScan[0] |= 1<<3;
  if(cube[0][4][LayerToScan]>0) MessDataToScan[0] |= 1<<4;
  if(cube[1][2][LayerToScan]>0) MessDataToScan[0] |= 1<<5;
  if(cube[1][1][LayerToScan]>0) MessDataToScan[0] |= 1<<6;
  if(cube[1][0][LayerToScan]>0) MessDataToScan[0] |= 1<<7;

  if(cube[1][3][LayerToScan]>0) MessDataToScan[1] |= 1;
  if(cube[1][4][LayerToScan]>0) MessDataToScan[1] |= 1<<1;
  if(cube[2][2][LayerToScan]>0) MessDataToScan[1] |= 1<<2;
  if(cube[2][1][LayerToScan]>0) MessDataToScan[1] |= 1<<3;
  if(cube[2][0][LayerToScan]>0) MessDataToScan[1] |= 1<<4;
  if(cube[2][3][LayerToScan]>0) MessDataToScan[1] |= 1<<5;
  if(cube[2][4][LayerToScan]>0) MessDataToScan[1] |= 1<<6;
  if(cube[3][2][LayerToScan]>0) MessDataToScan[1] |= 1<<7;

  if(cube[3][1][LayerToScan]>0) MessDataToScan[2] |= 1;
  if(cube[3][0][LayerToScan]>0) MessDataToScan[2] |= 1<<1;
  if(cube[3][3][LayerToScan]>0) MessDataToScan[2] |= 1<<2;
  if(cube[3][4][LayerToScan]>0) MessDataToScan[2] |= 1<<3;
  if(cube[4][2][LayerToScan]>0) MessDataToScan[2] |= 1<<4;
  if(cube[4][1][LayerToScan]>0) MessDataToScan[2] |= 1<<5;
  if(cube[4][0][LayerToScan]>0) MessDataToScan[2] |= 1<<6;
  if(cube[4][3][LayerToScan]>0) MessDataToScan[2] |= 1<<7;

  if(LayerToScan ==0) digitalWrite(LEDCUBESIZE+1, HIGH);
  else digitalWrite(LayerToScan+1, HIGH);

  digitalWrite(slaveSelectPin, LOW);
  SPI.transfer(0xff);
  SPI.transfer(MessDataToScan[2]);
  SPI.transfer(MessDataToScan[1]);
  SPI.transfer(MessDataToScan[0]);
  digitalWrite(slaveSelectPin, HIGH);

  digitalWrite(LayerToScan+2,LOW);
  LayerToScan = (LayerToScan + 1) %5;
}

/*********************set_speed*********************/
//Function Name:    set_speed()
//Parameter:        speed from 1 to 100
//Return:          
//Description:      change the speed of ledcube
/********************************************************/
void set_speed (int SpeedToSet)
{
  interval = map(SpeedToSet,1,100,1020,5);
}

/*********************set_value*********************/
//Function Name:    set_value
//Parameter:        valueto set led at xyz
//Return:          
//Description:      give the value
/********************************************************/
void set_value(byte xPos, byte yPos, byte zPos, byte ValueToSend )
{
  if((xPos<LEDCUBESIZE) && (yPos<LEDCUBESIZE) && (zPos<LEDCUBESIZE))
    cube[xPos][yPos][zPos] = ValueToSend;
}

/*********************clear_all*********************/
//Function Name:    clear_all
//Parameter:        none
//Return:          
//Description:      clear all data of ledcube
/********************************************************/
void clear_all()
{
  for(byte i=0;i<LEDCUBESIZE;i++)
    for(byte j=0;j<LEDCUBESIZE;j++)
      for(byte k =0;k<LEDCUBESIZE;k++)cube[i][j][k] = OFF;
}

/*********************set_all*********************/
//Function Name:    set_all
//Parameter:        none
//Return:          
//Description:      set all data of ledcube
/********************************************************/
void set_all()
{
  for(byte i=0;i<LEDCUBESIZE;i++)
    for(byte j=0;j<LEDCUBESIZE;j++)
      for(byte k =0;k<LEDCUBESIZE;k++)cube[i][j][k] = ON;
}

/*********************set_face*********************/
//Function Name:    set_face
//Parameter:        face: TOP, BOT, LEFT, RIGHT, FRONT, REAR
//Return:          
//Description:      set all data of  face ofledcube
/********************************************************/
void set_face(byte face)
{
  byte i,j,k;
  i=0;
  j=0;
  k=0;
  if( face >6  || face <1) return;
  switch(face){
  case TOP:
    k=LEDCUBESIZE-1;
    for(i=0;i<LEDCUBESIZE;i++)
      for(j=0;j<LEDCUBESIZE;j++) cube[i][j][k] = ON;
    break;
  case BOT:
    k=0;
    for(i=0;i<LEDCUBESIZE;i++)
      for(j=0;j<LEDCUBESIZE;j++) cube[i][j][k] = ON;
    break;
  case LEFT:
    i=0;
    for(j=0;j<LEDCUBESIZE;j++)
      for(k=0;k<LEDCUBESIZE;k++)  cube[i][j][k] = ON;      
    break;
  case RIGHT:
    i= LEDCUBESIZE -1;
    for(j=0;j<LEDCUBESIZE;j++)
      for(k=0; k<LEDCUBESIZE;k++)  cube[i][j][k] = ON;
    break;
  case FRONT:
    j = 0;
    for(i=0;i<LEDCUBESIZE;i++)
      for(k=0;k<LEDCUBESIZE;k++) cube[i][j][k] = ON;
    break;
  case REAR:
    j= LEDCUBESIZE -1;
    for(i=0;i<LEDCUBESIZE;i++)
      for(k=0;k<LEDCUBESIZE;k++)  cube[i][j][k] = ON;
    break;
  default: 
    break;
  }
}


/*********************set_face1*********************/
//Function Name:    set_face1
//Parameter:        face: LAYERX0->LAYERX4,LAYERY0->LAYERY4, LAYERZ0->LAYERZ4
//Return:          
//Description:      set the layer turn on all
/********************************************************/
void set_face1(byte face)
{
  byte x,y,z;
  if(((face/10) >2) || ((face%10)>=LEDCUBESIZE)) 
  {
    Serial.println("error in set_face1 function");
    return;
  }
  if(face/10 == 0)		//xlayer
  {
    x = face%10;
    for(y=0;y<LEDCUBESIZE;y++)
      for(z=0;z<LEDCUBESIZE;z++)	set_value(x,y,z,ON);
  }
  else if(face/10 ==1)	//y layer
  {
    y = face %10;
    for(x=0;x<LEDCUBESIZE;x++)
      for(z=0;z<LEDCUBESIZE;z++)	set_value(x,y,z,ON);
  }
  else if(face/10 ==2)
  {
    z = face%10;
    for(x=0;x<LEDCUBESIZE;x++)
      for(y=0;y<LEDCUBESIZE;y++)	set_value(x,y,z,ON);
  }
}

/*********************shift_to*********************/
//Function Name:    shift_to
//Parameter:        face
//Return:          
//Description:      shift data to the face select
/********************************************************/
void shift_to(byte face)
{
  byte x,y,z;
  //  byte CountState;
  if(face >6 || face <1) {
    Serial.print("invalid face ");
    return;
  }
  switch(face)
  {
  case TOP:
    for(z=LEDCUBESIZE-1;z>0;z--)
      for(y=0;y<LEDCUBESIZE;y++)
        for(x=0;x<LEDCUBESIZE;x++)   cube[x][y][z] = cube[x][y][z-1];

    for(y=0;y<LEDCUBESIZE;y++)
      for(x=0;x<LEDCUBESIZE;x++)   cube[x][y][0] = OFF;

    break;
  case BOT:
    for(x=0;x<LEDCUBESIZE;x++)
      for(y=0;y<LEDCUBESIZE;y++)
        for(z=0;z<LEDCUBESIZE-1;z++)  cube[x][y][z] = cube[x][y][z+1];
    for(y=0;y<LEDCUBESIZE;y++)
      for(x=0;x<LEDCUBESIZE;x++)  cube[x][y][LEDCUBESIZE-1] = OFF;
    break;
  case LEFT:
    for(x=0;x<LEDCUBESIZE-1;x++)
      for(y=0;y<LEDCUBESIZE;y++)
        for(z=0;z<LEDCUBESIZE;z++)  cube[x][y][z] = cube[x+1][y][z];
    for(y=0;y<LEDCUBESIZE;y++)
      for(z=0;z<LEDCUBESIZE;z++)  cube[LEDCUBESIZE-1][y][z] = OFF;
    break;
  case RIGHT:
    for(x=LEDCUBESIZE-1;x>0;x--)
      for(y=0;y<LEDCUBESIZE;y++)
        for(z=0;z<LEDCUBESIZE;z++)  cube[x][y][z] = cube[x-1][y][z];
    for(y=0;y<LEDCUBESIZE;y++)
      for(z=0;z<LEDCUBESIZE;z++) cube[0][y][z] = OFF;
    break;
  case FRONT:
    for(y=0;y<LEDCUBESIZE-1;y++)
      for(x=0;x<LEDCUBESIZE;x++)
        for(z=0;z<LEDCUBESIZE;z++)  cube[x][y][z] = cube[x][y+1][z];
    for(x=0;x<LEDCUBESIZE;x++)
      for(z=0;z<LEDCUBESIZE;z++)  cube[x][LEDCUBESIZE-1][z] = OFF;
    break;
  case REAR:
    for(y=LEDCUBESIZE-1;y>0;y--)
      for(x=0;x<LEDCUBESIZE;x++)
        for(z=0;z<LEDCUBESIZE;z++) cube[x][y][z] = cube[x][y-1][z];
    for(x=0;x<LEDCUBESIZE;x++)
      for(z=0;z<LEDCUBESIZE;z++)  cube[x][0][z] = OFF;
    break;
  default: 
    break;
  }
}

/********************* shift_pixel *********************/
//Function Name:    shift_pixel
//Parameter:        x,y, dir
//Return:          none
//Description:     shift a pixel by direction
/********************************************************/
void shift_pixel(byte x, byte y, byte dir)
{
  byte i;
  if(dir == TOP) 
  {
    for( i = LEDCUBESIZE-1 ; i>0 ; i--)  cube[x][y][i] = cube[x][y][i-1];
    cube[x][y][0] = OFF;
  } 
  else if(dir == BOT)
  {
    for(i=0;i<LEDCUBESIZE;i++) cube[x][y][i] = cube[x][y][i+1];
    cube[x][y][LEDCUBESIZE-1] = OFF;
  }
}

/*********************make_cube*********************/
//Function Name:    make_cube
//Parameter:        size of cube
//Return:          
//Description:      creat all kind of cube from center point
/********************************************************/
void make_cube(byte cubeSize)
{
  byte x, y, z;
  byte centerPoint, lowE, highE;
  if(cubeSize>LEDCUBESIZE) return;

  centerPoint = LEDCUBESIZE /2;
  lowE = centerPoint - cubeSize/2;
  highE = centerPoint + cubeSize/2 + (cubeSize%2 )-1 ;	// for both case of odd and even case

  for(x=lowE;x<highE+1;x++)  
  {
    cube[x][lowE][lowE] = ON;
    cube[x][lowE][highE] = ON;
    cube[x][highE][lowE] = ON;
    cube[x][highE][highE] = ON;

    cube[lowE][x][lowE] = ON;
    cube[lowE][x][highE] = ON;
    cube[highE][x][highE] = ON;
    cube[highE][x][lowE] = ON;

    cube[lowE][lowE][x] = ON;
    cube[lowE][highE][x] = ON;
    cube[highE][lowE][x] = ON;
    cube[highE][highE][x] = ON;  
  }
}

/*********************make_cube1*********************/
//Function Name:    make_cube1
//Parameter:        size of cube, first position of cube
//Return:          
//Description:      creat many size cube from any point
/********************************************************/
void make_cube1(byte cubeSize, byte firstPositionX, byte firstPositionY, byte firstPositionZ)
{
  byte lowX,highX,lowY,highY,lowZ,highZ,i;
  if(((firstPositionX + cubeSize)>LEDCUBESIZE) || ((firstPositionY + cubeSize)> LEDCUBESIZE) || ((firstPositionZ + cubeSize) > LEDCUBESIZE)) 
  {
    Serial.println("error of firstPosition and cubeSize in make_cube1");
    return;
  }  
  lowX = firstPositionX;
  highX = firstPositionX + cubeSize-1;
  lowY = firstPositionY;
  highY = firstPositionY + cubeSize-1;
  lowZ = firstPositionZ;
  highZ = firstPositionZ + cubeSize-1;
  for(i=0;i<cubeSize;i++)
  {
    cube[lowX + i][lowY][lowZ] = ON;
    cube[lowX][lowY + i][lowZ] = ON;
    cube[lowX][lowY][lowZ + i] = ON;

    cube[highX - i][lowY][highZ] = ON;
    cube[highX][lowY + i][highZ] = ON;
    cube[highX][lowY][highZ - i] = ON;

    cube[highX - i][highY][lowZ] = ON;
    cube[highX][highY - i][lowZ] = ON;
    cube[highX][highY][lowZ + i] = ON;

    cube[lowX + i][highY][highZ] = ON;
    cube[lowX][highY - i][highZ] = ON;
    cube[lowX][highY][highZ - i] = ON;	
  }
}

/*********************make_cube2*********************/
//Function Name:    make_cube2
//Parameter:        size of cube, first position of cube
//Return:          
//Description:      creat many size cube from any point with a few code but take time
/********************************************************/
void make_cube2(byte cubeSize, byte firstPositionX, byte firstPositionY, byte firstPositionZ)
{
  byte x,y,z,i,tmpCnt;
  byte lowX,highX,lowY,highY,lowZ,highZ;
  if(((firstPositionX + cubeSize)>LEDCUBESIZE) || ((firstPositionY + cubeSize)> LEDCUBESIZE) || ((firstPositionZ + cubeSize) > LEDCUBESIZE)) 
  {
    Serial.println("error of firstPosition and cubeSize in make_cube2");
    return;
  }  
  lowX = firstPositionX;
  highX = firstPositionX + cubeSize;
  lowY = firstPositionY;
  highY = firstPositionY + cubeSize;
  lowZ = firstPositionZ;
  highZ = firstPositionZ + cubeSize;
  tmpCnt =0;
  for(x=lowX;x<highX;x++)
    for(y=lowY;y<highY;y++)
      for(z=lowZ;z<highZ;z++)
      {
        if(x==lowX || x == highX-1) tmpCnt++;
        if(y==lowY || y == highY-1) tmpCnt++;
        if(z==lowZ || z == highZ-1) tmpCnt++;
        if(tmpCnt>1) set_value(x,y,z,ON);
        tmpCnt =0;
      }

}

/*********************rain *********************/
//Function Name:    rain
//Parameter:        none
//Return:          
//Description:      rain effect
/********************************************************/
void rain()
{
  //need place this function in setup() randomSeed(analogRead(0)); remember :|
  byte randN = random(3);
  byte randX,randY;
  shift_to(BOT);
  for(byte i=0;i<randN;i++)
  {
    randX = random(LEDCUBESIZE);
    randY = random(LEDCUBESIZE);
    set_value(randX,randY,LEDCUBESIZE-1,ON);
  }
}
/*********************send_voxel_randomz*********************/
//Function Name:    send_voxel_randomz
//Parameter:        state
//Return:          
//Description:      set random point at top or bot, then shift rondom from bot to top and return
/********************************************************/
void send_voxel_randomz(byte state)
{
  byte x,y,z;
  byte lastX,lastY;
  if(state == 0)
  {
    for(x=0;x<LEDCUBESIZE;x++)
      for(y=0;y<LEDCUBESIZE;y++)
        set_value(x,y, random(2) * (LEDCUBESIZE-1), ON);
  }
  else
  {
    x = random(LEDCUBESIZE);
    y = random(LEDCUBESIZE);
    if(x != lastX && y != lastY)
    {
      //if(cube[x][y][0]) 
      //if(cube[x][y][0]) shift_pixel(x,y,0);
      //else shift_pixel(x,y,LEDCUBESIZE-1);
      lastX = x;
      lastY = y;
    }
  }
}
/********************* test_face *********************/
//Function Name:    test_face()
//Parameter:        FaceNeedToTest
//Return:           0/1
//Description:      test the face which have any data or led on
/********************************************************/
boolean test_face (byte FaceNeedToTest)
{
  byte tmp = 0;
  byte x,y,z;
  switch(FaceNeedToTest)
  {
  case TOP:
    for(x=0;x<LEDCUBESIZE;x++)
      for(y=0;y<LEDCUBESIZE;y++)
        if(cube[x][y][LEDCUBESIZE-1] == ON) return 1;
    break;
  case BOT:
    for(x=0;x<LEDCUBESIZE;x++)
      for(y=0;y<LEDCUBESIZE;y++)
        if(cube[x][y][0] == ON ) return 1;
    break;
  case FRONT:
    for(x=0;x<LEDCUBESIZE;x++)
      for(z=0;z<LEDCUBESIZE;z++)
        if(cube[x][0][z] == ON) return 1;
    break;
  case REAR:
    for(x=0;x<LEDCUBESIZE;x++)
      for(z=0;z<LEDCUBESIZE;z++)
        if(cube[x][LEDCUBESIZE-1][z] == ON) return 1;
    break;
  case LEFT:
    for(y=0;y<LEDCUBESIZE;y++)
      for(z=0;z<LEDCUBESIZE;z++)
        if(cube[0][y][z] == ON) return 1;
    break;
  case RIGHT:
    for(y=0;y<LEDCUBESIZE;y++)
      for(z=0;z<LEDCUBESIZE;z++)
        if(cube[LEDCUBESIZE-1][y][z] == ON) return 1;
    break;
  }
  return 0;
}

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/
void move_random()
{
  byte tmp = random(6) +1;
  if(tmp == TOP && test_face(TOP) ==1) tmp = BOT;
  else if(tmp == BOT && test_face(BOT) ==1) tmp = TOP;
  else if(tmp == FRONT && test_face(FRONT) ==1) tmp = REAR;
  else if(tmp == REAR && test_face(REAR) ==1) tmp = REAR;
  else if(tmp == LEFT && test_face(LEFT) ==1) tmp = LEFT;
  else if(tmp == RIGHT && test_face(RIGHT) ==1) tmp = RIGHT;
  shift_to(tmp);
}

/********************* wave *********************/
//Function Name:    wave
//Parameter:        none
//Return:           none
//Description:      wave as on the sea
/********************************************************/
void wave()
{

}

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/

/********************* move_random *********************/
//Function Name:    move_radom()
//Parameter:        none
//Return:           none
//Description:      move a shape rodom in cube
/********************************************************/
