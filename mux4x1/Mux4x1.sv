module MUX4x1(
input [1:0]sel,
input [3:0]x,
output reg y);

always @(*)begin
	case(sel)
	2'b00: y=x[0];
	2'b01: y=x[1];
	2'b10: y=x[2];
	2'b11: y=x[3];
	default: y=x[0];
	endcase
end
endmodule


interface mux_if;
logic [1:0]sel;
logic [3:0]x;
logic y;
endinterface
