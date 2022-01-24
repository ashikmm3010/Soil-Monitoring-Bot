`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2022 20:16:25
// Design Name: 
// Module Name: ADC
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


module adc_control(
	input  clk_50,				
	input  dout,			
	output reg din,      			  					
	output reg cs,
	output wire sclk,
	output reg clock_out,
	output reg [11:0] dataout,dataout2,dataout4
	
);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////


    //defining parameters
    reg [3:0] count;
    reg ADD2,ADD1,ADD0;
    reg [11:0] data_temp;

//initializing parameters
initial begin
    count<=4'd0;
    cs=1;
    ADD2=0;
    ADD1=1;
    ADD0=0;
    clock_out=0;
    dataout=12'd0;
    dataout2=12'd0;
    dataout4=12'd0;
    data_temp=12'd0;
end



always@(negedge clk_50) begin
    if(count==1) cs<=0;
end

assign sclk=cs?1:clk_50;

always@(posedge clk_50) begin
    count<=count+4'd1;
end

always@(negedge clk_50) begin
    case(count)
        3:begin din<=ADD2; end          // CAHNNEL 2,4,5

        4:begin din<=ADD1; end
        
        5:begin
            din<=ADD0;
            ADD1<=!ADD1;
            ADD2<=!ADD2;
        end
    endcase
end

always @(posedge clk_50) begin
    case(count)
    4:begin
        if(ADD1==1 ) dataout<=data_temp;
        else if(ADD2==1) begin ADD0<=!ADD0;
                               dataout4<=data_temp; end
        else dataout2<=data_temp;
      end
    5: data_temp[11]<=dout;
    6: data_temp[10]<=dout;
    7: data_temp[9]<=dout;
    8: data_temp[8]<=dout;
    9: data_temp[7]<=dout;
    10: begin data_temp[6]<=dout;
              clock_out<=1;
        end
    11: data_temp[5]<=dout;
    12: data_temp[4]<=dout;
    13: data_temp[3]<=dout;
    14: data_temp[2]<=dout;
    15: data_temp[1]<=dout;
    16: data_temp[0]<=dout;
    endcase
end


////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
