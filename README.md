# Traffic-Light-Control
Intelligent Traffic Light Controller

-----------------------

<img src="https://github.com/feruxhi/thoughts/blob/master/TLCCC%20Cropped.png"  title="TLC">

The traffic congestion due to the exploding increase of vehicles became the severest social problems and it has a major effect on the economy of a country. Therefore, many researches about traffic light system have been done in order to overcome some complicated traffic phenomenon but existent research had been limited about present traffic system in well-travelled traffic scenarios.

Traffic lights are source of signalling device for road junctions. Traffic light controllers are programmed to assign timely directions to road users in Red, Yellow and Green. Present Traffic Light Controllers are based on microcontroller.TLC have limitations as it uses predefined hardware, which functions according to program that does not have flexibility of modification on real time basis.

To manage traffic flow, introduction of new technique ‘Dynamic Traffic Signal Controller’ emerged. Thus, optimization of traffic light switching; controls road capacity traffic flow and prevent congestions. The proposed system has simple architecture, ease of implementation and user friendliness.
----------------------------------------

#Implementation

1. Verilog Implementation :
Created a Finite State Machine for the controller with the traffic signal for the main highway getting highest priority because cars are continuously present on the main highway.

<img src="https://github.com/feruxhi/Traffic-Light-Control/blob/main/waveform_TLC_II.png">

2. Arduino Microcontroller Implementation:
To implement the controller in the Arduino, we started by designing the relevant circuitry. The circuit consists of the Arduino microcontroller connected with three sets of Red, Yellow and Green LEDs. Two of these sets of LEDs act as the lights for the Main Road signal and the other one acts as the side road signal. To simulate the use of the sensor on the side road,a push button is utilised. The entire schematic is shown here in the figure.
The entire software program i.e., the instructions driving the Controller is written in embedded C++ which allows fast execution and control over the hardware.

(Live Implementation) [https://www.youtube.com/watch?v=YzuWndfkYkQ]

--------------------------------
Final Year Project at NIT A,2021

Contributors : [@feruxhi]
