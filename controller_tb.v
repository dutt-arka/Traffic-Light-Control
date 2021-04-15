timescale 1ms / 1ns

module controller_tb();
reg SENSOR,clk;
wire[2:0] main_road;
wire[2:0] side_road;
wire[7:0] count;

controller DUT(main_road,side_road,SENSOR,clk,count);

initial
    begin                            //Change clock every 500ms
       clk=1; forever #500 clk=~clk; //so a cycle is 1s
    end
initial 
    begin                                         //Change SENSOR every
        SENSOR=1; forever #40000 SENSOR=~SENSOR;   //80 seconds
    end
endmodule
