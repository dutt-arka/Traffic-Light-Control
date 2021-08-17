#include "TrafficLight.h"
//defining the pin configurations
#define SENSOR 8
//M1 and M2:
int M_G = 7;
int M_Y = 6;
int M_R = 5;
//side road:
int S_G = 4;
int S_Y = 3;
int S_R = 2;



//objects
TrafficLight M(M_G,M_Y,M_R);//main line 1 and 2
TrafficLight S(S_G,S_Y,S_R);//side road signal

//variables
bool active = true;//indicates if main line is active ,else side road is active
int changeTime = 2500;//wait time betwwen LED transition
int waitTime = 5000;//wait time untill transition begins 

//int sec7=7000,sec5=5000,sec2=2000,sec3=3000;

void setup() {
  Serial.begin(9600);//start serial monitor
  //turn off all LEDs
  M.off();
  S.off();

  //initial state: M is active and S is closed
  M.green();
  S.red();
  
}

void loop() {
  //Depending on the traffic light we have active
  if(active){
    //sensor reading
    int sensorValue = digitalRead(SENSOR);
    //if there is a car waiting,button pressed
    if(sensorValue == HIGH){
      //turn on side road light
      sideRoadTL();
      //traffic light of side road is active
      active = false;
    }
  }else{
    mainRoadTL();//general case when there is no vehicle on the side road
    
    active = true;
  }
}

void sideRoadTL(){
  delay(waitTime);//turn off main line:G->Y->R and we wait

  //we turn to yellow light
  M.yellow();
  S.red();
  //we wait
  delay(changeTime);
  //turn on side road:R->Y->G
  M.red();
  S.green();
  delay(changeTime);
}

void mainRoadTL(){
  //turn off side road lights and wait
  delay(waitTime);
  //side road G->Y
  S.yellow();
  //wait
  delay(changeTime);
  //side road :Y->R and Main road: R->G
  S.red();
  M.green();

  delay(changeTime);
}
