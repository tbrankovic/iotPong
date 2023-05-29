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
  * Date          : 28/05/2023
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
  ui_displayType=1;
  ui_theme = THEME_DARK;
  frameRate(144);

  initGame();
  game_set();
  background(20);
  println("Starting unitary test");
  delay(1000);
}



// === === LOOP === ===
// === === ==== === ===
void TEST_GAME(){
  if (isPressed_down){
    game_moveDown();
  };

  if (isPressed_up){
    game_moveUp();
  }

  game_updatePos();
}


// === === DEBUG === ===
// === === ===== === ===