
//////////////////////////////////////////////////////////////////////////////////
// Final Year Project | B.Tech (ECE),NIT Agartala 
// Group  6
// 
// Create Date: 02.04.2021 16:55:17
// Design Name: Traffic Light Controller
// Module Name: controller
// Project Name: Intelligent Traffic Light Controller
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ms / 1ns

module controller(main_road_light,side_road_light,SENSOR,clk,second);
parameter MG_SR=2'b00, // main road green and side road red
        MY_SR=2'b01, // main road yellow and side road red
        MR_SG=2'b10, // main road red and side road green
        MR_SY=2'b11; // main road red and side road yellow
    
input SENSOR, //side road  sensor
    clk;
output reg[3:0] main_road_light,
                side_road_light;
reg[1:0] state,next_state; //to change the lights
output reg[7:0] second=-1; //I start clk from 1 in testbench so it will be incremented to 0


initial state<=2'b00; //Initial state wasn't mentioned so MG_SR was chosen for  initial state
initial main_road_light<=3'b001; //Lights for MRG_SRR are GREEN 
initial side_road_light<=3'b100; //and RED

always@(posedge clk)begin 
    state<=next_state; //to change state to next state
end
always @(*) begin //switch between states
    case(state) 
        MG_SR:
            begin
               main_road_light<=3'b001; //GREEN 
               side_road_light<=3'b100; //RED
               
               if((SENSOR==1))begin 
                       next_state<=MY_SR;end //depending the SENSOR input change the lights to YELLOW and RED
               
            end
        MY_SR:
            begin
                main_road_light<=3'b010; //yellow
                side_road_light<=3'b100; //red
                    if(second==9)begin //If there is congestion after 9 seconds     
                    next_state<=MR_SG;end     //main_road_light will be GREEN and side_road_light will be RED
            end
        MR_SG:
            begin
                main_road_light<=3'b100; //RED
                side_road_light<=3'b001; //GREEN
                    if(second==19)begin //If there is congestion after 20 seconds
                                                                           
                    next_state<=MR_SY;end       // lights changed to RED in Main Street and GREEN in Side Street                             
            end
        MR_SY:
            begin
                main_road_light<=3'b100; //RED
                side_road_light<=3'b010;  //YELLOW
                if(SENSOR==0) begin       
                    next_state<=MG_SR;end //Change the lights to GREEN and RED after 3 seconds
            end
        default state<=MG_SR; //Default state is GREEN for main_road_light and RED for side_road_light
        endcase
 end
 
 always@(posedge clk)begin
    if(state!=next_state)begin //If the lights changed
        state<=next_state;
        second<=0;end         //Start seconds from 0 (reset second)
     else begin
        second<=second+1;end //Continue counting seconds
 end
    
 endmodule
