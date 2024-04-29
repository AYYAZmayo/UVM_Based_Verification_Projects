class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	function new(string name ="monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual uart_if vif;
	uvm_analysis_port#(transaction) send;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		send=new("send",this);
		if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif))
			`uvm_error("monitor","Config access failed");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.clk);
			if (vif.rst)begin
				tr.rst=vif.rst;
				`uvm_info("monitor",$sformatf(" RESET DETECTED: Baud = %0d, length = %0d, tx_data = %0d, tx_start = %0d, rx_sart = %0d, party_en =%0d, parity_type =%0d, stop2 =%0d,tx_err=%0d, rx_err=%0d,rx_out=%0d",
										tr.baud,tr.length,tr.tx_data, tr.tx_start, tr.rx_start, tr.parity_en,tr.parity_type, tr.stop2,tr.tx_err,tr.rx_err,tr.rx_out),UVM_NONE);
				send.write(tr);
			end
			else begin
				tr.rst=vif.rst;
				tr.tx_start=vif.tx_start;
				tr.rx_start=vif.rx_start;
				tr.baud=vif.baud;
				tr.length=vif.length;
				tr.parity_en=vif.parity_en;
				tr.parity_type=vif.parity_type;
				tr.stop2=vif.stop2;
				tr.tx_data=vif.tx_data;
				@(posedge vif.tx_done);
				tr.tx_err=vif.tx_err;
				@(negedge vif.rx_done);
				tr.rx_out=vif.rx_out;
				`uvm_info("monitor",$sformatf("Baud = %0d, length = %0d, tx_data = %0d, tx_start = %0d, rx_sart = %0d, party_en =%0d, parity_type =%0d, stop2 =%0d,tx_err=%0d, rx_err=%0d,rx_out=%0d",
										tr.baud,tr.length,tr.tx_data, tr.tx_start, tr.rx_start, tr.parity_en,tr.parity_type, tr.stop2,tr.tx_err,tr.rx_err,tr.rx_out),UVM_NONE);
				send.write(tr);
			end
		end
    endtask
endclass
///////////////////////////////////////////////////////////////////////////////////////
