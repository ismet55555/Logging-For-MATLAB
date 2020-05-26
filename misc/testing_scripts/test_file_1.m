% Use this file for various testing if needed

clc
clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adding all parrent directories
addpath('../../.')  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


log = logger();

log.default_level    = 1;
log.show_logger_name = true;
log.log_to_file      = true;
log.show_time        = true;
log.show_ms          = true;

log.show_logging_filename   = true;
log.show_logging_function   = true;
log.show_logging_linenumber = true;

log.clear_log_file()


log.info("OK");
log.warning("OK");
log.fatal("OK");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log2 = logger("SomeName");
log2.show_logger_name = true;
log2.log_to_file      = true;

log2.info("OK");
log2.warning("OK");
log2.fatal("OK");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_file_2;

log.info("OK");
log.warning("OK");
log.fatal("OK");


