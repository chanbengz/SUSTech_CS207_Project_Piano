// Learning Mode Top Module
`include "const.v"

module learning(
	input clk,
    input [7:0] key,
	input [2:0] mode,
	input [1:0] pitch,
	input [1:0] song_num,
	output speaker,
	output reg [7:0] led,
	output reg [3:0] pitch_dis
	);

	reg  [1:0]  last_song_num;               // Last song number, used to reset cnt_note when song changes
	reg	 [16:0] cnt_note;                    // Counter for notes in a song
	reg	 [28:0] duration;                    // Duration Counter
	reg	 [5:0]  note_num;                    // Number of notes in a song
	reg  [4:0]  note, current;               // Note and current note
	reg  [3:0]  note_len;
	parameter   period = `CLK_FREQ;          // Note period
	parameter   note_div = 9 * period / 10;  // Note duration
	buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

	always @(key, mode, pitch) begin
		if(mode != 3'b001) begin
			note = 0;
		end else begin
			case({pitch, key})
				9'b010000001: note = 1;  // C3
				9'b010000010: note = 2;  // D3
				9'b010000100: note = 3;  // E3
				9'b010001000: note = 4;  // F3
				9'b010010000: note = 5;  // G3
				9'b010100000: note = 6;  // A3
				9'b011000000: note = 7;  // B3
				9'b000000001: note = 8;  // C4
				9'b000000010: note = 9;  // D4
				9'b000000100: note = 10; // E4
				9'b000001000: note = 11; // F4
				9'b000010000: note = 12; // G4
				9'b000100000: note = 13; // A4
				9'b001000000: note = 14; // B4
				9'b100000001: note = 15; // C5
				9'b100000010: note = 16; // D5
				9'b100000100: note = 17; // E5
				9'b100001000: note = 18; // F5
				9'b100010000: note = 19; // G5
				9'b100100000: note = 20; // A5
				9'b101000000: note = 21; // B5
				default:      note = 0;  // silence
			endcase
		end
	end

	
	initial begin
	   cnt_note = 0;
	   note = 0;
	   duration = 0;
       note_len = 1;
	end
	
    // Get the number of notes in a song when song changes
	always @(posedge clk) begin
		if(mode != 3'b011) begin
			note_num <= 0;
		end else begin
			case(song_num)
				2'b00: note_num <= 48;
				2'b01: note_num <= 53;
				2'b10: note_num <= 62;
			endcase
		end
	end
	
    // Count the number of notes played
	always @(posedge clk) begin
		if(mode != 3'b101 | song_num != last_song_num) begin
	       duration <= 0;
	       cnt_note <= 0;
	       last_song_num <= song_num;
	   end else begin
	       if(duration == period / note_len) begin
               if(cnt_note == note_num) cnt_note <= 1;
               else cnt_note <= cnt_note + 1;
	           duration <= 0;
	       end else begin
	           duration <= duration + 1;
	       end
	   end
	end
	
    // Play the note
	always @(posedge clk) begin
		if(duration < note_div / note_len) begin
	       note <= current;
	    end else begin
	       note <= 0;
	    end
	end

    //  Song Sheet and control led
	always @(song_num, cnt_note) begin
        case(song_num)
            2'b00: case(cnt_note) // Song 1: Twinkle Twinkle Little Star
               'd1:  begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd2:  begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd3:  begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd4:  begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd5:  begin current = 13; led = 8'b0010_0000; note_len = 1; end
               'd6:  begin current = 13; led = 8'b0010_0000; note_len = 1; end
               'd7:  begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd8:  begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd9:  begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd10: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd11: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd12: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd13: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd14: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd15: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd16: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd17: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd18: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd19: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd20: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd21: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd22: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd23: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd24: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd25: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd26: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd27: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd28: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd29: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd30: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd31: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd32: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd33: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd34: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd35: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd36: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd37: begin current = 13; led = 8'b0010_0000; note_len = 1; end
               'd38: begin current = 13; led = 8'b0010_0000; note_len = 1; end
               'd39: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd40: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd41: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd42: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd43: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd44: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd45: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd46: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd47: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd48: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
            default: begin current = 0;  led = 8'b0000_0000; end
           endcase
           2'b01: case(cnt_note) // Song 2: Haruhigake
               'd1:  begin current = 5;  led = 8'b0001_0000; note_len = 1; end
               'd2:  begin current = 10; led = 8'b0000_0100; note_len = 2; end
               'd3:  begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd4:  begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd5:  begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd6:  begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd7:  begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd8:  begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd9:  begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd10: begin current = 8;  led = 8'b0000_0001; note_len = 2; end
               'd11: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd12: begin current = 10; led = 8'b0000_0100; note_len = 1; end 
               'd13: begin current = 9;  led = 8'b0000_0010; note_len = 1; end 
               'd14: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd15: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd16: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd17: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd18: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd19: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd20: begin current = 12; led = 8'b0001_0000; note_len = 1; end 
               'd21: begin current = 15; led = 8'b0000_0001; note_len = 1; end 
               'd22: begin current = 14; led = 8'b0100_0000; note_len = 1; end
               'd23: begin current = 15; led = 8'b0000_0001; note_len = 1; end
               'd24: begin current = 14; led = 8'b0100_0000; note_len = 1; end
               'd25: begin current = 15; led = 8'b0000_0001; note_len = 1; end
               'd26: begin current = 14; led = 8'b0100_0000; note_len = 1; end
               'd27: begin current = 13; led = 8'b0010_0000; note_len = 1; end
               'd28: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd29: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd30: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd31: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd32: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd33: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd34: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd35: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd36: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd37: begin current = 5;  led = 8'b0001_0000; note_len = 1; end
               'd38: begin current = 11; led = 8'b0010_0000; note_len = 1; end
               'd39: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd40: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd41: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd42: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd43: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd44: begin current = 0;  led = 8'b0000_0000; note_len = 1; end
               'd45: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd46: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd47: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd48: begin current = 12; led = 8'b0001_0000; note_len = 1; end
               'd49: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
               'd50: begin current = 11; led = 8'b0000_1000; note_len = 1; end
               'd51: begin current = 10; led = 8'b0000_0100; note_len = 1; end
               'd52: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
               'd53: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
            default: begin current = 0;  led = 8'b0000_0000; end
           endcase
           2'b10: case(cnt_note) // Song 3: Ode to joy
                'd1:  begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd2:  begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd3:  begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd4:  begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd5:  begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd6:  begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd7:  begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd8:  begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd9:  begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd10: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd11: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd12: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd13: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd14: begin current = 9;  led = 8'b0000_0010; note_len = 2; end
                'd15: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd16: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd17: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd18: begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd19: begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd20: begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd21: begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd22: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd23: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd24: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd25: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd26: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd27: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd28: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd29: begin current = 8;  led = 8'b0000_0001; note_len = 2; end
                'd30: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd31: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd32: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd33: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd34: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd35: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd36: begin current = 10; led = 8'b0000_0100; note_len = 2; end
                'd37: begin current = 11; led = 8'b0000_1000; note_len = 2; end
                'd38: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd39: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd40: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd41: begin current = 10; led = 8'b0000_0100; note_len = 2; end
                'd42: begin current = 11; led = 8'b0000_1000; note_len = 2; end
                'd43: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd44: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd45: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd46: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd47: begin current = 5;  led = 8'b0001_0000; note_len = 1; end
                'd48: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd49: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd50: begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd51: begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd52: begin current = 12; led = 8'b0001_0000; note_len = 1; end
                'd53: begin current = 11; led = 8'b0000_1000; note_len = 1; end
                'd54: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd55: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd56: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd57: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
                'd58: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd59: begin current = 10; led = 8'b0000_0100; note_len = 1; end
                'd60: begin current = 9;  led = 8'b0000_0010; note_len = 1; end
                'd61: begin current = 8;  led = 8'b0000_0001; note_len = 2; end
                'd62: begin current = 8;  led = 8'b0000_0001; note_len = 1; end
             default: begin current = 0;  led = 8'b0000_0000; end
            endcase
            default: begin current = 0; led = 8'b0000_0000; end
        endcase
	end

endmodule