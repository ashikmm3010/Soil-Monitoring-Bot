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
    input freq
    );
 
 reg count = 0;
 reg red_mfreq;
 reg green_mfreq;
 reg blue_mfreq;
 //s1=0,s0=1  => 20% scaling
 
 always@(posedge clk)
 begin   
    if(OE==1'b0)
        begin
        
        s=4'b1001;
        //record the frequency
        if(freq>blue_mfreq)
        begin
        //light the red led
        //send the message  
        end
        
        s=4'b1101;
        //record frequency
        if(freq>green_mfreq & freq<blue_mfreq)
        begin
        //light the red led
        //send the message
        end
        
        s=4'b0001;
        //record the frequency
        if(freq>red_mfreq & freq<green_mfreq)
        begin
        //light the red led
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
    output fequency
    );
 reg count = 0;
   
 always@(posedge Vout)
        begin
        count=count+1;
        
        end
endmodule

