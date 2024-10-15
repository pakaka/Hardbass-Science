#Requires AutoHotkey v2.0

#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Display "Hello" message box when the script starts
MsgBox("Witamy w Hardbass science 14-10-13-51🤙 `nalt+w używa zaznaczonego tekstu`nalt+e używa ostatnio skopiowanego tekstu.")

; !w::
RAlt & n::
{
    Send "^c"  ; copy selection
    Sleep 100  ; gives time for the copy to work
    ProcessClipboard()
}

; !e::
RAlt & m::ProcessClipboard()

ProcessClipboard() {
    if (A_Clipboard = "") {
        MsgBox("Schowek jest pust, nic nie skopiowano.")
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
