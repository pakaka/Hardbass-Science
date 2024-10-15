#Requires AutoHotkey v2.0

#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Check if output.csv exists, create it if not
outputFile := A_WorkingDir . "\output.csv"
if !FileExist(outputFile) {
    try {
        FileAppend("", outputFile, "UTF-16")
        MsgBox("Utworzono nowy plik 'output.csv'. Zbierany przez ciebie tekst będzie tam zapisywany.", "Plik Utworzony")
    } catch as err {
        MsgBox("Error: Nie udało się utworzyć pliku 'output.csv', spróbuj stworzyć go samodzielnie w folderze z tym skryptem.", "Error")
        ExitApp()
    }
}

; Add these global variables at the top of your script, after other global declarations
global lastUserInput1 := "???"
global lastUserInput2 := "lorem ipsum"

; Create a custom GUI for user to choose the shortcut set
MyGui := Gui(, "w500")
MyGui.SetFont("s10", "Segoe UI")


MyGui.Add("Text", "x10 y10 w470 h40", "Witam w Hardbass science 🤙️").SetFont("s18")
MyGui.Add("Text", "x10 y60 w470 h40", "Wybierz preferowany zestaw skrótów klawiszowych:")
MyGui.Add("Radio", "x10 y100 w470 vShortcutSet Checked", "1: Lewy Alt + 'W'    2: Lewy Alt + 'E'")
MyGui.Add("Radio", "x10 y130 w470", "1: Prawy Alt + ','     2: Prawy Alt + '.'     `(przecinek i kropka`)")
MyGui.Add("Button", "x10 y170 w120 h30", "OK").OnEvent("Click", ProcessChoice)

MyGui.Add("Text", "x10 y220 w470 h30", "Instrukcja").SetFont("s12 bold")
MyGui.Add("Text", "x20 y250 w470 h210", "To narzędzie służy do łatwego zbierania i zapisywania tekstu z różnych źródeł.`nPo kliknięciu 'OK', program będzie działał w tle.`nZebrane dane będą zapisywane w pliku 'output.csv' w folderze ze skryptem.`nAby zapisać tekst, zaznacz go i użyj skrótu 1. Możesz też użyć skrótu 2, aby zapisać tekst wcześniej zapisany w schowku (ctrl+c). `nRegularnie sprawdzaj plik 'output.csv' i rób kopie zapasowe.`nAby zakończyć, kliknij prawym przyciskiem myszy na ikonę 'H' w obszarze powiadomień (w prawym rogu paska zadań systemu windows), lub kliknij Alt+Esc")
MyGui.Add("Text", "x20 y470 w470 h20 Right", "Wersja z dnia 15-10-2024").SetFont("s8")


MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.Title := "Hardbass Science"
MyGui.Show()

ProcessChoice(*)
{
    shortcutSet := MyGui.Submit()
    if (shortcutSet.ShortcutSet = 1) {
        SetupSet1()
    } else if (shortcutSet.ShortcutSet = 2) {
        SetupSet2()
    } else {
        MsgBox("Nieprawidłowy wybór zestawu skrótów.", "Błąd")
        return
    }
    MsgBox("To lecimy!", "Success", "T1")
    MyGui.Destroy()
}



SetupSet1()
{
    Hotkey "!w", CopyAndProcess
    Hotkey "!e", ProcessClipboard
}

SetupSet2()
{
    Hotkey "RAlt & ,", CopyAndProcess
    Hotkey "RAlt & .", ProcessClipboard
}

CopyAndProcess(*)
{
    Send "^c"  ; copy selection
    Sleep 100  ; gives time for the copy to work
    ProcessClipboard()
}

ProcessClipboard(*)
{
    global outputFile, lastUserInput1, lastUserInput2  ; Use the global variables

    if (A_Clipboard = "") {
        MsgBox("Schowek jest pusty, nic nie skopiowano.", "Uwaga", "T2")
        return
    }

    userInput1 := InputBox("To zostanie zapiane w kolumnie 1 (np. kategoria, tytuł akpitu): ", , , lastUserInput1)
    if userInput1.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput1.Value := userInput1.Value = "" ? "???" : userInput1.Value
    lastUserInput1 := userInput1.Value  ; Remember the last input

    userInput2 := InputBox("To zostanie zapiane w kolumnie 2 (np. nazwisko autora): ", , , lastUserInput2)
    if userInput2.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput2.Value := userInput2.Value = "" ? "???" : userInput2.Value
    lastUserInput2 := userInput2.Value  ; Remember the last input

    ; Function to properly escape and quote CSV fields
    EscapeCSV(field) {
        ; Escape double quotes by doubling them
        field := StrReplace(field, '"', '""')
        ; Enclose field in double quotes if it contains commas, double quotes, or newlines
        if (InStr(field, ",") or InStr(field, '"') or InStr(field, "`n")) {
            return '"' . field . '"'
        }
        return field
    }

    ; Escape and quote the user inputs and clipboard content
    userInput1 := EscapeCSV(userInput1.Value)
    userInput2 := EscapeCSV(userInput2.Value)
    clipboardContent := EscapeCSV(A_Clipboard)

    ; Create the CSV line
    csvLine := userInput1 . "," . userInput2 . "," . clipboardContent . "`n"

    ; Append the user inputs and clipboard content to the CSV file in UTF-16 with BOM
    try {
        FileAppend(csvLine, outputFile, "UTF-16")
        MsgBox("Jazda jazdunia!!!`nZapisano", "Sukces", "T1")
    } catch as writeError {
        if (writeError.Number == 32) {  ; Error code 32 indicates the file is in use by another process
            MsgBox("Błąd: Plik 'output.csv' jest obecnie używany przez inny program. Zamknij wszystkie programy, które mogą korzystać z tego pliku i spróbuj ponownie.", "Plik w użyciu", "T16")
        } else {
            errorMessage := EscapeCSV("ERROR: " . A_Now) . "," . EscapeCSV("Error writing to CSV: " . writeError.Message) . "," . EscapeCSV("ERROR") . "`n"
            try {
                FileAppend(errorMessage, outputFile, "UTF-16")
                MsgBox("Błąd: Nie można zapisać danych.", "Błąd zapisu", "T2")
            } catch as logError {
                MsgBox("Krytyczny błąd: Nie można zapisać danych ani zalogować błędu. " . logError.Message, "Błąd krytyczny", "T16")
            }
        }
    }
}

; Function to exit the script
ExitScript() {
    MsgBox("Już się wyłączam", "Wyjście", "T3")
    ExitApp
}

; Create a hotkey to exit the script (Ctrl+Q)
!Esc::ExitScript()

