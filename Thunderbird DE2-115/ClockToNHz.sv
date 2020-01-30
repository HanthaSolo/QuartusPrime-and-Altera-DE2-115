/**
 * ClockToNHz.sv
 * TCSS 380 - Spring 2019
 * Author: Ryan Mateo
 * Partners: Hantha Nyunt, Bryan Blue
 * Instructor: Jie Sheng
 * Homework 4
*/

/** 
 * Module ClockToNHz
 *
 * (Assumes that the input is a 50 Mhz clock)
 * Divides the 50 Mhz clock by counting N times based on the desired output Hz. 
 * Once it has counted that much, reverse the output then reset the counter.
 * 
 */
module ClockToNHz #(parameter desiredHz=1)(
   output logic clk_4hz,
   input clk_50mhz
);

   
   // 26 bits is required to store 50,000,000 in binary
   logic [25:0] counter;
   integer countTo = 50000000/desiredHz - 1;

   // Initialize values
   initial begin
      counter = 0;
      clk_4hz = 0;
   end
   // Increment counter 50000000/(2*N) - 1 times then reset to 0
   // After resetting to 0, invert output. 
   always @(posedge clk_50mhz) begin
      if (counter == countTo) begin
         counter <= 0;
         clk_4hz <= 1'b1;
      end 
      else begin
         counter <= counter + 1'b1;
			clk_4hz <= 1'b0;
      end
   end
endmodule


module ClockToNHz_tb();

   logic clk_4hz;
   logic clk_50mhz;
   integer X;
   ClockToNHz #(1000000)dut(.clk_4hz(clk_4hz), .clk_50mhz(clk_50mhz));

   initial begin

      $monitor($time, ": InputClock=%b, OutputClock=%b, ", clk_50mhz, clk_4hz);
      clk_50mhz = 0;
      for(X = 0; X < 2000; X++) begin
         clk_50mhz <= 0;
         #1;
         clk_50mhz <= 1;
         #1;
      end

   end

   

endmodule
