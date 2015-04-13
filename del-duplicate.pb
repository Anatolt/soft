; удалялка дубликатов строк v0.2 не работает
OpenWindow(0,100,100,530,290,"Удалялка дублей")
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 230)
For i=0 To 9
  r=Random(9)
  AddGadgetItem(pole1,-1,Str(r))
Next

pole2 = EditorGadget(#PB_Any, 330, 40, 190, 230)
btn = ButtonGadget(#PB_Any, 210, 190, 100, 25, "Да!")
TextGadget(#PB_Any, 210, 40, 120, 20, "Удалить повторы")
TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
TextGadget(#PB_Any, 320, 10, 100, 25, "Поле 2")

If CreatePopupMenu(0) : MenuItem(2, "Quit") : EndIf : AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2) ;закрывалка по эскейпу

Repeat
  event = WaitWindowEvent()
  
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf ; закрывалка по эскейпу
  If event = #PB_Event_Gadget And EventGadget() = btn
    ClearGadgetItems(pole2)
    numberOfStrings = CountGadgetItems(pole1) - 1
    Debug numberOfStrings
    For counter1 = 0 To numberOfStrings
      textPole1_1$ = GetGadgetItemText(pole1,counter1)
      For counter2 = 0 To numberOfStrings
        Debug "#"+Str(counter1)+"_"+textPole1_1$ +"vs"+ "#"+Str(counter2)+"_"+textPole1_2$
        If counter1 = counter2
          Debug "skip cause # same"
          Break
        Else
          textPole1_2$ = GetGadgetItemText(pole1,counter2)
          If textPole1_1$ = textPole1_2$
            Debug "waaa"
          Else
            AddGadgetItem(pole2,-1,textPole1_1$)
            Debug "good"
            Break
          EndIf
        EndIf
      Next
    Next
  EndIf
Until event = #PB_Event_CloseWindow
