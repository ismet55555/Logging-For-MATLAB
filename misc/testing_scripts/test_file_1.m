% Use this file for various testing if needed

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adding all parrent directories
addpath('../../.')  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log = logger();
log.show_logger_name = true;
log.info("OK")


log2 = logger("BLAH");
log2.warning("ok")



log3 = logger("BLAH");
log3.info('ok')
