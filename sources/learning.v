// Learning Mode Top Module
`include "const.v"

module learning(
	input             clk,                   // clock
    input      [6:0]  key,                   // 0: do, 1: re, 2: mi, 3: fa, 4: sol, 5: la, 6: si
	input      [2:0]  mode,                  // 011: auto, 001: manual, 111: learning
	input      [1:0]  pitch,                 // 01: low, 00:middle, 10: high
	input      [1:0]  song_num,              // song number
	output            speaker,               // speaker
	output reg [7:0]  led,                   // LED
	output reg [4:0]  pitch_dis,             // Pitch display
    output reg        finished,              // Finished playing a song
    output reg [31:0] score                  // Score
	);

	reg  [1:0]  last_song_num;               // Last song number, used to reset cnt_note when song changes
	reg	 [16:0] cnt_note;                    // Counter for notes in a song
	reg	 [28:0] duration;                    // Duration Counter
	reg	 [5:0]  note_num;                    // Number of notes in a song
	reg  [4:0]  note;                        // Note and current note
    reg  [8:0]  current;                     // Current note and pitch
	reg  [3:0]  note_len;                    // Note length
	parameter   period   = `CLK_FREQ;        // Note period
	parameter   note_div = 9 * period / 10;  // Note duration

	buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));

    initial begin
	    cnt_note = 0;
	    duration = 0;
        finished = 0;
        score    = 0;
        note_len = 1;
	end

	always @(*) begin
		if(mode != `MODELRN || key != current) begin
			note = 0;
		end else begin
			case({pitch, key})
                `KEYL1: note = 1;  // C3
                `KEYL2: note = 2;  // D3
                `KEYL3: note = 3;  // E3
                `KEYL4: note = 4;  // F3
                `KEYL5: note = 5;  // G3
                `KEYL6: note = 6;  // A3
                `KEYL7: note = 7;  // B3
                `KEYM1: note = 8;  // C4
                `KEYM2: note = 9;  // D4
                `KEYM3: note = 10; // E4
                `KEYM4: note = 11; // F4
                `KEYM5: note = 12; // G4
                `KEYM6: note = 13; // A4
                `KEYM7: note = 14; // B4
                `KEYH1: note = 15; // C5
                `KEYH2: note = 16; // D5
                `KEYH3: note = 17; // E5
                `KEYH4: note = 18; // F5
                `KEYH5: note = 19; // G5
                `KEYH6: note = 20; // A5
                `KEYH7: note = 21; // B5
               default: note = 0;  // silence
			endcase
		end
	end
	
    // Get the number of notes in a song when song changes
	always @(posedge clk) begin
		if(mode != `MODELRN) begin
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
		if(mode != `MODELRN | song_num != last_song_num) begin
	        duration <= 0;
	        cnt_note <= 0;
            finished <= 0;
            score <= 0;
	        last_song_num <= song_num;
	   end else begin
	       if(duration == note_div / note_len) begin
               if(cnt_note == note_num) begin
                    finished <= 1;
                    cnt_note <= 1;
               end else cnt_note <= cnt_note + 1;
	           duration <= 0;
	       end else if({pitch, key} == current) begin
	           duration <= duration + 1;
           end else begin
               duration <= 0;
               if(score > 'd1000_000_000) score <= score;
               else score <= score + 1;
           end
	   end
	end

    // Song Sheet and control led
	always @(song_num, cnt_note) begin
        case(song_num)
            2'b00: case(cnt_note) // Song 1: Twinkle Twinkle Little Star
               'd1:  begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd2:  begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd3:  begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd4:  begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd5:  begin current = `KEYM6; led = `LED5; note_len = 1; pitch_dis = `INN; end
               'd6:  begin current = `KEYM6; led = `LED5; note_len = 1; pitch_dis = `INN; end
               'd7:  begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd8:  begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
               'd9:  begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd10: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd11: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd12: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd13: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd14: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd15: begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd16: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
               'd17: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd18: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd19: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd20: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd21: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd22: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd23: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd24: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
               'd25: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd26: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd27: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd28: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd29: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd30: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd31: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd32: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
               'd33: begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd34: begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd35: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd36: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd37: begin current = `KEYM6; led = `LED5; note_len = 1; pitch_dis = `INN; end
               'd38: begin current = `KEYM6; led = `LED5; note_len = 1; pitch_dis = `INN; end
               'd39: begin current = `KEYM5; led = `LED4; note_len = 1; pitch_dis = `INN; end
               'd40: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
               'd41: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd42: begin current = `KEYM4; led = `LED3; note_len = 1; pitch_dis = `INN; end
               'd43: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd44: begin current = `KEYM3; led = `LED2; note_len = 1; pitch_dis = `INN; end
               'd45: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd46: begin current = `KEYM2; led = `LED1; note_len = 1; pitch_dis = `INN; end
               'd47: begin current = `KEYM1; led = `LED0; note_len = 1; pitch_dis = `INN; end
               'd48: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = `INN; end
            default: begin current = `KEYEM; led = `LEDM; note_len = 1; pitch_dis = 5'b11111; end
           endcase
           2'b01: case(cnt_note) // Song 2: Haruhigake
               'd1:  begin current = 5;  led = `LED4; note_len = 1; end
               'd2:  begin current = 10; led = `LED2; note_len = 2; end
               'd3:  begin current = 10; led = `LED2; note_len = 1; end
               'd4:  begin current = 9;  led = `LED1; note_len = 1; end
               'd5:  begin current = 11; led = `LED3; note_len = 1; end
               'd6:  begin current = 10; led = `LED2; note_len = 1; end
               'd7:  begin current = 9;  led = `LED1; note_len = 1; end
               'd8:  begin current = 9;  led = `LED1; note_len = 1; end
               'd9:  begin current = 9;  led = `LED1; note_len = 1; end
               'd10: begin current = 8;  led = `LED0; note_len = 2; end
               'd11: begin current = 11; led = `LED3; note_len = 1; end
               'd12: begin current = 10; led = `LED2; note_len = 1; end 
               'd13: begin current = 9;  led = `LED1; note_len = 1; end 
               'd14: begin current = 9;  led = `LED1; note_len = 1; end
               'd15: begin current = 8;  led = `LED0; note_len = 1; end
               'd16: begin current = 8;  led = `LED0; note_len = 1; end
               'd17: begin current = 9;  led = `LED1; note_len = 1; end
               'd18: begin current = 0;  led = `LEDM; note_len = 1; end
               'd19: begin current = 10; led = `LED2; note_len = 1; end
               'd20: begin current = 12; led = `LED4; note_len = 1; end 
               'd21: begin current = 15; led = `LED0; note_len = 1; end 
               'd22: begin current = 14; led = `LED6; note_len = 1; end
               'd23: begin current = 15; led = `LED0; note_len = 1; end
               'd24: begin current = 14; led = `LED6; note_len = 1; end
               'd25: begin current = 15; led = `LED0; note_len = 1; end
               'd26: begin current = 14; led = `LED6; note_len = 1; end
               'd27: begin current = 13; led = `LED5; note_len = 1; end
               'd28: begin current = 12; led = `LED4; note_len = 1; end
               'd29: begin current = 0;  led = `LEDM; note_len = 1; end
               'd30: begin current = 12; led = `LED4; note_len = 1; end
               'd31: begin current = 9;  led = `LED1; note_len = 1; end
               'd32: begin current = 11; led = `LED3; note_len = 1; end
               'd33: begin current = 11; led = `LED3; note_len = 1; end
               'd34: begin current = 10; led = `LED2; note_len = 1; end
               'd35: begin current = 10; led = `LED2; note_len = 1; end
               'd36: begin current = 0;  led = `LEDM; note_len = 1; end
               'd37: begin current = 5;  led = `LED4; note_len = 1; end
               'd38: begin current = 11; led = `LED5; note_len = 1; end
               'd39: begin current = 10; led = `LED2; note_len = 1; end
               'd40: begin current = 9;  led = `LED1; note_len = 1; end
               'd41: begin current = 10; led = `LED2; note_len = 1; end
               'd42: begin current = 12; led = `LED4; note_len = 1; end
               'd43: begin current = 8;  led = `LED0; note_len = 1; end
               'd44: begin current = 0;  led = `LEDM; note_len = 1; end
               'd45: begin current = 8;  led = `LED0; note_len = 1; end
               'd46: begin current = 9;  led = `LED1; note_len = 1; end
               'd47: begin current = 8;  led = `LED0; note_len = 1; end
               'd48: begin current = 12; led = `LED4; note_len = 1; end
               'd49: begin current = 8;  led = `LED0; note_len = 1; end
               'd50: begin current = 11; led = `LED3; note_len = 1; end
               'd51: begin current = 10; led = `LED2; note_len = 1; end
               'd52: begin current = 9;  led = `LED1; note_len = 1; end
               'd53: begin current = 8;  led = `LED0; note_len = 1; end
            default: begin current = 0;  led = `LEDM; end
           endcase
           2'b10: case(cnt_note) // Song 3: Ode to joy
                'd1:  begin current = 10; led = `LED2; note_len = 1; end
                'd2:  begin current = 10; led = `LED2; note_len = 1; end
                'd3:  begin current = 11; led = `LED3; note_len = 1; end
                'd4:  begin current = 12; led = `LED4; note_len = 1; end
                'd5:  begin current = 12; led = `LED4; note_len = 1; end
                'd6:  begin current = 11; led = `LED3; note_len = 1; end
                'd7:  begin current = 10; led = `LED2; note_len = 1; end
                'd8:  begin current = 9;  led = `LED1; note_len = 1; end
                'd9:  begin current = 8;  led = `LED0; note_len = 1; end
                'd10: begin current = 8;  led = `LED0; note_len = 1; end
                'd11: begin current = 9;  led = `LED1; note_len = 1; end
                'd12: begin current = 10; led = `LED2; note_len = 1; end
                'd13: begin current = 10; led = `LED2; note_len = 1; end
                'd14: begin current = 9;  led = `LED1; note_len = 2; end
                'd15: begin current = 9;  led = `LED1; note_len = 1; end
                'd16: begin current = 10; led = `LED2; note_len = 1; end
                'd17: begin current = 10; led = `LED2; note_len = 1; end
                'd18: begin current = 11; led = `LED3; note_len = 1; end
                'd19: begin current = 12; led = `LED4; note_len = 1; end
                'd20: begin current = 12; led = `LED4; note_len = 1; end
                'd21: begin current = 11; led = `LED3; note_len = 1; end
                'd22: begin current = 10; led = `LED2; note_len = 1; end
                'd23: begin current = 9;  led = `LED1; note_len = 1; end
                'd24: begin current = 8;  led = `LED0; note_len = 1; end
                'd25: begin current = 8;  led = `LED0; note_len = 1; end
                'd26: begin current = 9;  led = `LED1; note_len = 1; end
                'd27: begin current = 10; led = `LED2; note_len = 1; end
                'd28: begin current = 9;  led = `LED1; note_len = 1; end
                'd29: begin current = 8;  led = `LED0; note_len = 2; end
                'd30: begin current = 8;  led = `LED0; note_len = 1; end
                'd31: begin current = 9;  led = `LED1; note_len = 1; end
                'd32: begin current = 9;  led = `LED1; note_len = 1; end
                'd33: begin current = 10; led = `LED2; note_len = 1; end
                'd34: begin current = 8;  led = `LED0; note_len = 1; end
                'd35: begin current = 9;  led = `LED1; note_len = 1; end
                'd36: begin current = 10; led = `LED2; note_len = 2; end
                'd37: begin current = 11; led = `LED3; note_len = 2; end
                'd38: begin current = 10; led = `LED2; note_len = 1; end
                'd39: begin current = 8;  led = `LED0; note_len = 1; end
                'd40: begin current = 9;  led = `LED1; note_len = 1; end
                'd41: begin current = 10; led = `LED2; note_len = 2; end
                'd42: begin current = 11; led = `LED3; note_len = 2; end
                'd43: begin current = 10; led = `LED2; note_len = 1; end
                'd44: begin current = 9;  led = `LED1; note_len = 1; end
                'd45: begin current = 8;  led = `LED0; note_len = 1; end
                'd46: begin current = 9;  led = `LED1; note_len = 1; end
                'd47: begin current = 5;  led = `LED4; note_len = 1; end
                'd48: begin current = 10; led = `LED2; note_len = 1; end
                'd49: begin current = 10; led = `LED2; note_len = 1; end
                'd50: begin current = 11; led = `LED3; note_len = 1; end
                'd51: begin current = 12; led = `LED4; note_len = 1; end
                'd52: begin current = 12; led = `LED4; note_len = 1; end
                'd53: begin current = 11; led = `LED3; note_len = 1; end
                'd54: begin current = 10; led = `LED2; note_len = 1; end
                'd55: begin current = 9;  led = `LED1; note_len = 1; end
                'd56: begin current = 8;  led = `LED0; note_len = 1; end
                'd57: begin current = 8;  led = `LED0; note_len = 1; end
                'd58: begin current = 9;  led = `LED1; note_len = 1; end
                'd59: begin current = 10; led = `LED2; note_len = 1; end
                'd60: begin current = 9;  led = `LED1; note_len = 1; end
                'd61: begin current = 8;  led = `LED0; note_len = 2; end
                'd62: begin current = 8;  led = `LED0; note_len = 1; end
             default: begin current = 0;  led = `LEDM; end
            endcase
            default: begin current = 0; led = `LEDM; end
        endcase
	end

endmodule