#ifndef _TRAFFIC_LIGHT_
#define _TRAFFIC_LIGHT_

#include "Timer.h"

class TrafficLight {
    long TIMER_BLINKING_GREEN = 3000;//3secs
    long TIMER_YELLOW = 2000;//2secs
    int _greenLED, _yellowLED, _redLED;
    //fsm states

    enum State {
      GREEN,
      BLINKING_GREEN,
      YELLOW,
      RED
    };

    State _currentState = GREEN;
    State _targetState = GREEN;
    //object of timer class
    Timer timer;
    //private methods:
    
    void blinkGreen() {
      if (millis() % 1000 > 500) {
        green();
      } else {
        off();
      }
    }

    void goToGreen() {
      switch (_currentState) {
        case RED:
          _currentState = YELLOW;
          timer.startTimer(TIMER_YELLOW);
          break;
        case YELLOW:
          yellow();
          if (timer.isTimerReady()) {
            _currentState = GREEN;
          }
          break;
        case BLINKING_GREEN:
          _currentState = GREEN;
          break;
        case GREEN:
          green();
          break;


      }
      //red->yellow->green
    }
    void goToRed() {
      //green->blinking green->yellow->red
      switch (_currentState) {
        case GREEN:
          _currentState = BLINKING_GREEN;
          timer.startTimer(TIMER_BLINKING_GREEN);
          break;
        case BLINKING_GREEN:
          blinkGreen();
          if (timer.isTimerReady()) {
            _currentState = YELLOW;
            timer.startTimer(TIMER_YELLOW);
          }
          break;
        case YELLOW:
          yellow();
          if (timer.isTimerReady()) {
            _currentState = RED;
          }
          break;
        case RED:
          red();
          break;
      }
    }
  public:
    TrafficLight(int greenLED, int yellowLED, int redLED) {
      _greenLED = greenLED;
      _yellowLED = yellowLED;
      _redLED = redLED;

      pinMode(_greenLED, OUTPUT);
      pinMode(_yellowLED, OUTPUT);
      pinMode(_redLED, OUTPUT);
    }
    void green() {
      digitalWrite(_greenLED, HIGH);
      digitalWrite(_yellowLED, LOW);
      digitalWrite(_redLED, LOW);
    }
    void red() {

      digitalWrite(_greenLED, LOW);
      digitalWrite(_yellowLED, LOW);
      digitalWrite(_redLED, HIGH);
    }
    void yellow() {

      digitalWrite(_greenLED, LOW);
      digitalWrite(_yellowLED, HIGH);
      digitalWrite(_redLED, LOW);
    }
    void off() {

      digitalWrite(_greenLED, LOW);
      digitalWrite(_yellowLED, LOW);
      digitalWrite(_redLED, LOW);
    }

    void go() {
      //red->yellow->green
      _targetState = GREEN;
    }

    void stop() {
      //green ->blinking green->yellow->red
      _targetState = RED;

    }

    void loop() {
      if (_targetState == GREEN) {
        goToGreen();
      } else {
        goToRed();
      }
    }



};

#endif // _TRAFFIC_LIGHT_
