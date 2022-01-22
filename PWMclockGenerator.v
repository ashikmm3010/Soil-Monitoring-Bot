module clock_generator( 
 input wire clock, //100MHz coming into the system
 output reg counter_clock_signal = 0 ); // 1 kHz
 
        reg div_value = 4999;
        integer counter_value=0;
 
 always@(posedge clock) begin
       if(counter_value == div_value) // counter_value = 100MHz/(2*1kHz) - 1
          counter_value <= 0; //reseting the counter
       else 
          counter_value <= counter_value + 1;
 end
 
 //divided clock
 always@(posedge clock) begin
       if(counter_value == div_value)
          counter_clock_signal = ~counter_clock_signal; //fliping the output after 
      //every 4999 cycles
       else
          counter_clock_signal <= counter_clock_signal;
 end
 
 endmodule
