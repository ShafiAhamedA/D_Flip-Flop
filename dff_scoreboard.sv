class dff_scoreboard;
  virtual dff_interface vif;
  dff_trans tn;
  mailbox #(dff_trans) mbx_scb;
  logic [16:0] exp_dout;
  
  function new(virtual dff_interface vif,mailbox #(dff_trans) mbx_scb);
    this.mbx_scb = mbx_scb;
    this.vif = vif;
  endfunction
  
  task exp_operation();
    if(tn.rst) begin 
      exp_dout<=16'd0;
    end 
    else begin
      exp_dout<=tn.din;
    end
  endtask
    
    task scb_run();
      forever begin
      	mbx_scb.get(tn);
      	exp_operation();
      
        if(vif.rst == 1 && tn.dout !=0) begin
          $display("Reset test failed");
        end
        else begin
          if(exp_dout !=tn.dout)begin
            $error("dout mismatch: time=%0d,clk=%0d,rst=%0d,din=%0d,dout=%0d,exp_dout=%0d",$time,vif.clk,tn.rst,tn.din,tn.dout,exp_dout);
          end
          else begin
            $display("dout passed: time=%0d,clk=%0d,rst=%0d,din=%0d,dout=%0d,exp_dout=%0d",$time,vif.clk,tn.rst,tn.din,tn.dout,exp_dout);
          end
        end
      end
    endtask
endclass
