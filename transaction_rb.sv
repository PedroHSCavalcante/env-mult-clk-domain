class transaction_rb extends uvm_sequence_item;
  rand bit [31:0] data;
  rand bit [31:0] addr;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_param_utils_begin(transaction_rb)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("{data = %d, addr = %d}",data, addr);
  endfunction
endclass