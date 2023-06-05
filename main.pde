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
String apiMsg;
import http.requests.*;
// SERVER PARAMETERS
import processing.net.*;

Server myServer;
Client myClient;


// === === CONSTANTS === ===
// === === ========= === ===
final int DISPLAYTYPE_MENU = 0;
final int DISPLAYTYPE_GAME = 1;
final int DISPLAYTYPE_CALIBRATION = 2;

final int JOYSTICK_COM_PORT = 0;

// === === VARS === ===
// === === ==== === ===
int displayType;
int timeTracker;
int timeT0;


// === === SETUP === ===
// === === ===== === ===
void setup(){
  //setup window
  size(1280,720);
  frameRate(60);

  apiMsg = getWindMessage();
  // timeTracker=millis();
  // timeT0=millis();

  // unitary test
  TEST_GAME_init();
  TEST_UI_init();
  printArray(Serial.list());
  initJoystick();
  //execute client config
  //initialize com port ?
  displayType=DISPLAYTYPE_CALIBRATION;
}



// === === LOOP === ===
// === === ==== === ===
void draw(){

  
  //println(millis()-timeTracker);
  //timeTracker=millis();

  
  switch(displayType){
    case DISPLAYTYPE_GAME:
      TEST_GAME();
      return;
    case DISPLAYTYPE_MENU:
      TEST_UI();
      return;
    case DISPLAYTYPE_CALIBRATION:
      joystick_calibrate();
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
String getWindMessage() {
  GetRequest get = new GetRequest("http://api.weatherapi.com/v1/forecast.json?q=Paris&days=1&aqi=no&alerts=no&key=135cadb4546b47a9a43124718230506");
  get.send();
  get.addHeader("Accept", "application/json");
  JSONObject json = parseJSONObject(get.getContent());  
  
  if (json == null) {
    println("API connection error");
    return "API connection error";
  } else {
    JSONObject current = json.getJSONObject("current");
    Integer windSpeed = current.getInt("wind_kph");
    
    String msg = "Il y a " + windSpeed + " km/h de vent à Paris. Vous pouvez blâmer le vent si vous perdez!";
    println(msg);
    return msg;
  }
}