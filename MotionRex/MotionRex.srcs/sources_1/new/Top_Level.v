`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 08:10:57 PM
`timescale 1ns / 1ps
module Top_Level(
input CLK,

output h_sync,
output v_sync,
output [3:0] red,
output [3:0] green,
output [3:0] blue,
output [6:0] LED_out,
output [3:0] Anode_Activate,
input score_reset,
input wire  reset,
input wire ir_in,
output wire fsm_input_user, fsm_reset,
output wire key_release

);  
  wire clk_d,trig_V,VD_ON;
  wire [9:0]XL, YL;
  wire [9:0]hcount, Vcount;
  wire [2:0] state;
  wire [9:0]mover_dino;
  wire [9:0]mover; 
  
    ir_sensor kb(
        .clk(CLK),
        .reset(reset),
        .ir_in(ir_in),
        .v17_pin(v17_pin),
        .fsm_input_user(fsm_input_user),
        .fsm_reset(fsm_reset)
    );



  clk_divider C1(.clk(CLK),.clk_d(clk_d));
  h_counter H1(.clock(clk_d),.hcount(hcount),.trig_V(trig_V));
  v_counter V1(.clock(clk_d),.V_signal(trig_V),.Vcount(Vcount));
  VGA_sync VG1(.h_count(hcount),.v_count(Vcount),.h_sync(h_sync),.v_sync(v_sync),.video_on(VD_ON),.x_log(XL),.y_log(YL));
  FSM F1(.clk_div1(clk_d),.fsm_reset(fsm_reset),.fsm_input_user(fsm_input_user),.state(state),.mover_dino(mover_dino),.mover(mover));
  pixel_gen P1(.pixel_x(XL),.pixel_y(YL),.clk_div1(clk_d),.video_on(VD_ON),.red(red),.green(green),.blue(blue),.state(state),.mover_dino(mover_dino),.mover(mover));
  seven_segment SedDisp(.clock_100Mhz(CLK),.reset(score_reset),.Anode_Activate(Anode_Activate),.LED_out(LED_out));
  start p2(pixel_x,pixel_y,display);
endmodule
