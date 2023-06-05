/* === === === === === === === === === ===
  * Project name  : IOT CONNECTED PONG
  * 
  * Description   : this handles the Serial communication
  *                  with the TIVA controller board
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 05/06/2023
  * Created on    : 03/06/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/


import processing.serial.*;
import processing.net.*;

// === === CONSTANTS === ===
// === === ========= === ===
final int JOYSTICK_BAUDRATE = 9600;
final int JOYSTICK_THRESHOLD = 100;
final int CALIBRATION_MAXITERATION = 200;




// === === VARS === ===
// === === ==== === ===
Serial joystick_serialPort;  // The serial port
//boolean isCalibrated = false;
int joystick_calibratedZero;
int joystick_serialValue;
int calibration_sum;
int calibration_currentStep;

boolean isJoystick_down;
boolean isJoystick_up;
boolean wasJoystick_down;
boolean wasJoystick_up;



// === === CORE === ===
// === === ==== === ===
void initJoystick(){
  printArray(Serial.list());
  joystick_serialPort = new Serial(this, Serial.list()[JOYSTICK_COM_PORT], 9600);
  joystick_calibratedZero = 1024;

  isJoystick_down = false;
  isJoystick_up = false;
  wasJoystick_down = false;
  wasJoystick_up = false;
}


boolean getSerialData() {
  if (joystick_serialPort.available() < 5){
    return false;
  }

  String inputBuffer = joystick_serialPort.readString();
  if (inputBuffer == null){
    return false;
  }
  String[] filteredBuffer = match(inputBuffer, "[0-9]+");  
  if (filteredBuffer == null) {
    return false;
  }

  joystick_serialValue = Integer.parseInt(filteredBuffer[0]);
  //println("value: " + joystick_serialValue);
  return true;
}



// === === OTHER FUNCTIONS === ===
// === === ===== ========= === ===
void joystick_calibrateInit(){
  calibration_sum = 0;
  calibration_currentStep = 0;
}

void joystick_calibrate() {
  if (calibration_currentStep > CALIBRATION_MAXITERATION){
    joystick_calibratedZero = calibration_sum / CALIBRATION_MAXITERATION;
    displayType = DISPLAYTYPE_MENU;
    return;
  }

  if (!getSerialData()){
    return;
  }

  joystick_calibrationDisplay(calibration_currentStep);
  calibration_sum += joystick_serialValue;
  delay(5);
  calibration_currentStep += 1;
  return;
}


// === === USER INPUT === ===
// === === ========== === ===
boolean getJoystick_down(){
  getSerialData();
  if (joystick_serialValue <= joystick_calibratedZero - JOYSTICK_THRESHOLD) {
    return true;
  }
  wasJoystick_down = false;
  return false;
}

boolean getJoystick_up(){
  getSerialData();
  if (joystick_serialValue >= joystick_calibratedZero + JOYSTICK_THRESHOLD) {
    return true;
  }
  wasJoystick_up = false;
  return false;
}


boolean getJoystick_eventDown(){
  isJoystick_down = getJoystick_down();
  //if rising transition
  if (wasJoystick_down==false && isJoystick_down==true) {
    wasJoystick_down = isJoystick_down;
    return true;
  };
  return false;
}

boolean getJoystick_eventUp(){
  isJoystick_up=getJoystick_up();
  //if rising transition
  if (wasJoystick_up==false && isJoystick_up==true) {
    wasJoystick_up = isJoystick_up;
    return true;
  };
  return false;
}


// === === CALIBRATION SCREEN === ===
// === === =========== ====== === ===

void joystick_calibrationDisplay(int progression){
  background(0);
  fill(UI_PRIMARYCOLOR[ui_theme]);
  noStroke();
  textSize(32);
  text("Calibration in progress",width/2,height/2-32-12);
  textSize(24);
  text("Step "+progression+" of "+CALIBRATION_MAXITERATION,width/2,height/2);
  textSize(24);
  text("Please do not touch joystick",width/2,height/2 +32 +12);
  return;
}
