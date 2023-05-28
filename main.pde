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
  * Date          : 28/05/2023
  * Created on    : 24/04/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === VARS === ===
// === === ==== === ===
  //general display variables
  String displayType;  // type of content being displayed
  int[] displayVariant;  // array of information about the content being displayed
  String displayTheme;  // active theme
  color[] displayColor; // array of the colors used by the active theme

  //game physics parameters
  String gameObjective;  // Classic = First to maxScore, Killstreak = Most points in a row, Training 
  boolean isGameOnline;

  /* Timer gameObjective */
  //int minutesLeft;
  //int secondsLeft;
  //int minutesPassed;
  //int secondsPassed;

  int playerScore;
  int enemyScore;
  int maxScore;
    
  int ballRadius;
  int ballXPos;
  int ballYPos;
  int ballXDirection;
  int ballYDirection;
  int ballXSpeed;
  int ballYSpeed;
  int ballXAcceleration;
  int ballYAcceleration;

  int ballMaxY;
  int ballMinY;
  int ball;

  int playerYPos;
  int enemyYPos;

  int paddleWidth;
  int paddleMaxY;
  int paddleMinY;



// === === SETUP === ===
// === === ===== === ===
void setup(){
  //setup window
  size(1280,720);
  frameRate(144);

  // unitary test
  TEST_NAV_init();


  //execute client config
  //initialize com port ?
}



// === === LOOP === ===
// === === ==== === ===
void draw(){
  TEST_NAV();


  //read input
  //getMenu state  
  //refresh display
}



// === === OTHER FUNCTIONS === ===
// === === ===== ========= === ===
