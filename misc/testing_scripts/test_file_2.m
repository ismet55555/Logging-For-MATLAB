
global log3
log3 = logger();

log3.info("OK");
log3.warning("OK");
log3.fatal("OK");

testFunction()


function testFunction()
    global log3
    
    log3.info("OK");
    log3.warning("OK");
    log3.fatal("OK");
end