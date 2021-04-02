`timescale 1ms / 1ns

module controller(main_road_light,side_road_light,SENSOR,clk,second);
parameter MRG_SRR=2'b00, // main road green and side road red
    MRSA_SRGA=2'b01, // main road stop-attention and side road go-attention
    MRR_SRG=2'b10, // main road red and side road green
    MRGA_SRSA=2'b11; // main road go-attention and side road stop-attention
    
input SENSOR, //main road congestion sensor
    clk;
output reg[3:0] main_road_light,
                side_road_light;
reg[1:0] state,next_state; //to change the lights
output reg[7:0] second=-1; //I start clk from 1 in testbench so it will be incremented to 0


initial state<=2'b00; //Initial state wasn't mentioned so I chose MRG_SRR for my initial state
initial main_road_light<=3'b001; //Lights for MRG_SRR are GREEN 
initial side_road_light<=3'b101; //and RED

always@(posedge clk)begin 
    state<=next_state; //to change state to next state
end
always @(*) begin //switch between states
    case(state) 
        MRG_SRR:
            begin
               main_road_light<=3'b001; //GREEN 
               side_road_light<=3'b101; //RED
               
               if((SENSOR==1))begin 
                    next_state<=MRSA_SRGA;end //If a congestion was cleared or no congestion occured in 
                                              //20 seconds; change the lights to STOP-ATTENTION and GO-ATTENTION
               
            end
        MRSA_SRGA:
            begin
                main_road_light<=3'b011; //STOP-ATTENTION//yellow
                side_road_light<=3'b010; //GO-ATTENTION//red
                if(second==9)begin //If there is congestion after 3 seconds     
                    next_state<=MRR_SRG;end     //main_road_light will be GREEN and side_road_light will be RED
            end
        MRR_SRG:
            begin
                main_road_light<=3'b101; //RED
                side_road_light<=3'b001; //GREEN
                if(second==19)begin //If there is congestion after the 
                                                                           //m_r_l turned RED or no congestion
                    next_state<=MRGA_SRSA;end                              //occured in 9 seconds change the lights
                                                                           //to GO-ATTENTION and STOP-ATTENTION 
            end
        MRGA_SRSA:
            begin
                main_road_light<=3'b010; //GO-ATTENTION
                side_road_light<=3'b011;  //STOP-ATTENTION
                if(SENSOR==0) begin       
                    next_state<=MRG_SRR;end //Change the lights to GREEN and RED after 3 seconds
            end
        default state<=MRG_SRR; //Default state is GREEN for main_road_light and RED for side_road_light
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
