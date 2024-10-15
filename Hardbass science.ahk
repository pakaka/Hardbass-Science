#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Display "Hello" message box when the script starts
;MsgBox, Witamy w Hardbass science 14-10-13-51🤙 `nalt+w używa zaznaczonego tekstu,`nalt+e używa ostatnio skopiowanego tekstu.`n 
MsgBox, Witamy w Hardbass science 14-10-13-51🤙 `nalt+w używa zaznaczonego tekstu,`nalt+e używa ostatnio skopiowanego tekstu.`n 

;!w::
RAlt & n::
    Sendinput ^c ; copy selection
    Sleep 100 ; gives time for the copy to work
    GoSub, ProcessClipboard
return


;!e::
RAlt & m::
    GoSub, ProcessClipboard
return

ProcessClipboard:
    if (clipboard = "")
    {
        MsgBox, Schowek jest pust, nic nie skopiowano.
        return
    }

    InputBox, userInput, Input Required, Please enter the value for column 1:
    if ErrorLevel
    {
        MsgBox, Operation cancelled by user.
        return
    }

    InputBox, userInput3, Input Required, Please enter the value for column 3:
    if ErrorLevel
    {
        MsgBox, Operation cancelled by user.
        return
    }

    outputFile := A_ScriptDir . "\output.csv"
    
    ; Function to properly escape and quote CSV fields
    EscapeCSV(field) {
        ; Escape double quotes by doubling them
        field := StrReplace(field, """", """""")
        ; Enclose field in double quotes if it contains commas, double quotes, or newlines
        if (InStr(field, ",") or InStr(field, """") or InStr(field, "`n")) {
            return """" . field . """"
        }
        return field
    }

    ; Escape and quote the user inputs and clipboard content
    userInput := EscapeCSV(userInput)
    userInput3 := EscapeCSV(userInput3)
    clipboardContent := EscapeCSV(clipboard)

    ; Create the CSV line
    csvLine := userInput . "," . clipboardContent . "," . userInput3 . "`n"

    ; Append the user inputs and clipboard content to the CSV file in UTF-16 with BOM
    FileAppend, %csvLine%, %outputFile%, UTF-16
    if (ErrorLevel)
    {
        MsgBox, Error: Unable to write to file. ErrorLevel: %ErrorLevel%
    }
    else
    {
        MsgBox, Plik CSV został pomyślnie zapisany. Jazda jazdunia!! 🔥 🔥 🔥 
    }
