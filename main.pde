/* === === === === === === === === === ===
  * Document      : main code
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : Processing.org main code file of
  *                 ISEP school project in IOT class
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 30/05/2023
  * Created on    : 24/04/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/


// === === CONSTANTS === ===
// === === ========= === ===
final int DISPLAYTYPE_MENU = 0;
final int DISPLAYTYPE_GAME = 1;



// === === VARS === ===
// === === ==== === ===
int displayType;



// === === SETUP === ===
// === === ===== === ===
void setup(){
  //setup window
  size(1280,720);
  frameRate(144);

  // unitary test
  TEST_GAME_init();
  TEST_UI_init();

  //execute client config
  //initialize com port ?
}



// === === LOOP === ===
// === === ==== === ===
void draw(){
  
  switch(displayType){
    case DISPLAYTYPE_GAME:
      TEST_GAME();
      return;
    case DISPLAYTYPE_MENU:
      TEST_UI();
      return;
    default:
      TEST_UI();
      return;
  }
  //getMenu_type  
  
  //then action
}



// === === OTHER FUNCTIONS === ===
// === === ===== ========= === ===
