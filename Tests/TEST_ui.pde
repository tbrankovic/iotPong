/* === === === === === === === === === ===
  * Document      : TEST ui
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : Test code for menu navigation
  *                  with GUI
  *                  will require input and nav
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 30/05/2023
  * Created on    : 26/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/

// === === SETUP === ===
// === === ===== === ===
void TEST_UI_init(){
  frameRate(144);
  background(0);

  initInput();
  initNav();
  initUI();

  ui_theme=THEME_DARK;
  displayType=DISPLAYTYPE_MENU;

  ui_drawMenu();
}



// === === LOOP === ===
// === === ==== === ===
void TEST_UI(){
  ui_drawMenu();

  if (ui_interrupt)return;
  
  if (getEvent_up()){
    nav_menuUp();
    TEST_NAV_console();
  }

  if (getEvent_down()){
    nav_menuDown();
    TEST_NAV_console();
  }

  if (getEvent_ok()){
    ui_timeStamp = millis();
    nav_menuOk();
    TEST_NAV_console();
  }

  if (getEvent_back()){
    nav_menuBack();
    TEST_NAV_console();
  }

}

// === === DEBUG === ===
// === === ===== === ===
