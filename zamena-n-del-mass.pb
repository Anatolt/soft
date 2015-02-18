; программа удаляет строки если они содержат искомый текст
OpenWindow(0, 100, 100, 830, 530, "Массовая заменялка", #PB_Window_SystemMenu)
ishodnik = EditorGadget(#PB_Any, 10, 10, 400, 510)
chto = EditorGadget(#PB_Any, 420, 170, 200, 100)
na_chto = EditorGadget(#PB_Any, 630, 170, 190, 100)
btn = ButtonGadget(#PB_Any, 420, 280, 400, 30, "Сделал дело - гуляй смело")
result = EditorGadget(#PB_Any, 420, 320, 400, 200)
pole_del = EditorGadget(#PB_Any, 420, 40, 210, 90)
Text_0 = TextGadget(#PB_Any, 420, 10, 210, 25, "Удалить строки содержащие")
Text_1 = TextGadget(#PB_Any, 420, 140, 210, 25, "Заменить")
Text_2 = TextGadget(#PB_Any, 630, 140, 190, 25, "на")

AddGadgetItem(ishodnik,-1,"[14:59:08] 5UN5H1N3 вышел(а) из комнаты")
AddGadgetItem(ishodnik,-1,"[15:04:42] χ@ηΔ€® вышел(а) из комнаты")
AddGadgetItem(ishodnik,-1,"[15:13:29] <Obiwаn> .")
AddGadgetItem(ishodnik,-1,"[15:13:30] <hochleistungsfähigen> Obiwаn: Пинг от тебя 0.084 сек.")
AddGadgetItem(ishodnik,-1,"[16:24:29] aerohead вышел(а) из комнаты")
AddGadgetItem(ishodnik,-1,"[16:46:05] Ozz_Klochkov вышел(а) из комнаты")
AddGadgetItem(ishodnik,-1,"[17:35:21] plus`` вошёл(а) в комнату")
AddGadgetItem(ishodnik,-1,"[17:40:15] plus`` вышел(а) из комнаты")
AddGadgetItem(chto,-1," <")
AddGadgetItem(chto,-1,"> ")
AddGadgetItem(na_chto,-1," <b>")
AddGadgetItem(na_chto,-1,"</b> ")
AddGadgetItem(pole_del,-1,"вошёл")
AddGadgetItem(pole_del,-1,"вышел")
 
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = btn
        ClearGadgetItems(result)
        numberOfStrings = CountGadgetItems(ishodnik)
        numberOfStrings_del = CountGadgetItems(pole_del)
        CntChto = CountGadgetItems(chto)
        CntNaChto = CountGadgetItems(na_chto)
        
        For counter = 0 To numberOfStrings-1
          textishodnik$ = GetGadgetItemText(ishodnik,counter)
          For pos_chto = 0 To CntChto-1
            chto$ = GetGadgetItemText(chto,pos_chto)
            na_chto$ = GetGadgetItemText(na_chto,pos_chto)
            textishodnik$ = ReplaceString(textishodnik$,chto$,na_chto$,#PB_String_NoCase)
          Next
          For counter_del = 0 To numberOfStrings_del
            text_pole_del$ = GetGadgetItemText(pole_del,counter_del)
            If FindString(textishodnik$, text_pole_del$)
              counter_del = numberOfStrings_del
            ElseIf counter_del = numberOfStrings_del
              AddGadgetItem(result,-1,textishodnik$)
            EndIf
          Next
        Next
  EndIf
 
Until event = #PB_Event_CloseWindow
