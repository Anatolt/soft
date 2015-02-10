; Починили с учителем кодировки. Дело былов BOM UTF. Открываем c помощью NPP и сохраняем в UTF без BOM. Всё становится на места.
; Разобрались с гитхабом. Оказывается надо было клонировать чтобы загрузить проект из облака на комп.
; К чёрту формы. Одни проблемы с ними.

OpenWindow(#PB_Any, 100, 100, 540, 400, "Найти и уничтожить", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget)
  pole1 = EditorGadget(#PB_Any, 10, 40, 190, 350)
  pole2 = EditorGadget(#PB_Any, 340, 40, 190, 310)
  pole_del1 = StringGadget(#PB_Any, 210, 70, 120, 20, "plus")
  pole_del2 = StringGadget(#PB_Any, 210, 100, 120, 20, "Obiwаn")
  pole_del3 = StringGadget(#PB_Any, 210, 130, 120, 20, "Klochkov")
  txt2 = TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
  txt3 = TextGadget(#PB_Any, 340, 10, 100, 25, "Поле 2")
  copy = ButtonGadget(#PB_Any, 340, 360, 190, 25, "← Копировать")
  btn_del = ButtonGadget(#PB_Any, 210, 40, 120, 25, "Удалить →")
AddGadgetItem(pole1,-1,"[14:59:08] 5UN5H1N3 вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:04:42] χ@ηΔ€® вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:13:29] <Obiwаn> .")
AddGadgetItem(pole1,-1,"[15:13:30] <hochleistungsfähigen> Obiwаn: Пинг от тебя 0.084 сек.")
AddGadgetItem(pole1,-1,"[16:24:29] aerohead вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[16:46:05] Ozz_Klochkov вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[17:35:21] plus`` вошёл(а) в комнату")
AddGadgetItem(pole1,-1,"[17:40:15] plus`` вышел(а) из комнаты")
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
      Case btn_del
        ClearGadgetItems(pole2)
        numberOfStringsPole1 = CountGadgetItems(pole1) - 1        ;считаем количество строк поля со списком исходных данных
        For i = 0 To numberOfStringsPole1
          txt$ = GetGadgetItemText(pole1,i)
          str1$ = GetGadgetText(pole_del1)
          str2$ = GetGadgetText(pole_del2)
          str3$ = GetGadgetText(pole_del3)
            If FindString(txt$,str1$) Or FindString(txt$,str2$) Or FindString(txt$,str3$) 
              Debug "удаляем"
            Else
              AddGadgetItem(pole2,-1,txt$)
              Debug "оставляем"
            EndIf 
        Next
        
      Case copy
        ClearGadgetItems(pole1)
        numberOfStringsPole2 = CountGadgetItems(pole2)
        For counter = 0 To numberOfStringsPole2
          textPole1$ = GetGadgetItemText(pole2,counter)
          AddGadgetItem(pole1,-1,textPole1$)
        Next
    EndSelect
  EndIf
  
Until event = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 48
; FirstLine = 23
; EnableUnicode
; EnableXP