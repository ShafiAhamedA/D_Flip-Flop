class dff_test;
  virtual dff_interface vif;
  dff_environment env;
  
  function new( virtual dff_interface vif);
    env=new(vif);
    this.vif=vif;
  endfunction
  
  task test_run();
    
    env.env_run();
  endtask
endclass
