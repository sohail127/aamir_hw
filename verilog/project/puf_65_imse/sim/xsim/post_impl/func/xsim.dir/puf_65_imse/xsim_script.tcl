set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {puf_65_imse} -wdb {simulate_xsim.wdb} -view {{simulate_xsim.wcfg}}
