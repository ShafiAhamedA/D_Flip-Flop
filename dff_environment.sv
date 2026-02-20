class dff_environment;
  virtual dff_interface vif;
  dff_generator gen;
  dff_driver drv;
  dff_monitor mon;
  dff_scoreboard scb;
  mailbox #(dff_trans) mbx_drv;
  mailbox #(dff_trans) mbx_scb;
  
  function new( virtual dff_interface vif);
    this.vif = vif;
    mbx_drv=new();
    mbx_scb=new();
    gen=new(vif,mbx_drv);
    drv=new(vif,mbx_drv);
    mon=new(vif,mbx_scb);
    scb=new(vif,mbx_scb);
    
  endfunction

  task env_run();    
    fork
      gen.gen_run();
      drv.drv_run();
      mon.mon_run();
      scb.scb_run();
    join_none
  endtask
endclass
