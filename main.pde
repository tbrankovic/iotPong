int bgColor = 000;
double counterT0;

int engagement;

// SERIAL COMMUNICATION PARAMETERS
import processing.serial.*;

Serial myPort;  // The serial port

boolean isCalibrated = false;
int calibratedZero;
int serialValue;

int calibrationSum = 0;
int calibrationI = 0;

final int threshold = 200;
final int calibrationLimit = 200;

 // BALL PARAMETERS
int ballRadius = 50;       // ball radius
float ballXPos, ballYPos;    // ball CENTER COORDS   

float ballXSpeedDefault = 5.8;  // Speed of the shape
float ballYSpeedDefault = 1.1;  // Speed of the shape
float ballXSpeed = ballXSpeedDefault;  // Speed of the shape
float ballYSpeed = ballYSpeedDefault;  // Speed of the shape
int ballSpeedIncrement = 2;

int ballXDirection = 1;  // Left or Right
int ballYDirection = 1;  // Top to Bottom
 
 
 
 // PADDLE PARAMETERS 
int paddleMargin = 100;  // the distance from the edge (greater value = harder gameplay)
int paddleSize = 150;  // total length of the paddle 

int paddleYPos = mouseY - paddleSize/2;
int paddleXPos = width - paddleMargin;

int kbdMoveSpeed = 10;
int kbdDirection = 1;
int kbdPos = height/2;


// GAME PARAMETERS
int leftThreshold;
int rightThreshold = width - paddleMargin + ballRadius;
 
char scoreA = '1';
char scoreB = '5';


void setup() 
{
  size(1280, 720);
  noStroke();
  frameRate(144);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  ballXPos = width/2;
  ballYPos = height/2;
  counterT0 = 2100;
  engagement = 2;
  
  // List all the available serial ports:
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[9], 9600);
}




void draw() 
{
  background(bgColor);
  //drawing middle line
  rect((width/2)-2,0,4,(height-80)/2);
  rect((width/2)-2,(height+80)/2,4,height);
  
  //PFont font;
  //font = createFont("DINPro-CondBold.otf",32);
  //textFont(font);
  textAlign(CENTER,CENTER);
  text(scoreA+"\t:\t"+scoreB, width/2, height/2);
  
  // Update the position of the shape

  
  
  if (millis()-counterT0 > 2000 && millis()-counterT0 < 2300){
    ballXSpeed = ballXSpeedDefault;
    ballYSpeed = ballYSpeedDefault;
    engagement=2;
  } else if (engagement==0){
    ballYPos = kbdPos;
  } else if (engagement==1){
    ballYPos = mouseY;
  } else {
    ballXPos = ballXPos + ( ballXSpeed * ballXDirection );
    ballYPos = ballYPos + ( ballYSpeed * ballYDirection );
  }
    
    
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (ballXPos < 0) {
    ballXDirection = 1;
    ballXPos = width*1/4;
    ballYPos = kbdPos;
    
    ballXSpeed = 0;
    ballYSpeed = 0;

    engagement = 0;

    counterT0=millis();
  }
  
  if (ballXPos > width) {
    ballXDirection = -1;
    ballXPos = width*3/4;
    ballYPos = mouseY;
    
    ballXSpeed = 0;
    ballYSpeed = 0;
    
    engagement = 1;
    
    counterT0=millis();
  }
  
  
  
  if (ballYPos > height-ballRadius || ballYPos < ballRadius) {
    ballYDirection *= -1;
  }
  
  
  
  if (ballXPos < (ballRadius*2)+paddleMargin && ballYPos>kbdPos-paddleSize/2 && ballYPos<kbdPos+paddleSize/2) {
    ballXDirection *= -1;
    ballXSpeed+=ballSpeedIncrement;
    ballYSpeed+=ballSpeedIncrement/2;
  }
  if (ballXPos > width-paddleMargin-ballRadius && ballYPos>mouseY-paddleSize/2 && ballYPos<mouseY+paddleSize/2) {
    ballXDirection *= -1;
    ballXSpeed+=ballSpeedIncrement;
    ballYSpeed+=ballSpeedIncrement/2;
  }

  // Draw the shape
  ellipse(ballXPos-ballRadius/2, ballYPos-ballRadius/2, ballRadius, ballRadius);
  
  //defining paddle
  rect(ballRadius+paddleMargin-30,kbdPos-paddleSize/2,30,paddleSize);//LEFT player
  rect(width-paddleMargin-ballRadius,mouseY-paddleSize/2,30,paddleSize); // RIGHT Player
  
  getSerialData();
  if ( key == CODED && keyPressed == true){
    if ( keyCode == UP){
      kbdPos = kbdPos + (kbdMoveSpeed * -1);
    } else if ( keyCode == DOWN){
      kbdPos = kbdPos + (kbdMoveSpeed * 1);
    }
  }
}

void getSerialData() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    // handle buffer
    if (inBuffer != null) {
      String[] match = match(inBuffer, "[0-9]+");
      
      // extract integer values from buffer
      if (match != null) {  // contains only numbers
        serialValue = Integer.parseInt(match[0]);
        //println("value: " + serialValue);
        
        // calibrate
        if (!isCalibrated) {
          calibrate();
        } else {
          getJoystickAction();
        }
      }
    }
  }
}

void calibrate() {
  if (!isCalibrated) {
      calibrationI += 1;
      calibrationSum += serialValue;
      
      if (calibrationI >= calibrationLimit) {
        isCalibrated = true;
        
        calibratedZero = calibrationSum / calibrationLimit;
        println("\n\n\n\tSum: " + calibrationSum + "\n\n\n");
        println("\n\n\n\tZero:" + calibratedZero + "\n\n\n");
      }
  }
}

void getJoystickAction() {
  if (serialValue <= calibratedZero - threshold) {
    println("DOWN");
    kbdPos = kbdPos + (kbdMoveSpeed * 1);
  } else if (serialValue >= calibratedZero + threshold) {
    println("UP");
    kbdPos = kbdPos + (kbdMoveSpeed * -1);
  } else {
    println("NONE");
  }
}
