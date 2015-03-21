version$ = "v0.2"
OpenWindow(0,100,100,570,290,"Комментировалка " + version$)

Global pole2, pole1, str_begin, str_end

TextGadget(#PB_Any, 10, 10, 100, 25, "Исходник")
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 230)
AddGadgetItem(pole1, -1, "этот")
AddGadgetItem(pole1, -1, "текст")
AddGadgetItem(pole1, -1, "нужно")
AddGadgetItem(pole1, -1, "взять в кавычки")
TextGadget(#PB_Any, 370, 10, 100, 25, "Результат")
pole2 = EditorGadget(#PB_Any, 370, 40, 190, 230)
AddGadgetItem(pole2, -1, "<этот>")
AddGadgetItem(pole2, -1, "<текст>")
AddGadgetItem(pole2, -1, "<нужно>")
AddGadgetItem(pole2, -1, "<взять в кавычки>")
str_begin = StringGadget(#PB_Any, 210, 40, 150, 20, "<")
btn_begin = ButtonGadget(#PB_Any, 210, 70, 150, 25, "Добавить в начале строки")
str_end = StringGadget(#PB_Any, 210, 130, 150, 20, ">")
btn_end = ButtonGadget(#PB_Any, 210, 160, 150, 25, "Добавить в конце строки")
btn_both = ButtonGadget(#PB_Any, 210, 220, 150, 25, "Оба")

; управление с клавы
If CreatePopupMenu(0) 
  MenuItem(2, "Quit") 
EndIf 
AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2)

Procedure Add_to_begin()
  ClearGadgetItems(pole2)
  add$ = GetGadgetText(str_begin)
  numberOfStrings = CountGadgetItems(pole1) - 1
  For counter = 0 To numberOfStrings
    textPole1$ = GetGadgetItemText(pole1,counter)
    AddGadgetItem(pole2,-1,add$+textPole1$)
  Next
EndProcedure

Procedure Add_to_end()
  ClearGadgetItems(pole2)
  add$ = GetGadgetText(str_end)
  numberOfStrings = CountGadgetItems(pole1) - 1
  For counter = 0 To numberOfStrings
    textPole1$ = GetGadgetItemText(pole1,counter)
    AddGadgetItem(pole2,-1,textPole1$+add$)
  Next
EndProcedure

Procedure Add_to_both()
  ClearGadgetItems(pole2)
  add_begin$ = GetGadgetText(str_begin)
  add_end$ = GetGadgetText(str_end)
  numberOfStrings = CountGadgetItems(pole1) - 1
  For counter = 0 To numberOfStrings
    textPole1$ = GetGadgetItemText(pole1,counter)
    AddGadgetItem(pole2,-1,add_begin$+textPole1$+add_end$)
  Next
EndProcedure

Repeat
  event = WaitWindowEvent()
  ; закрывалка по эскейпу
  If event = #PB_Event_Menu And EventMenu() = 2 
    event = #PB_Event_CloseWindow
  EndIf
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case btn_begin
        Add_to_begin()
      Case btn_end
        Add_to_end()
      Case btn_both
        Add_to_both()
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow
