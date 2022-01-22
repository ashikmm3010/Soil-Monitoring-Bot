`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2022 11:13:36
// Design Name: 
// Module Name: top
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

module roughModule(
    input wire [9:0] sensorL,
    input wire [9:0] sensorC,
    input wire [9:0] sensorR,
    input clock,
    output reg AF,AB,BF,BB);    //taken as active low
    
	ColourSensorController(s,clk,OE,colour,freq);	//sub module wrapping
	
	reg black = 12'd1000;
	reg white = 12'd30;
	reg [2:0] a;
	

//orientation of the movement & Node Detection//

always@(posedge clock)
begin

	if(sensorL > 30)  a[2] = 1;
	else if(sensorL < 30) a[2] = 0;

	if(sensorC > 30) a[1] = 1;
	else if(sensorL < 30) a[1] = 0;

	if(sensorR > 30) a[0] = 1;
	else if(sensorL < 30) a[0] = 0;

end

always@(posedge clock)
begin
case(a)

	3'b010:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1;end//Move straight
	3'b100:begin AF=1'b1;AB=1'b1;BF=1'b0;BB=1'b1; end//Move right
	3'b001:begin AF=1'b0;AB=1'b1;BF=1'b1;BB=1'b1; end//Move left


	3'b110:begin //Node Detected (on left)

				//send message to Xbee

				AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end

	3'b011:begin //Node Detected (on right)  then turn right

				//send message to Xbee

				AF=1'b0;AB=1'b1;BF=1'b1;BB=1'b1; end


	//default:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end//stop

endcase

end
////////////////////////////////////////////////////////////////////////);
endmodule
