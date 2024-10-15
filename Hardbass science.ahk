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

; Create a custom GUI for user to choose the shortcut set
MyGui := Gui()
MyGui.SetFont("s10", "Segoe UI")


MyGui.Add("Text", "x10 y10 w500 h40", "Witam w Hardbass science 🤙️").SetFont("s18")
MyGui.Add("Text", "x10 y60 w500 h40", "Wybierz preferowany zestaw skrótów klawiszowych:")
MyGui.Add("Radio", "x10 y100 w500 vShortcutSet Checked", "1: Lewy Alt + 'W'    2: Lewy Alt + 'E'")
MyGui.Add("Radio", "x10 y130 w500", "1: Prawy Alt + ','     2: Prawy Alt + '.'     `(przecinek i kropka`)")
MyGui.Add("Button", "x10 y170 w120 h30", "OK").OnEvent("Click", ProcessChoice)

MyGui.Add("Text", "x10 y220 w500", "Instrukcje użytkowania:").SetFont("s12 bold")
MyGui.Add("Text", "x10 y250 w500", "To narzędzie służy do łatwego zbierania i zapisywania tekstu z różnych źródeł.")
MyGui.Add("Text", "x10 y280 w500", "1. Po kliknięciu 'OK', program będzie działał w tle.")
MyGui.Add("Text", "x10 y310 w500", "2. Zebrane dane będą zapisywane w pliku 'output.csv' w folderze skryptu.")
MyGui.Add("Text", "x10 y340 w500", "3. Aby zapisać tekst, zaznacz go i użyj skrótu 1.")
MyGui.Add("Text", "x10 y370 w500", "4. Możesz też użyć skrótu 2, aby zapisać tekst ze schowka (ctrl+c).")
MyGui.Add("Text", "x10 y400 w500", "5. Regularnie sprawdzaj plik 'output.csv' i rób kopie zapasowe.")
MyGui.Add("Text", "x10 y430 w500", "6. Aby zakończyć, kliknij prawym przyciskiem myszy na ikonę 'H' w obszarze powiadomień.")

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
    global outputFile  ; Use the global outputFile variable

    if (A_Clipboard = "") {
        MsgBox("Schowek jest pusty, nic nie skopiowano.", "Uwaga", "T2")
        return
    }

    userInput := InputBox("To zostanie zapiane w kolumnie 1 (np. kategoria, tytuł akpitu): ")
    if userInput.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput.Value := userInput.Value = "" ? "???" : userInput.Value

    userInput3 := InputBox("To zostanie zapiane w kolumnie 3 (np. nazwisko autora): ")
    if userInput3.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput3.Value := userInput3.Value = "" ? "???" : userInput3.Value

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
    userInput := EscapeCSV(userInput.Value)
    userInput3 := EscapeCSV(userInput3.Value)
    clipboardContent := EscapeCSV(A_Clipboard)

    ; Create the CSV line
    csvLine := userInput . "," . clipboardContent . "," . userInput3 . "`n"

    ; Append the user inputs and clipboard content to the CSV file in UTF-16 with BOM
    try {
        FileAppend(csvLine, outputFile, "UTF-16")
        MsgBox("Jazda jazdunia!!!`nZapisano", "Sukces", "T1")
    } catch as writeError {
        errorMessage := EscapeCSV("ERROR: " . A_Now) . "," . EscapeCSV("Error writing to CSV: " . writeError.Message) . "," . EscapeCSV("ERROR") . "`n"
        try {
            FileAppend(errorMessage, outputFile, "UTF-16")
            MsgBox("Błąd: Nie można zapisać danych.", "Błąd zapisu", "T2")
        } catch as logError {
            MsgBox("Krytyczny błąd: Nie można zapisać danych ani zalogować błędu. " . logError.Message, "Błąd krytyczny", "T16")
        }
    }
}
