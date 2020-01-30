module ProjectA(SW, LEDG, LEDR, CLOCK_50);

	// Initializing variables
	input logic CLOCK_50;
	input [2:0] SW;
	
	output [6:0]LEDG;
	output [3:0] LEDR;
	
	logic [2:0] LL,RL;
	logic clk_4hz, OneHzClk;
	
	assign LEDR = SW;
	assign H = SW[2];
	assign L = SW[1];
	assign R = SW[0];
	assign LEDG[6:4] = LL;
	assign LEDG[2:0] = RL;
	
	// Calling function that converts input 50mhz to 1hz
	ClockToNHz clk1(OneHzClk, CLOCK_50);
	thunderbird bird(OneHzClk, H, L, R, LL, RL);
	
	
	
endmodule
