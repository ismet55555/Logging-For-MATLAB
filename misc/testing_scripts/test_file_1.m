% Use this file for various testing if needed

clear all
close all
clc

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

log.info("OK");
log.warning("OK");
log.log(3, "OK");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


log2 = logger("SomeName");
log2.show_logger_name = true;

log2.warning("Logger 2")


