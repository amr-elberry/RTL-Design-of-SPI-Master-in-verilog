/***********************************************port declartion*************************************************/
module clock_divider(
input wire clk,rst,valid,
output reg clk_div,leading_edge,trailing_edg,valid_latch
                    );
/***************************************************************************************************************/

reg [2:0] counter=0;
reg [6:0] counter_byte=0;

always@ (posedge clk or  negedge rst)
begin
    clk_div <=1;  // signal clock during no sending (no latch) 
    counter <= counter + 1;

    if(!rst)
    begin
    valid_latch <= 1'b0 ;
    counter <= 0;
    end
    else if (valid_latch == 1)
    begin
                if (counter < 4)
                begin
                clk_div <= 1;
                end
                else
                begin
                clk_div <= 0;
                end
    end
    else
    counter <=0;

end
/***************************counter byte 8-byte****************************************************************/
always@(posedge clk or negedge rst)
begin
    counter_byte <= counter_byte + 1;
            if(!rst)
            begin
                clk_div <=1 ;  //CPOL =1
                counter_byte <= 0;
            end

            else 
            begin 

                if (valid) 
                    valid_latch <= 1'b1 ; // as latching flag 
                else if (counter_byte==64)
                    valid_latch <= 1'b0 ; // as latching flag 
            end // not reset
end
/****************************************************************************************************************/


/****************************************************trail and train edge***************************************/
always@(posedge clk or negedge rst)
begin
			if (counter == 3)
			begin
				leading_edge <=1;
				trailing_edg <= 0;
			end
			else if (counter == 7)
			begin
				trailing_edg <= 1;
				leading_edge <= 0;
			end
			else
			begin 
				leading_edge <= 0;
				trailing_edg <= 0;
			end

end
/**************************************************************************************************************/	
endmodule

