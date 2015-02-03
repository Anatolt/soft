OpenWindow(0,100,100,520,290,"Удалялка строк")
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 230)
For l=1 To 20
  txt$ = Str(l)
  AddGadgetItem(pole1,-1,txt$)  
Next
pole2 = EditorGadget(#PB_Any, 330, 40, 190, 230)
btn = ButtonGadget(#PB_Any, 210, 190, 100, 25, "Тыдыщ")
str = StringGadget(#PB_Any, 210, 70, 100, 25, "3")
TextGadget(#PB_Any, 210, 40, 120, 20, "Удалить каждые")
TextGadget(#PB_Any, 210, 100, 120, 20, "строки из поля 1")
TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
TextGadget(#PB_Any, 320, 10, 100, 25, "Поле 2")
Repeat 
  event = WaitWindowEvent() 
  If EventGadget() = button
    ClearGadgetItems(pole2)
    i = 1 + Val(GetGadgetText(str))
    numberOfStrings = CountGadgetItems(pole1)
    For counter = 0 To numberOfStrings
      If (counter + i)%i=0
        textPole1$ = GetGadgetItemText(pole1,counter)
        AddGadgetItem(pole2,-1,textPole1$)
      EndIf
    Next
  EndIf
Until event = #PB_Event_CloseWindow
