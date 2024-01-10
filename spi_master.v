/***********************************************port declartion*************************************************/
module spi_master ( 
input wire clk,rst,clk_div,valid_latch,leading_edge,trailing_edg,miso,valid,
output reg sclk,mosi
);
/*****************************************************************************************************************/

/***********************************************signal declartion*************************************************/        
reg [7:0]    data_in,data_out;
integer          i,x;
/*****************************************************************************************************************/

/*****************************************************************************************************************/
always@(posedge clk or negedge rst)
begin
sclk <= clk_div;
    if(!rst)
    begin
        data_in<=0;
        data_out<=0;
        mosi<=0;
        sclk <=clk_div;
    end

    else if (leading_edge==1)
    begin
        mosi <= data_out[i];
        for(i=7;i>=1;i=i-1)
        begin
        data_out[i] <= data_out[i-1];
        end
    end
    else if (trailing_edg==1)
    begin
        data_in[x] <= miso;
        for(x=7;x>=1;x=x-1)
        data_in[x-1] <= data_in[x];
    end


end
/**************************************************************************************************************/	
endmodule
