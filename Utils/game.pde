/* === === === === === === === === === ===
  * Project name  : IOT CONNECTED PONG
  * 
  * Description   : this handles the physics of the
  *                  game, as well as server-client data
  *
  * Authors       : Tristan Brankovic
  *                 Alexandre Eang
  *
  * Date          : 30/05/2023
  * Created on    : 21/05/2023
  * Version       : 1.0 
  * Repository    : github.com/tbrankovic/iotPong/
  *
  * === === === === === === === === === ===
 (c) Tristan Brankovic & Alexandre Eang
*/



// === === CONSTANTS === ===
// === === ========= === ===
  final int GAME_BALL_DIRLEFT = -1;
  final int GAME_BALL_DIRRIGHT = 1;
  final int GAME_BALL_DIRUP = -1;
  final int GAME_BALL_DIRDOWN = 1;
  final int GAME_BALL_MAXSPEED = 20;

  final int GAME_ENGAGEMENT_PLAYER = -1;
  final int GAME_ENGAGEMENT_ENEMY = 1;

  final int GAME_TIMETRIGGER_FREEZE=600;
  final int GAME_TIMETRIGGER_ENGAGE=1900;



// === === VARS === ===
// === === ==== === ===
/* Game objective
  String gameObjective;  // Classic = First to maxScore, Killstreak = Most points in a row, Training 
  boolean isGameOnline;
*/
/* Timer Game objective
  int minutesLeft;
  int secondsLeft;
  int minutesPassed;
  int secondsPassed;
*/
/* Score
  // server host shall be player 1, and server guest be player 2
  int sv_playerScore;
  int sv_enemyScore;
  int playerScore;
  int enemyScore;
  int maxScore;
*/
// Game physics parameters
  int game_paddleMargin;
  int game_playerPos;
  int game_enemyPos;
  int game_paddleSpeed;
  int game_paddleSize;
  int game_paddleWidth;
  int game_paddleMaxPos;
  int game_paddleMinPos;

  int game_ballRadius;
  int game_ballDirection_X;
  int game_ballDirection_Y;
  int[] game_ball_X; // [0] : pos , [1] : speed , [2] : acc
  int[] game_ball_Y;

  int game_ballMax_Y;
  int game_ballMin_Y;
  int game_ballMax_X;
  int game_ballMin_X;
  int game_bounceComp_X;

  float game_ballSpeedPercent;
  int game_ballStrokeWeight;

// Game rules parameters
  int game_maxScore;
  int game_playerScore;
  int game_enemyScore;

  boolean isBallScored;
  int game_engagementSide;
  int game_timer;

  boolean isGameLocal;
  boolean isPlayer_Hosting;


// === === CORE === ===
// === === ==== === ===
void initGame(){
  ellipseMode(RADIUS);
  rectMode(RADIUS);
  game_ball_X = new int[3];
  game_ball_Y = new int[3];
  isBallScored = false;
}

void game_set(){
  isGameAlive = true;

  game_paddleMargin = 150;
  game_paddleSize = 80; //actually halfsize
  game_paddleWidth = 10; //actually halfwidth
  game_paddleMaxPos = height - game_paddleSize;
  game_paddleMinPos = 0 + game_paddleSize;
  game_playerPos=height/2;
  game_enemyPos=height/2;
  game_paddleSpeed=5;

  game_ballRadius = 30;
  if (int(random(1,3))==1){
    game_ballDirection_X = GAME_BALL_DIRLEFT;
  } else {
    game_ballDirection_X = GAME_BALL_DIRRIGHT;
  }
  if (int(random(1,3))==1){
    game_ballDirection_Y = GAME_BALL_DIRDOWN;
  } else {
    game_ballDirection_Y = GAME_BALL_DIRUP;
  }
  game_ball_X[0] = width/2;
  game_ball_X[1] = 6;
  game_ball_X[2] = 1;
  game_ball_Y[0] = height/2;
  game_ball_Y[1] = 3;
  game_ball_Y[2] = 1;

  game_ballMax_Y = height - game_ballRadius;
  game_ballMin_Y = 0 + game_ballRadius;
  game_ballMax_X = width - (game_paddleMargin + game_paddleWidth + game_ballRadius);
  game_ballMin_X = 0 + (game_paddleMargin + game_paddleWidth + game_ballRadius);
}

void game_updatePos(){
  if (isBallScored){
    game_timeout();
  } else {
    game_ballAccelerate_H();
    game_updateBounce_H();
    game_ballAccelerate_V();
    game_updateBounce_V();   
  }

  game_updateBall();
  game_updateEnemy();
  
  game_drawBackground();
  game_drawBall();
  game_drawPaddle();
}

// === === GAME PHYSICS MODULES === ===
// === === ==================== === ===
void game_ballAccelerate_H(){
  if (game_ball_X[0] > game_ballMin_X + game_ball_X[1] && game_ball_X[0] < game_ballMax_X - game_ball_X[1]){
    return;
  }

  if (game_ball_X[1] >= GAME_BALL_MAXSPEED - game_ball_X[2]){
    game_ball_X[1] = GAME_BALL_MAXSPEED;
    return;
  }

  if (game_ball_X[0] <= game_ballMin_X + game_ball_X[1] && game_ballDirection_X == GAME_BALL_DIRRIGHT){
    return;
  }
  if (game_ball_X[0] >= game_ballMax_X + game_ball_X[1] && game_ballDirection_X == GAME_BALL_DIRLEFT){
    return;
  }


  game_ball_X[1] += game_ball_X[2];
  return;
}

void game_updateBounce_H(){
  if (game_ball_X[0] < game_ballMax_X - game_ball_X[1] && game_ball_X[0] > game_ballMin_X + game_ball_X[1]){
    return;
  }


  if (game_ball_X[0] >= game_ballMax_X - game_ball_X[1] && game_ballDirection_X == GAME_BALL_DIRRIGHT){
    if (game_ball_Y[0] <= game_enemyPos- game_paddleSize || game_ball_Y[0] >= game_enemyPos+ game_paddleSize){
      game_ball_X[0] += 5* game_ballDirection_X * game_ball_X[1];
      game_ball_Y[0] += 5* game_ballDirection_Y * game_ball_Y[1];

      game_ball_X[1] = 0;
      game_ball_Y[1] = 0;
      game_ball_X[2] = 0;
      game_ball_Y[2] = 0;

      isBallScored = true;
      game_ballDirection_X=GAME_BALL_DIRLEFT;
      game_engagementSide = GAME_ENGAGEMENT_PLAYER;
      game_timer = millis();
      return;
    }

    game_ball_X[0] += game_bounceComp_X;
    game_ballDirection_X = GAME_BALL_DIRLEFT;
    return; 
  }
  if (game_ball_X[0] <= game_ballMin_X + game_ball_X[1] && game_ballDirection_X == GAME_BALL_DIRLEFT){
    if (game_ball_Y[0] <= game_playerPos- game_paddleSize || game_ball_Y[0] >= game_playerPos+ game_paddleSize){
      game_ball_X[0] += 5* game_ballDirection_X * game_ball_X[1];
      game_ball_Y[0] += 5* game_ballDirection_Y * game_ball_Y[1];

      game_ball_X[1] = 0;
      game_ball_Y[1] = 0;
      game_ball_X[2] = 0;
      game_ball_Y[2] = 0;

      isBallScored = true;
      game_ballDirection_X = GAME_BALL_DIRRIGHT;
      game_engagementSide = GAME_ENGAGEMENT_ENEMY;
      game_timer = millis();
      return;
    }

    game_ball_X[0] -= game_bounceComp_X;
    game_ballDirection_X = GAME_BALL_DIRRIGHT;
    return;
  }

  return;
}

void game_ballAccelerate_V(){
  if (game_ball_Y[0] > game_ballMin_Y && game_ball_Y[0] < game_ballMax_Y){
    return;
  }

  if (game_ball_Y[1] >= GAME_BALL_MAXSPEED - game_ball_Y[2]){
    game_ball_Y[1] = GAME_BALL_MAXSPEED;
    return;
  }

  game_ball_Y[1] += game_ball_Y[2];
  return;
}

void game_updateBounce_V(){
  if (game_ball_Y[0] > game_ballMin_Y && game_ball_Y[0] < game_ballMax_Y){
    return;
  }

  game_ballDirection_Y *= -1;
  return;
}

void game_updateBall(){
  game_ball_X[0] += game_ballDirection_X * game_ball_X[1];
  game_ball_Y[0] += game_ballDirection_Y * game_ball_Y[1];
  return;
}

void game_updateEnemy(){
  if (isGameLocal){
    if (mouseY<=game_paddleMinPos){
      game_enemyPos = game_paddleMinPos;
    } else if (mouseY>=game_paddleMaxPos){
      game_enemyPos = game_paddleMaxPos;
    } else {
      game_enemyPos = mouseY;
    };
    return;
  }

  if (isPlayer_Hosting){
    getClientPaddleData();
    return;
  }

  if (!isPlayer_Hosting){
    getClientPaddleData();
    return;
  }
  
}

// === === TIMEOUT MODULES === ===
// === === =============== === ===
void game_timeout(){
  //phase 1 : freeze
  if (millis() - game_timer < GAME_TIMETRIGGER_FREEZE){
    //println("pahse1");
    return;
  }

  //phase 2 : prepare engage
  game_ball_X[0] = width/2 - game_engagementSide* width/4;
  if (millis() - game_timer < GAME_TIMETRIGGER_ENGAGE){
    //println("pahse2");

    if (game_engagementSide == GAME_ENGAGEMENT_ENEMY){
      game_ball_Y[0] = game_playerPos;
    } else {
      game_ball_Y[0] = game_enemyPos;
    }
    
    
    return;
  }
  //phase 3 : shoot
  game_setEngage();
  //println("pahse3");
  isBallScored = false;
  return;  
}

void game_setEngage(){
  isGameAlive = true;

  game_paddleMargin = 150;
  game_paddleSize = 80; //actually halfsize
  game_paddleWidth = 10; //actually halfwidth
  game_paddleMaxPos = height - game_paddleSize;
  game_paddleMinPos = 0 + game_paddleSize;
  game_playerPos=height/2;
  game_enemyPos=height/2;
  game_paddleSpeed=5;

  game_ballRadius = 30;
  if (int(random(1,3))==1){
    game_ballDirection_Y = GAME_BALL_DIRDOWN;
  } else {
    game_ballDirection_Y = GAME_BALL_DIRUP;
  }
  game_ball_X[1] = 6;
  game_ball_X[2] = 1;
  game_ball_Y[1] = 3;
  game_ball_Y[2] = 1;

  game_ballMax_Y = height - game_ballRadius;
  game_ballMin_Y = 0 + game_ballRadius;
  game_ballMax_X = width - (game_paddleMargin + game_paddleWidth + game_ballRadius);
  game_ballMin_X = 0 + (game_paddleMargin + game_paddleWidth + game_ballRadius);
}

// === === DRAW MODULES === ===
// === === ============ === ===
void game_drawBackground(){
  background(UI_BGCOLOR[ui_theme]);
  return;
}

void game_drawBall(){
    fill(UI_PRIMARYCOLOR[ui_theme]);
    if(isBallScored){
      fill(UI_PRIMARYCOLOR[THEME_PROCESSING]);
    }
    stroke(
        int( 255 - 0.1 * 35 ),
        int( 255 - 5 * 35 ),
        255 - 8 * 35
      );

    // evaluate ball acceleration progression
    game_ballSpeedPercent = float(game_ball_X[1])/float(GAME_BALL_MAXSPEED);
    game_ballStrokeWeight = game_ballRadius + int (float(game_ballRadius) * (exp(game_ballSpeedPercent)-exp(1.0)));

    // if acceleration is important enough
    if (game_ballStrokeWeight > 0) {
      strokeWeight(game_ballStrokeWeight);
      ellipse(
        game_ball_X[0],
        game_ball_Y[0],
        game_ballRadius - game_ballStrokeWeight/2,
        game_ballRadius - game_ballStrokeWeight/2
      );
      return;  
    }

    noStroke();
    ellipse(
      game_ball_X[0],
      game_ball_Y[0],
      game_ballRadius,
      game_ballRadius
    );
    return;  
}

void game_drawPaddle(){
  noStroke();

  //player paddle
  fill(UI_PRIMARYCOLOR[ui_theme]);
  rect(
    0+(game_paddleMargin),
    game_playerPos,
    game_paddleWidth,
    game_paddleSize
  );

  //enemy paddle
  fill(UI_PRIMARYCOLOR[ui_theme]);
  rect(
    width-(game_paddleMargin) ,
    game_enemyPos,
    game_paddleWidth,
    game_paddleSize
  );
}

// === === ONLINE FUNCTIONS === ===
// === === ====== ========= === ===
void getClientPaddleData() {
  myClient = myServer.available();
  if (myClient != null) {
    String input = myClient.readString();
    input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    int data[] = int(split(input, ' ')); // Split values into an array
   
    game_enemyPos=data[0];
  }
}

void writePaddlePosToServer() {
   myClient.write(int(game_playerPos) + "\n");    
}

// === === OTHER FUNCTIONS === ===
// === === ===== ========= === ===
void game_endScreen(){
}

void game_kill(){
  isGameAlive = false;
}


// === === USER INPUT === ===
// === === ========== === ===
void game_moveDown(){
  if (isPressed_up){
    return;
  }
  if (game_playerPos >= game_paddleMaxPos){
    return;
  }

  if (isPressed_boost){
    game_playerPos += 3* game_paddleSpeed;
    return;
  }

  game_playerPos += game_paddleSpeed;
  return;
}

void game_moveUp(){
  if (isPressed_down){
    return;
  }
  if (game_playerPos <= game_paddleMinPos){
    return;
  }

  if (isPressed_boost){
    game_playerPos -= 3* game_paddleSpeed;
    return;
  }

  game_playerPos -= game_paddleSpeed;
  return;
}
