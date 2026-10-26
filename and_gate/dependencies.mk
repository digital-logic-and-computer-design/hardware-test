# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies
#    (Use \ at the end of the line for line continuation)
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  Ice40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream
#    *.edit: Open the preceeding file for editing
#    *.riscv-sim: Simulate the file (using launch.json view; Must config launch.json)
# A line preceeding a target that starts with a comment can "ovverride" the type of target or the label used in the task
#   With either/both label="..." or type="..." (Types include a dot for the extension, like .edit or .rtl.json)
#   A type of "edit" can be used to open the file in code.



# label="1.1 Simulate and_gate.sv"
products/and_gate.rtl.json: \
	and_gate.sv \

# label="1.2 Edit and_gate.sv" type=".edit"
and_gate.sv.edit:


# label="1.3 and_gate testbench verification"
products/and_gate_tb.vcd: \
	and_gate.sv \
	and_gate_tb.sv

# label="1.4 and_gate iCE40 bitstream"
products/and_gate.bin: \
	and_gate.sv \
	top.sv \
	ledandkey.sv \
	pins.pcf
