#Requires AutoHotkey v2.0

; Hotkey to trigger the script (Ctrl+Shift+D)
; Ctrl+Shift+D:: 
^+d:: 
{
    ; Get text from clipboard
    articleQuery := A_Clipboard

    ; Check if clipboard is not empty
    if (articleQuery != "") 
    {
        ; Escape special characters in the query
        articleQuery := StrReplace(articleQuery, '"', '\"')
        
        ; Run the Python script and capture the output
        command := 'python get_doi.py "' . articleQuery . '"'
        result := ComObject("WScript.Shell").Exec(command).StdOut.ReadAll()

        ; Display the result in a message box
        MsgBox(result)
    }
    else
    {
        MsgBox("Clipboard is empty. Please copy some text before running the script.")
    }
}
