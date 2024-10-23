#Requires AutoHotkey v2.0

#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
; --------------------------
versionNumber := "16-10-2024 v5"
; --------------------------



; Check if output.csv exists, create it if not
outputFile := A_WorkingDir . "\output.csv"
if !FileExist(outputFile) {
    try {
        FileAppend(Chr(0xFEFF), outputFile, "UTF-8")  ; Create file with UTF-8 BOM
        MsgBox("Utworzono nowy plik 'output.csv'. Zbierany przez ciebie tekst będzie tam zapisywany.", "Plik Utworzony")
    } catch as err {
        MsgBox("Error: Nie udało się utworzyć pliku 'output.csv', spróbuj stworzyć go samodzielnie w folderze z tym skryptem.", "Error")
        ExitApp()
    }
}

; Add these global variables at the top of your script, after other global declarations
global lastUserInput1 := "???"
global lastUserInput2 := "???"
global lastUserInput3 := "???"

; Create a custom GUI for user to choose the shortcut set
MyGui := Gui(, "w500 h500")  ; Changed width from 600 to 500
MyGui.SetFont("s10", "Segoe UI")

MyGui.Add("Text", "x10 y10 w470 h40", "Witam w Hardbass science 🤙️").SetFont("s18")
MyGui.Add("Text", "x10 y60 w470 h40", "Wybierz preferowany zestaw skrótów klawiszowych:")
MyGui.Add("Radio", "x10 y100 w470 vShortcutSet Checked", "1: Lewy Alt + 'W'    2: Lewy Alt + 'E'    3: Lewy Alt + 'R'")
MyGui.Add("Radio", "x10 y130 w470", "1: Prawy Alt + ','     2: Prawy Alt + '.'     3: Prawy Alt + '/'     ")
MyGui.Add("Text", "x10 y145 w300 h30 Center", "`(przecinek, kropka i ukośnik`)").SetFont("s8 cGray")


; Add new radio buttons for input prompt choice
MyGui.Add("Text", "x10 y170 w470 h30", "Wybierz liczbę pól do wprowadzania:")
MyGui.Add("Radio", "x10 y200 w470 vInputPrompts", "2 pola (kategoria i autor)")
MyGui.Add("Radio", "x10 y230 w470 Checked", "3 pola (kategoria, autor i dodatkowe informacje)")

MyGui.Add("Button", "x10 y270 w120 h30", "OK").OnEvent("Click", ProcessChoice)

MyGui.Add("Text", "x10 y310 w470 h30", "Instrukcja").SetFont("s12 bold")
MyGui.Add("Text", "x20 y340 w470 h310", "To narzędzie służy do łatwego zbierania i zapisywania tekstu z różnych źródeł.`nPo kliknięciu 'OK', program będzie działał w tle.`nZebrane dane będą zapisywane w pliku 'output.csv' w folderze ze skryptem.`nAby zapisać tekst, zaznacz go i wciśnij skrót 1. Alternatywnie skorzystaj ze`nskrótu 2, aby użyć tekstu wcześniej zapisanego w schowku (ctrl+c). `nRegularnie sprawdzaj plik 'output.csv' i rób kopie zapasowe.`nAby zakończyć, kliknij prawym przyciskiem myszy na ikonę 'H' w obszarze powiadomień (w prawym rogu paska zadań systemu windows), lub kliknij Alt+Esc.`nProgram daje możliwośc wygodnego pobierania artykułów z Sci-Hub'a na podstawie DOI z bazy crossref.org, aby skorzystać z tej funkcji zaznacz tytuł pracy i aktywuj skrót 3")
MyGui.Add("Text", "x20 y600 w470 h20 Right", "Wersja z dnia " . versionNumber).SetFont("s8")

; Add GitHub link
MyGui.Add("Link", "x20 y600 w100 h20", "<a href=`"https://github.com/pakaka/Hardbass-Science---Text-Collection-Tool`">Github</a>")

MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.Title := "Hardbass Science"
MyGui.Show()

ProcessChoice(*)
{
    global inputPromptCount  ; Explicitly declare we're using the global variable

    shortcutSet := MyGui.Submit()
    if (shortcutSet.ShortcutSet = 1) {
        SetupSet1()
    } else if (shortcutSet.ShortcutSet = 2) {
        SetupSet2()
    } else {
        MsgBox("Nieprawidłowy wybór zestawu skrótów.", "Błąd")
        return
    }
    
    ; Set the input prompt count based on user's choice
    inputPromptCount := shortcutSet.InputPrompts = 1 ? 2 : 3
    
    MsgBox("To lecimy!", "Success", "T1")
    MyGui.Destroy()
}



SetupSet1()
{
    Hotkey "!w", CopyAndProcess
    Hotkey "!e", ProcessClipboard
    Hotkey "!r", (*) => GetFromScihub()  ; Changed this line
}

SetupSet2()
{
    Hotkey "RAlt & ,", CopyAndProcess
    Hotkey "RAlt & .", ProcessClipboard
    Hotkey "RAlt & /", (*) => GetFromScihub()  ; Changed this line
}

CopyAndProcess(*)
{
    Send "^c"  ; copy selection
    Sleep 100  ; gives time for the copy to work
    ProcessClipboard()
}

ProcessClipboard(*)
{
    global outputFile, lastUserInput1, lastUserInput2, lastUserInput3, inputPromptCount  

    ; Show the clipboard preview GUI
    PreviewGui := Gui()
    PreviewGui.Opt("+Resize +MinSize500x300")  ; Increased minimum width to 500
    PreviewGui.SetFont("s7", "Segoe UI")
    PreviewGui.Add("Edit", "x10 y10 w480 h200 vClipboardContent", A_Clipboard)  ; Increased width to 480
    saveButton := PreviewGui.Add("Button", "x125 y220 w90 h30", "Ok")
    saveButton.OnEvent("Click", SaveContent)
    PreviewGui.Add("Button", "x285 y220 w90 h30", "Cancel").OnEvent("Click", (*) => PreviewGui.Destroy())
    PreviewGui.OnEvent("Close", (*) => PreviewGui.Destroy())
    PreviewGui.Title := "Podgląd i edycja schowka"
    
    clipboardContent := ""
    
    SaveContent(*)
    {
        clipboardContent := PreviewGui["ClipboardContent"].Value
        PreviewGui.Destroy()
    }
    
    PreviewGui.Show()
    saveButton.Focus()  ; Focus the "Ok" button after showing the GUI

    ; Wait for the GUI to close
    WinWaitClose("ahk_id " . PreviewGui.Hwnd)
    
    if (clipboardContent = "") {
        MsgBox("Schowek jest pusty lub operacja anulowana.", "Uwaga", "T2")
        return
    }

    userInput1 := InputBox("To zostanie zapiane w kolumnie 1 np. kategoria, tytuł akpitu: `n`(pozostawienie pustego pola automatycznie wypełnia je symbolem zastępczym '???'`)", , , lastUserInput1)
    if userInput1.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput1.Value := userInput1.Value = "" ? "???" : userInput1.Value
    lastUserInput1 := userInput1.Value  ; Remember the last input

    userInput2 := InputBox("To zostanie zapiane w kolumnie 2 np. nazwisko autora: `n`(pozostawienie pustego pola automatycznie wypełnia je symbolem zastępczym '???'`)", , , lastUserInput2)
    if userInput2.Result = "Cancel" {
        MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
        return
    }
    userInput2.Value := userInput2.Value = "" ? "???" : userInput2.Value
    lastUserInput2 := userInput2.Value  ; Remember the last input

    ; Only show the third input box if the user chose 3 input prompts
    if (inputPromptCount = 3) {
        userInput3 := InputBox("To zostanie zapiane w kolumnie 3 np. dodatkowe informacje: `n`(pozostawienie pustego pola automatycznie wypełnia je symbolem zastępczym '???'`)", , , lastUserInput3)
        if userInput3.Result = "Cancel" {
            MsgBox("Operacja anulowana przez użytkownika.", "Informacja", "T1")
            return
        }
        userInput3.Value := userInput3.Value = "" ? "???" : userInput3.Value
        lastUserInput3 := "???" ; always set to ???
    } else {
        userInput3 := {Value: "???"}
    }

    ; Function to properly escape and quote CSV fields
    EscapeCSV(field) {
        ; Remove any existing double quotes at the start and end
        field := RegExReplace(field, '^"|"$', '')
        
        ; Replace any double quotes within the field with two double quotes
        field := StrReplace(field, '"', '""')
        
        ; If the field contains commas, newlines, or double quotes, enclose it in quotes
        if (InStr(field, ",") || InStr(field, "`n") || InStr(field, '"'))
            field := '"' . field . '"'
        
        return field
    }

    ; Escape and process the user inputs and clipboard content
    userInput1 := EscapeCSV(userInput1.Value)
    userInput2 := EscapeCSV(userInput2.Value)
    userInput3 := EscapeCSV(userInput3.Value)
    clipboardContent := EscapeCSV(clipboardContent)  ; Use the captured clipboard content

    ; Create the CSV line with the new order: userInput1, userInput2, clipboardContent, userInput3
    csvLine := userInput1 . "," . userInput2 . "," . clipboardContent . "," . userInput3 . "`n"

    ; Append the user inputs and clipboard content to the CSV file in UTF-8 with BOM
    try {
        if (!FileExist(outputFile)) {
            FileAppend(Chr(0xFEFF), outputFile, "UTF-8")  ; Add UTF-8 BOM if file doesn't exist
        }
        FileAppend(csvLine, outputFile, "UTF-8")
        MsgBox("Jazda jazdunia!!!`nZapisano", "Sukces", "T1")
    } catch as writeError {
        MsgBox("Error writing to file: " . writeError.Message, "Error", "T3")
    }
}

; Function to exit the script
ExitScript() {
    MsgBox("Już się wyłączam", "Wyjście", "T3")
    ExitApp
}

; Create a hotkey to exit the script (Alt+Esc)
!Esc::ExitScript()

; Add this new hotkey and function near the end of the file, before ExitScript()
;!r::GetDOI()

GetFromScihub(*) {  ; Renamed from GetDOI(*) to GetFromScihub(*)
    ; Copy selected text
    Send "^c"
    Sleep 100  ; Short delay to ensure the copy operation completes

    ; Get text from clipboard (which now contains the selected text)
    articleQuery := A_Clipboard

    ; Check if selection is not empty
    if (articleQuery != "") 
    {
        ; Escape special characters in the query
        articleQuery := StrReplace(articleQuery, '"', '\"')
        
        ; Run the executable and capture the output
        command := 'System_Files\dist\get_doi.exe "' . articleQuery . '"'
        result := ComObject("WScript.Shell").Exec(command).StdOut.ReadAll()

        ; Extract DOI from the result (assuming it's the first line)
        doi := StrSplit(result, "`n")[1]

        ; Extract title from the result (assuming it's the second line)
        title := StrSplit(result, "`n")[2]

        ; Check if DOI starts with "No results found"
        if (SubStr(doi, 1, 16) = "No results found") {
            doi := "Nie znaleziono pracy w bazie crossref.org"
            title := "Nie znaleziono pracy w bazie crossref.org"
        }


        ; Create a GUI to display the results
        ResultGui := Gui()
        ResultGui.Opt("+AlwaysOnTop")
        ResultGui.SetFont("s10", "Segoe UI")
        
        ResultGui.Add("Text", "x10 y10 w480", "Pobrany tytuł:").SetFont("s7 cGray")

        ResultGui.Add("Text", "x10 y30 w480 h60 vTitle", title).SetFont("s12")
        
        ResultGui.Add("Text", "x10 y100 w480", "DOI:").SetFont("s7 cGray")
        ResultGui.Add("Text", "x10 y115 w480", doi).SetFont("s7 cGray")

        ResultGui.Add("Text", "x10 y160 w480", "Czy znaleziony tytuł odpowiada pracy, której szukasz?").SetFont("s9 cGray")
        ResultGui.Add("Text", "x10 y180 w480", "Jeśli tak, to zostaniesz przekierowany/a do Sci-Hub'a.").SetFont("s9 cGray")
        ResultGui.Add("Text", "x10 y200 w480", "Jeśli nie, lub na Sci-Hub'ie brakuje tego artykułu, to musisz wyszukać go ręcznie, zaznaczony przez ciebie tekst został zapisany w schowku").SetFont("s9 cGray")
        
        yesButton := ResultGui.Add("Button", "x170 y240 w70 h30", "Tak")
        yesButton.OnEvent("Click", (*) => OpenSciHub(doi, ResultGui))
        noButton := ResultGui.Add("Button", "x260 y240 w70 h30", "Nie")
        noButton.OnEvent("Click", (*) => ResultGui.Destroy())
        
        ResultGui.OnEvent("Close", (*) => ResultGui.Destroy())
        ResultGui.Title := "Article Information"
        ResultGui.Show()

        ; Focus the appropriate button
        if (SubStr(doi, 1, 16) = "No results found") {
            noButton.Focus()
        } else {
            yesButton.Focus()
        }
    }
    else
    {
        MsgBox("No text selected.", "Error", "T2")
    }
}

OpenSciHub(doi, gui) {
    ; Create Sci-Hub link
    scihubLink := "https://www.sci-hub.st/" . doi

    ; Open Sci-Hub link in default browser
    if (doi != "") {
        Run scihubLink
        gui.Destroy()
    } else {
        MsgBox("Nie znaleziono DOI dla podanego zapytania.", "Brak DOI", "T2")
    }
}






