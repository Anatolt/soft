IncludeFile "server-login-pass.pbf"

OpenWnd()

;закрывалка по эскейпу
If CreatePopupMenu(0) 
  MenuItem(1, "Enter")
  MenuItem(2, "Quit")
EndIf
AddKeyboardShortcut(Wnd, #PB_Shortcut_Escape, 2) 
AddKeyboardShortcut(Wnd, #PB_Shortcut_Return, 1)

Repeat 
  event = WaitWindowEvent()
  If event = #PB_Event_Menu And EventMenu() = 2 ; esc
    event = #PB_Event_CloseWindow
  EndIf 
  
  If (event = #PB_Event_Menu And EventMenu() = 1) Or (event = #PB_Event_Gadget And EventGadget() = Enter)
    Debug GetGadgetText(Server)
    Debug GetGadgetText(Login)
    Debug GetGadgetText(Pass)
  EndIf
Until event = #PB_Event_CloseWindow
