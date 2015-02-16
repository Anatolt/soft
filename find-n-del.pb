; Починили с учителем кодировки. Дело былов BOM UTF. Открываем c помощью NPP и сохраняем в UTF без BOM. Всё становится на места.
; Разобрались с гитхабом. Оказывается надо было клонировать чтобы загрузить проект из облака на комп.
 
IncludeFile "find-n-del-test.pbf"
OpenWindow_0()
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
      Case btn
        ClearGadgetItems(pole2)
        numberOfStrings = CountGadgetItems(pole1)        ;считаем количество строк поля со списком исходных данных
        numberOfStrings_del = CountGadgetItems(pole_del) ;считаем количество строк поля со списком на удаление
       
        For counter = 0 To numberOfStrings
          textPole1$ = GetGadgetItemText(pole1,counter)
          For counter_del = 0 To numberOfStrings_del
            text_pole_del$ = GetGadgetItemText(pole_del,counter_del) ;берем элемент №counter_del и пишем в переменную text_pole_del$
            Debug "testing {" + text_pole_del$ + "} against {" + textPole1$ + "}: " + Str(FindString(textPole1$, text_pole_del$))
            If FindString(textPole1$, text_pole_del$)
              ; нет никакого смысла проверять дальше если мы уже нашли совпадение, выходим из цикла
              counter_del = numberOfStrings_del
            ElseIf counter_del = numberOfStrings_del
              ; а вот если это последний элемент и строка до сих пор не найдена, то можно уже и добавить
              AddGadgetItem(pole2,-1,textPole1$)
            EndIf
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
