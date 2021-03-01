// minimalistic simulation top module with clock gen and initial reset

module ibex_soc_tb #(
        parameter RAM_FPATH = ""
    );

    logic clk, rst;
    logic rx, tx;

    ibex_soc #(
        .RAM_FPATH  ( RAM_FPATH )
    )i_ibex_soc (
        .sys_clk_i  ( clk       ),
        .sys_rst_ni ( ~rst      ),
        .uart_rx_i  ( rx        ),
        .uart_tx_o  ( tx        )
    );

    initial begin
        rst = 1'b1;
        #20
        rst = 1'b0;
    end

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    assign rx = 1'b1;
endmodule
