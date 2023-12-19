module auto_player(
	input clk, 
	input [2:0] mode,
	input[1:0] song_num,
	output speaker
	);
	
	reg [1:0] last_song_num;
	reg	 [16:0] cnt_note;
	reg	 [28:0] duration;
	reg	 [5:0]  note_num;
	reg  [4:0]  note, current;
	parameter period = 50000000;
	parameter div = 9 * period / 10;
	buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));
	
	initial begin
	   cnt_note = 0;
	   note = 0;
	   duration = 0;
	end
	
	always @(posedge clk) begin
		if(mode != 3'b011) begin
			note_num <= 0;
		end else begin
			case(song_num)
				2'b00: note_num <= 48;
				2'b01: note_num <= 53;
				2'b10: note_num <= 44;
			endcase
		end
	end
	
	always @(posedge clk) begin
	   if(mode != 3'b011 | song_num != last_song_num) begin
	       duration <= 0;
	       cnt_note <= 0;
	       last_song_num <= song_num;
	   end else begin
	       if(duration == period) begin
	           if(cnt_note == note_num) cnt_note <= 1;
               else cnt_note <= cnt_note + 1;
	           duration <= 0;
	       end else begin
	           duration <= duration + 1;
	       end
	   end
	end
	
	always @(posedge clk) begin
	   if(duration < div) begin
	       note <= current;
	   end else begin
	       note <= 0;
	   end
	end
	
	always @(song_num, cnt_note) begin
        case(song_num)
            2'b00: case(cnt_note)
               'd1:  current = 8;
               'd2:  current = 8;
               'd3:  current = 12;
               'd4:  current = 12;
               'd5:  current = 13;
               'd6:  current = 13;
               'd7:  current = 12;
               'd8:  current = 0;
               'd9:  current = 11; 
               'd10: current = 11; 
               'd11: current = 10; 
               'd12: current = 10; 
               'd13: current = 9; 
               'd14: current = 9; 
               'd15: current = 8; 
               'd16: current = 0; 
               'd17: current = 12; 
               'd18: current = 12; 
               'd19: current = 11; 
               'd20: current = 11; 
               'd21: current = 10; 
               'd22: current = 10; 
               'd23: current = 9; 
               'd24: current = 0; 
               'd25: current = 12; 
               'd26: current = 12; 
               'd27: current = 11; 
               'd28: current = 11; 
               'd29: current = 10; 
               'd30: current = 10; 
               'd31: current = 9; 
               'd32: current = 0; 
               'd33: current = 8; 
               'd34: current = 8; 
               'd35: current = 12; 
               'd36: current = 12; 
               'd37: current = 13; 
               'd38: current = 13; 
               'd39: current = 12; 
               'd40: current = 0;
               'd41: current = 11;
               'd42: current = 11;
               'd43: current = 10;
               'd44: current = 10;
               'd45: current = 9;
               'd46: current = 9;
               'd47: current = 8;
               'd48: current = 0;
               default current = 0;
           endcase
           2'b01: case(cnt_note)
               'd1:  current = 5;
               'd2:  current = 10;
               'd3:  current = 10;
               'd4:  current = 9;
               'd5:  current = 11;
               'd6:  current = 10;
               'd7:  current = 9;
               'd8:  current = 9; 
               'd9:  current = 9; 
               'd10: current = 8; 
               'd11: current = 11;
               'd12: current = 10; 
               'd13: current = 9;  
               'd14: current = 9; 
               'd15: current = 8; 
               'd16: current = 8; 
               'd17: current = 9; 
               'd18: current = 0; 
               'd19: current = 10;
               'd20: current = 12; 
               'd21: current = 15; 
               'd22: current = 14;
               'd23: current = 15;
               'd24: current = 14;
               'd25: current = 15;
               'd26: current = 14;
               'd27: current = 13;
               'd28: current = 12;
               'd29: current = 0; 
               'd30: current = 12;
               'd31: current = 9; 
               'd32: current = 11;
               'd33: current = 11;
               'd34: current = 10;
               'd35: current = 10;
               'd36: current = 0; 
               'd37: current = 5; 
               'd38: current = 11;
               'd39: current = 10;
               'd40: current = 9;
               'd41: current = 10;
               'd42: current = 12;
               'd43: current = 8;
               'd44: current = 0;
               'd45: current = 8;
               'd46: current = 9;
               'd47: current = 8;
               'd48: current = 12;
               'd49: current = 8;
               'd50: current = 11;
               'd51: current = 10;
               'd52: current = 9;
               'd53: current = 8;
               default: current = 0;
           endcase
           2'b10: case(cnt_note)
                'd1:  current = 20;
                'd2:  current = 19;
                'd3:  current = 17;
                'd4:  current = 16;
                'd5:  current = 12;
                'd6:  current = 13;
                'd7:  current = 12;
                'd8:  current = 6; 
                'd9:  current = 9; 
                'd10: current = 10; 
                'd11: current = 12;
                'd12: current = 0; 
                'd13: current = 20;  
                'd14: current = 19; 
                'd15: current = 17; 
                'd16: current = 16; 
                'd17: current = 12; 
                'd18: current = 13; 
                'd19: current = 12;
                'd20: current = 6; 
                'd21: current = 9; 
                'd22: current = 10;
                'd23: current = 12;
                'd24: current = 0;
                'd25: current = 20;
                'd26: current = 19;
                'd27: current = 17;
                'd28: current = 16;
                'd29: current = 12; 
                'd30: current = 13;
                'd31: current = 12; 
                'd32: current = 6;
                'd33: current = 9;
                'd34: current = 9;
                'd35: current = 0;
                'd36: current = 20; 
                'd37: current = 19; 
                'd38: current = 17;
                'd39: current = 16;
                'd40: current = 12;
                'd41: current = 13;
                'd42: current = 12;
                'd43: current = 10;
                'd44: current = 10;
                default: current = 0;
           endcase
           default: current = 0;
        endcase
	end

endmodule
	