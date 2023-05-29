/* === === === === === === === === === ===
  * Document      : TEST input
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : Test code for keyboard input.
  *                 Simply add TEST_INPUT_init() to setup()
  *                 and TEST_INPUT() in the bottom of draw(),
  *                 preferably alone in draw()
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 26/05/2023
  * Created on    : 26/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === VARS === ===
// === === ==== === ===
int TEST_INPUT_sqColor;

int TEST_INPUT_xpos;
int TEST_INPUT_ypos;

int TEST_INPUT_discreteStep;
int TEST_INPUT_contStep;



// === === SETUP === ===
// === === ===== === ===
void TEST_INPUT_init(){
  initInput();
  TEST_INPUT_xpos=width/2;
  TEST_INPUT_ypos=height/2;
  TEST_INPUT_discreteStep = 10;
  TEST_INPUT_contStep = 1;
  TEST_INPUT_sqColor = 127;
}



// === === LOOP === ===
// === === ==== === ===
void TEST_INPUT(){
  background(0);

  fill(TEST_INPUT_sqColor,127,127);
  rect(TEST_INPUT_xpos, TEST_INPUT_ypos, 30, 30);

  fill(127,127,127);
  textAlign(LEFT,TOP);
  textSize(32);
  text("Left/Right arrow move the square horizontally",10,0);
  text("Up/Down arrow move the square vertically",10,32);
  text("Left/Right arrow move continuously",10,64);
  text("Up/Down arrow move step by step",10,96);
  textAlign(RIGHT,BOTTOM);
  textSize(16);
  fill(255,127,127);
  text("Adjust horizontal step/speed by modifying TEST_INPUT_contStep",width-10,height-48);
  text("and TEST_INPUT_discreteStep",width-10,height-32);
  text("Current values are : TEST_INPUT_contStep = "+TEST_INPUT_contStep,width-10,height-16);
  text("TEST_INPUT_discreteStep = "+TEST_INPUT_discreteStep,width-10,height-0);
  
  if (getEvent_up()) {
    if (TEST_INPUT_ypos < 10){
      TEST_INPUT_ypos = 0;
    } else {
      TEST_INPUT_ypos = TEST_INPUT_ypos - 10;
    };
  };
  
  if (getEvent_down()) { 
    if (TEST_INPUT_ypos > height-10){
      TEST_INPUT_ypos = height;
    } else {
      TEST_INPUT_ypos = TEST_INPUT_ypos + 10;
    };
  };


  if (isPressed_left) {
    if (TEST_INPUT_xpos == 0){
      TEST_INPUT_xpos = 0;
    } else {
      TEST_INPUT_xpos --;
    };
  };
  
  if (isPressed_right) { 
    if (TEST_INPUT_xpos == width){
      TEST_INPUT_xpos = width;
    } else {
      TEST_INPUT_xpos ++;
    };
  };


  if (getEvent_ok()) {
    if (TEST_INPUT_sqColor < 50){
      TEST_INPUT_sqColor = 0;
    } else {
      TEST_INPUT_sqColor = TEST_INPUT_sqColor - 50;
    };
  };
  
  if (getEvent_back()) { 
    if (TEST_INPUT_sqColor > 255-50){
      TEST_INPUT_sqColor = 255;
    } else {
      TEST_INPUT_sqColor = TEST_INPUT_sqColor + 50;
    };
  };


}
