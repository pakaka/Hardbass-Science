# 🤖 Hardbass Science 🤙 
Hardbass Science to narzędzie do zbierania i organizowania tekstu, zaprojektowane, aby pomóc użytkownikom w łatwym gromadzeniu i zapisywaniu tekstu z różnych źródeł.

## Wymagania
* System operacyjny Windows
* (opcjonalnie [AutoHotkey](https://www.autohotkey.com/) v2.0

## Instalacja
<!--1. Zainstaluj AutoHotkey v2.0 z oficjalnej strony [AutoHotkey](https://www.autohotkey.com/).-->
2. Pobierz spakowany plik skryptu.
![alt text](image.png)
3. wypakuj plik `Hardbass science.exe` (archiwium zaweira również pliki `readme.md`, czyli instrukcję, którą właśnie czytasz, oraz `Hardbass science.ahk` z kodem źródłowym )
3. Umieść plik skryptu w dogodnej lokalizacji na komputerze i używaj
  
## Użycie
Kliknij dwukrotnie plik Hardbass science.exe, aby uruchomić skrypt.<br>
Pojawi się interfejs graficzny, kliknij "OK", aby uruchomić program. Będzie działał w tle.<br>
Postępuj zgodnie z instrukcjami, aby wprowadzić dodatkowe informacje dla każdego wpisu.<br>
Zebrane dane zostaną zapisane w pliku `output.csv` w tym samym folderze co skrypt. 

### Wyświetlanie i edycja pliku CSV<br>
Najwygodniejszym sposobem otwierania plików csv jest zrobienie tego za pomocą LibreOffice Calc. Jest to darmowa alternatywa dla MS Excel, ale łatwiej otwiera pliki csv (IMO).<br>
LibreOffice Calc jest częścią pakietu Libre Office - możesz go pobrać z poniższego linku. <br>
[Wersja stabilna | LibreOffice Polska - Wolny i darmowy pakiet biurowy](https://pl.libreoffice.org/pobieranie/stabilna/)<br>
Samouczek dla opornych znajdziesz na dole strony [^1].<br>
Regularnie sprawdzaj plik `output.csv` i twórz jego kopie zapasowe. <br>

alternatywnie możesz otworzyć plik w Excelu [^2].

## Aby zakończyć program, możesz:
* Kliknąć prawym przyciskiem myszy ikonę 'H' w zasobniku systemowym (prawy dolny róg paska zadań systemu Windows) i wybrać "Zakończ"
* Nacisnąć Alt+Esc

## Uwagi
Dane są zapisywane w kodowaniu UTF-16 z BOM. (ale 1200:Unicode też działa z jakiegoś powodu)<br>

## Napisz do mnie
stenzelpawel.t@gmail.com


[^1]: Otwieranie i edycja pliku CSV - instrukcja dla opornych:
    1. Znajdź plik CSV: Użyj menedżera plików (np. Eksploratora plików w systemie Windows lub Findera w systemie Mac), aby znaleźć plik CSV, który chcesz otworzyć.
    2. Kliknij plik prawym przyciskiem myszy: Spowoduje to otwarcie menu kontekstowego.
    3. Wybierz "Otwórz za pomocą": Najedź kursorem na tę opcję, a pojawi się kolejne podmenu.
    4. Wybierz "LibreOffice Calc": Jeśli Calc jest na liście, po prostu go kliknij. Jeśli nie:
       a. Kliknij "Wybierz inną aplikację" (lub podobne sformułowanie w zależności od systemu operacyjnego).
       b. Wyszukaj LibreOffice Calc (może znajdować się w "Program Files" lub "Applications").
    5. Wybierz "Calc" i zaznacz pole "Zawsze używaj tej aplikacji do otwierania plików .csv".
    6. Kliknij "Otwórz": Uruchomi to LibreOffice Calc i otworzy plik CSV.

[^2]: Otwieranie pliku CSV w Excelu - poradnik dla opornych:
    1. Otwórz Excela.
    2. Kliknij zakładkę Dane.
    3. W grupie Pobieranie danych zewnętrznych kliknij Z tekstu/CSV.
    4. Wybierz plik CSV, który chcesz otworzyć.
    5. Kliknij Importuj.
    6. Kreator importu tekstu:
    ![alt text](image-2.png)
    7. kliknij załaduj
