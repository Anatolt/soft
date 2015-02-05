; узнал, что можно править форматирование не всего документа, но его часть
; нашёл команду FindString()
; если вставить текст из примера написанного на js - программа зависат
; отключил работу проги без нажатия на кнопку. я всё равно не понимаю как это работает. клюк с текстом пропал
; столкнулся с аномалией - перестала работать кнопка. переделал всё из инклюда в один файл
; столкнулся с глюком - сломались кодировки

OpenWindow(0, 100, 100, 540, 400, "Найти и уничтожить", #PB_Window_SystemMenu)
pole1 = EditorGadget(#PB_Any, 10, 40, 190, 350)
pole2 = EditorGadget(#PB_Any, 340, 40, 190, 350)
str = StringGadget(#PB_Any, 210, 90, 120, 25, "выход")
txt = TextGadget(#PB_Any, 210, 40, 120, 40, "Удалить строку, содержащую")
txt2 = TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
txt3 = TextGadget(#PB_Any, 340, 10, 100, 25, "Поле 2")
copy = ButtonGadget(#PB_Any, 210, 360, 120, 25, "← Копировать")
btn = ButtonGadget(#PB_Any, 220, 120, 100, 25, "Удалить →")
AddGadgetItem(pole1,-1,"[14:59:08] 5UN5H1N3 вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:04:42] χ@ηΔ€® вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:13:29] <Obiwаn> .")
AddGadgetItem(pole1,-1,"[15:13:30] <hochleistungsfähigen> Obiwаn: Пинг от тебя 0.084 сек.")
AddGadgetItem(pole1,-1,"[16:24:29] aerohead вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[16:46:05] Ozz_Klochkov вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[17:35:21] plus`` вошёл(а) в комнату")
AddGadgetItem(pole1,-1,"[17:40:15] plus`` вышел(а) из комнаты")

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

; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 10
; EnableUnicode
; EnableXP