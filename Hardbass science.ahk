#Requires AutoHotkey v2.0

#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Create a custom GUI for user to choose the shortcut set
MyGui := Gui()
MyGui.SetFont("s10", "Segoe UI")

MyGui.Add("Text", "x10 y10 w500 h40", "Witamy w Hardbass science 🤙️").SetFont("s18")
MyGui.Add("Text", "x10 y60 w500 h40", "Wybierz preferowany zestaw skrótów klawiszowych:").SetFont("s10")
MyGui.Add("Radio", "x10 y100 w500 vShortcutSet Checked", "Prawy Alt + 'przecinek' oraz prawy Alt + 'kropka'").SetFont("s10")
MyGui.Add("Radio", "x10 y130 w500", "Lewy Alt + 'W' oraz lewy Alt + 'e'").SetFont("s10")
MyGui.Add("Button", "x10 y170 w120 h30", "OK").OnEvent("Click", ProcessChoice)
MyGui.Add("Text", "x10 y210 w500", "Aby zakończyć skrypt, kliknij prawym przyciskiem myszy na ikonę 'H'`nw pasku zadań systemu Windows (prawy dolny róg ekranu)").SetFont("s10")

MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.Title := "Hardbass Science"
MyGui.Show()

ProcessChoice(*)
{
    shortcutSet := MyGui.Submit()
    if (shortcutSet.ShortcutSet = 1) {
        MsgBox("Wybrałeś/aś Zestaw: Prawy Alt + 'przecinek' oraz prawy Alt + 'kropka'. Zaczynajmy!")
        SetupSet1()
    } else {
        MsgBox("Wybrałeś/aś Zestaw 2: Lewy Alt + 'W' oraz lewy Alt + 'e'. Zaczynajmy!")
        SetupSet2()
    }
    MyGui.Destroy()
}

SetupSet1()
{
    Hotkey "RAlt & ,", CopyAndProcess
    Hotkey "RAlt & .", ProcessClipboard
}

SetupSet2()
{
    Hotkey "!w", CopyAndProcess
    Hotkey "!e", ProcessClipboard
}

CopyAndProcess(*)
{
    Send "^c"  ; copy selection
    Sleep 100  ; gives time for the copy to work
    ProcessClipboard()
}

ProcessClipboard(*)  ; Added (*) here
{
    if (A_Clipboard = "") {
        MsgBox("Schowek jest pusty, nic nie skopiowano.")
        return
    }

    userInput := InputBox("Please enter the value for column 1:", "Input Required")
    if userInput.Result = "Cancel" {
        MsgBox("Operation cancelled by user.")
        return
    }

    userInput3 := InputBox("Please enter the value for column 3:", "Input Required")
    if userInput3.Result = "Cancel" {
        MsgBox("Operation cancelled by user.")
        return
    }

    outputFile := A_ScriptDir . "\output.csv"
    
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
        MsgBox("Plik CSV został pomyślnie zapisany. Jazda jazdunia!! 🔥 🔥 🔥")
    } catch as err {
        MsgBox("Error: Unable to write to file. " . err.Message)
    }
}
