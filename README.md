<h1 align="center">Logging For MATLAB/Octave :notebook:</h1>

If you have ever wanted a nice message logger for your MATLAB or GNU Octave scripts, well my friend, you may be in luck!

Logger provides a lot of functionalities and flexibility which regular `fprintf()`" or `disp()` commands cannot. Such added funcitonalities include: 
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

* [Compatibility](#thumbsup-compatibility)
    * [Minimum System Requirements](#minimum-system-requirements)
    * [Verified Platforms](#verified-platforms)
* [Installing and Setup](#rocket-installing-and-setup)
* [Usage](#boom-usage)
    * [Image Formats You Can Use](#image-formats-you-can-use)
    * [Adding Images](#adding-images)
        * [Via Physical Flash/USB Drive](#via-physical-flashusb-drive)
        * [Remotely Via scp Command](#remotely-via-scp-command)
        * [Remotely Via ftp Command](#remotely-via-ftp-command)
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
This logger was created and tested on MATLAB R2018b and tailored to GNU Octave 5.20 on a Windows 10 operating system. Although this logger was created within those software versions and operating system, it may work in other environments as well(I would love to hear about usage on earlier versions).




## :rocket: Installing and Setup
1. Download/copy the [`logger.m`](logger.m) file into your working directory
    - You can use the "Clone or Download" button GitHub provides 
    - You can even go to the file here, select it, and copy it into a new script called `logger.m`
2. Create the logger object (more in section XXXXXX)
    - `log = logger()`
3. Use the assigned variable to use the logger
    - `log.info("This is a log message")`
    - `log.warning("This is a warning log message")`
    - *etc*




## :boom: Usage

Some creation examples are as follows:
```matlab
% Creating a logger with the name "My Cool Logger"
log = logger("My Cool Logger")

% Creating a logger that logs messages with the current date, 
% current time, and the line number that send the log
log = logger("Badass Logger", true, true, false, false, true)
```



## :blue_book: Reference Docummentation
### Creation
The following command creats a logger object that is used to log messages
```matlab
log = logger(<logger_name>, <show_date>, <show_time>, <show_logging_filename>, <show_logging_function>, <show_logging_linenumber>, <log_filename>)
```
You then in turn use the `log` variable to execute logging functions (ie. `log.warning("Watch out!")`)
Although all of the creation/constructor logger parameters are optional with default values, you may use any of these in the above creation command.  
**NOTE**: *Note that any of these can be changed anytime after creation.*

| Parmeter | Name                      |      Type      | Optional | Default Value | Description                                        |
|:--------:|---------------------------|:--------------:|:--------:|:-------------:|----------------------------------------------------|
|     1    | `logger_name`             | String or Char |    Yes   |   "Default"   | Name of the logger                                 |
|     2    | `show_date`               |     Boolean    |    Yes   |     false     | Show the current date in a log message             |
|     3    | `show_time`               |     Boolean    |    Yes   |     false     | Show the current time in the log message           |
|     4    | `show_logging_filename`   |     Boolean    |    Yes   |     false     | Show the file where the log message was made       |
|     5    | `show_logging_function`   |     Boolean    |    Yes   |     false     | Show the function where the log message was made   |
|     6    | `show_logging_linenumber` |     Boolean    |    Yes   |     false     | Show the linenumber where the log message was made |






### Methods
Logging Methods
| Method                             |      Parameter Type     | Description                            |
|------------------------------------|:-----------------------:|----------------------------------------|
| `.debug(<Log Message>)`            |      String or Char     | Log a debug level message (Level 1)    |
| `.info(<Log Message>)`             |      String or Char     | Log a info level message (Level 2)     |
| `.warning(<Log Message>)`          |      String or Char     | Log a warning level message (Level 3)  |
| `.error(<Log Message>)`            |      String or Char     | Log a error level message (Level 4)    |
| `.critical(<Log Message>)`         |      String or Char     | Log a critical level message (Level 5) |
| `.fatal(<Log Message>)`            |      String or Char     | Log a fatal level message (Level 6)    |
| `.log(<Log Level>, <Log Message>)` | Integer, String or Char | Log a message with any available level |

Utility Methods
| Method                                   |      Parameter Type     | Description                            |
|------------------------------------------|:-----------------------:|----------------------------------------|
| `.get_logger_levels()`                   |            -            | List the available logging levels      |
| `.time_the_logger(<Number of Messages>)` |         Integer         | Performance/Timing test for the logger |
| `.clear_log_file()`                      |            -            | Clear log file for this logger         |
| `.delete_log_file()`                     |            -            | Delete log file for this logger        |


### Properties

Properties related to displayed log message information and formatting
| Parameter                  |      Type      |      Default      | Description                                           |
|----------------------------|:--------------:|:-----------------:|-------------------------------------------------------|
| `.show_logger_name`        |     Boolean    |       false       | Show the name of the logger in the log message        |
| `.show_date`               |     Boolean    |       false       | Show the current date in a log message                |
| `.show_time`               |     Boolean    |       false       | Show the current time in the log message              |
| `.show_ms`                 |     Boolean    |       false       | Show milliseconds in log message                      |
| `.show_logging_filename`   |     Boolean    |       false       | Show the file name where the log message was logged   |
| `.show_logging_function`   |     Boolean    |       false       | Show the function where the log message was logged    |
| `.show_logging_linenumber` |     Boolean    |       false       | Show the line number where the log message was logged |

Properties related to logger behavior
| Parameter                  |      Type      |      Default      | Description                                           |
|----------------------------|:--------------:|:-----------------:|-------------------------------------------------------|
| `.description`             | String or Char |    Some filler    | Custom description of the logger object instance      |
| `.default_level`           |     Integer    |         2         | Lowest log level to be logged                         |
| `.log_to_command_window`   |     Boolean    |        true       | Show the log messages in the command window           |
| `.log_to_file`             |     Boolean    |       false       | Save log messages to the log file                     |
| `.enabled`                 |     Boolean    |        true       | Enable or disable the logger                          |
| `.log_directory`           | String or Char |       *pwd*       | Directory where log file will be saved                |
| `.log_filename`            | String or Char | <logger_name>.log | File name into which the logs will be saved           |


## :clock5: A Note on Performance and Speed
TODO ...


## :bust_in_silhouette: Author
**Ismet Handžić** - Github: [@ismet55555](https://github.com/ismet55555)


## Licence
This project is licensed under the MIT License (FIXXXX MEE) - see the [LICENSE.md](LICENSE.md) file for details
