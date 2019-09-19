class transaction_in extends uvm_sequence_item;
  rand bit [7:0] A;
  rand bit [1:0] instru;
  rand bit [1:0] reg_sel;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_param_utils_begin(transaction_in)
    `uvm_field_int(A, UVM_ALL_ON)
    `uvm_field_int(instru, UVM_ALL_ON)
    `uvm_field_int(reg_sel, UVM_ALL_ON)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("{A = %d, intru = %d, reg_sel = %d}",A, instru, reg_sel);
  endfunction
endclass