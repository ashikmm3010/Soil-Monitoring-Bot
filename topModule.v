module top(motor,sensorL,sensorC,sensorR,clk);	//controller module

	input reg [2:0] sensorL, reg [2:0] sensorR, reg [2:0] sensorC;
	output reg [1:0] motor;
	reg a,b,c;
	reg black = 1023;
	reg white = 32;
	
////////////////////////////////////////////////	
	
module sensor_read();		//adc module

endmodule



//orientation of the movement & Node Detection//

always@(posedge clock)
begin

	if(sensorL<black) assign a = 1;
	else assign a = 0;

	if(sensorC<black) assign b = 1;
	else assign b = 0;

	if(sensorR<black) assign c = 1;
	else assign c = 0;
	
end

case(a,b,c)

	3'b010:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end//Move straight
	3'b100:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end//Move right
	3'b001:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end//Move left
	
	
	3'b110:begin //Node Detected (on left)
	
				//send message to Xbee
				
				AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end
				
	3'b011:begin //Node Detected (on right)
	
				//send message to Xbee
				
				AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end
				
	
	default:begin AF=1'b0;AB=1'b1;BF=1'b0;BB=1'b1; end//stop

endcase
////////////////////////////////////////////////////////////////////////
