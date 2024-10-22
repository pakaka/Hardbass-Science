get_doi.exe  was compiled with PyInstaller.

```
pyinstaller --onefile --distpath .\System_Files\dist .\System_Files\get_doi.py
```
this ↑ command creates get_doi.exe in .\System_Files\dist folder, instead of .\dist folder. based on get_doi.py file.


'build' folder contains temporary files generated during the building process. Think of it as PyInstaller's "scratchpad."is ignored in .gitignore, so it's not uploaded to the repository.


