version$ = "v0.1"
OpenWindow(0,100,100,530,290,"Комментировалка " + version$)

Global pole2, pole1, str

pole1 = EditorGadget(#PB_Any, 10, 40, 190, 230)
AddGadgetItem(pole1,-1,"этот")
AddGadgetItem(pole1,-1,"текст")
AddGadgetItem(pole1,-1,"нужно")
AddGadgetItem(pole1,-1,"закомментировать")
pole2 = EditorGadget(#PB_Any, 330, 40, 190, 230)
btn = ButtonGadget(#PB_Any, 210, 210, 100, 25, "Ctrl+Enter")
str = StringGadget(#PB_Any, 210, 100, 100, 25, "# ")
TextGadget(#PB_Any, 210, 40, 120, 40, "Добавить в начале каждой строки")
; TextGadget(#PB_Any, 210, 100, 120, 20, "строки из поля 1")
TextGadget(#PB_Any, 10, 10, 100, 25, "Исходник")
TextGadget(#PB_Any, 320, 10, 100, 25, "Результат")
; управление с клавы
If CreatePopupMenu(0) 
  MenuItem(2, "Quit") 
  MenuItem(1, "Do the job") 
EndIf 
AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2)
AddKeyboardShortcut(0, #PB_Shortcut_Control | #PB_Shortcut_Return, 1)

Procedure Do_the_job()
  ClearGadgetItems(pole2)
  add$ = GetGadgetText(str)
  numberOfStrings = CountGadgetItems(pole1) - 1
  For counter = 0 To numberOfStrings
    textPole1$ = GetGadgetItemText(pole1,counter)
    AddGadgetItem(pole2,-1,add$+textPole1$)
  Next
EndProcedure

Repeat
  event = WaitWindowEvent()
  ; закрывалка по эскейпу
  If event = #PB_Event_Menu 
    Select EventMenu()
      Case 2 
        event = #PB_Event_CloseWindow
      Case 1
        Do_the_job()
    EndSelect
  EndIf
  If event = #PB_Event_Gadget And EventGadget() = btn
    Do_the_job()
  EndIf
Until event = #PB_Event_CloseWindow
