//Top
module top;
  import uvm_pkg::*;
  import pkg::*;
  logic clk;
  logic rst;

  initial begin
    clk = 1;
    rst = 1;
    #20 rst = 0;
    #20 rst = 1;


  end

  always #10 clk = !clk;

  interface_if dut_if(.clk(clk), .rst(rst));
  
  sqrt my_sqrt(
              .clk_i(clk),
              .rstn_i(rst),
              .enb_i(dut_if.enb_i),
              .dt_i(dut_if.dt_i),
              .busy_o(dut_if.busy_o),
              .dt_o(dut_if.dt_o)
  );

  initial begin
    `ifdef XCELIUM
       $recordvars();
    `endif
    `ifdef VCS
       $vcdpluson;
    `endif
    `ifdef QUESTA
       $wlfdumpvars();
       set_config_int("*", "recording_detail", 1);
    `endif

    uvm_config_db#(interface_vif)::set(uvm_root::get(), "*", "vif", dut_if);

    run_test("simple_test");
  end
endmodule
