`define L1 769230                               // C3
`define L2 680272                               // D3
`define L3 606061                               // E3
`define L4 571428                               // F3
`define L5 510204                               // G3
`define L6 454545                               // A3
`define L7 404858                               // B3
`define M1 381680                               // C4
`define M2 340136                               // D4
`define M3 303030                               // E4
`define M4 285714                               // F4
`define M5 255102                               // G4
`define M6 227272                               // A4
`define M7 202429                               // B4
`define H1 191204                               // C5
`define H2 170357                               // D5
`define H3 151745                               // E5
`define H4 143266                               // F5
`define H5 127713                               // G5
`define H6 113636                               // A5
`define H7 101317                               // B5
`define SEG_FREQ 200000                         // 500kHz
`define CLK_FREQ 60000000                       // 50MHz
`define GAP 1000000                             // Gap between two button presses
`define AUTO 20'b01010_10101_10100_10010        // Auto Message
`define FREE 20'b01111_10011_01110_01110        // Free Message
`define LRN 15'b10001_10011_10110               // Learn Message
`define HELLO 25'b10000_01110_10001_10001_00000 // Hello Message
`define EMPTY2 10'b11111_11111                  // Empty Message
`define EMPTY3 15'b11111_11111_11111            // Empty Message
`define EMPTY4 20'b11111_11111_11111_11111      // Empty Message
`define BAD 20'b01000_10010_01101_11111         // Bad_
`define SOSO 20'b00101_10010_00101_10010        // SoSo
`define GOOD 20'b00110_10010_10010_01101        // Good
`define SEG0 8'b1111_1100                       // Display '0'
`define SEG1 8'b0110_0000                       // Display '1'
`define SEG2 8'b1101_1010                       // Display '2'
`define SEG3 8'b1111_0010                       // Display '3'
`define SEG4 8'b0110_0110                       // Display '4'
`define SEG5 8'b1011_0110                       // Display '5'
`define SEG6 8'b1011_1110                       // Display '6'
`define SEG7 8'b1110_0000                       // Display '7'
`define SEG8 8'b1111_1110                       // Display '8'
`define SEG9 8'b1111_0110                       // Display '9'
`define SEGA 8'b1110_1110                       // Display 'A'
`define SEGB 8'b0011_1110                       // Display 'B'
`define SEGC 8'b1001_1100                       // Display 'C'
`define SEGD 8'b0111_1010                       // Display 'D'
`define SEGE 8'b1001_1110                       // Display 'E'
`define SEGF 8'b1000_1110                       // Display 'F'
`define SEGH 8'b0110_1110                       // Display 'H'
`define SEGL 8'b0001_1100                       // Display 'L'
`define SEGo 8'b0011_1010                       // Display 'o'
`define SEGR 8'b0000_1010                       // Display 'r'
`define SEGt 8'b0001_1110                       // Display 't'
`define SEGu 8'b0011_1000                       // Display 'u'
`define SEGn 8'b0010_1010                       // Display 'n'
`define SEGN 8'b1110_1100                       // Display 'N'
`define SEGU 8'b0111_1100                       // Display 'U'
`define IN0 5'b00000                            // Encode of '0'
`define IN1 5'b00001                            // Encode of '1'
`define IN2 5'b00010                            // Encode of '2'
`define IN3 5'b00011                            // Encode of '3'
`define IN4 5'b00100                            // Encode of '4'
`define IN5 5'b00101                            // Encode of '5'
`define IN6 5'b00110                            // Encode of '6'
`define IN7 5'b00111                            // Encode of '7'
`define IN8 5'b01000                            // Encode of '8'
`define IN9 5'b01001                            // Encode of '9'
`define INA 5'b01010                            // Encode of 'A'
`define INB 5'b01011                            // Encode of 'B'
`define INC 5'b01100                            // Encode of 'C'
`define IND 5'b01101                            // Encode of 'D'
`define INE 5'b01110                            // Encode of 'E'
`define INF 5'b01111                            // Encode of 'F'
`define INH 5'b10000                            // Encode of 'H'
`define INL 5'b10001                            // Encode of 'L'
`define INo 5'b10010                            // Encode of 'o'
`define INR 5'b10011                            // Encode of 'r'
`define INt 5'b10100                            // Encode of 't'
`define INu 5'b10101                            // Encode of 'u'
`define INn 5'b10110                            // Encode of 'n'
`define INN 5'b10111                            // Encode of 'N'
`define INU 5'b11000                            // Encode of 'U'
`define MODEFREE 3'b001                         // Free mode
`define MODEAUTO 3'b011                         // Auto mode
`define MODELRN 3'b111                          // Learning mode
`define KEYL1 9'b010000001                      // Key C3
`define KEYL2 9'b010000010                      // Key D3
`define KEYL3 9'b010000100                      // Key E3
`define KEYL4 9'b010001000                      // Key F3
`define KEYL5 9'b010010000                      // Key G3
`define KEYL6 9'b010100000                      // Key A3
`define KEYL7 9'b011000000                      // Key B3
`define KEYM1 9'b000000001                      // Key C4
`define KEYM2 9'b000000010                      // Key D4
`define KEYM3 9'b000000100                      // Key E4
`define KEYM4 9'b000001000                      // Key F4
`define KEYM5 9'b000010000                      // Key G4
`define KEYM6 9'b000100000                      // Key A4
`define KEYM7 9'b001000000                      // Key B4
`define KEYH1 9'b100000001                      // Key C5
`define KEYH2 9'b100000010                      // Key D5
`define KEYH3 9'b100000100                      // Key E5
`define KEYH4 9'b100001000                      // Key F5
`define KEYH5 9'b100010000                      // Key G5
`define KEYH6 9'b100100000                      // Key A5
`define KEYH7 9'b101000000                      // Key B5
`define KEYEM 9'b000000000                      // Empty key
`define LED0 8'b0000_0001                       // LED for C
`define LED1 8'b0000_0010                       // LED for D
`define LED2 8'b0000_0100                       // LED for E
`define LED3 8'b0000_1000                       // LED for F
`define LED4 8'b0001_0000                       // LED for G
`define LED5 8'b0010_0000                       // LED for A
`define LED6 8'b0100_0000                       // LED for B
`define LEDM 8'b0000_0000                       // LED off
