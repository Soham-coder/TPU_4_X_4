module fifo(
    input i_clk;
    input i_rstn;
    input i_wr;
    input i_rd;
    input [31:0] i_data;
    output [31:0] o_data;
    output o_full,
    output o_empty
);

reg [2:0] wr_addr; //write address
reg [2:0] rd_addr; //read address

reg [31:0] memory[0:7] //Fifo depth 8 and data size is 32 bits

//fifo memory write

always@(posedge i_clk, negedge i_rstn)
begin
    if(!i_rstn)
    begin
        memory[0] <= 0;
        memory[1] <= 0;
        memory[2] <= 0;
        memory[3] <= 0;
        memory[4] <= 0;
        memory[5] <= 0;
        memory[6] <= 0;
        memory[7] <= 0;
    end
    else if(i_wr && !o_full) //write and fifo not full
    begin
        memory[wr_addr] <= i_data; //push input data
    end
end

//fifo increment write address
always@(posedge i_clk, negedge i_rstn)
begin
    if(!i_rstn) //if reset write address pointer == 0
    begin
        wr_addr <= 0;
    end
    else if(i_wr && (!o_full)) //if write and fifo not full so write happening->
    //increment write address by 1
    begin
        wr_addr <= wr_addr + 1;
    end
end

//fifo memory read
assign o_data = memory[rd_addr]; //read at any time

//fifo increment read address
always@(posedge i_clk, negedge i_rstn)
begin
    if(!i_rstn) //if reset read address pointer == 0
    begin
        rd_addr <= 0;
    end
    else if(i_rd && !(o_empty)) //if read and fifo not empty so read happening->
    //increment read address by 1
    begin
        rd_addr <= rd_addr + 1;
    end
end

//update empty status
assign o_empty = (wr_addr == rd_addr); //rd_pointer = wr_pointer
//update full sign
assign o_full = ((wr_addr + 1) == (rd_addr)) ; //rd_pointer = wr_pointer + 1

endmodule
