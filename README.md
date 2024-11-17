this is just a simple script to install windows .wim files automaticly without the hassle of typing each commands.

this batch script works on Windows Vista PE up to Windows 11 PE (recommended to use a actual PE disc instead of the PE of windows installer)

Requirements:
1. Windows PE iso (recommended that its cleaned, removing the install.wim/install.esd inside the sources folder)
2. a Windows .wim file (just put it on the iso where the setup.bat is)
3. wimlib imagex 1.8.3 i686 (download on: https://wimlib.net/downloads/wimlib-1.8.3-windows-i686-bin.zip)
4. Text editor (notepad can work but notepad++ is recommended)


How to use this script:

1. Prepare your windows PE iso (use anyburn or any iso editor out there)
2. delete install.wim/install.esd on the sources folder and remove the support folder.
3. put "setup.bat" on the iso (not in a folder, just on the root of the iso file)
4. put your .wim file on the same location as the setup.bat (rename your .wim file to install.wim)
5. now put wimlib imagex files on the same location as the setup.bat and your wim file (just wimlib-imagex.exe and libwim-15.dll, you dont need the others)
6. after you do that, save the iso file and try it out on a vm using cmd on windows pe
7. once you have the cmd on windows pe, navigate to D: and type setup, after that just follow the things on cmd
8. once it sucessfully worked and installed windows with no problem, its ready (please credit me if youre gonna showcase this script to your project, https://www.youtube.com/@heavysnipermk2781)
