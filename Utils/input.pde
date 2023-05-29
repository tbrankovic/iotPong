/* === === === === === === === === === ===
  * Document      : input code
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : handles keyboard clicks
  *                 and presses
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 28/05/2023
  * Created on    : 24/04/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === CONSTANTS === ===
// === === ========= === ===
final int KEYCODE_DOWN = 40;
final int KEYCODE_UP = 38;
final int KEYCODE_RIGHT = 39 ;
final int KEYCODE_LEFT = 37;
final int KEYCODE_DOWN_KP = 225;
final int KEYCODE_UP_KP = 224;
final int KEYCODE_RIGHT_KP = 227;
final int KEYCODE_LEFT_KP = 226;
final int KEYCODE_SPACE = 32;
final int KEYCODE_ENTER = 10;
final int KEYCODE_BACKSPACE = 8;
final int KEYCODE_ESCAPE = 27;

final int DELAY_DOUBLECLICK = 90;


// === === VARS === ===
// === === ==== === ===
boolean isPressed_down;
boolean isPressed_up;
boolean isPressed_right;
boolean isPressed_left;
boolean isPressed_ok;
boolean isPressed_boost;
boolean isPressed_back;

boolean wasPressed_down;
boolean wasPressed_up;
boolean wasPressed_right;
boolean wasPressed_left;
boolean wasPressed_ok;
boolean wasPressed_boost;
boolean wasPressed_back;

int esc_time;
int esc_lasttime;



// === === FUNCTIONS === ===
// === === ========= === ===
void initInput(){
  isPressed_down = false;
  isPressed_up = false;
  isPressed_right = false;
  isPressed_left = false;
  isPressed_ok = false;
  isPressed_boost = false;
  isPressed_back = false;

  wasPressed_down = false;
  wasPressed_up = false;
  wasPressed_right = false;
  wasPressed_left = false;
  wasPressed_ok = false;
  wasPressed_boost = false;
  wasPressed_back = false;
}



boolean getEvent_down(){
  //if rising transition
  if (wasPressed_down==false && isPressed_down==true) {
    wasPressed_down = isPressed_down;
    return true;
  };
  return false;
}

boolean getEvent_up(){
  //if rising transition
  if (wasPressed_up==false && isPressed_up==true) {
    wasPressed_up = isPressed_up;
    return true;
  };
  return false;
}

boolean getEvent_right(){
  //if rising transition
  if (wasPressed_right==false && isPressed_right==true) {
    wasPressed_right = isPressed_right;
    return true;
  };
  return false;
}

boolean getEvent_left(){
  //if rising transition
  if (wasPressed_left==false && isPressed_left==true) {
    wasPressed_left = isPressed_left;
    return true;
  };
  return false;
}


boolean getEvent_ok(){
  //if rising transition
  if (wasPressed_ok==false && isPressed_ok==true) {
    wasPressed_ok = isPressed_ok;
    return true;
  };
  return false;
}

boolean getEvent_boost(){
  //if rising transition
  if (wasPressed_boost==false && isPressed_boost==true) {
    wasPressed_boost = isPressed_boost;
    return true;
  };
  return false;
}

boolean getEvent_back(){
  //if rising transition
  if (wasPressed_back==false && isPressed_back==true) {
    wasPressed_back = isPressed_back;
    return true;
  };
  return false;
}



public void keyPressed() {
  
  switch(keyCode){
    // DIRECTIONAL CASES
    case KEYCODE_DOWN:
      wasPressed_down = isPressed_down;
      isPressed_down = (keyCode == KEYCODE_DOWN || keyCode == KEYCODE_DOWN_KP);
      return;
    case KEYCODE_DOWN_KP:
      wasPressed_down = isPressed_down;
      isPressed_down = (keyCode == KEYCODE_DOWN || keyCode == KEYCODE_DOWN_KP);
      return;
    case KEYCODE_UP:
      wasPressed_up = isPressed_up;
      isPressed_up = (keyCode == KEYCODE_UP || keyCode == KEYCODE_UP_KP);
      return;
    case KEYCODE_UP_KP:
      wasPressed_up = isPressed_up;
      isPressed_up = (keyCode == KEYCODE_UP || keyCode == KEYCODE_UP_KP);
      return;
    case KEYCODE_RIGHT:
      wasPressed_right = isPressed_right;
      isPressed_right = (keyCode == KEYCODE_RIGHT|| keyCode == KEYCODE_RIGHT_KP);
      return;
    case KEYCODE_RIGHT_KP:
      wasPressed_right = isPressed_right;
      isPressed_right = (keyCode == KEYCODE_RIGHT || keyCode == KEYCODE_RIGHT_KP);
      return;
    case KEYCODE_LEFT:
      wasPressed_left = isPressed_left;
      isPressed_left = (keyCode == KEYCODE_LEFT || keyCode == KEYCODE_LEFT_KP);
      return;
    case KEYCODE_LEFT_KP:
      wasPressed_left = isPressed_left;
      isPressed_left = (keyCode == KEYCODE_LEFT || keyCode == KEYCODE_LEFT_KP);
      return;
      
    // OTHER CASES
    case KEYCODE_ESCAPE:
      esc_time = millis();
      if (esc_time < esc_lasttime + DELAY_DOUBLECLICK && esc_time > esc_lasttime){
        ui_specialExit();
      }
      wasPressed_back = isPressed_back;
      isPressed_back = (keyCode == KEYCODE_ESCAPE || keyCode == KEYCODE_BACKSPACE);
      key=0;//prevents exiting the application
      return; 
    case KEYCODE_BACKSPACE:
      wasPressed_back = isPressed_back;
      isPressed_back = (keyCode == KEYCODE_ESCAPE || keyCode == KEYCODE_BACKSPACE);
      return;
    case KEYCODE_ENTER:
      wasPressed_ok = isPressed_ok;
      isPressed_ok = (keyCode == KEYCODE_ENTER || keyCode == KEYCODE_SPACE);
      return;
    case KEYCODE_SPACE:
      wasPressed_ok = isPressed_ok;
      wasPressed_boost = isPressed_boost;
      isPressed_ok = (keyCode == KEYCODE_ENTER || keyCode == KEYCODE_SPACE);
      isPressed_boost = isPressed_ok;
      return;



  };
  
}


public void keyReleased() {
  
  switch(keyCode){
    case KEYCODE_DOWN:
      isPressed_down = (keyCode != KEYCODE_DOWN && keyCode != KEYCODE_DOWN_KP);
      return;
    case KEYCODE_DOWN_KP:
      isPressed_down = (keyCode != KEYCODE_DOWN && keyCode != KEYCODE_DOWN_KP);
      return;
    case KEYCODE_UP:
      isPressed_up = (keyCode != KEYCODE_UP && keyCode != KEYCODE_UP_KP);
      return;
    case KEYCODE_UP_KP:
      isPressed_up = (keyCode != KEYCODE_UP && keyCode != KEYCODE_UP_KP);
      return;
    case KEYCODE_RIGHT:
      isPressed_right = (keyCode != KEYCODE_RIGHT && keyCode != KEYCODE_RIGHT_KP);
      return;
    case KEYCODE_RIGHT_KP:
      isPressed_right = (keyCode != KEYCODE_RIGHT && keyCode != KEYCODE_RIGHT_KP);
      return;
    case KEYCODE_LEFT:
      isPressed_left = (keyCode != KEYCODE_LEFT && keyCode != KEYCODE_LEFT_KP);
      return;
    case KEYCODE_LEFT_KP:
      isPressed_left = (keyCode != KEYCODE_LEFT && keyCode != KEYCODE_LEFT_KP);
      return;

    // OTHER CASES
    case KEYCODE_ESCAPE:
      isPressed_back = (keyCode != KEYCODE_ESCAPE && keyCode != KEYCODE_BACKSPACE);
      esc_lasttime = millis();
      return; 
    case KEYCODE_BACKSPACE:
      isPressed_back = (keyCode != KEYCODE_ESCAPE && keyCode != KEYCODE_BACKSPACE);
      return;
    case KEYCODE_ENTER:
      isPressed_ok = (keyCode != KEYCODE_ENTER && keyCode != KEYCODE_SPACE);
      return;
    case KEYCODE_SPACE:
      isPressed_ok = (keyCode != KEYCODE_ENTER && keyCode != KEYCODE_SPACE);
      isPressed_boost = isPressed_ok;
      return;

  };

}