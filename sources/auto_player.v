// Auto Player Top Module
`include "const.v"

module auto_player(
	input            clk, pause,             // clock, pause
	input      [2:0] mode,                   // 011: auto
	input      [1:0] song_num,               // 00: song1, 01: song2, 10: song3
	output           speaker,                // pwm signal
	output reg [7:0] led1                    // control led
	);
	
	reg  [1:0]  last_song_num;               // Last song number, used to reset cnt_note when song changes
	reg	 [15:0] cnt_note, note_num;          // Counter for notes in a song
	reg	 [28:0] duration;                    // Duration Counter
	reg  [4:0]  note, current;               // Note and current note
	reg  [3:0]  note_len;                    // Note length
    reg  [7:0]  led;
	parameter   period = `CLK_FREQ;          // Note period
	parameter   note_div = 9 * period / 10;  // Note duration

	buzzer buzzer(.clk(clk), .note(note), .speaker(speaker));
	
	initial begin
	   cnt_note = 0;
	   note = 0;
	   duration = 0;
       note_len = 1;
	end
	
    // Get the number of notes in a song when song changes
	always @(posedge clk) begin
		if(mode != `MODEAUTO) begin
			note_num <= 0;
		end else begin
			case(song_num)
				2'b00: note_num <= 48; // Little Star
				2'b01: note_num <= 93; // Haruhigake
				2'b10: note_num <= 62; // Ode to Joy
                2'b11: note_num <= 76; // Jingle bell
			endcase
		end
	end
	
    // Count the number of notes played
	always @(posedge clk) begin
	   if(pause) begin
	       cnt_note <= cnt_note;
	       duration <= 0;
	   end else if(mode != `MODEAUTO | song_num != last_song_num) begin
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
	   if(pause) begin
	       note <= 0;
	   end else if(duration < note_div / note_len) begin
	       note <= current;
           led1 <= led;
	   end else begin
	       note <= 0;
           led1 <= 0;
	   end
	end

    //  Song Sheet and control led
	always @(song_num, cnt_note) begin
        case(song_num)
            2'b00: case(cnt_note) // Song 1: Twinkle Twinkle Little Star
               'd1:  begin current = 8;  led = `LED0; note_len = 1; end
               'd2:  begin current = 8;  led = `LED0; note_len = 1; end
               'd3:  begin current = 12; led = `LED4; note_len = 1; end
               'd4:  begin current = 12; led = `LED4; note_len = 1; end
               'd5:  begin current = 13; led = `LED5; note_len = 1; end
               'd6:  begin current = 13; led = `LED5; note_len = 1; end
               'd7:  begin current = 12; led = `LED4; note_len = 1; end
               'd8:  begin current = 0;  led = `LEDM; note_len = 1; end
               'd9:  begin current = 11; led = `LED3; note_len = 1; end
               'd10: begin current = 11; led = `LED3; note_len = 1; end
               'd11: begin current = 10; led = `LED2; note_len = 1; end
               'd12: begin current = 10; led = `LED2; note_len = 1; end
               'd13: begin current = 9;  led = `LED1; note_len = 1; end
               'd14: begin current = 9;  led = `LED1; note_len = 1; end
               'd15: begin current = 8;  led = `LED0; note_len = 1; end
               'd16: begin current = 0;  led = `LEDM; note_len = 1; end
               'd17: begin current = 12; led = `LED4; note_len = 1; end
               'd18: begin current = 12; led = `LED4; note_len = 1; end
               'd19: begin current = 11; led = `LED3; note_len = 1; end
               'd20: begin current = 11; led = `LED3; note_len = 1; end
               'd21: begin current = 10; led = `LED2; note_len = 1; end
               'd22: begin current = 10; led = `LED2; note_len = 1; end
               'd23: begin current = 9;  led = `LED1; note_len = 1; end
               'd24: begin current = 0;  led = `LEDM; note_len = 1; end
               'd25: begin current = 12; led = `LED4; note_len = 1; end
               'd26: begin current = 12; led = `LED4; note_len = 1; end
               'd27: begin current = 11; led = `LED3; note_len = 1; end
               'd28: begin current = 11; led = `LED3; note_len = 1; end
               'd29: begin current = 10; led = `LED2; note_len = 1; end
               'd30: begin current = 10; led = `LED2; note_len = 1; end
               'd31: begin current = 9;  led = `LED1; note_len = 1; end
               'd32: begin current = 0;  led = `LEDM; note_len = 1; end
               'd33: begin current = 8;  led = `LED0; note_len = 1; end
               'd34: begin current = 8;  led = `LED0; note_len = 1; end
               'd35: begin current = 12; led = `LED4; note_len = 1; end
               'd36: begin current = 12; led = `LED4; note_len = 1; end
               'd37: begin current = 13; led = `LED5; note_len = 1; end
               'd38: begin current = 13; led = `LED5; note_len = 1; end
               'd39: begin current = 12; led = `LED4; note_len = 1; end
               'd40: begin current = 0;  led = `LEDM; note_len = 1; end
               'd41: begin current = 11; led = `LED3; note_len = 1; end
               'd42: begin current = 11; led = `LED3; note_len = 1; end
               'd43: begin current = 10; led = `LED2; note_len = 1; end
               'd44: begin current = 10; led = `LED2; note_len = 1; end
               'd45: begin current = 9;  led = `LED1; note_len = 1; end
               'd46: begin current = 9;  led = `LED1; note_len = 1; end
               'd47: begin current = 8;  led = `LED0; note_len = 1; end
               'd48: begin current = 0;  led = `LEDM; note_len = 1; end
            default: begin current = 0;  led = `LEDM; note_len = 1; end
           endcase
           2'b01: case(cnt_note) // Song 2: Haruhigake
               'd1:  begin current = 17; led = `LED2; note_len = 1; end
               'd2:  begin current = 16; led = `LED1; note_len = 2; end
               'd3:  begin current = 15; led = `LED0; note_len = 1; end
               'd4:  begin current = 16; led = `LED1; note_len = 2; end
               'd5:  begin current = 17; led = `LED2; note_len = 2; end
               'd6:  begin current = 18; led = `LED3; note_len = 4; end
               'd7:  begin current = 17; led = `LED2; note_len = 2; end
               'd8:  begin current = 16; led = `LED1; note_len = 1; end
               'd9:  begin current = 17; led = `LED2; note_len = 1; end
               'd10: begin current = 16; led = `LED1; note_len = 2; end
               'd11: begin current = 15; led = `LED0; note_len = 1; end
               'd12: begin current = 16; led = `LED1; note_len = 2; end 
               'd13: begin current = 17; led = `LED2; note_len = 2; end 
               'd14: begin current = 18; led = `LED3; note_len = 4; end
               'd15: begin current = 17; led = `LED2; note_len = 2; end
               'd16: begin current = 16; led = `LED1; note_len = 1; end
               'd17: begin current = 17; led = `LED2; note_len = 1; end
               'd18: begin current = 16; led = `LED1; note_len = 2; end
               'd19: begin current = 15; led = `LED0; note_len = 1; end
               'd20: begin current = 16; led = `LED1; note_len = 2; end 
               'd21: begin current = 17; led = `LED2; note_len = 2; end 
               'd22: begin current = 18; led = `LED3; note_len = 4; end
               'd23: begin current = 17; led = `LED2; note_len = 2; end
               'd24: begin current = 16; led = `LED1; note_len = 1; end
               'd25: begin current = 17; led = `LED2; note_len = 1; end
               'd26: begin current = 16; led = `LED1; note_len = 2; end
               'd27: begin current = 15; led = `LED0; note_len = 1; end
               'd28: begin current = 16; led = `LED1; note_len = 2; end
               'd29: begin current = 17; led = `LED2; note_len = 2; end
               'd30: begin current = 18; led = `LED3; note_len = 4; end
               'd31: begin current = 17; led = `LED2; note_len = 2; end
               'd32: begin current = 16; led = `LED1; note_len = 1; end
               'd33: begin current = 8;  led = `LED0; note_len = 2; end
               'd34: begin current = 8;  led = `LED0; note_len = 2; end
               'd35: begin current = 10; led = `LED2; note_len = 2; end
               'd36: begin current = 10; led = `LED2; note_len = 2; end
               'd37: begin current = 9;  led = `LED1; note_len = 2; end
               'd38: begin current = 11; led = `LED3; note_len = 2; end
               'd39: begin current = 10; led = `LED2; note_len = 2; end
               'd40: begin current = 9;  led = `LED1; note_len = 2; end
               'd41: begin current = 9;  led = `LED1; note_len = 2; end
               'd42: begin current = 9;  led = `LED1; note_len = 2; end
               'd43: begin current = 8;  led = `LED0; note_len = 4; end
               'd44: begin current = 8;  led = `LED0; note_len = 4; end
               'd45: begin current = 11; led = `LED3; note_len = 2; end
               'd46: begin current = 10; led = `LED2; note_len = 2; end
               'd47: begin current = 9;  led = `LED1; note_len = 2; end
               'd48: begin current = 9;  led = `LED1; note_len = 1; end
               'd49: begin current = 8;  led = `LED0; note_len = 4; end
               'd50: begin current = 9;  led = `LED1; note_len = 4; end
               'd51: begin current = 10; led = `LED2; note_len = 1; end
               'd52: begin current = 0;  led = `LEDM; note_len = 1; end
               'd53: begin current = 10; led = `LED2; note_len = 2; end
               'd54: begin current = 12; led = `LED4; note_len = 2; end
               'd55: begin current = 15; led = `LED0; note_len = 2; end
               'd56: begin current = 14; led = `LED6; note_len = 1; end
               'd57: begin current = 15; led = `LED0; note_len = 2; end
               'd58: begin current = 14; led = `LED6; note_len = 1; end
               'd59: begin current = 15; led = `LED0; note_len = 2; end
               'd60: begin current = 14; led = `LED6; note_len = 4; end
               'd61: begin current = 13; led = `LED5; note_len = 4; end
               'd62: begin current = 12; led = `LED4; note_len = 1; end
               'd63: begin current = 12; led = `LED4; note_len = 2; end
               'd64: begin current = 9;  led = `LED1; note_len = 2; end
               'd65: begin current = 11; led = `LED3; note_len = 2; end
               'd66: begin current = 11; led = `LED3; note_len = 1; end
               'd67: begin current = 10; led = `LED2; note_len = 2; end
               'd68: begin current = 10; led = `LED2; note_len = 1; end
               'd69: begin current = 5;  led = `LED4; note_len = 2; end
               'd70: begin current = 11; led = `LED3; note_len = 2; end
               'd71: begin current = 10; led = `LED2; note_len = 2; end
               'd72: begin current = 9;  led = `LED1; note_len = 2; end
               'd73: begin current = 10; led = `LED2; note_len = 1; end
               'd74: begin current = 12; led = `LED4; note_len = 2; end
               'd75: begin current = 8;  led = `LED0; note_len = 1; end
               'd76: begin current = 0;  led = `LEDM; note_len = 1; end
               'd77: begin current = 8;  led = `LED0; note_len = 1; end
               'd78: begin current = 9;  led = `LED1; note_len = 2; end
               'd79: begin current = 8;  led = `LED0; note_len = 2; end
               'd80: begin current = 7;  led = `LED6; note_len = 4; end
               'd81: begin current = 8;  led = `LED1; note_len = 2; end
               'd82: begin current = 12; led = `LED4; note_len = 2; end
               'd83: begin current = 8;  led = `LED1; note_len = 2; end
               'd84: begin current = 11; led = `LED3; note_len = 1; end
               'd85: begin current = 10; led = `LED2; note_len = 2; end
               'd86: begin current = 9;  led = `LED1; note_len = 2; end
               'd87: begin current = 8;  led = `LED0; note_len = 2; end
               'd88: begin current = 8;  led = `LED0; note_len = 2; end
               'd89: begin current = 8;  led = `LED0; note_len = 1; end
               'd90: begin current = 8;  led = `LED0; note_len = 1; end
               'd91: begin current = 0;  led = `LEDM; note_len = 2; end
               'd92: begin current = 8;  led = `LED0; note_len = 2; end
               'd93: begin current = 9;  led = `LED0; note_len = 2; end
            default: begin current = 0;  led = `LEDM; note_len = 1; end
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
             default: begin current = 0;  led = `LEDM; note_len = 1; end
            endcase
            2'b11: case(cnt_note)
                'd1:  begin current = 10; led = `LED2; note_len = 2; end
                'd2:  begin current = 10; led = `LED2; note_len = 2; end
                'd3:  begin current = 10; led = `LED2; note_len = 1; end
                'd4:  begin current = 10; led = `LED2; note_len = 2; end
                'd5:  begin current = 10; led = `LED2; note_len = 2; end
                'd6:  begin current = 10; led = `LED2; note_len = 1; end
                'd7:  begin current = 10; led = `LED0; note_len = 2; end
                'd8:  begin current = 12; led = `LED0; note_len = 2; end
                'd9:  begin current = 8;  led = `LED0; note_len = 2; end
                'd10: begin current = 9;  led = `LED0; note_len = 4; end
                'd11: begin current = 10; led = `LED0; note_len = 1; end
                'd12: begin current = 11; led = `LED3; note_len = 2; end
                'd13: begin current = 11; led = `LED3; note_len = 2; end
                'd14: begin current = 11; led = `LED3; note_len = 2; end
                'd15: begin current = 11; led = `LED3; note_len = 2; end
                'd16: begin current = 11; led = `LED3; note_len = 2; end
                'd17: begin current = 10; led = `LED2; note_len = 2; end
                'd18: begin current = 10; led = `LED2; note_len = 2; end
                'd19: begin current = 10; led = `LED2; note_len = 2; end
                'd20: begin current = 12; led = `LED4; note_len = 2; end
                'd21: begin current = 12; led = `LED4; note_len = 2; end
                'd22: begin current = 11; led = `LED3; note_len = 2; end
                'd23: begin current = 9;  led = `LED1; note_len = 2; end
                'd24: begin current = 8;  led = `LED0; note_len = 1; end
                'd25: begin current = 1;  led = `LED0; note_len = 1; end
                'd26: begin current = 5;  led = `LED4; note_len = 2; end
                'd27: begin current = 10; led = `LED2; note_len = 2; end
                'd28: begin current = 9;  led = `LED1; note_len = 2; end
                'd29: begin current = 8;  led = `LED0; note_len = 2; end
                'd30: begin current = 5;  led = `LED4; note_len = 1; end
                'd31: begin current = 5;  led = `LED4; note_len = 4; end
                'd32: begin current = 5;  led = `LED4; note_len = 4; end
                'd33: begin current = 5;  led = `LED4; note_len = 2; end
                'd34: begin current = 10; led = `LED2; note_len = 2; end
                'd35: begin current = 9;  led = `LED1; note_len = 2; end
                'd36: begin current = 8;  led = `LED0; note_len = 2; end
                'd37: begin current = 6;  led = `LED5; note_len = 1; end
                'd38: begin current = 6;  led = `LED5; note_len = 1; end
                'd39: begin current = 6;  led = `LED5; note_len = 2; end
                'd40: begin current = 11; led = `LED3; note_len = 2; end
                'd41: begin current = 10; led = `LED2; note_len = 2; end
                'd42: begin current = 9;  led = `LED1; note_len = 2; end
                'd43: begin current = 7;  led = `LED6; note_len = 1; end
                'd44: begin current = 5;  led = `LED4; note_len = 1; end
                'd45: begin current = 12; led = `LED4; note_len = 1; end
                'd46: begin current = 11; led = `LED3; note_len = 2; end
                'd47: begin current = 9;  led = `LED1; note_len = 2; end
                'd48: begin current = 10; led = `LED2; note_len = 1; end
                'd49: begin current = 8;  led = `LED0; note_len = 2; end
                'd50: begin current = 5;  led = `LED4; note_len = 2; end
                'd51: begin current = 5;  led = `LED4; note_len = 2; end
                'd52: begin current = 10; led = `LED2; note_len = 2; end
                'd53: begin current = 9;  led = `LED1; note_len = 2; end
                'd54: begin current = 8;  led = `LED0; note_len = 2; end
                'd55: begin current = 5;  led = `LED4; note_len = 1; end
                'd56: begin current = 5;  led = `LED4; note_len = 2; end
                'd57: begin current = 5;  led = `LED4; note_len = 2; end
                'd58: begin current = 10; led = `LED2; note_len = 2; end
                'd59: begin current = 9;  led = `LED1; note_len = 2; end
                'd60: begin current = 8;  led = `LED0; note_len = 2; end
                'd61: begin current = 6;  led = `LED5; note_len = 1; end
                'd62: begin current = 6;  led = `LED5; note_len = 2; end
                'd63: begin current = 5;  led = `LED4; note_len = 2; end
                'd64: begin current = 11; led = `LED3; note_len = 2; end
                'd65: begin current = 10; led = `LED2; note_len = 2; end
                'd66: begin current = 9;  led = `LED1; note_len = 2; end
                'd67: begin current = 12; led = `LED4; note_len = 2; end
                'd68: begin current = 12; led = `LED4; note_len = 2; end
                'd69: begin current = 12; led = `LED4; note_len = 2; end
                'd70: begin current = 12; led = `LED4; note_len = 2; end
                'd71: begin current = 13; led = `LED5; note_len = 2; end
                'd72: begin current = 12; led = `LED4; note_len = 2; end
                'd73: begin current = 11; led = `LED3; note_len = 2; end
                'd74: begin current = 9;  led = `LED1; note_len = 2; end
                'd75: begin current = 8;  led = `LED0; note_len = 1; end
                'd76: begin current = 0;  led = `LEDM; note_len = 1; end
             default: begin current = 0;  led = `LEDM; note_len = 1; end
            endcase
            default: begin current = 0; led = `LEDM; end
        endcase
	end

endmodule