# Hardbass Science (pl)
Hardbass Science to narzędzie do zbierania i organizowania tekstu, zaprojektowane, aby pomóc użytkownikom w łatwym gromadzeniu i zapisywaniu tekstu z różnych źródeł.

## Wymagania
AutoHotkey v2.0
System operacyjny Windows

## Instalacja
Zainstaluj AutoHotkey v2.0 z oficjalnej strony AutoHotkey.
Pobierz plik skryptu Hardbass science.ahk.
Umieść plik skryptu w dogodnej lokalizacji na komputerze.

## Użycie
Kliknij dwukrotnie plik Hardbass science.ahk, aby uruchomić skrypt.
Pojawi się interfejs graficzny, który pozwoli Ci wybrać preferowany zestaw skrótów klawiaturowych i liczbę pól wprowadzania.
Kliknij "OK", aby uruchomić program. Będzie działał w tle.
Postępuj zgodnie z instrukcjami, aby wprowadzić dodatkowe informacje dla każdego wpisu tekstowego.
Zebrane dane zostaną zapisane w pliku output.csv w tym samym folderze co skrypt. Pliki CSV można importować do programu Excel za pomocą
Wyświetlanie i edycja pliku CSV
Najwygodniejszym sposobem otwierania plików csv jest zrobienie tego za pomocą LibreOffice Calc. Jest to darmowa alternatywa dla MS Excel, ale łatwiej otwiera pliki csv (IMO).
LibreOffice Calc jest częścią pakietu Libre Office - możesz go pobrać z poniższego linku.
[Wersja stabilna | LibreOffice Polska - Wolny i darmowy pakiet biurowy](https://pl.libreoffice.org/pobieranie/stabilna/)
Jeszcze bardziej szczegółowy samouczek dla początkujących poniżej [^1].

## Aby zakończyć program, możesz:
* Kliknąć prawym przyciskiem myszy ikonę 'H' w zasobniku systemowym (prawy dolny róg paska zadań systemu Windows) i wybrać "Zakończ"
* Nacisnąć Alt+Esc

## Uwagi
Regularnie sprawdzaj plik output.csv i twórz jego kopie zapasowe.
Skrypt tworzy plik output.csv, jeśli nie istnieje.
Dane są zapisywane w kodowaniu UTF-16 z BOM.

---

[^1]: Otwieranie i edycja pliku CSV - samouczek dla początkujących:
    1. Znajdź plik CSV: Użyj menedżera plików (np. Eksploratora plików w systemie Windows lub Findera w systemie Mac), aby znaleźć plik CSV, który chcesz otworzyć.
    2. Kliknij plik prawym przyciskiem myszy: Spowoduje to otwarcie menu kontekstowego.
    3. Wybierz "Otwórz za pomocą": Najedź kursorem na tę opcję, a pojawi się kolejne podmenu.
    4. Wybierz "LibreOffice Calc": Jeśli Calc jest na liście, po prostu go kliknij. Jeśli nie:
       a. Kliknij "Wybierz inną aplikację" (lub podobne sformułowanie w zależności od systemu operacyjnego).
       b. Wyszukaj LibreOffice Calc (może znajdować się w "Program Files" lub "Applications").
    5. Wybierz "Calc" i zaznacz pole "Zawsze używaj tej aplikacji do otwierania plików .csv".
    6. Kliknij "Otwórz": Uruchomi to LibreOffice Calc i otworzy plik CSV.