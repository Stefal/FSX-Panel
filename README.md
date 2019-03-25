# FSX-Panel
Autoit scripts to store and restore FSX's panels

These scripts were written in 2009, and are provided "as is".

A little software to save and recall the panels' position an size. It works when you use Fsx in Windowed mode and with undocked panels, and should help the users with multiple monitors.

How it works:
There are two applications, one for saving the position/size and another one to recall it. It saves one panels setup per aircraft.
Open Fsx in windowed mode- Open the panels you need, undocked them, and place/resize them the way you want.
- Launch "Panel Store.exe" and wait a few (2 to 5 secondes)Move, resize the panels or load/create a flight.
- Open the panels you need (undocked)
- Launch "Panel Restore.exe"The size and the positions of your panels will be recalled.

More details:
When you execute "Panel Store.exe", it scans all the open windows, keep only the panels, and store their name, size and position in a .ini file. The .ini file name should be the aircraft name but I noticed it could be different with some addons.
When you execute "Panel Restore.exe", it search the aircraft name, scan for the .ini file that match and move/resize the panels if they are opened and undocked (otherwise the software can't do anything).When you launch "Panel Store.exe", and if a corresponding .ini file is already created, it will delete it and create a new one.

Tips:
Create a shortcut for the two .exe, and assign an available keyboard shortcut. For example : Ctrl+Alt+F11 to save and Ctrl+Alt+F12 to restore.

To run the scripts and/or build the .exe you need AutoiT: https://www.autoitscript.com/site/autoit/
