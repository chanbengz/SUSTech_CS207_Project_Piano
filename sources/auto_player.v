module auto_player(
	input clk,
	input rst_n,
	input[1:0] song_num,
	output reg pwm
	);
	
	localparam	L1 = 0,
				L2 = 0,
				L3 = 0,
				L4 = 0,
				L5 = 0,
				L6 = 0,
				L7 = 0,
				M0 = 481680,
				M1 = 381680,
				M2 = 340136,
				M3 = 303030,
				M4 = 285714,
				M5 = 255102,
				M6 = 227273,
				M7 = 202429,
                H1 = 191204,
				H2 = 170357,
				H3 = 151745,
				H4 = 143061,
				H5 = 0,
				H6 = 0,
				H7 = 0;

	reg	[16:0] cnt0,cnt1, cnt2;
	reg	[16:0] pre_set;
	reg	[10:0] duration;
	wire[10:0] duration_div;
	reg	[5:0] note_num;

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)
			note_num <= 0;
		else begin
			case(song_num)
				2'b00: note_num <= 48;
				2'b01: note_num <= 36;
			endcase
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt0 <= 0;
		end
		else begin
			if(cnt0 == pre_set - 1)
				cnt0 <= 0;
			else
				cnt0 <= cnt0 + 1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt1 <= 0;
		end
		else begin
			if(cnt0 == pre_set - 1)begin
				if(cnt1 == duration)
					cnt1 <= 0;
				else
					cnt1 <= cnt1 + 1;
			end
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt2 <= 0;
		end
		else begin
			if(cnt1 == duration && cnt0 == pre_set - 1) begin
				if(cnt2 == note_num - 1) begin
					cnt2 <= 0;
				end
				else
					cnt2 <= cnt2 + 1;
			end
		end
	end

	always @(*) begin
		case(pre_set)
			M0: duration = 207;
			M1: duration = 261;
			M2: duration = 294;
			M3: duration = 329;
			M4: duration = 349;
			M5: duration = 392;
			M6: duration = 440;
			M7: duration = 493;
			default: duration = 0;
		endcase
	end
	
	always @(*) begin
		case(song_num)
		2'b00: begin
		case(cnt2)
				0 : pre_set = M1;
				1 : pre_set = M1;
				2 : pre_set = M5;
				3 : pre_set = M5;
				4 : pre_set = M6;
				5 : pre_set = M6;
				6 : pre_set = M5;
				7 : pre_set = M0;
				8 : pre_set = M4;
				9 : pre_set = M4;
				10: pre_set = M3;
				11: pre_set = M3;
				12: pre_set = M2;
				13: pre_set = M2;
				14: pre_set = M1;
				15: pre_set = M0;
				16: pre_set = M5;
				17: pre_set = M5;
				18: pre_set = M4;
				19: pre_set = M4;
				20: pre_set = M3;
				21: pre_set = M3;
				22: pre_set = M2;
				23: pre_set = M0;	
				24: pre_set = M5;
				25: pre_set = M5;
				26: pre_set = M4;
				27: pre_set = M4;
				28: pre_set = M3;
				29: pre_set = M3;
				30: pre_set = M2;
				31: pre_set = M0;
				32: pre_set = M1;
				33: pre_set = M1;
				34: pre_set = M5;
				35: pre_set = M5;
				36: pre_set = M6;
				37: pre_set = M6;
				38: pre_set = M5;
				39: pre_set = M0;
				40: pre_set = M4;
				41: pre_set = M4;
				42: pre_set = M3;
				43: pre_set = M3;
				44: pre_set = M2;
				45: pre_set = M2;
				46: pre_set = M1;
				47: pre_set = M0;
			endcase
		end
		2'b01: begin
		case(cnt2)
				0 : pre_set = M1;
				1 : pre_set = M2;
				2 : pre_set = M3;
				3 : pre_set = M1;
				4 : pre_set = M1;
				5 : pre_set = M2;
				6 : pre_set = M3;
				7 : pre_set = M1;
				8 : pre_set = M3;
				9 : pre_set = M4;
				10: pre_set = M5;
				11: pre_set = M0;
				12: pre_set = M3;
				13: pre_set = M4;
				14: pre_set = M5;
				15: pre_set = M0;
				16: pre_set = M5;
				17: pre_set = M6;
				18: pre_set = M5;
				19: pre_set = M4;
				20: pre_set = M3;
				21: pre_set = M1;
				22: pre_set = M5;
				23: pre_set = M6;
				24: pre_set = M5;
				25: pre_set = M4;
				26: pre_set = M3;
				27: pre_set = M1;
				28: pre_set = M2;
				29: pre_set = M5;
				30: pre_set = M1;
				31: pre_set = M0;
				32: pre_set = M2;
				33: pre_set = M5;
				34: pre_set = M1;
				35: pre_set = M0;
			endcase
		end
		endcase
	end
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			pwm <= 1'b1;
		end
		else if(pre_set != M0) begin
			if(cnt1 < duration * 4 / 5) begin
				if(cnt0 < pre_set >> 1) begin
					pwm <= 1'b1;
				end 
				else begin
					pwm <= 1'b0;
				end
			end else begin
				pwm <= 1'b1;
			end
		end
		else
			pwm <= 1'b1;
	end

endmodule
	