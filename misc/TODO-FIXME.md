
### TODO
1. Add `inputParser()` to object constructor
2. Try using `validateattributes()` for setters and constructor
3. See if file closure does not happen every log, but in object destructor
4. Message input as `sprintf()` format, instead of having to format before hand

### FIXME
1. Fix bug in constructor that overwrites filename if filename is passed as a constructor argument
2. Use `fullfile()` instead of `strcat()`
