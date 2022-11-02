
/*DEFINITION*/
//#define LEDCUBESIZE 	5
//#define ON 				0
//#define OFF 			0xff
//#define RESETSTATE		0
#define RESETSTATE 0

/*VALUE*/

//byte cube[LEDCUBESIZE][LEDCUBESIZE][LEDCUBESIZE];

/*FUNCTION*/
/***********OPEN OUT LAYER***********/
//Function:		open_layer
//Parameter:	layer to open
//Return value:	no
//Description:	layer selected will open out
/********************************/
void open_out_layer(byte layer)
{
  if(layer> LEDCUBESIZE-1) 
  {
    Serial.println("error in layer input in function open_out_layer");
    return;
  }
  for(byte j =0;j<LEDCUBESIZE/2;j++)
  {
    for(byte i = j; i<LEDCUBESIZE-j;i++)
    {
      cube[j][i+1][layer] = cube[j+1][i+1][layer];
      cube[LEDCUBESIZE-1-j][i+1][layer] = cube[LEDCUBESIZE-2-j][i+1][layer];
      cube[i+1][j][layer] = cube[i+1][j+1][layer];
      cube[i+1][LEDCUBESIZE-1-j][layer] = cube[i+1][LEDCUBESIZE -2-j][layer];
    }
  }
}

/***********OPEN OUT LAYER1***********/
//Function:		open_layer1
//Parameter:	layer to open
//Return value:	no
//Description:	layer selected will open out
/********************************/
void open_out_layer1(byte layer)
{
  byte i,j,center;
  if(layer> LEDCUBESIZE-1) 
  {
    Serial.println("error in layer input in function open_out_layer");
    return;
  }
  for(i=0;i<LEDCUBESIZE/2;i++)
  {
    center = i/2;
    for(j=i;j<LEDCUBESIZE/2;j++)
    {
      cube[j][i][layer] = cube[j+1][i][layer];
      cube[LEDCUBESIZE-j-1][i][layer] = cube[LEDCUBESIZE-j-2][i][layer];
      cube[j][LEDCUBESIZE-1-i][layer] = cube[j+1][LEDCUBESIZE-1-i][layer];
      cube[LEDCUBESIZE-j-1][LEDCUBESIZE-1-i][layer] = cube[LEDCUBESIZE-j-2][LEDCUBESIZE-1-i][layer];

      cube[i][j][layer] = cube[i][j+1][layer];
      cube[i][LEDCUBESIZE-j-1][layer] = cube[i][LEDCUBESIZE-j-2][layer];
      cube[LEDCUBESIZE-1-i][j][layer] = cube[LEDCUBESIZE-1-i][j+1][layer];
      cube[LEDCUBESIZE-1-i][LEDCUBESIZE-j-1][layer] = cube[LEDCUBESIZE-1-i][LEDCUBESIZE-j-2][layer];  
    }
    cube[2][i][layer] = cube[2][i+1][layer];
    cube[2][LEDCUBESIZE-1-i][layer] = cube[2][LEDCUBESIZE-2-i][layer];
    cube[i][2][layer] = cube[i+1][2][layer];
    cube[LEDCUBESIZE-1-i][2][layer] = cube[LEDCUBESIZE-2-i][2][layer];
  }
}

/***********OPEN OUT LAYER2***********/
//Function:		open_layer2
//Parameter:	layer to open
//Return value:	no
//Description:	layer selected will open out
/********************************/
void open_out_layer2(byte layer)
{
  byte i,j,center;
  byte x,y,z;
  byte runAlong,standLow,standHigh;
  if(layer%10> LEDCUBESIZE-1) 
  {
    Serial.println("error in layer input in function open_out_layer");
    return;
  }
  layer = layer %10;
  
  for(i=0;i<LEDCUBESIZE/2;i++)
  {
    center = i/2;
    for(j=i;j<LEDCUBESIZE/2;j++)
    {
      //x=;y=;z=
      cube[j][i][layer] = cube[j+1][i][layer];
      cube[LEDCUBESIZE-j-1][i][layer] = cube[LEDCUBESIZE-j-2][i][layer];
      cube[j][LEDCUBESIZE-1-i][layer] = cube[j+1][LEDCUBESIZE-1-i][layer];
      cube[LEDCUBESIZE-j-1][LEDCUBESIZE-1-i][layer] = cube[LEDCUBESIZE-j-2][LEDCUBESIZE-1-i][layer];

      cube[i][j][layer] = cube[i][j+1][layer];
      cube[i][LEDCUBESIZE-j-1][layer] = cube[i][LEDCUBESIZE-j-2][layer];
      cube[LEDCUBESIZE-1-i][j][layer] = cube[LEDCUBESIZE-1-i][j+1][layer];
      cube[LEDCUBESIZE-1-i][LEDCUBESIZE-j-1][layer] = cube[LEDCUBESIZE-1-i][LEDCUBESIZE-j-2][layer];  
    }
    cube[2][i][layer] = cube[2][i+1][layer];
    cube[2][LEDCUBESIZE-1-i][layer] = cube[2][LEDCUBESIZE-2-i][layer];
    cube[i][2][layer] = cube[i+1][2][layer];
    cube[LEDCUBESIZE-1-i][2][layer] = cube[LEDCUBESIZE-2-i][2][layer];
  }
}

/***********FireWork***********/
//Function:		fire_work
//Parameter:	no
//Return value:	no
//Description:	fire work effect
/********************************/
void fire_work(byte state)
{
  if(state == RESETSTATE)
  {
    clear_all();
    set_value(2,2,0, ON);
  }
  else if (state<5)
  {		
    shift_to(TOP);
    set_value(2,2,0,ON);
  }
  else if(state< 7)
  {
    open_out_layer(4);		
  }
  else if(state<13)
  {
    shift_to(BOT);
    // set_value(0,0,4,ON);
  }
  else state = 0;
}

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/

/***********FUNCTION***********/
//Function:		
//Parameter:	
//Return value:	
//Description:	
/********************************/


