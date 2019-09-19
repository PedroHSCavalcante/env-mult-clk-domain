typedef virtual interface_if.mst interface_vif;

class driver extends uvm_driver #(transaction_in);
    `uvm_component_utils(driver)
    interface_vif vif;
    event begin_record, end_record;
    transaction_in tr;
    bit item_done;

    function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction

    task run_phase (uvm_phase phase);

        forever begin
            @(posedge vif.clk) begin

                item_done = 1'b0;

                if(!vif.rst) begin
                    vif.enb_i   <= '0;  
                    vif.dt_i    <= '0;
                    item_done = 0;
                end
                else begin
                    if(tr)begin
                        if(!vif.busy_o) begin
                            @(posedge vif.clk);
                            @(posedge vif.clk);
                            $display("dt_i = ",tr.data);
                            vif.dt_i <= tr.data;
                            vif.enb_i   <= '1;
                            // wait(vif.busy_o === 1);
                            item_done = 1;
                        end
                    end
                end

                if (item_done) begin
                    `uvm_info("ITEM_DONE", $sformatf("Item done."), UVM_HIGH);
                    seq_item_port.item_done();
                end
                if ((item_done || !tr) && vif.rst) begin
                    seq_item_port.try_next_item(tr);
                end
            end
        end
    endtask

endclass