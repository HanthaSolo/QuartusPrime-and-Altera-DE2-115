/**
 * ClockToNHz.sv
 * TCES 330 - Spring 2019
 * Team: Ryan Mateo, Hantha Nyunt, James Stevens
 * Instructor: Jie Sheng
 * Project A - Top Level Module
*/

module ProjectA(SW, LEDG, LEDR, CLOCK_50);

	// Initializing variables
	input logic CLOCK_50;
	input [2:0] SW;
	
	output [6:0]LEDG;
	output [3:0] LEDR;
	
	logic [2:0] LL,RL;
	logic OneHzClk;
	
	assign LEDR = SW;
	assign H = SW[2];
	assign L = SW[1];
	assign R = SW[0];
	assign LEDG[6:4] = LL;
	assign LEDG[2:0] = RL;
	
	// Calling function that converts input 50mhz to 1hz
	ClockToNHz clk1(OneHzClk, CLOCK_50);
	TaillightsFSM bird(OneHzClk, H, L, R, LL, RL);
	
endmodule 