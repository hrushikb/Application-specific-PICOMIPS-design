`include "alucodes.sv"

module alu #(parameter n = 8)
			(input logic signed [n-1:0] in1, in2,
			input logic [2:0] alu_func,
			output logic [3:0] flags,
			output logic signed [n-1:0] out);

logic [n-1:0] temp_result1, sign_in2;
logic signed [(4*n) - 1:0] temp_product;	//Multiplying 2 n bit numbers=> we get 2n bits output

always_comb
begin
	if (alu_func == `RSUB)
		sign_in2 = ~in2 + 1'b1;	//2's compliment
	else
		sign_in2 = in2;
	
	temp_result1 = in1 + sign_in2;
end

always_comb
begin
	out = in1;
	flags = 4'b0000;
	temp_product = '0;
	
	case(alu_func)
		`RNOP	:	;	//begin
					//	out = {n{1'b0}};	//No operation
					//end
		`RADD	:	begin
						out = temp_result1;
						//enable flags
						flags[0] = in1[7] & in2[7] & ~out[7] | ~in1[7] & ~in2[7] & out[7];	//Overflow
						flags[1] = in1[7] & in2[7] | in1[7] & ~out[7] | in2[7] & ~out[7];	//Carry
					end
		`RSUB	:	begin
						out = temp_result1;
						flags[0] = ~in1[7] & in2[7] & ~out[7] | in1[7] & ~in2[7] & out[7]; //Overflow
						flags[1] = in1[7] & ~in2[7] | in1[7] & out[7] | ~in2[7] & out[7];	//2's compliment carry
					end
		`RMUL	:	begin
						temp_product = {{n{in1[7]}}, in1[7:0]} * {{n{in2[7]}}, in2[7:0]};
						out = temp_product[14:7];	//Truncating the fractional bits.
						// Checking if multiplication of 2 +ve numbers is giving -ve or 2 -ve numbers giving -ve or if both inputs are of different signs and output is +ve
						flags[0] = in1[7] & in2[7] & out[7] | ~in1[7] & ~in2[7] & out[7] | in1[7] & ~in2[7] & ~out[7] | ~in1[7] & in2[7] & ~out[7];	//Multiplication Overflow
					end
	endcase
	
	flags[2] = ((out == '0) ? 1 : 0);	//Zero Checking
	flags[3] = out[n-1];	//-ve result
end


endmodule