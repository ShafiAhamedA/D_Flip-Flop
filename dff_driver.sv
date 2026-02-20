class dff_driver;
  virtual dff_interface vif;
  dff_trans tn;
  mailbox #(dff_trans) mbx_drv;
  
  function new(virtual dff_interface vif,mailbox #(dff_trans) mbx_drv);
    this.vif=vif;
    this.mbx_drv=mbx_drv;
  endfunction
  
  task drv_run();
    $display("Randomized Signals are passed to interface by Driver");
    forever @(negedge vif.clk) begin
      mbx_drv.get(tn);
      vif.din=tn.din;
      $display("Driver: ,time=%0t, clk=%0d, din=%0d",$time,vif.clk,vif.din);
    end
  endtask
endclass
