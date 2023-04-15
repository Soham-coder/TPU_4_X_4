module systolic_register
    (
        input i_clk;
        input i_rstn;
        input [31:0] in1;
        input [31:0] in2;
        output [31:0] out1;
        output [31:0] out2
    );

    reg [31:0] delay_1_0;
    reg [31:0] delay_2_0;
    reg [31:0] delay_2_1;
    
    assign out1 = delay_1_0;
    assign out2 = delay_2_1;

    always@(posedge i_clk, negedge i_rstn)
    begin
        if(!i_rstn)
        begin
            delay_1_0 <= 0;
            delay_2_0 <= 0;
            delay_2_1 <= 0;
        end
        begin
            delay_1_0 <= in1;
            delay_2_0 <= in2;
            delay_2_1 <= delay_2_0;
        end
    end
endmodule


