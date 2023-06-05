/* === === === === === === === === === ===
  * Document      : TEST navigation
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : Unitary test code for menu navigation
  *                  requires input code file too
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 28/05/2023
  * Created on    : 26/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === VARS === ===
// === === ==== === ===




// === === SETUP === ===
// === === ===== === ===
void TEST_NAV_init(){
  initInput();
  initNav();

  //frameRate(60);

  TEST_NAV_console();
}



// === === LOOP === ===
// === === ==== === ===
void TEST_NAV(){
  background(0);
  TEST_NAV_console();

  if (getEvent_up()){
    nav_menuUp();
  }

  if (getEvent_down()){
    nav_menuDown();
  }

  if (getEvent_ok()){
    nav_menuOk();
  }

  if (getEvent_back()){
    nav_menuBack();
  }

}


void TEST_NAV_console(){
  println("\n\n\n\n\n\n\n\n\n");

  // for (int k = 0 ; k < nav_path.length ; k++){
  //   print(nav_path[k]+"/");
  // }

  println("\n=== "+nav_activeMenu_name+" ===");

  for (int i = 0 ; i < nav_maxRow+1 ; i++){

    print("> ".repeat( int( (nav_activeRow == i) )) + "  ".repeat( int( (nav_activeRow != i) )) );
    println(nav_label[i]);

  }
  // println(nav_cursor);
}