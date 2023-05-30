/* === === === === === === === === === ===
  * Project name  : IOT CONNECTED PONG
  * 
  * Description   : this code serves as an interface
  *                  between displayTypes such as Game
  *                  menu, loading screens, etc.
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



// === === CONSTANTS === ===
// === === ========= === ===
final int UI_THEME_MAXINDEX = 2;
final String[] UI_THEME_NAME = {
  "Dark theme",
  "Light theme",
  "Processing theme"
};
final color[] UI_PRIMARYCOLOR = {
  color(255,255,255),
  color(0,0,0),
  color(4, 104, 255)
};
final color[] UI_SECONDARYCOLOR = {
  color(200,200,200),
  color(0,0,0),
  color(4, 104, 255)
};
final color[] UI_ACCENTCOLOR = {
  color(31, 52, 171),
  color(0,0,0),
  color(4, 104, 255)
};
final color[] UI_BGCOLOR = {
  color(12,12,12),
  color(234,234,234),
  color(0,0,0)
};

final int THEME_DARK = 0;
final int THEME_LIGHT = 1;
final int THEME_PROCESSING = 2;

final int[] UI_TIMETRIGGER = {200,300,500,600};

// === === VARS === ===
// === === ==== === ===
int ui_theme;

boolean isGameAlive;
boolean ui_interrupt;

int ui_startBoxPos;
int ui_endBoxPos;
int ui_boxKerning;
int ui_boxHeight;
int ui_boxWidth;
int ui_boxMargin;
int ui_boxTextSize;

int ui_timeStamp;

int ui_highlightButtonRow;
String ui_highlightLabel;



// === === MENU === ===
// === === ==== === ===
void initUI(){
  rectMode(RADIUS);
  ui_interrupt=true;
  ui_startBoxPos = 220;
  ui_highlightLabel ="";
}



void ui_drawMenu(){
  if (millis()  < ui_timeStamp + UI_TIMETRIGGER[0] ){
    ui_highlightButton();
    ui_interrupt=true;
    return;
  };

  ui_interrupt=false;

  //draw background
  background(0);


  //draw title
  noStroke();
  fill(UI_PRIMARYCOLOR[ui_theme]);
  textSize(64);
  textAlign(CENTER, CENTER);
  text(nav_activeMenu_name.toUpperCase(), width/2 , height/8);

  //draw button boxes
  for (int k = 0 ; k<=nav_maxRow ; k++){

    stroke(UI_PRIMARYCOLOR[ui_theme]);
    strokeWeight(1);
    fill(UI_BGCOLOR[ui_theme]);
    if (k == nav_activeRow) fill(UI_PRIMARYCOLOR[ui_theme]);
    rect(
      width/2,
      ui_startBoxPos+k*(2* 40+30),
      200,
      40  //30 kerning
    );

    fill(UI_PRIMARYCOLOR[ui_theme]);
    if (k == nav_activeRow)fill(UI_BGCOLOR[ui_theme]);
    textSize(32);
    text(
      nav_label[k].toUpperCase(),
      width/2 ,
      ui_startBoxPos+k*(2* 40+30)
    );
  }

  return;
}



void ui_highlightButton(){
  stroke(UI_SECONDARYCOLOR[ui_theme]);
  strokeWeight(1);
  fill(0); 
  rect(
    width/2,
    ui_startBoxPos+ui_highlightButtonRow*(2* 40+30),
    200,
    40  //30 kerning
  );
  fill(UI_PRIMARYCOLOR[ui_theme]);
  textSize(32);
  text(
    ui_highlightLabel.toUpperCase(),
    width/2 ,
    ui_startBoxPos+ui_highlightButtonRow*(2* 40+30)
  );
  return;
}

// === === OTHER FUNCTIONS === ===
// === === =============== === ===
void ui_specialExit(){
  switch (displayType){
  case  DISPLAYTYPE_MENU:
    exit();
    return;

  case DISPLAYTYPE_GAME:
    displayType = DISPLAYTYPE_MENU;
  }
}
