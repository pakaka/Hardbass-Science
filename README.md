# Hardbass Science

Hardbass Science is a text collection and organization tool designed to help users easily gather and save text from various sources.

## Requirements

- AutoHotkey v2.0
- Windows operating system

## Installation

1. Install AutoHotkey v2.0 from the [official AutoHotkey website](https://www.autohotkey.com/).
2. Download the `Hardbass science.ahk` script file.
3. Place the script file in a convenient location on your computer.

## Usage

1. Double-click the `Hardbass science.ahk` file to run the script.
2. A GUI will appear, allowing you to choose your preferred keyboard shortcut set and the number of input fields.
3. Click "OK" to start the program. It will run in the background.
4. Follow the prompts to enter additional information for each text entry.
6. Collected data will be saved in an `output.csv` file in the same folder as the script. CSV files can be imported to excel using

### Viewing and editing CSV file
Most convinient way to open csv files is to do it using LibreOffice Calc. It is a free alternative to ms excel, but opens csv files more easily (IMO). 
LibreOffice calc is a part of libre office suite - you can dowload it from the link below.
[Wersja stabilna | LibreOffice Polska - Wolny i darmowy pakiet biurowy](https://pl.libreoffice.org/pobieranie/stabilna/) Even more detailed tutorial for dummies below.



## Keyboard Shortcuts

Choose between two sets of shortcuts:

1. Left Alt + 'W' and Left Alt + 'E'
2. Right Alt + ',' and Right Alt + '.'

## Exiting the Program

To exit the program, either:
- Right-click on the 'H' icon in the system tray (bottom right corner of the windows taskbar) and select "Exit"
- Press Alt+Esc

## Notes

- Regularly check the `output.csv` file and make backups.
- The script creates `output.csv` if it doesn't exist.
- Data is saved in UTF-16 encoding with BOM.
