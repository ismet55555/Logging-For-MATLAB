classdef (ConstructOnLoad = false) logger < handle
    %LOGGER  Logger object that handles any command window or file logging.
    %
    %   Logger provides a lot of functionalities and flexibility which 
    %   a regular "fprintf" or "disp" message cannot such as log message 
    %   formatting, logging to file, or specifiying logging levels to be 
    %   displayed. 
    %
    %   Keep on logging on!
    %
    %
    %
    %   CREATION
    %         log = LOGGER(logger_name, ...             (string  - Optional - Default Value: "Default")
    %                      show_date, ...               (boolean - Optional - Default Value: false    )
    %                      show_time, ...               (boolean - Optional - Default Value: false    )
    %                      show_logging_filename, ...   (boolean - Optional - Default Value: false    )
    %                      show_logging_function, ...   (boolean - Optional - Default Value: false    )
    %                      show_logging_linenumber, ... (boolean - Optional - Default Value: false    )
    %                      log_filename)                (string  - Optional - Default Value: false    )
    %
    %         logger_name             - Name the logger (useful when using seperate loggers)
    %         show_date               - Show the date in a log message
    %         show_time               - Show the current time in the log message
    %         show_logging_filename   - Show the file where the log message was made
    %         show_logging_function   - Show the function where the log message was made
    %         show_logging_linenumber - Show the linenumber where the log message was made
    %         log_filename            - Use a specific log filename (.log)
    %
    %
    %
    %   METHODS
    %         LOGGER.get_logger_levels()  -  List the available logging levels
    %         LOGGER.time_the_logger(n)   -  Perform a performance test for the logger, logging n number of logs
    %
    %         LOGGER.debug()              -  Log a debug level message
    %         LOGGER.info()               -  Log a info level message
    %         LOGGER.warning()            -  Log a warning level message
    %         LOGGER.error()              -  Log a error level message
    %         LOGGER.critical()           -  Log a critical level message
    %         LOGGER.fatal()              -  Log a fatal level message
    %
    %         LOGGER.log()                -  Log any log level using integers (ie. 3 instead of warning)
    %
    %         LOGGER.clear_log_file()     -  Clears an existing log file
    %         LOGGER.delete_log_file()    -  Deletes an existing log file
    %
    %
    %
    %   PROPERTIES
    %         LOGGER.description             - (string)  - Custom description of the logger object instance
    %         LOGGER.default_level           - (integer) - Lowest log level to be displayed
    %
    %         LOGGER.show_logger_name        - (boolean) - Show the name of the logger in the log message
    %         LOGGER.show_date               - (boolean) - Show the date in a log message
    %         LOGGER.show_time               - (boolean) - Show the current time in the log message
    %         LOGGER.show_ms                 - (boolean) - Show the file where the log message was made
    %         LOGGER.show_logging_filename   - (boolean) - Show the function where the log message was made
    %         LOGGER.show_logging_function   - (boolean) - Show the linenumber where the log message was made
    %         LOGGER.show_logging_linenumber - (boolean) - Show the linenumber where the log message was made
    %                 
    %         LOGGER.log_to_command_window   - (boolean) - Show the log messages command window
    %         LOGGER.log_to_file             - (boolean) - Save log messages to log file
    %         LOGGER.enabled                 - (boolean) - Enable or disable the logger
    %         LOGGER.log_directory           - (string)  - Directory where log file will be saved
    %         LOGGER.log_filename            - (string)  - Custom filename where log will be saved
    %   
    %
    %   DISTRIBUTED LOGGER USAGE
    %       - The same LOGGER can be used in many different scopes such as
    %         different functions or files.  The ways of doing that include:
    %
    %           1. Pass the logger object variable around just like any
    %              other variable.
    %
    %                   log = LOGGER()    
    %                   log.info("Logging a message")
    %                   someFunction(log)   
    %
    %                   function someFunction(log)
    %                       log.info("Logging a message inside this function")
    %                   end
    %
    %           2. Make the LOGGER a global variable that is available to
    %              the funcitons within a file. Remember to "global" the logger
    %              again at any new function you are using it.
    %
    %                   global log
    %                   log = LOGGER()
    %
    %                   function someFunction()
    %                      global log
    %                      log.info("This is some log message")
    %                   end
    %
    %           3. Simply create another LOGGER with the same name or
    %              default name.  The logger manager will sync all loggers
    %              with the same name, acting as one big distributed
    %              logger.
    %       
    %                   File 1:
    %                       log = LOGGER("Cool Logger")
    %                       log.info("Logging some message")
    %
    %                   File 2:
    %                       log = LOGGER("Cool Logger")
    %                       log.info("This is another message using the same logger")
    %
    %
    %
    %   NOTES
    %       - Please do not name your LOGGER object "logger". That will make
    %         lots of wasted time scratching your head and pulling your hair :)
    %
    %       - As of now, you must use a different log variable when using the
    %         same LOGGER accross different files and functions with "global". 
    %         Example:
    %                   File 1:
    %                       log = LOGGER("Cool Logger")
    %                       log.info("Logging some message")
    %
    %                   File 2:
    %                       global log2                      <-- NOTE "log2" not "log"
    %                       log2 = LOGGER("Cool Logger")
    %                       log2.info("This is another message using the same logger")
    %
    %                       function someFunction()
    %                           global log2
    %                           log2.info("Another message using the same logger")
    %                       end
    %
    %       - Simultanously logging messages to both command window and file is 
    %         slower than just logging to command window. To measure yourself, use 
    %         "log.time_the_logger(n)" method.
    %
    %       - Using simple "disp()" and "fprintf()" is faster than using LOGGER.
    %         However LOGGER gives you lots of ability and flexibility in
    %         return.
    %
    %       - You can create multiple LOGGER for multiple functions and events.
    %
    %           main_log = LOGGER("Main")
    %           cool_log = LOGGER("Cool")
    %
    %
    %
    %	EXAMPLES
    %       Creating a logger:                  log = LOGGER()
    %
    %       Show the time in log:               log.show_time = true
    %       Show milliseconds:                  log.show_ms = true
    %
    %       Output all logging levels:          log.get_log_levels
    %       Change default level to debug:      log.default_level = 1
    %
    %       Logging a message:                  log.info("Cool stuff!")
    %       Logging an error:                   log.error("Trouble!")
    %       Log a warning with integer:         log.log(3, "Watch out!")
    %
    %       Time logger performance:            log.time_the_logger(10000)
    

    properties (SetAccess = public)
        description   = "This is a logger object. Feel free to change this description!";
        default_level = 2;

        show_logger_name        = false;
        show_date               = false;
        show_time               = false;
        show_ms                 = false;
        show_logging_filename   = false;
        show_logging_function   = false;
        show_logging_linenumber = false;   
                
        log_to_command_window = true;
        log_to_file           = false;
        enabled               = true;
        
        log_directory = pwd;
        log_filename  = "Filename_TBD.log";  
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    properties (SetAccess = protected, Hidden = true)
        pause_sync_notifier   = false;
        
        name                 = "Default";
        object_ID            = randi(999999999);
        
        object_creation_file     = []
        object_creation_function = []  % TODO:  Also check function in log manager
        
        log_level_labels  = ["DEBUG"; "INFO"; "WARNING"; "ERROR"; "CRITICAL"; "FATAL"]
        bold_font_level   = 6;

        caller_filename   = "";
        caller_function   = "";
        caller_linenumber = -1;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    properties (Constant, Hidden = true)
        logger_props = ["description";
                        "default_level";
                        "show_logger_name";
                        "show_date";
                        "show_time";
                        "show_ms";
                        "show_logging_filename";
                        "show_logging_function";
                        "show_logging_linenumber";
                        "log_to_command_window";
                        "log_to_file";
                        "enabled";
                        "log_directory";
                        "log_filename"]
                    
    	unique_logger_props = ["object_ID"; 
                               "object_creation_file"; 
                               "object_creation_function"];
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Events that can be triggered by object
    events (ListenAccess = protected, NotifyAccess = protected, Hidden = true)
       SyncLoggers 
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    methods
        function obj = logger(logger_name, ...
                              show_date, ...
                              show_time, ...
                              show_logging_filename, ...
                              show_logging_function, ...
                              show_logging_linenumber, ...
                              log_filename)
        % Object constructor for logger object
        % This method runs when the object is being created into memory
                          
            % Check number of input arguments
            switch nargin
                case 1
                    obj.name = logger_name;
                case 2
                    obj.name      = logger_name;
                    obj.show_date = show_date;
                case 3
                    obj.name      = logger_name;
                    obj.show_date = show_date;
                    obj.show_time = show_time;
                case 4
                    obj.name                  = logger_name;
                    obj.show_date             = show_date;
                    obj.show_time             = show_time;
                    obj.show_logging_filename = show_logging_filename;
                case 5
                    obj.name                  = logger_name;
                    obj.show_date             = show_date;
                    obj.show_time             = show_time;
                    obj.show_logging_filename = show_logging_filename;
                    obj.show_logging_function = show_logging_function;
                case 6
                    obj.name                    = logger_name;
                    obj.show_date               = show_date;
                    obj.show_time               = show_time;
                    obj.show_logging_filename   = show_logging_filename;
                    obj.show_logging_function   = show_logging_function;
                    obj.show_logging_linenumber = show_logging_linenumber;
                case 7
                    obj.name                    = logger_name;
                    obj.show_date               = show_date;
                    obj.show_time               = show_time;
                    obj.show_logging_filename   = show_logging_filename;
                    obj.show_logging_function   = show_logging_function;
                    obj.show_logging_linenumber = show_logging_linenumber;
                    obj.log_filename            = log_filename;
            end
            
            % Storing the m-file that created the logger object
            % TODO: Error from command line, index 2 will give error
            caller_stack                 = dbstack;
            obj.object_creation_file     = string(caller_stack(2).file);
            obj.object_creation_function = string(caller_stack(2).name);
            
            % Rename the log file (TODO: MOVE TO LOG MANAGER!)
            filename = strrep(obj.name, " ", "_");
            obj.log_filename  = strcat(filename, ".log");           
            
            % Add the logger object to the logger manager list
            % If the same name logger exists, sync it to existing ones
            [~, obj] = obj.logger_manager(obj, "add");  
                        
            % Craete a listener for a logger sync event
            % When "SyncLoggers" event is triggered, "sync_loggers()" is exectued
            addlistener(obj, 'SyncLoggers', @sync_loggers);
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        

        function delete(obj, print_out)
            % Object destructor for logger object
            % This method runs when the object is being deleted from memory
            if print_out
                obj.fatal(sprintf("Deleting logger '%s' ...", obj.name));
            end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        

        function set.description(obj, value)
            obj.verify_type(obj, value, ["string"; "char"]);
            obj.description = value;            % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.default_level(obj, value)
            obj.verify_type(obj, value, ["double"]);
            obj.default_level = value;          % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_logger_name(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.show_logger_name = value;       % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_date(obj, value)  
            obj.verify_type(obj, value, ["logical"]);
            obj.show_date = value;              % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_time(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.show_time = value;              % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_ms(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.show_ms = value;                % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        
        function set.show_logging_filename(obj, value)  
            obj.verify_type(obj, value, ["logical"]);
            obj.show_logging_filename = value;  % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_logging_function(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.show_logging_function = value;  % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.show_logging_linenumber(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.show_logging_linenumber = value;% Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        
        function set.log_to_command_window(obj, value)    
            obj.verify_type(obj, value, ["logical"]);
            obj.log_to_command_window = value;  % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.log_to_file(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.log_to_file = value;            % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.enabled(obj, value)
            obj.verify_type(obj, value, ["logical"]);
            obj.enabled = value;                % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        
        function set.log_directory(obj, value)    
            obj.verify_type(obj, value, ["string"; "char"]);
            obj.log_directory = value;          % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        function set.log_filename(obj, value) 
            obj.verify_type(obj, value, ["string"; "char"]);
            obj.log_filename = value;           % Set the variable
            if ~obj.pause_sync_notifier
                notify(obj, 'SyncLoggers');         % Trigger a "SyncLoggers" event 
            end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        function get_logger_levels(obj)
            fprintf('\n')
            fprintf('The following are the avilable logger logging levels:\n\n')
            fprintf("  Level  |  Label\n")
            fprintf("------------------------\n")
            for i = 1 : length(obj.log_level_labels)
                if i < 3
                   color_index = 1;
                else
                   color_index = 2;
                end       
                
                if i == obj.bold_font_level
                   log_level_label = obj.bold_font(obj.create_level_label(i));
                else
                   log_level_label = obj.create_level_label(i);
                end
                default_level_mark = "";
                if i == obj.default_level
                   default_level_mark = "<-- default_level";
                end
                fprintf(color_index, '  %i      |  %s  %s\n', i, log_level_label, default_level_mark);
            end
            fprintf('\n')
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function delete_log_file(obj)
           if exist(strcat(obj.log_directory, "\", obj.log_filename), 'file')
               delete(strcat(obj.log_directory, "\", obj.log_filename));
           end
        end
        function clear_log_file(obj)
            obj.create_log_file();
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        % Logging messages
        function debug(obj, message_text)
            if obj.default_level <= 1 && obj.enabled
                obj.log_it(message_text, 1); 
            end
        end  
        function info(obj, message_text)
            if obj.default_level <= 2 && obj.enabled
                obj.log_it(message_text, 2); 
            end
        end
        function warning(obj, message_text)
            if obj.default_level <= 3 && obj.enabled
                obj.log_it(message_text, 3); 
            end
        end
        function error(obj, message_text)
            if obj.default_level <= 4 && obj.enabled
                obj.log_it(message_text, 4); 
            end
        end
        function critical(obj, message_text)
            if obj.default_level <= 5 && obj.enabled
                obj.log_it(message_text, 5); 
            end
        end
        function fatal(obj, message_text)
            if obj.default_level <= 6 && obj.enabled
                obj.log_it(message_text, 6); 
            end
        end

        function log(obj, level_index, message_text)
            if obj.enabled
                if (level_index > length(obj.log_level_labels) || level_index < 1)
                   fprintf('[LOGGER] : %s\n', message_text)
                   fprintf(2, '[LOGGER] : Level number (%i) is not within vaild range (Range: 1-%i)\n', ...
                       length(level_index_obj.log_level_labels))
                   return 
                end
                obj.log_it(message_text, level_index);
            end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        
        function time_the_logger(obj, number_of_messages)
            fprintf('\n');
            obj.logger_message(sprintf('This test will measure the performance of the logger over %i log(s)', number_of_messages));
            obj.logger_message(sprintf('It will also compare the same number of logs to "fprintf"'));
            obj.logger_message(sprintf('Note: Writing to log file significantly impacts speed.'));
            fprintf('\n');
            obj.logger_message(sprintf('Press any key to begin\n'));
            pause
            obj.logger_message(sprintf('Starting logger timing test ...'));
            fprintf('\n');
            
            % Temporarilty setting the log filename to the logger timing test file
            temp_log_filename = obj.log_filename;
            obj.log_filename = "logger_timing_test.log";
            
            % Creating the log file
            obj.create_log_file();
            
            % Measuring fprintf command speed
            tic
            for i = 1 : number_of_messages
                fprintf('Testing "fprintf" speed ...\n');
            end
            fprintf_time_total = toc;
            fprintf_time_avg   = fprintf_time_total/number_of_messages;  
            fprintf('\n');
            
            % Measuring logger speed
            tic
            for i = 1 : number_of_messages
                obj.log(obj.default_level, 'Testing logger speed ... ');
            end
            log_time_total = toc;
            log_time_avg   = log_time_total/number_of_messages;
            
            % Report
            fprintf('\n')
            fprintf('=====================================================\n')
            obj.logger_message(sprintf('Timing test complete'));
            obj.logger_message(sprintf('Total messages logged : %i', number_of_messages));          
            fprintf('\n')
            obj.logger_message(sprintf('fprintf - Total elapsed time   : %.5f sec\n', fprintf_time_total));
            obj.logger_message(sprintf('fprintf - Average time per log : %.5f sec per log\n', fprintf_time_avg));
            fprintf('\n')
            obj.logger_message(sprintf('Logger - Total elapsed time    : %.5f sec\n', log_time_total));
            obj.logger_message(sprintf('Logger - Average time per log  : %.5f sec per log\n',log_time_avg));
            fprintf('=====================================================\n\n')
            
            % Deleting the temporary logger timing log file
            obj.delete_log_file();
            
            % Restoring the original log filename
            obj.log_filename = temp_log_filename;
        end 
    end
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    methods (Access = protected, Hidden = true)
        
        function obj = sync_loggers(obj, ~)
           % This method is exectued when "SyncEvent" is triggered
           [~, obj] = obj.logger_manager(obj, "sync");
        end
        
        function sync_loggers_trigger(obj)
            % This is a trigger, to trigger a "SyncLoggers" event
            notify(obj, 'SyncLoggers');
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        function obj = find_caller_info(obj)
            % Get the caller stack
            caller_stack = dbstack; 
            
            obj.caller_filename  = string(caller_stack(end).file);
            filename_split       = split(obj.caller_filename, '.');
            filename             = filename_split{1};
            
            obj.caller_function   = string(caller_stack(end).name);
            obj.caller_linenumber = string(caller_stack(end).line);
            
            % Looping from most recent call to furthest
            for i = length(caller_stack) : -1 : 5
               % If function and file name do not match
               if string(caller_stack(i).name) ~= string(filename)
                    obj.caller_filename   = string(caller_stack(i).file);
                    obj.caller_function   = string(caller_stack(i).name);
                    obj.caller_linenumber = string(caller_stack(i).line);
               end
            end       
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [level_label] = create_level_label(obj, level_index)
            % Total output string length
            total_length = 11;
            
            % Label text string
            label = obj.log_level_labels(level_index);
            
            % End filler blanks
            blank_filler = blanks(total_length - 1 - (2 + strlength(label)));
            
            % Compile entire output label
            level_label    = strcat("[", label, string(blank_filler), "]");
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [log_message] = construct_log_message(obj, level_index, message_text)
            % Create log level label
            level_label = obj.create_level_label(level_index);
            
            % Find caller stack information
            obj.find_caller_info();

            logger_name_info = "";
            if obj.show_logger_name
                logger_name_info = strcat("[", obj.name, "]");
            end

            date_info = "";
            if obj.show_date
                date_info = strcat("[", obj.get_date(), "]");
            end

            time_info = "";
            if obj.show_time
                time_info = strcat("[", obj.get_time(obj.show_ms), "]");
            end

            caller_filename_info = "";
            if obj.show_logging_filename
                caller_filename_info   = strcat("[", obj.caller_filename,   "]");
            end   

            caller_function_info = "";
            if obj.show_logging_function
                caller_function_info   = strcat("[", obj.caller_function,   "]");
            end   

            caller_linenumber_info = "";
            if obj.show_logging_linenumber
                caller_linenumber_info = strcat("[", obj.caller_linenumber, "]");
            end   
            
            % Compiling the entire log message
            log_message = strcat(logger_name_info, ...
                                 date_info, ...
                                 time_info, ...
                                 caller_filename_info, ...
                                 caller_function_info, ...
                                 caller_linenumber_info, ...
                                 level_label, ...
                                 " : ", ...
                                 string(message_text), ...
                                 "\n");
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function log_it(obj, message_text, level_index)
            % Compiling the log message
            [log_message] = obj.construct_log_message(level_index, message_text);
            
            % Determine if message color
            if level_index < 3
                % Default font color
               color_index = 1;
            else
               % Red font color
               color_index = 2;  
            end
            
            % Write message to log file
            if obj.log_to_file
                obj.append_log_file(log_message)
            end            
            
            % Bold the log message for Fatal log level
            if level_index == obj.bold_font_level
               log_message = obj.bold_font(log_message);
            end
            
            % Output to command window
            if obj.log_to_command_window
               fprintf(color_index, log_message);
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function create_log_file(obj)
            % Create the log file
            f = fopen(strcat(obj.log_directory, "\", obj.log_filename), 'w');
            fclose(f); 
        end
        
        function append_log_file(obj, log_message)
           % Write to log file
           if ~exist(strcat(obj.log_directory, "\", obj.log_filename), 'file')
                obj.create_log_file()
           end
           
           % Open a file, write video data, close file
           f = fopen(strcat(obj.log_directory, "\", obj.log_filename), 'a');
           fprintf(f, log_message);
           fclose(f); 
        end
    end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

    methods (Static, Access = protected, Hidden = true)
        function [all_loggers, logger_obj] = logger_manager(logger_obj, operation)
            persistent loggers
            
            % Create logger container map, if it does not exist
            if isempty(loggers)
                loggers = containers.Map();
            end
            
            % Only change if anything is passed
            if nargin > 1
                % Logger and change operation index have been passed
                if operation == "add"
                    % Check if the added logger exists, if not add it
                    add_logger_obj = true;
                    logger_keys = keys(loggers);
                    
                    for i = 1 : length(loggers)
                        % Check if there is a match to exiting logger group name
                        if lower(logger_keys{i}) == lower(logger_obj.name)
                            % Disable sync notifier for object
                            logger_obj.pause_sync_notifier = true;
                            
                            loggers_for_group = loggers(logger_keys{i});
                            first_logger      = loggers_for_group{1};

                            % Check if it comes from the same file
                            if lower(first_logger.object_creation_file) == lower(logger_obj.object_creation_file)
                                add_logger_obj = false;
                            else
                                for k = 1 : length(logger_obj.logger_props)
                                    property = logger_obj.logger_props(k);
                                    logger_obj.(property) = first_logger.(property);
                                end
                                add_logger_obj = true;
                            end
                            % Enable sync notifier for object
                            logger_obj.pause_sync_notifier = false;
                            
                            % Stop looking for a group name match
                            break
                        end
                       
                    end
                    
                    % Add it to logger list under shared group name 
                    if add_logger_obj
                        % Check if the logger group name exists
                        if isKey(loggers, logger_obj.name)
                            % Logger group exists
                            next_logger_index = length(loggers(logger_obj.name)) + 1;
                            logger_list       = loggers(logger_obj.name);
                        else
                            % Logger list does not exist
                            next_logger_index = 1;
                            logger_list       = {};
                        end
                        logger_list{next_logger_index} = logger_obj;
                        loggers(logger_obj.name)       = logger_list;
                    else
                        % The logger was created in teh same file
                        %   TODO:  Also check function!!!

                        % Delete the object entirely by calling its destructor
                        logger_obj.delete(false)
                    end
                    
                elseif operation == "sync"
                    logger_keys = keys(loggers);
                    
                    for i = 1 : length(loggers)
                        loggers_for_group = loggers(logger_keys{i});
                        
                        % Check if logger name is in existing logger group name
                        if lower(logger_keys{i}) == lower(logger_obj.name)                         
                            % Duplicate the passed logger to all in group
                            for j = 1 : length(loggers_for_group)
                                % Disable sync notifier for object
                                loggers_for_group{j}.pause_sync_notifier = true;
                                
                                for k = 1 : length(logger_obj.logger_props)
                                    property = logger_obj.logger_props(k);
                                    loggers_for_group{j}.(property) = logger_obj.(property);
                                end
                                % Enable sync notifier for object
                                loggers_for_group{j}.pause_sync_notifier = false;
                            end   
                            % Stop looking for a group name match
                            break
                        end
                    end
                else
                    % No index match
                    error("[ LOGGER ] : Wrong 'change' value was passed (Passed value: '%s')", operation);
                end
            else
                % Nothing was passed into the log_manager
                logger_obj = [];
            end
            
%             % DEBUG STUFF
%             fprintf("\n\n========= LOG MANAGER CALL ==============\n")
%             k = keys(loggers);
%             x = values(loggers);
%             for i = 1 : length(loggers)
%                 fprintf("====== Group ======\n")
%                 fprintf("Group Name: %s\n", k{i})
%                 for j =  1 : length(x{i})
%                    fprintf("===== Logger =====\n")
%                    fprintf("Name:      %s\n", x{i}{j}.name)
%                    fprintf("Logger ID: %i\n", x{i}{j}.object_ID)
%                    fprintf("Show Name: %i\n", x{i}{j}.show_logger_name)
%                    fprintf("Show Time: %i\n", x{i}{j}.show_time)
%                    fprintf("Show Date: %i\n", x{i}{j}.show_date)
%                 end
%             end
            
            % Returning information
            all_loggers = loggers;
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        function [accepted] = verify_type(obj, value, accepted_value_types)
           accepted = false;
           % Checking each value type to see if there is a match
           for i = 1 : length(accepted_value_types)
               if accepted_value_types(i) == class(value)
                   accepted = true;
                   break
               end
           end
           if not(accepted)
               obj.logger_message(sprintf("Property assignment must be a '%s' variable type", accepted_value_types(1)), 2, true)
           end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [logger_message] = logger_message(message, color_index, error_message)
            % Creating a general internal logger message
            logger_message = strcat("[ LOGGER ] : ", message, "\n");
            if nargin == 1
                % Regular font
                fprintf(logger_message)
            elseif nargin == 2
                % Display in red colored font
                fprintf(color_index, logger_message);
            elseif nargin == 3
                if error_message
                    % Display error message
                    logger_message = erase(logger_message, "\n");
                    error(logger_message);
                else
                    % Display in red colored font
                    fprintf(color_index, logger_message);
                end
            else
                error("Too many arguments passed");
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [date_string] = get_date()
            date_string = datestr(now, 'yyyy-dd-mm');
        end
        
        function [time_string] = get_time(show_ms)
            if show_ms
                time_string = datestr(now,'HH:MM:SS.FFF');
            else
                time_string = datestr(now,'HH:MM:SS');
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [text] = bold_font(text)
            text = strcat("<strong>", text, "</strong>");
        end
		
        function [text] = regular_font(text)
            text = erase(text, "<strong>");
            text = erase(text, "</strong>");
        end
    end
end
