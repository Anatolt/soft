; Починили с учителем кодировки. Дело былов BOM UTF. Открываем c помощью NPP и сохраняем в UTF без BOM. Всё становится на места.
; Разобрались с гитхабом. Оказывается надо было клонировать чтобы загрузить проект из облака на комп.
; К чёрту формы. Одни проблемы с ними.

OpenWindow(#PB_Any, 100, 100, 540, 400, "Найти и уничтожить", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget)
  pole1 = EditorGadget(#PB_Any, 10, 40, 190, 350)
  pole2 = EditorGadget(#PB_Any, 340, 40, 190, 310)
  txt2 = TextGadget(#PB_Any, 10, 10, 100, 25, "Поле 1")
  txt3 = TextGadget(#PB_Any, 340, 10, 100, 25, "Поле 2")
  copy = ButtonGadget(#PB_Any, 340, 360, 190, 25, "← Копировать")
  btn_del = ButtonGadget(#PB_Any, 210, 40, 120, 25, "Удалить →")
  pole_del = EditorGadget(#PB_Any, 210, 70, 120, 320)
AddGadgetItem(pole1,-1,"[14:59:08] 5UN5H1N3 вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:04:42] χ@ηΔ€® вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[15:13:29] <Obiwаn> .")
AddGadgetItem(pole1,-1,"[15:13:30] <hochleistungsfähigen> Obiwаn: Пинг от тебя 0.084 сек.")
AddGadgetItem(pole1,-1,"[16:24:29] aerohead вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[16:46:05] Ozz_Klochkov вышел(а) из комнаты")
AddGadgetItem(pole1,-1,"[17:35:21] plus`` вошёл(а) в комнату")
AddGadgetItem(pole1,-1,"[17:40:15] plus`` вышел(а) из комнаты")
AddGadgetItem(pole_del,-1,"вышел")
AddGadgetItem(pole_del,-1,"вошёл")

Repeat 
  event = WaitWindowEvent() 
  If event = #PB_Event_Gadget
    Select EventGadget() 
      Case btn_del
        ClearGadgetItems(pole2)
        numberOfStrings = CountGadgetItems(pole1)-1        ;считаем количество строк поля со списком исходных данных
        numberOfStrings_del = CountGadgetItems(pole_del)-1 ;считаем количество строк поля со списком на удаление
        
        For counter_del = 0 To numberOfStrings_del
          text_pole_del$ = GetGadgetItemText(pole_del,counter_del) ;берем элемент №counter_del и пишем в переменную text_pole_del$ 
          For counter = 0 To numberOfStrings
            textPole1$ = GetGadgetItemText(pole1,counter)
            Debug "testing {" + text_pole_del$ + "} against {" + textPole1$ + "}: " + Str(FindString(textPole1$, text_pole_del$))
            If Not FindString(textPole1$, text_pole_del$) : AddGadgetItem(pole2,-1,textPole1$) : EndIf ; аномалия: если убрать нот, работает верно наоборот, если поставить чёрти что
          Next
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
; CursorPosition = 29
; FirstLine = 12
; EnableUnicode
; EnableXP