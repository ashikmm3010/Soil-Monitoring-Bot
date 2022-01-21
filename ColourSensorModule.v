`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2022 10:50:19
// Design Name: 
// Module Name: ColourSensor
// Project Name: 
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


module ColourSensorController(
    output reg [3:0] s,
    input clk,
    input OE,
    output [1:0] colour,
    input freq,
    output reg [2:0] led //in RGB order
    );
 
 reg count = 0;
 reg red_mfreq;
 reg green_mfreq;
 reg blue_mfreq;
 //s1=0,s0=1  => 20% scaling
 
 freqCalculator freqCounter(.freq(frequency),.Vout(Vout),.clk(clock));
 
 always@(posedge clk)
 begin   
    if(OE==1'b0)
        begin
        
        s=4'b1001;
        //record the frequency
        if(freq>blue_mfreq)
        begin
        //light the blue led
        led=3'b001;
        //send the message  
        end
        
        s=4'b1101;
        //record frequency
        if(freq>green_mfreq & freq<blue_mfreq)
        begin
        //light the green led
        led=3'b010;
        //send the message
        end
        
        s=4'b0001;
        //record the frequency
        if(freq>red_mfreq & freq<green_mfreq)
        begin
        //light the red led
        led=3'b100;
        //send the message
        end
    end
    else
        begin
            //nooperation
        end
end   
endmodule


////////////////////////////////////////////////////////////////////////////////

module freqCalculator(
    input Vout,
    input clock,
    output fequency);
   
 reg unit = 0;
 reg flag = 0;
 reg clk; // input the fpga clock value
 
 //for marking completion of 1 second
 always@(posedge clock) 
 begin
    unit=unit+1;
    if (unit==clk)
    begin
        flag = 1;
        unit=0;
    end
 end 
 
 //counting the output frequency for 1 sec
 reg count = 0;
 reg frequency;
 
 always@(posedge Vout)
        begin
        count=count+1;
        if(flag==1)
        begin
            frequency=count;
            count=0;
        end
 end

endmodule
