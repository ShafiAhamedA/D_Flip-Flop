// Code your testbench here
// or browse Examples
`include "dff_interface.sv"
`include "dff_trans.sv"
`include "dff_generator.sv"
`include "dff_driver.sv"
`include "dff_monitor.sv"
`include "dff_scoreboard.sv"
`include "dff_environment.sv"
`include "dff_test.sv"

module dff_tb_top();
  logic clk;
  dff_interface vif(clk);
   
  dff dut(.clk(clk),.rst(vif.rst),.din(vif.din),.dout(vif.dout));
  
  always #5 clk=~clk;
  
  initial begin
    clk=0;
    vif.rst=1;
    vif.din=0;
  end
  
  initial begin
    vif.rst=1;
    repeat(2)@(negedge clk);
    vif.rst=0;
  end
  
  dff_test test;
  initial begin
    test=new(vif);
    //test.vif=vif;
    test.test_run();
  end
  initial begin
    #300 $finish;
  end
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end 
endmodule
