module mux5(inputs, controls, moutput);
	input[4:0] inputs;
	input[2:0]  controls;
	output      moutput;	// called moutput because just output is a recognized term, so mux output is the next better thing
	wire[4:0]  inputs;
	wire[2:0]   controls;
	reg         moutput;
	
	always@(controls or inputs)
		moutput = inputs[controls];
endmodule
