<h1 align="center">Logger For MATLAB/Octave :notebook:</h1>

If you have ever wanted a nice message logger for your MATLAB or GNU Octave scripts, well my friend, you may be in luck!

Logger ([`logger.m`](logger.m)) provides a lot of functionalities and flexibility which regular `fprintf()` or `disp()` commands cannot. Such added funcitonalities include: 
* Specifiying log message urgency levels
* Log message formatting (red color, bold font)
* Setting a default urgency level
* Logging to a log file
* Logging accross multiple files
* and more ...

Logger was inspired by phython's `logging` package.


### Very Basically ...
1. Every time you want to log/show/save a message in the command window or in a file, you can do that with this logger.
2. The logger can display a message with different levels such as `debug`, `error`, or `fatal`.
3. There are many other things this logger can do, that a simple `fprintf()` command cannot.


## :eyeglasses: Overview

* [Quick Start](#fast_forward-quick-start)
* [Compatibility](#thumbsup-compatibility)
* [Installing and Setup](#rocket-installing-and-setup)
* [Usage](#boom-usage)
    * [Logging](#logging)
    * [Changing Default Log Level](#changing-default-log-level)
    * [Logging Within a Script](#logging-within-a-script)
    * [Logging Accross Functions](#logging-accross-functions)
    * [Logging Accross Files](#logging-accross-files)
    * [Using Multiple Loggers](#using-multiple-loggers)
* [Reference Docummentation](#blue_book-reference-docummentation)
    * [Log Levels](#log-levels)
    * [Creation](#creation)
    * [Methods](#methods)
    * [Properties](#properties)
* [Notes on Performance and Speed](#clock5-notes-on-performance-and-speed)
* [Author](#bust_in_silhouette-author)
* [Licence](#licence)


## :fast_forward: Quick Start
```matlab
% Creating a logger
log = logger();

% Setting some logger options
log.show_time = true;
log.show_ms = true;

% Logging some Messages
log.info("Hello sweet sweet world!")
log.warning("Hey watch out! A bus!")
log.fatal("Goodbye, crewl crewl world ...")
```
**Command Window Output**
```
[23:38:58.619][INFO    ] : Hello sweet sweet world!
[23:38:58.671][WARNING ] : Hey watch out! A bus!
[23:38:58.681][FATAL   ] : Goodbye, crewl crewl world ...
```
**NOTE**: *The warning log message is in red color. The fatal log message is red color and bold*


## :thumbsup: Compatibility
This logger was created and tested on MATLAB R2018b and tailored to GNU Octave 5.20 on a Windows 10 operating system. Although this logger was created within those software versions and operating system, it may work in other environments as well.

I would love to hear about usage on earlier versions and other operating systems.




## :rocket: Installing and Setup
1. Download/copy the [`logger.m`](logger.m) file into your working directory
    - **Git:** Use the ol' git to clone the repo onto your computer
    - **Download:** Use the "**Clone or Download**" button GitHub provides to download this entire repo as a .zip file
    - **Save As:** Right click on this link, [`logger.m`](logger.m), and "**Save Link As ...**"
    - **Copy/Paste:** Visit [`logger.m`](logger.m), and copy/paste all code into a new .m file script called `logger.m`
2. In your script, create the logger object and store it in a variable 
    - `log = logger()`
    - *Please don't use `logger = logger()`*
3. Use the assigned variable to use the logger
    - `log.info("This is a log message")`
    - `log.warning("This is a warning log message")`
    - *etc*




## :boom: Usage

### Logging
Obviously logging messages is the most fundemental thing to this logger thing. There are two different ways to log a message with a specific log level.
1. Use the predefined logging methods that coorespond to the specific logging level
    ```matlab
    % Create a logger
    log = logger();
    log.default_level = 1;
    
    % Log messages with different log levels
    log.debug("This is a debug level message");
    log.info("This is a info level message");
    log.warning("This is a warning level message");
    log.error("This is a error level message");
    log.critical("This is a critical level message");
    log.fatal("This is a fatal level message");
    ```
    **Command Window Output**
    ```
    [INFO    ] : This is a info level message
    [WARNING ] : This is a warning level message
    [ERROR   ] : This is a error level message
    [CRITICAL] : This is a critical level message
    [FATAL   ] : This is a fatal level message
    ```

2. Use the `.log()` method to specify a log level using an integer instead of the name of the log level
    ```matlab
    % Create a logger
    log = logger();
    log.default_level = 1;
    
    % Log messages with different log levels
    log.log(1, "This is a debug level message");
    log.log(2, "This is a info level message");
    log.log(3, "This is a warning level message");
    log.log(4, "This is a error level message");
    log.log(5, "This is a critical level message");
    log.log(6, "This is a fatal level message");
    ```
    **Command Window Output**
    ```
    [INFO    ] : This is a info level message
    [WARNING ] : This is a warning level message
    [ERROR   ] : This is a error level message
    [CRITICAL] : This is a critical level message
    [FATAL   ] : This is a fatal level message
    ```


### Changing Default Log Level
Default log level means the lowest log level which the logger will display and safe to file. For example, if the default log level of a logger is set to 3 (warning), that logger will only print out and safe logs that are at level 3 (warning) or above.

Changing the default log level comes in handy when, for example, you create a few debug (level 1) level logs to troubleshoot your code in key places and would like to turn these debug messages on and off depending if you are troubleshooting or not. This turning on and off can be easily done by setting the log level from 1 (debug) to 2 (info) or vice versa.

You can change default log level by using the `.default_level` logger property, which takes a positive integer. Note that you can display all log levels and see the default log level using the `.get_logger_levels()` method.

The following is an example of chanign a default log level for a logger.
```matlab
% Creating the logger
log = logger();

% Logging a info and warning log
log.info("This is an info log message");
log.warning("This is a warning log message");

% Changing the default log level for logger to level 3 (warning);
log.default_level = 3;

% Logging the same info and warning log
log.info("This is an info log message");      % <-- Will not be displayed
log.warning("This is a warning log message");
```
**Command Window Output**
```
[INFO    ] : This is an info log message
[WARNING ] : This is a warning log message
[WARNING ] : This is a warning log message
```


### Logging Within a Script
Using the logger within the same script file is fairly straightforward.
```matlab
% Creating a logger object with default options and assigning to a variable
log = logger();

% Logging a message
log.info("This a logging message");
```


### Logging Accross Functions
If you want to use the same logger accross multiple different functions within the same script, you can do as follows:
1. Pass the logger object variable into the function
    ```matlab
    log = logger();
    log.info("This is a logging message");
    someFunction(log);
    
    function someFunction(log)
        log.info("Logging a message inside this function with same logger");
    end
    ```
2. Declare the logger object variable a `global` variable
    ```matlab
    global log
    log = logger();
    log.info("This is a logging message");
    someFunction();
    
    function someFunction()
        global log;
        log.info("Logging a message inside this function with sameN logger");
    end
    ```
3. Create another logger with the exact same logger name. The logger is smart enough to combine duplicate logger names into one single logger group.
    ```matlab
    log = logger("Nice Logger");
    log.info("This is a logging message");
    someFunction();
    
    function someFunction()
        log = logger("Nice Logger");
        log.info("Logging a message inside this function with same logger");
    end
    ```

### Logging Accross Files
Logging accross different files is done the exact same as logging accross different functions. See the previous section for the different ways and details.  For example, this shows method 3:

`firstFile.m`
```matlab
log = logger("Nice Logger");
log.info("This a logging message");
secondFile;
```

`secondFile.m`
```matlab
log = logger("Nice Logger");
log.info("Logging a message inside this function with same logger");
```

## Using Multiple Loggers
You can assign different loggers for different purposes. For example, let's say you would like one logger to log all things related to one part of the program like maybe the data aquisition, while another logger logs all messages related to the graphical interface of the program. 

In this case you can specify that each logger has its own message formatting and each logger saves its messages into seperate log files. In such a case you would also be able to seperately enable and disable each logger if needed.

Here is a short example of using two loggers in the same script.

```matlab
% Creating a default logger for general program logs
logDefault = logger();
logDefault.show_date = true;
logDefault.log_to_file = true;

% Creating a logger for any data acquisition (DAQ)
logDAQ = logger("DAQ");
logDAQ.show_time = true;
logDAQ.show_ms = true;
logDAQ.log_to_file = true;

logDefault.info("Program start ...");

logDAQ.info("Starting data acquisition ..."")
for i = 1 : 1000
    try
        logDAQ.info(sprintf("Measuring data point number %i", i);
        % Code for data acquisition (DAQ) here ..
    catch
        logDAQ.error("Failed to read data point");
    end
end
logDAQ.info("Data acquisition has completed");

logDefault.info("Program ended");
```






## :blue_book: Reference Docummentation
## Log Levels
The following are the only available log levels for the logger. Each integer cooresponds to a log level. You can display all log levels and see the default log level using the `.get_logger_levels()` method.

| Level | Name       | Typical Usage                                                    |
|-------|------------|------------------------------------------------------------------|
| 1     | `DEBUG`    | Diagnostic and fine-grained troubleshooting                      |
| 2     | `INFO`     | Normal program behavior                                          |
| 3     | `WARNING`  | Notification of potential error, but program is still ok         |
| 4     | `ERROR`    | Serious issue, reguires attention, may allow program to continue |
| 5     | `CRITICAL` | Issue will lead to a termination of the program                  |
| 6     | `FATAL`    | Catastrophic, severe, irrecoverable situation                    |


### Creation
The following command creats a logger object that is used to log messages
```matlab
log = logger(<logger_name>, <show_date>, <show_time>, <show_logging_filename>, <show_logging_function>, <show_logging_linenumber>, <log_filename>)
```
You then in turn use the `log` variable to execute logging functions (ie. `log.warning("Watch out!")`)

**IMPORTANT**: *Do not use `logger` as your variable (ie. `logger = logger()`).*

Although all of the creation/constructor logger parameters are optional with default values, you may use any of these constructor parameters in the above creation command. **Note that any of these can be changed anytime after creation.**

| Parmeter | Name                      |      Type      | Optional | Default Value | Description                                        |
|:--------:|---------------------------|:--------------:|:--------:|:-------------:|----------------------------------------------------|
|     1    | `logger_name`             | String or Char |    Yes   |   "Default"   | Name of the logger                                 |
|     2    | `show_date`               |     Boolean    |    Yes   |     false     | Show the current date in a log message             |
|     3    | `show_time`               |     Boolean    |    Yes   |     false     | Show the current time in the log message           |
|     4    | `show_logging_filename`   |     Boolean    |    Yes   |     false     | Show the file where the log message was made       |
|     5    | `show_logging_function`   |     Boolean    |    Yes   |     false     | Show the function where the log message was made   |
|     6    | `show_logging_linenumber` |     Boolean    |    Yes   |     false     | Show the linenumber where the log message was made |

**Creation Example**
```matlab
% Creating a logger that logs messages with the current date, 
% current time, and the line number that send the log

log = logger("Badass Logger", true, true, false, false, true)
```



### Methods

**Logging Methods**

| Method                             |      Parameter Type     | Description                            |
|------------------------------------|:-----------------------:|----------------------------------------|
| `.debug(<Log Message>)`            |      String or Char     | Log a debug level message (Level 1)    |
| `.info(<Log Message>)`             |      String or Char     | Log a info level message (Level 2)     |
| `.warning(<Log Message>)`          |      String or Char     | Log a warning level message (Level 3)  |
| `.error(<Log Message>)`            |      String or Char     | Log a error level message (Level 4)    |
| `.critical(<Log Message>)`         |      String or Char     | Log a critical level message (Level 5) |
| `.fatal(<Log Message>)`            |      String or Char     | Log a fatal level message (Level 6)    |
| `.log(<Log Level>, <Log Message>)` | Integer, String or Char | Log a message with any available level |

**Utility Methods**

| Method                                   |      Parameter Type     | Description                            |
|------------------------------------------|:-----------------------:|----------------------------------------|
| `.get_logger_levels()`                   |            -            | List the available logging levels      |
| `.time_the_logger(<Number of Messages>)` |         Integer         | Performance/Timing test for the logger |
| `.clear_log_file()`                      |            -            | Clear log file for this logger         |
| `.delete_log_file()`                     |            -            | Delete log file for this logger        |


### Properties

**Message Information and Formatting**

| Parameter                  |      Type      |      Default      | Description                                           |
|----------------------------|:--------------:|:-----------------:|-------------------------------------------------------|
| `.show_logger_name`        |     Boolean    |       false       | Show the name of the logger in the log message        |
| `.show_date`               |     Boolean    |       false       | Show the current date in a log message                |
| `.show_time`               |     Boolean    |       false       | Show the current time in the log message              |
| `.show_ms`                 |     Boolean    |       false       | Show milliseconds in log message                      |
| `.show_logging_filename`   |     Boolean    |       false       | Show the file name where the log message was logged   |
| `.show_logging_function`   |     Boolean    |       false       | Show the function where the log message was logged    |
| `.show_logging_linenumber` |     Boolean    |       false       | Show the line number where the log message was logged |

**Logger Behavior**

| Parameter                  |      Type      |      Default      | Description                                           |
|----------------------------|:--------------:|:-----------------:|-------------------------------------------------------|
| `.description`             | String or Char |    Some filler    | Custom description of the logger object instance      |
| `.default_level`           |     Integer    |         2         | Lowest log level to be logged                         |
| `.log_to_command_window`   |     Boolean    |        true       | Show the log messages in the command window           |
| `.log_to_file`             |     Boolean    |       false       | Save log messages to the log file                     |
| `.enabled`                 |     Boolean    |        true       | Enable or disable the logger                          |
| `.log_directory`           | String or Char |       *pwd*       | Directory where log file will be saved                |
| `.log_filename`            | String or Char | <logger_name>.log | File name into which the logs will be saved           |


## :clock5: Notes on Performance and Speed
- Understand that the time duration per log may vary with the following logger settings.
    - *Logging formatting additions* - A logger that only shows the logger name will be very slightly faster than a logger displaying the name, date, time, and/or line number.
    - *Logging to file* - Currently logging to file is slower than only loggering to the command window.
    - *Logging to command window* - Obviously if nothing is printed out, it will be faster.
- Remember that there is a `.time_the_logger()` method that you can use to measure the current logger settings and compare them to a simple `frpintf()` command.
- Using simple "disp()" and "fprintf()" is faster than using this logger. However logger gives you lots of convenient ability and flexibility in return.

---
## :bust_in_silhouette: Author
**Ismet Handžić** - Github: [@ismet55555](https://github.com/ismet55555)


## Licence
This project is licensed under the Apache 2.0 - Please see the [LICENSE.md](LICENSE.md) file for details.
