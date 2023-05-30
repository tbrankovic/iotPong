/* === === === === === === === === === ===
  * Document      : TEST navigation
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : Test code for game physics
  *                  and eventual rules
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 30/05/2023
  * Created on    : 28/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === SETUP === ===
// === === ===== === ===
void TEST_GAME_init(){
  initInput();
  initGame();
  
  
  displayType = DISPLAYTYPE_GAME;
  ui_theme = THEME_DARK;
  frameRate(144);
  background(20);
  game_set();
  
  println("Starting unitary test");
  delay(1000);
}



// === === LOOP === ===
// === === ==== === ===
void TEST_GAME(){
  game_updatePos();
  
  
  
  if (isPressed_down){
    game_moveDown();
  };

  if (isPressed_up){
    game_moveUp();
  }

  
}


// === === DEBUG === ===
// === === ===== === ===
