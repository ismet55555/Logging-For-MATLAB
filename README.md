<h1 align="center">Logging For MATLAB/Octave :bowtie:</h1>

If you have ever wanted a nice message logger for your MATLAB or GNU Octave scripts, well my friend, you may be in luck!

Explain what it is, and briefly what situations this may come in handy.
It was inspired by phython's `logging` package.


### Very Basically ...
1. Every time you want to log/show/save a message, you can do that with this logger.
2. The logger can display a message with different levels such as `debug`, `error`, or `fatal`.
3. There are many other things this logger can do that a simple `fprintf()` command can not.


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


## :thumbsup: Compatibility

### Minimum System Requirements
Blah blah blah blah blah blah blah bla
- __CPU__: 1.2 GHz
- __CPUs/Cores__: 4
- __RAM__: 1GB
- __Disk Storage__: 400 MB + Images


### Verified Platforms
Blah blah blah blah blah blah blah bla

|           Works Fine           |    Will Not Work    |
|:------------------------------:|:-------------------:|
| Raspberry Pi 3b+ *(Raspbian)*  | Raspberry Pi Zero W |
| Raspberry Pi 4 *(Raspbian)*    |                     |
| Atomic Pi *(Lubuntu 18.04)*    |                     |
| Ubuntu 16.04 and up            |                     |

I have not tried it out on `Microsoft WSL (Windows Subsystem for Linux)`, but may work on it as well.



## :rocket: Installing and Setup
1. *[If on remote computer]* Enter remote linux device using `ssh`:
    - MAC/Linux Terminal, Windows Powershell: `ssh <username/login>@<IP address of picture frame computer>`
    - May need to enable SSH on remote linux host computer: `sudo apt install -y openssh-server`
2. Navigate into user documents directory: 
    - `$ cd ~/Documents`
3. Install git:
    - `$ sudo apt -y install git-all`
4. Configure git:
    - `$ git config --global user.name "Your Name Here"`
    - `$ git config --global user.email "your.email@here.com"`
5. Clone this public git repo form github:
    - `$ git clone git@github.com:ismet55555/Super-Best-Frame.git`
6. Change directory into cloned directory:
    - `$ cd Super-Best-Frame`
7. Install OpenCV system dependencies:
    - `$ sudo apt -y install python3-opencv`
8. Run the start script
    - `$ ./start`

**NOTE**: *Check out the [`start`](start) script to see what exactly it executes.*


## :boom: Usage
TODO - Maybe some gifs


### Image Formats You Can Use
- `.png`, `.jpg`, `.jpeg`, `.bmp`, `.dib`, `.jpe`, `.jp2`, `.pgm`, `.tiff`, `.tif`, `.ppm`


### Adding Images
Blah blah blah blah blah blah blah bla



## :bust_in_silhouette: Author
**Ismet Handžić** - Github: [@ismet55555](https://github.com/ismet55555)


## Licence
This project is licensed under the MIT License (FIXXXX MEE) - see the [LICENSE.md](LICENSE.md) file for details
