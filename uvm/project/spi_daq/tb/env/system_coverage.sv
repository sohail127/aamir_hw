`ifndef SYSTEM_COVERAGE_SV
`define SYSTEM_COVERAGE_SV

class system_coverage extends uvm_subscriber #(spi_seq_item);
  `uvm_component_utils(system_coverage)

  uvm_analysis_export #(spi_seq_item) sensor_export[3];
  uvm_analysis_export #(spi_seq_item) flash_export;

  int sensor_transaction_count[3];
  int flash_transaction_count;
  int total_sensor_transactions;
  int max_sensor_transactions;

  // Coverage groups
  covergroup system_cg;
    SENSOR_ACTIVITY: coverpoint total_sensor_transactions {
      bins no_activity = {0};
      bins low_activity = {[1:10]};
      bins medium_activity = {[11:50]};
      bins high_activity = {[51:$]};
    }

    FLASH_WRITES: coverpoint flash_transaction_count {
      bins no_writes = {0};
      bins few_writes = {[1:5]};
      bins many_writes = {[6:$]};
    }

    SENSOR_DISTRIBUTION: coverpoint max_sensor_transactions {
      bins single_sensor_dominant = {[total_sensor_transactions*2/3+1:$]};
      bins two_sensors_dominant = {[total_sensor_transactions/3+1:total_sensor_transactions*2/3]};
      bins all_sensors_active = {[1:total_sensor_transactions/3]};
    }

    CONCURRENT_ACTIVITY: cross SENSOR_ACTIVITY, FLASH_WRITES;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    system_cg = new();
    foreach (sensor_export[i]) begin
      sensor_export[i] = new($sformatf("sensor_export[%0d]", i), this);
    end
    flash_export = new("flash_export", this);
    foreach (sensor_transaction_count[i]) begin
      sensor_transaction_count[i] = 0;
    end
    flash_transaction_count = 0;
    total_sensor_transactions = 0;
    max_sensor_transactions = 0;
  endfunction

  function void write(spi_seq_item t);
    if (t.is_flash_transaction) begin
      flash_transaction_count++;
    end else begin
      foreach (sensor_transaction_count[i]) begin
        if (t.sensor_id == i) begin
          sensor_transaction_count[i]++;
          total_sensor_transactions++;
          if (sensor_transaction_count[i] > max_sensor_transactions) begin
            max_sensor_transactions = sensor_transaction_count[i];
          end
          break;
        end
      end
    end
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    system_cg.sample();
  endfunction
endclass
`endif // SYSTEM_COVERAGE_SV
