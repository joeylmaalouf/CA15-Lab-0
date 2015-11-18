module mux(inputs, controls, moutput);
	input[31:0] inputs;
	input[4:0]  controls;
	output      moutput;	// called moutput because just output is a recognized term, so mux output is the next better thing
	wire[31:0]  inputs;
	wire[4:0]   controls;
	reg         moutput;
	
	always@(controls or inputs)
		moutput = inputs[controls];
endmodule
