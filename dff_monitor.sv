class dff_monitor;
  virtual dff_interface vif;
  dff_trans tn;
  mailbox #(dff_trans) mbx_scb;

  function new(virtual dff_interface vif,mailbox #(dff_trans) mbx_scb);
    this.mbx_scb = mbx_scb;
    this.vif = vif;
  endfunction
  
  task mon_run();
    $display("Output signals from interface passed to transaction by monitor");
    forever @(posedge vif.clk) begin
      tn=new();
      tn.rst=vif.rst;
      tn.din=vif.din;
      tn.dout=vif.dout;
      mbx_scb.put(tn);
    end 
  endtask
endclass
