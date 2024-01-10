/***********************************************(I/O)port declartion******************************************************/
module top_module(
input    wire     clk,valid,rst,miso,
output   wire     sclk,mosi
);
/**************************************************************************************************************************/

/***********************************************internal signal declartion*************************************************/        
wire clk_div,valid_latch,leading_edge,trailing_edg;
/**************************************************************************************************************************/

/***********************************************port mapping***************************************************************/
clock_divider u1(
    .clk(clk),
    .rst(rst),
    .valid(valid),
    .clk_div(clk_div),
    .valid_latch(valid_latch),
    .leading_edge(leading_edge),
    .trailing_edg(trailing_edg)

);

spi_master u2(
    .clk(clk),
    .rst(rst),
    .valid(valid),
    .clk_div(clk_div),
    .leading_edge(leading_edge),
    .trailing_edg(trailing_edg),
    .miso(miso),
    .mosi(mosi),
    .sclk(sclk)  
);
/**************************************************************************************************************************/
endmodule
