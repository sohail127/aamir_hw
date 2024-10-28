`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

// Define the analysis_imp types
`uvm_analysis_imp_decl(_sensor0)
`uvm_analysis_imp_decl(_sensor1)
`uvm_analysis_imp_decl(_sensor2)
`uvm_analysis_imp_decl(_flash)

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp_sensor0#(spi_seq_item, scoreboard) sensor_fifo0;
  uvm_analysis_imp_sensor1#(spi_seq_item, scoreboard) sensor_fifo1;
  uvm_analysis_imp_sensor2#(spi_seq_item, scoreboard) sensor_fifo2;
  uvm_analysis_imp_flash#(spi_seq_item, scoreboard) flash_fifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sensor_fifo0 = new("sensor_fifo0", this);
    sensor_fifo1 = new("sensor_fifo1", this);
    sensor_fifo2 = new("sensor_fifo2", this);
    flash_fifo = new("flash_fifo", this);
  endfunction

  // Write functions for each sensor
  function void write_sensor0(spi_seq_item item);
    write_sensor(item, 0);
  endfunction

  function void write_sensor1(spi_seq_item item);
    write_sensor(item, 1);
  endfunction

  function void write_sensor2(spi_seq_item item);
    write_sensor(item, 2);
  endfunction

  // Write function for flash
  function void write_flash(spi_seq_item item);
    $display("Received flash data: %p", item.data);
    // Implement flash data checking logic here
  endfunction

  // Helper function for sensor data
  function void write_sensor(spi_seq_item item, int sensor_id);
    $display("Received sensor data from sensor %0d: %p", sensor_id, item.data);
    // Implement sensor data checking logic here
  endfunction

endclass

`endif // SCOREBOARD_SV
