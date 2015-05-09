#Persistent

GetSkypeMainWindowClass() {
  Return, % "ahk_class tSkMainForm"
}

GetContactInfoClass() {
  Return, % "ahk_class TContactInfoForm"
}

GetSkypeMainWindowId() {
  WinGet, id, ID, % GetSkypeMainWindowClass()
  Return, %id%
}

GetContactInfoWindowId() {
  WinGet, id, ID, % GetContactInfoClass()
  Return, %id%
}

GetSkypeMainWindowPid() {
  WinGet, pid, PID, % GetSkypeMainWindowClass()
  Return, %pid%
}

ActivateSkypeMainWindow() {
  id := GetSkypeMainWindowId()
  WinActivate, ahk_id %id%
  Return, % WinActive("ahk_id " . id)
}

WaitActiveSkypeMainWindow() {
  id := GetSkypeMainWindowId()
  WinWaitActive, ahk_id %id%, , 10
  Return, % WinActive("ahk_id " . id)
}

ActivateConversationInfoWindow() {
  id := GetContactInfoWindowId()
  WinActivate, ahk_id %id%
  Return, % WinActive("ahk_id " . id)
}

GetContactInfoWindowPos() {
  id := GetContactInfoWindowId()
  WinGetPos, X, Y, W, H, ahk_id %id%
  Return, % X . "," . Y . "," . W . "," H
}

WaitActiveContactInfoWindow() {
  id := GetContactInfoWindowId()
  WinWaitActive, ahk_id %id%, , 10
  Return, % WinActive("ahk_id " . id)
}

CloseContactInfoWindow() {
  id := GetContactInfoWindowId()
  WinClose, ahk_id %id%, ,
  WinWaitClose, ahk_id %id%, , 10
  Return, ErrorLevel
}

ForceCloseSkypeProcess() {
  pid := GetSkypemainWindowPid()
  Process, Close, %pid%
  Return, ErrorLevel
}

StartSkypeProcess(path) {
  Run, %path%, , , pid
  
  if (pid) {
    WinWait, % GetSkypeMainWindowClass()
    Return, ErrorLevel
  }
  
  Return, 1
}

IsSkypeRunning() {
  if (GetSkypeMainWindowId()) {
    Return, 0
  }
  
  Return, 1
}
