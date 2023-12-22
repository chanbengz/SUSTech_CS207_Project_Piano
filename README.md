<div align='center'>

# SUSTech CS207 Digital Design Project<br> Piano
A Mini Piano Toy ~~not playable~~
</div>

## Introduction
In this semester project, we implement a piano toy with learn mode
and music player on the Xilinx(TM) FPGA EGO1 board, and the code
is written in `Verilog`. Inside the piano, we put three songs,
`Twinkle Twinkle Little Star`, `Haruhigake` and `Ode to Joy`.
The implementation seems quite simple and straight forward, but it works pretty well.
That's exactly what we need. Anyway, enjoy your time with the toy!

## Features
 - [x] Free Mode
 - [x] Autoplay Mode
 - [x] Learning Mode
 - [x] Three Octaves (C3 - C5)
 - [x] Pause during autoplay
 - [x] Song switching
 - [x] Evaluation of Learning
 - [x] Learning Record
 - [x] Support crotchet and quaver
 - [x] Mode & Index of Song Displayed
 - [ ] Key Adjustment
 - [ ] VGA Display

## User Manual
When turning on the board, a welcome message "HELLO" will be displayed.
And then you can start using it by changing the mode first.
The tiny switches of SW8 has two functions. The right most three switches is for changing mode
| Mode | Switch | Function |
| ---- | ------ | -------- |
| Free |  001   | Play the piano |
| Auto |  011   | Play songs automatically |
| Learning | 111 | Play throught the instruction|

And the left most two switches is for changing user in learning mode.
When you enter a mode, the name of current mode will be displayed on the segtube.

### Free Mode
The switches (SW6 - SW0) is the keys of piano
```
┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ 
│ │ │ │ │ │ │ │ │ │ │ │ │ │ 
└─┘ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘ 
 │   │   │   │   │   │   │ 

 Si  La  So  Fa  Mi  Re  Do
```
When you turn on one of them, the corresponding note will be played.
Note that more than one keys turned on at the same time will not play any notes.
On the right of the board, the up button(S4) is used to play the higher octaves and the down button is for the lower octaves, e.g., when you turn on the key `Do` while pressing the up
button, the piano will play `C5` instead of `C4`.

### Auto Mode
When you feel tired of playing by yourself, you can ask the board to play songs automatically
by switching into auto mode. The piano has 3 songs built in (if you want add more, feel free to notify me in **Issue**), `Twinkle Twinkle Little Star`, `Haruhikage` and `Ode to Joy`.
The song is switched by the buttons, left for previous song, right for next song. And
the middle button can control the pause of song.
```
                  0 -- High pitch

Previous --  0    0    0 -- Pause Next
            
                  0 -- Low pitch
```
On the segment tube, you can see clearly the index of current song.

### Learning Mode
TO-DO

## Architecture
TO-DO

## Contributors
 - [**@Ben Chen**](https://github.com/chanbengz)   *Task:* Program (50%)
 - [**@Zhuo Wang**](https://github.com/we-are-zed) *Task:* Test (50%)

## Development Schedule

|  Task  | Start time | Detail | Status | Estimating | Actual |
| ------ | ---------- | ------ | ------ | ---------- | ------ |
| Main Module | 2023-12-10 | Do the wire planing | Finished | 3 Days | 5 Days |
| Buzzer Module | 2023-12-15 | Develop and Test the funcionality of speaker | Finished | 2 Days | 1 Day |
| Segment Tube Module | 2023-12-16 | Develop and Test the functionality of 8 7SegTube | Finished | 2 Days | 2 Days |
| Document | 2023-12-24 | Compose project report (aka this README) | Pending | 1 Day | N/A |