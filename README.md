# 🤖 Hardbass Science 🤙 -Text Collection Tool

Hardbass Science to narzędzie do zbierania i organizowania tekstu, zaprojektowane, aby pomóc użytkownikom w łatwym gromadzeniu i zapisywaniu tekstu z różnych źródeł.

## Instalacja
1. Pobierz spakowany plik skryptu.
![alt text](System_Files/readme%20resources/image.png)
3. wypakuj **wszystkie** pliki do dogodnego folderu
4. uruchom plik `🤙 Hardbass science.exe` <br>
(paczka zip zawiera pliki niezbędne do działania programu, gdy usuniesz jeden z nich, lub przeniesisz do innego folderu, program może nie działać)

### Uwaga dotycząca Windows Defender
Ten program zawiera pliki wykonywalne (exe). Przy pierwszym uruchomieniu programu, Windows Defender może go błędnie zidentyfikować jako zagrożenie i wyświetlić ostrzeżenie. Jest to fałszywy alarm i można go bezpiecznie zignorować. <br>
Zachowanie to wynika z faktu, że niektóre programy antywirusowe, w tym Windows Defender, traktują pliki exe utworzone z języków skryptowych z podejrzliwością.  Gwarantuję że, program jest bezpieczny i nie zawiera żadnego złośliwego oprogramowania. Jeśli mimo to masz wątpliwości, możesz przeskanować program za pomocą niezależnego skanera antywirusowego online. <br>
Aby zignorować ostrzeżenie, kliknij "Więcej informacji" > "Uruchom mimo to".

<img src="System_Files/readme%20resources/image-defender.png" alt="Windows Defender warning" width="250"/>

### jakie pliki znajdziesz w folderze?
* `show gathered data.xlsx` plik excel umożliwający wygodne importowanie, przeglądanie i formatowanie danych z pliku `output.csv`
* `output.csv` plik do którego zapisują się dane. - zostanie utworzony po uruchomieniu programu
* `readme.md`, czyli instrukcję, którą właśnie czytasz
* `Hardbass science.ahk` z kodem źródłowym, do jego uruchomienia potrzebny jest [AutoHotkey 2.0](https://www.autohotkey.com/) - jeśli czujesz się na siłach, możesz samodzielnie wprowadzać w nim zmiany.
* `system_files/` folder zawiera dodatkowe pliki niezbędne do działania programu.
 
  
## Użycie
Po uruchomieniu `🤙 Hardbass science.exe` pojawi się interfejs graficzny, kliknij "OK", aby uruchomić program. Od tej pory będzie działał w tle.<br>
Postępuj zgodnie z instrukcjami, aby wprowadzić dodatkowe informacje dla każdego wpisu.<br>
Zebrane dane zostaną zapisane w pliku `output.csv` w tym samym folderze co skrypt. 

### Wyświetlanie i edycja pliku CSV<br>
Wygodny podgląd danych z pliku `output.csv` dostępny jest w pliku `show gathered data.xlsx`. Dane są wczytywane z użyciem Power Query, plik excel może być otwarty w trakcie działania skryptu, ale aby wyświelnić zmiany kliknij `odśwież` w zakładce `dane`na pasku u góry ekranu.
![alt text](System_Files/readme%20resources/image-3.png)


> [!WARNING]
> Nie wprowadzaj zmian bezpośrednio w pliku `show gathered data.xlsx`. Wszelkie modyfikacje powinny być dokonywane w pliku `output.csv`. Plik Excel służy jedynie do wygodnego przeglądania i formatowania danych.
>Uwaga zmiany dokonywane w pliku `show gathered data.xlsx` nie wpływają na plik `output.csv`. Usunięcie lub edycja wpisu w excelu nie powoduje zmian w pliku csv.
>Używaj pliku `show gathered data.xlsx` wyłącznie do wyświetlania  i formatowania danych, wprowadzone w nim zmiany mogą łatwo zostać nadpisane przy następnym uruchomieniu programu.

Najwygodniejszym sposobem otwierania plików csv jest  LibreOffice Calc. Jest to darmowa alternatywa dla MS Excel, ale łatwiej otwiera pliki csv (IMO).<br>
LibreOffice Calc jest częścią pakietu [LibreOffice](https://pl.libreoffice.org/pobieranie/stabilna/) - możesz go pobrać z powyższego linku (samouczek dla opornych znajdziesz na dole strony [^1]). 

> [!INFO]
> Regularnie sprawdzaj plik `output.csv` i twórz jego kopie zapasowe.

## Aby zakończyć program, możesz:
* Kliknąć prawym przyciskiem myszy ikonę '🤙' w zasobniku systemowym (prawy dolny róg paska zadań systemu Windows) i wybrać "Zakończ"
* Nacisnąć Alt+Esc

## FAQ
*  *Jak usunąć/edytować wpis w pliku CSV?*<br>
*Jak usunąć/dodać/edytować wpis w excelu?*<br>
Aby wprowadzić zmiany w zapianych przez ciebie danych, edytuj plik `output.csv` w LibreOffice Calc <br>
Zmiany dokonywane w pliku `show gathered data.xlsx` nie wpływają na plik `output.csv`i zostaną nadpisane przy następnym odświeżeniu.

*  *dlaczego to tyle waży?*<br>
Program napisałem w dwóch językach: AutoHotkey (większość funkcji) oraz Python (pobieranie danych z Crossref.org). Jest to nieefektywne, bo aby program działał prawidłwo muszę spakować oba interpretery (AutoHotkey i Python) wraz z zależnościami. Wszystko to waży dużo, ale działa - może kiedyś przepiszę wszystko w Pythonie, aby całość była lżejsza.
*  Dane są zapisywane w kodowaniu UTF-8 z BOM. (ale 1200:Unicode też działa z jakiegoś powodu)<br>

## Wymagania:
* system Windows
* [AutoHotkey 2.0](https://www.autohotkey.com/)
* [Python 3.10+](https://www.python.org/)

## Napisz do mnie
stenzelpawel.t@gmail.com

[^1]: Otwieranie i edycja pliku CSV - instrukcja dla opornych:
    1. Kliknij plik prawym przyciskiem myszy na plik output.csv: Spowoduje to otwarcie menu kontekstowego.
    2. Wybierz "Otwórz za pomocą": Najedź kursorem na tę opcję, a pojawi się kolejne podmenu.
    3. Wybierz "LibreOffice Calc": Jeśli Calc jest na liście, po prostu go kliknij. Jeśli nie:
       a. Kliknij "Wybierz inną aplikację" (lub podobne sformułowanie w zależności od systemu operacyjnego).
       b. Wyszukaj LibreOffice Calc (może znajdować się w "Program Files" lub "Applications").
    4. Wybierz "Calc" i zaznacz pole "Zawsze używaj tej aplikacji do otwierania plików .csv".
    5. Kliknij "Otwórz": Uruchomi to LibreOffice Calc i otworzy plik CSV.
    6. **Zmiany dokonane w pliku CSV za pomocą LibreOffice Calc zostaną w nim zapisane.**

