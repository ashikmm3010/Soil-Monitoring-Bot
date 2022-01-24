`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2022 21:22:51
// Design Name: 
// Module Name: UART
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


module UART(
    input wire clk,
    output reg tx
    );
    
    reg [6*8:0] data = "SM1928";    //data to be transmitted
    reg [7:0] data_frame = 7'b00000000; //data frame
    reg [1:0] stop = 2'b11;
    reg start = 1'b0; 
    reg [3:0] count=0;
    reg [2:0] index=6;
    reg enable=1;
    reg [10:0] signal;

always@(posedge clk) begin //counter
    count = count + 1;
    if(count==13) count = 0;
end

always@(posedge clk) begin
    if(count==12) begin
        index=index-1;
        if (index==0) begin
            enable=0;   //end the communication -- declare another module
        end
    end    
end
always@(posedge clk) begin
    case(index)
        3'd6:data_frame = data[47:40];
        3'd5:data_frame = data[41:32];
        3'd4:data_frame = data[33:24];
        3'd3:data_frame = data[25:16];
        3'd2:data_frame = data[15:7];
        3'd1:data_frame = data[7:0];       
    endcase
end    


always@(posedge clk,enable) begin

    if (enable == 1) begin    
        case(count)
            4'd0:tx=1;
            4'd1:signal={start,data_frame,stop};
            4'd2:tx=signal[10];
            4'd3:tx=signal[9];
            4'd4:tx=signal[8];
            4'd5:tx=signal[7];
            4'd6:tx=signal[6];
            4'd7:tx=signal[5];
            4'd8:tx=signal[4];
            4'd9:tx=signal[3];
            4'd10:tx=signal[2];
            4'd11:tx=signal[1];
            4'd12:tx=signal[0];     
        endcase
    end
    
    else tx = 1;
    
end

endmodule
