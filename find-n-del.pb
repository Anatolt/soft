; идеи - добавить кнопку копирующую поле2 в поле1
; если вбить в поле поискать пробел - то прога удалит строку с ним. хм
; убрал единственную кнопку. хотел написать реакцию на потерю фокуса из поля 1. 
; а прога сама меняет знаечения  поля 2 через секунду

IncludeFile "C:\Users\Tolik\Documents\GitHub\find-n-del\find-n-del.pbf"
OpenWindow_0()

Repeat 
  event = WaitWindowEvent() 
  If EventGadget() = button
    ClearGadgetItems(pole2)
    textStr$ = GetGadgetText(str)
    numberOfStrings = CountGadgetItems(pole1)
    For counter = 0 To numberOfStrings
      textPole1$ = GetGadgetItemText(pole1,counter)
      If Not textStr$ = textPole1$ 
        AddGadgetItem(pole2,-1,textPole1$)
      EndIf
    Next
    EndIf
Until event = #PB_Event_CloseWindow
