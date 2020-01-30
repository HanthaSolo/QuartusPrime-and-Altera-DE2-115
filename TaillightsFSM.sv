/**
 * ClockToNHz.sv
 * TCES 330 - Spring 2019
 * Team: Ryan Mateo, Hantha Nyunt, James Stevens
 * Instructor: Jie Sheng
 * Project A - Moore Machine Module
*/

//`timescale 1s/4ms
module TaillightsFSM	(input logic clk_1hz,
							input H,
							input L,
							input R,
							output logic [2:0]Left,
							output logic [2:0]Right
							);
   
   // Instantiate 8 States that have 3 bit values
   // Ex: A =  000, B = 001, Z = 111
    typedef enum logic [2:0] {A, B, C, D, E, F, G, Z} State;

    //Intermediate Signal 
	 logic [2:0]Y;
     
   // Finite State Machine(Moore)
    State currentState, nextState;

    always_ff @(posedge clk_1hz)

        currentState <= nextState;
    always_comb
	 
        case(currentState)
		  
            A: if(H) nextState = Z;
               else if(R) nextState = B;
               else if(L) nextState = E;
               else  nextState = A;

            B: if(H) nextState = A;
               else if(R) nextState = C;
               else  nextState = A;
            
            C: if(H) nextState = A;
               else if(R) nextState = D;
               else  nextState = A;
            
            D: nextState = A;

            E: if(H) nextState = A;
               else if(L) nextState = F;
               else  nextState = A;
            
            F: if(H) nextState = A;
               else if(L) nextState = G;
               else  nextState = A;

            G: nextState = A;
				
				Z: nextState = A;
            
            default: nextState = A;

        endcase

    assign Y = currentState;
	
    assign Right[2] = (~Y[2] & Y[0])|(~Y[2] & Y[1])|(Y[1] & Y[0]);
    assign Right[1] = (~Y[2] & Y[1])|(Y[1] & Y[0]);
    assign Right[0] = (Y[1] & Y[0]);
    assign Left[0] = Y[2];
    assign Left[1] = (Y[2] & Y[0])|(Y[2] & Y[1]);
    assign Left[2] = Y[2] & Y[1];

endmodule

//Test Bench for Thunder Bird module
module TaillightsFSM_tb();

	logic clk_1hz, H, L, R;
	logic [2:0] Right, Left;
	integer X;
	
	TaillightsFSM DUT(clk_1hz, H, L, R, Left, Right);
	
	always begin
		clk_1hz = 0;
		#10;
		clk_1hz = 1;
		#10;
	end
	
	initial begin
		$monitor ( $time, ": Clk = %b, Haz = %b, L = %b, R = %b, Left = %3b, Right = %3b",
						clk_1hz, H, L, R, Left, Right );
	H = 0;
	R = 0;
	L = 0;
	#10;
	//Test left
	L = 1;
	wait(Left == 3'b111);
	#20;
	L = 0;
	#10;
	//Test Right
	R = 1;
	wait(Right == 3'b111);
	#20;
	R = 0;
	#10;
	//Test Hazard lights
	H = 1;
	wait ( Left == 3'b111 && Right == 3'b111);
	#20
	//Test Hazard override case
	R = 1;
	#10;
	R = 0;
	L = 1;
	wait ( Left == 3'b111 && Right == 3'b111);
	#10
	
	$stop;
	
	end

endmodule 