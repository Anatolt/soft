; узнал, что можно править форматирование не всего документа, но его часть
; нашёл команду FindString()
; если вставить текст из примера написанного на js - программа зависат
; отключил работу проги без нажатия на кнопку. я всё равно не понимаю как это работает. клюк с текстом пропал
; столкнулся с аномалией - перестала работать кнопка. переделал всё из инклюда в один файл
; столкнулся с глюком - сломались кодировки

OpenWindow(0, 100, 100, 540, 400, "Найти и уничтожить", #PB_Window_SystemMenu)
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 350)
pole2 = EditorGadget(#PB_Any, 340, 40, 190, 350)
str = StringGadget(#PB_Any, 210, 90, 120, 25, "два")
txt = TextGadget(#PB_Any, 210, 40, 120, 40, "Удалить строку, содержащую")
txt2 = TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
txt3 = TextGadget(#PB_Any, 340, 10, 100, 25, "Поле 2")
copy = ButtonGadget(#PB_Any, 210, 360, 120, 25, "← Копировать")
btn = ButtonGadget(#PB_Any, 220, 120, 100, 25, "Удалить →")
AddGadgetItem(pole1,-1,"один два три")
AddGadgetItem(pole1,-1,"четыре пять шесть")
AddGadgetItem(pole1,-1,"семь восемь девять")

Repeat 
  event = WaitWindowEvent() 
  If event = #PB_Event_Gadget
    Select EventGadget() 
      Case btn
        ClearGadgetItems(pole2)
        textStr$ = GetGadgetText(str)
        numberOfStrings = CountGadgetItems(pole1)
        For counter = 0 To numberOfStrings
          textPole1$ = GetGadgetItemText(pole1,counter)
          If Not FindString(textPole1$, textStr$)
            AddGadgetItem(pole2,-1,textPole1$)
          EndIf
        Next
      Case copy
        ClearGadgetItems(pole1)
        numberOfStrings = CountGadgetItems(pole2)
        For counter = 0 To numberOfStrings
          textPole1$ = GetGadgetItemText(pole2,counter)
          AddGadgetItem(pole1,-1,textPole1$)
        Next
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
