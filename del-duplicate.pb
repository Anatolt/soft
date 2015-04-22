; удалялка дубликатов строк v0.4 не работает
OpenWindow(0,100,100,530,290,"Удалялка дублей")
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 230)

;генерим 10 произвольных строк с цифрами
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
  NewList FuckingList()
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf ; закрывалка по эскейпу
  If event = #PB_Event_Gadget And EventGadget() = btn
    ClearGadgetItems(pole2)
    numberOfStrings = CountGadgetItems(pole1) - 1
    For i = 0 To numberOfStrings
      first$ = GetGadgetItemText(pole1,i)
      For j = 0 To numberOfStrings
        second$ = GetGadgetItemText(pole1,j)
        If i = j
          Break
        Else
          If first$ = second$
            Debug "совпадонс "+Str(i+1)+" "+Str(j+1)
            AddElement(FuckingList())
            FuckingList() = i+1
            AddElement(FuckingList())
            FuckingList() = j+1
            Break
          EndIf
        EndIf
      Next
    Next
    Debug "---"
    SortList(FuckingList(),Start)
    ForEach FuckingList()
      Debug FuckingList()
    Next
  EndIf
Until event = #PB_Event_CloseWindow
