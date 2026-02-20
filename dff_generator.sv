class dff_generator;
  virtual dff_interface vif;
  mailbox #(dff_trans) mbx_drv;
  dff_trans tn;
  
  function new(virtual dff_interface vif,mailbox #(dff_trans) mbx_drv);
    this.vif=vif;
    this.mbx_drv=mbx_drv;
  endfunction
  
  task gen_run();
    forever @(negedge vif.clk) begin
      tn= new();
      
      if(!tn.randomize()) begin
        $display("Random failed");
      end 
      mbx_drv.put(tn);
    end 
  endtask
endclass
