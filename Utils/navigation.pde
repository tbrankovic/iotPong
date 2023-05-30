/* === === === === === === === === === ===
  * Document      : navigation code
  * Project       : IOT CONNECTED PONG
  * 
  * Description   : handles menus and links
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 30/05/2023
  * Created on    : 25/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/

// note to self : change int[] arrays with variable sizes to arrayList or,
// use append(Array) method
// 
// nav_cursor is fine with arrays
// 
// maybe flush cursor position history when back browsing more than 2 layers



// === === CONSTANTS === ===
// === === ========= === ===
// Alternate functions ID
final int ALT_LINK = 1;
final int ALT_LINK_EXIT = 0;
final int ALT_LINK_IDLE = 1;
final int ALT_LINK_BACK = 2;
final int ALT_LINK_CALIBRATION = 3;
final int ALT_LINK_MODIFYRULES = 4;
final int ALT_LINK_STARTGAME = 5;

// MENU UIDs
final int NAV_MENU_COUNT = 9;// max index + 1

final int NAV_MAINMENU = 0;
final int NAV_SOLOMENU = 1;
final int NAV_ONLINEMENU = 2;
final int NAV_SETTINGSMENU = 3;
final int NAV_CREDITS = 4;
final int NAV_PARTYLIST = 5;
final int NAV_PARTYSETUP = 6;
final int NAV_LOBBYHOST = 7;
final int NAV_LOBBYGUEST = 8;

// 0 = MAIN MENU
  final String NAV_MAINMENU_NAME = "Main menu";
  final boolean NAV_MAINMENU_ALLOWCYCLE = false;
  final int NAV_MAINMENU_MAXROW = 4;
  final String[] NAV_MAINMENU_LABEL = {
    "Play solo",
    "Play online",
    "Settings",
    "Credits",
    "Exit"
  };
  final int[] NAV_MAINMENU_TYPE = { 
    0,// 0 = links , 1=ALT_LINK , 2=in-linebutton(not implented)
    0,
    0,
    0,
    ALT_LINK
  };
  final int[] NAV_MAINMENU_LINK ={
    NAV_SOLOMENU,
    NAV_ONLINEMENU,
    NAV_SETTINGSMENU,
    NAV_CREDITS,
    ALT_LINK_EXIT
  };

// 1 = SOLO MENU
  final String NAV_SOLOMENU_NAME = "Solo game";
  final boolean NAV_SOLOMENU_ALLOWCYCLE = true;
  final int NAV_SOLOMENU_MAXROW = 6;
  final String[] NAV_SOLOMENU_LABEL = {
    "Start match",
    "Gamemode",
    "Difficulty",
    "Max point",
    "Ball speed",
    "Ball acceleration",
    "Back"
  };
  final int[] NAV_SOLOMENU_TYPE = { 
    ALT_LINK,// 0 = links , 1=parameters , 2=in-linebutton(not implented)
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    ALT_LINK
  };
  final int[] NAV_SOLOMENU_LINK ={
    ALT_LINK_STARTGAME,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_BACK,
  };

// 2 = ONLINE MENU
  final String NAV_ONLINEMENU_NAME = "Play online";
  final boolean NAV_ONLINEMENU_ALLOWCYCLE = true;
  final int NAV_ONLINEMENU_MAXROW = 2;
  final String[] NAV_ONLINEMENU_LABEL = {
    "Join party",
    "Create party",
    "Back"
  };
  final int[] NAV_ONLINEMENU_TYPE = {
    0,
    0,
    ALT_LINK
  };
  final int[] NAV_ONLINEMENU_LINK ={
    NAV_PARTYLIST,
    NAV_PARTYSETUP,
    ALT_LINK_BACK
  };

// 3 = SETTINGS MENU
  final String NAV_SETTINGSMENU_NAME = "Game settings";
  final boolean NAV_SETTINGSMENU_ALLOWCYCLE = false;
  final int NAV_SETTINGSMENU_MAXROW = 2;
  final String[] NAV_SETTINGSMENU_LABEL = {
    "Calibrate",
    "Refresh rate",
    "Back"
  };
  final int[] NAV_SETTINGSMENU_TYPE = {
    ALT_LINK, // will link to calibration tool
    ALT_LINK,
    0
  };
  final int[] NAV_SETTINGSMENU_LINK ={
    ALT_LINK_CALIBRATION,
    ALT_LINK_IDLE,
    NAV_MAINMENU
  };

// 4 = CREDITS MENU
  final String NAV_CREDITS_NAME = "Credits";
  final boolean NAV_CREDITS_ALLOWCYCLE = true;
  final int NAV_CREDITS_MAXROW = 1;
  final String[] NAV_CREDITS_LABEL = {
    "Contact us",
    "Back"
  };
  final int[] NAV_CREDITS_TYPE = {
    ALT_LINK,
    ALT_LINK
  };
  final int[] NAV_CREDITS_LINK ={
    ALT_LINK_IDLE,
    ALT_LINK_BACK
  };

// 5 = PARTYLIST MENU
  final String NAV_PARTYLIST_NAME = "List of parties";
  final boolean NAV_PARTYLIST_ALLOWCYCLE = false;
  final int NAV_PARTYLIST_MAXROW = 1;
  final String[] NAV_PARTYLIST_LABEL = {
    "Player 3's party",
    "Back"
  };
  final int[] NAV_PARTYLIST_TYPE = {
    0,//tbd
    ALT_LINK
  };
  final int[] NAV_PARTYLIST_LINK ={
    NAV_LOBBYGUEST,//side scrolling will be implemented
    ALT_LINK_BACK
  };

// 6 = PARTYSETUP MENU
  final String NAV_PARTYSETUP_NAME = "Setup party";
  final boolean NAV_PARTYSETUP_ALLOWCYCLE = true;
  final int NAV_PARTYSETUP_MAXROW = 6;
  final String[] NAV_PARTYSETUP_LABEL = {
    "Gamemode",
    "Difficulty",
    "Max point",
    "Ball speed",
    "Ball acceleration",
    "Create party",
    "Back"
  };
  final int[] NAV_PARTYSETUP_TYPE = {
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    0,
    ALT_LINK
  };
  final int[] NAV_PARTYSETUP_LINK ={
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    ALT_LINK_IDLE,
    NAV_LOBBYHOST,
    ALT_LINK_BACK
  };

// 7 = LOBBYHOST MENU
  final String NAV_LOBBYHOST_NAME = "Online lobby";
  final boolean NAV_LOBBYHOST_ALLOWCYCLE = true;
  final int NAV_LOBBYHOST_MAXROW = 3;
  final String[] NAV_LOBBYHOST_LABEL = {
    "Start match",
    "Change rules",// !!! !!!
    "Kick guest",
    "Leave party"
  };
  final int[] NAV_LOBBYHOST_TYPE = {
    ALT_LINK,
    ALT_LINK,
    ALT_LINK,
    0
  };
  final int[] NAV_LOBBYHOST_LINK ={
    ALT_LINK_IDLE,
    ALT_LINK_MODIFYRULES,
    ALT_LINK_IDLE,
    NAV_ONLINEMENU
  };

// 8 = LOBBYGUEST MENU
  final String NAV_LOBBYGUEST_NAME = "Online lobby";
  final boolean NAV_LOBBYGUEST_ALLOWCYCLE = true;
  final int NAV_LOBBYGUEST_MAXROW = 1;
  final String[] NAV_LOBBYGUEST_LABEL = {
    "Ready",
    "Leave party"
  };
  final int[] NAV_LOBBYGUEST_TYPE = {
    ALT_LINK,
    ALT_LINK
  };
  final int[] NAV_LOBBYGUEST_LINK ={
    ALT_LINK_IDLE,
    ALT_LINK_BACK
  };

// === === VARS === ===
// === === ==== === ===
  int[] nav_path; // 0 is top, N-1 is last, as for every arrays
  int[] nav_cursor = new int[NAV_MENU_COUNT];

  String nav_activeMenu_name;
  int nav_activeMenu;
  boolean nav_allowCycle;
  int nav_maxRow;
  int nav_activeRow; 
  String[] nav_label;
  int[] nav_type;
  int[] nav_link;



// === === FUNCTIONS === ===
// === === ========= === ===
void initNav(){
  nav_setMenu(NAV_MAINMENU);
  nav_resetPath();

  //clear path history auto when landing on main menu
}

// === === NAVIGATION === ===
// === === ========== === ===
void nav_setMenu(int targetMenu){
  nav_activeRow = nav_cursor[targetMenu];

  switch(targetMenu){
    case NAV_MAINMENU:
      nav_activeMenu_name = NAV_MAINMENU_NAME;
      nav_activeMenu = NAV_MAINMENU;
      nav_allowCycle = NAV_MAINMENU_ALLOWCYCLE;
      nav_maxRow = NAV_MAINMENU_MAXROW;
      nav_label = NAV_MAINMENU_LABEL;
      nav_type = NAV_MAINMENU_TYPE;
      nav_link = NAV_MAINMENU_LINK;
      return;
    
    case NAV_ONLINEMENU:
      nav_activeMenu_name = NAV_ONLINEMENU_NAME;
      nav_activeMenu = NAV_ONLINEMENU;
      nav_allowCycle = NAV_ONLINEMENU_ALLOWCYCLE;
      nav_maxRow = NAV_ONLINEMENU_MAXROW;
      nav_label = NAV_ONLINEMENU_LABEL;
      nav_type = NAV_ONLINEMENU_TYPE;
      nav_link = NAV_ONLINEMENU_LINK;
      return;

    case NAV_SOLOMENU:
      nav_activeMenu_name = NAV_SOLOMENU_NAME;
      nav_activeMenu = NAV_SOLOMENU;
      nav_allowCycle = NAV_SOLOMENU_ALLOWCYCLE;
      nav_maxRow = NAV_SOLOMENU_MAXROW;
      nav_label = NAV_SOLOMENU_LABEL;
      nav_type = NAV_SOLOMENU_TYPE;
      nav_link = NAV_SOLOMENU_LINK;
      return;

    case NAV_SETTINGSMENU:
      nav_activeMenu_name = NAV_SETTINGSMENU_NAME;
      nav_activeMenu = NAV_SETTINGSMENU;
      nav_allowCycle = NAV_SETTINGSMENU_ALLOWCYCLE;
      nav_maxRow = NAV_SETTINGSMENU_MAXROW;
      nav_label = NAV_SETTINGSMENU_LABEL;
      nav_type = NAV_SETTINGSMENU_TYPE;
      nav_link = NAV_SETTINGSMENU_LINK;
      return;

    case NAV_CREDITS:
      nav_activeMenu_name = NAV_CREDITS_NAME;
      nav_activeMenu = NAV_CREDITS;
      nav_allowCycle = NAV_CREDITS_ALLOWCYCLE;
      nav_maxRow = NAV_CREDITS_MAXROW;
      nav_label = NAV_CREDITS_LABEL;
      nav_type = NAV_CREDITS_TYPE;
      nav_link = NAV_CREDITS_LINK;
      return;

    case NAV_PARTYLIST:
      nav_activeMenu_name = NAV_PARTYLIST_NAME;
      nav_activeMenu = NAV_PARTYLIST;
      nav_allowCycle = NAV_PARTYLIST_ALLOWCYCLE;
      nav_maxRow = NAV_PARTYLIST_MAXROW;
      nav_label = NAV_PARTYLIST_LABEL;
      nav_type = NAV_PARTYLIST_TYPE;
      nav_link = NAV_PARTYLIST_LINK;
      return;

    case NAV_PARTYSETUP:
      nav_activeMenu_name = NAV_PARTYSETUP_NAME;
      nav_activeMenu = NAV_PARTYSETUP;
      nav_allowCycle = NAV_PARTYSETUP_ALLOWCYCLE;
      nav_maxRow = NAV_PARTYSETUP_MAXROW;
      nav_label = NAV_PARTYSETUP_LABEL;
      nav_type = NAV_PARTYSETUP_TYPE;
      nav_link = NAV_PARTYSETUP_LINK;
      return;

    case NAV_LOBBYHOST:
      nav_activeMenu_name = NAV_LOBBYHOST_NAME;
      nav_activeMenu = NAV_LOBBYHOST;
      nav_allowCycle = NAV_LOBBYHOST_ALLOWCYCLE;
      nav_maxRow = NAV_LOBBYHOST_MAXROW;
      nav_label = NAV_LOBBYHOST_LABEL;
      nav_type = NAV_LOBBYHOST_TYPE;
      nav_link = NAV_LOBBYHOST_LINK;
      return;

    case NAV_LOBBYGUEST:
      nav_activeMenu_name = NAV_LOBBYGUEST_NAME;
      nav_activeMenu = NAV_LOBBYGUEST;
      nav_allowCycle = NAV_LOBBYGUEST_ALLOWCYCLE;
      nav_maxRow = NAV_LOBBYGUEST_MAXROW;
      nav_label = NAV_LOBBYGUEST_LABEL;
      nav_type = NAV_LOBBYGUEST_TYPE;
      nav_link = NAV_LOBBYGUEST_LINK;
      return;
  }


  return;
}

// === === PATH HISTORY === ===
// === === ============ === ===
void nav_resetPath(){
  int[] nav_path_buffer = new int[1];
  nav_path_buffer[0] = 0;
  nav_path=nav_path_buffer;
  return;
}

void nav_appendPath(int newPathElement){
  int currentDepth = nav_path.length;
  int newDepth = currentDepth + 1;
  int[] nav_path_buffer = new int[newDepth];
    //copy
  for (int depthIndex = 0 ; depthIndex < currentDepth ; depthIndex++){
    nav_path_buffer[depthIndex] = nav_path[depthIndex];
  }
    //append
  nav_path_buffer[newDepth-1] = newPathElement;
    //merge
  nav_path = nav_path_buffer;
  return;
}

void nav_cropPath(int pathIndex){
  int[] nav_path_buffer = new int[pathIndex];
  // partial copy
  for (int depthIndex = 0 ; depthIndex < pathIndex ; depthIndex++){
    nav_path_buffer[depthIndex] = nav_path[depthIndex];
  }
  // merge
  nav_path = nav_path_buffer;
  return;
}

void nav_updatePath(int newPathElement){

  for (int pathIndex = 0 ; pathIndex < nav_path.length ; pathIndex++){
    if (nav_path[pathIndex] == newPathElement) {
      nav_cropPath(pathIndex);
    }
  }
  nav_appendPath(newPathElement);
  return;
}


// === === CURSOR HISTORY === ===
// === === ============== === ===
void nav_resetCursor(){
  int[] nav_cursor_buffer = new int[NAV_MENU_COUNT];
  nav_cursor=nav_cursor_buffer;
  return;
}

void nav_updateCursor(){
  nav_cursor[nav_activeMenu]=nav_activeRow;
  return;
}



// === === USER INPUT === ===
// === === ========== === ===
void nav_menuOk(){
  ui_highlightButtonRow = nav_activeRow;
  ui_highlightLabel = nav_label[nav_activeRow];

  if (nav_type[nav_activeRow] != ALT_LINK){
    nav_updatePath(nav_link[nav_activeRow]);
    nav_setMenu(nav_link[nav_activeRow]);
  return;
  }

  switch(nav_link[nav_activeRow]){
    case ALT_LINK_EXIT:
      exit();
      return;
    case ALT_LINK_IDLE:
      return;
    case ALT_LINK_CALIBRATION:
      return;
    case ALT_LINK_BACK:
      nav_menuBack();
      return;
    case ALT_LINK_MODIFYRULES:
      nav_setMenu(NAV_PARTYSETUP);
      nav_label[5]="Confirm changes";
      nav_appendPath(NAV_PARTYSETUP);
      return;
    case ALT_LINK_STARTGAME:
      displayType = DISPLAYTYPE_GAME;
      return;
  }
  return;
}

void nav_menuBack(){
  if (nav_activeMenu==NAV_LOBBYHOST){
    nav_setMenu(NAV_ONLINEMENU);
    nav_updatePath(NAV_ONLINEMENU);
    return;
  }

  if (nav_path.length <= 1){
    nav_setMenu(NAV_MAINMENU);
    nav_resetPath();
    return;
  }
  nav_setMenu(nav_path[nav_path.length-2]);
  nav_updatePath(nav_path[nav_path.length-2]);
}

void nav_menuRight(){

  switch(nav_activeMenu){

  }

  return;
}

void nav_menuUp(){
  if (nav_activeRow == 0 && nav_allowCycle == false){
    return;
  }

  if (nav_activeRow == 0 && nav_allowCycle == true) {
    nav_activeRow = nav_maxRow;
    nav_updateCursor();
    return;
  }

  nav_activeRow -= 1;
  nav_updateCursor();
  return;
}

void nav_menuDown(){
  if (nav_activeRow == nav_maxRow && nav_allowCycle == false){
    return;
  }

  if (nav_activeRow == nav_maxRow && nav_allowCycle == true) {
    nav_activeRow = 0;
    nav_updateCursor();
    return;
  }

  nav_activeRow += 1;
  nav_updateCursor();
  return;
}
