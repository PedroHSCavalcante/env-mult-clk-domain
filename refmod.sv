import "DPI-C" context function int my_sqrt(int x);

class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    transaction_in tr_in;
    transaction_out tr_out;
    
    uvm_analysis_imp #(transaction_in, refmod) in;
    uvm_analysis_port #(transaction_out) out;
    
    event begin_refmodtask;

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = transaction_out::type_id::create("tr_out", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @begin_refmodtask;
            tr_out = transaction_out::type_id::create("tr_out", this);
            tr_out.result = my_sqrt(tr_in.data);
            out.write(tr_out);
        end
    endtask: run_phase

    virtual function write (transaction_in t);
        tr_in = transaction_in#()::type_id::create("tr_in", this);
        tr_in.copy(t);
       -> begin_refmodtask;
    endfunction
endclass: refmod