# nbastat
Program which parses statline files from http://www.basketball-reference.com/, and displays information to the user as a GUI

The original intent regarding file organization was to have player images, team logos, and raw .csv files in separate subdirectories. This would ease the strain of locating .m files, as well as reducing clutter in the main directory. However, it was difficult for MATLAB to access files not in the root directories, especially as the program will be run on different systems.

Because of this, we opted to have all files in the main directory. This will make it harder to locate specific files, but increases ease of use for the user (all that is needed is to run the program).

The main file which regulates all the other functions is "uiskeleton.m". From this file, all other outside functions are called. These outside functions include:

"parsePlayer.m"
"parseStatLine.m"
"lastngames.m"
"faveteam.m"