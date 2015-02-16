; заменялка-удалялка полей массовая 

OpenWindow(0, 100, 100, 830, 530, "Массовая заменялка", #PB_Window_SystemMenu)
ishodnik = EditorGadget(#PB_Any, 10, 10, 400, 510)
chto = EditorGadget(#PB_Any, 420, 170, 200, 100)
na_chto = EditorGadget(#PB_Any, 630, 170, 190, 100)
btn = ButtonGadget(#PB_Any, 420, 280, 400, 30, "Зробыть дiло")
result = EditorGadget(#PB_Any, 420, 320, 400, 200)
del = EditorGadget(#PB_Any, 420, 40, 210, 90)
Text_0 = TextGadget(#PB_Any, 420, 10, 210, 25, "Удалить строки содержащие")
Text_1 = TextGadget(#PB_Any, 420, 140, 210, 25, "Заменить")
Text_2 = TextGadget(#PB_Any, 630, 140, 190, 25, "на")

;SetGadgetText(ishodnik, "грустный текст. грустный текст. грустный грустный. Пиздец какой грустный. Тестовее некуда грустный")
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
AddGadgetItem(del,-1,"вошёл")
AddGadgetItem(del,-1,"вышел")
If CreatePopupMenu(0) : MenuItem(2, "Quit") : EndIf : AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2); закрывалка по эскейпу

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf ; закрывалка по эскейпу
  If event = #PB_Event_Gadget And EventGadget() = btn
    ClearGadgetItems(result)
    CntIshodnik = CountGadgetItems(ishodnik)
    CntChto = CountGadgetItems(chto)
    CntNaChto = CountGadgetItems(na_chto)
    CntDel = CountGadgetItems(del)
    For pos_ishodnik = 0 To CntIshodnik-1
      ishodnik$ = GetGadgetItemText(ishodnik,pos_ishodnik)
      For pos_chto = 0 To CntChto-1
        chto$ = GetGadgetItemText(chto,pos_chto)
        na_chto$ = GetGadgetItemText(na_chto,pos_chto)
        ishodnik$ = ReplaceString(ishodnik$,chto$,na_chto$,#PB_String_NoCase)
      Next
      
      ;вот эта часть пока не пашет почему-то
      For pos_del = 0 To CntDel-1
        text_del$ = GetGadgetItemText(del,pos_del)
        Debug "testing {" + text_del$ + "} against {" + ishodnik$ + "}: " + Str(FindString(ishodnik$, text_del$))
        If FindString(ishodnik$, text_del$)
          pos_del = CntDel
        ElseIf pos_del = CntDel
          AddGadgetItem(result,-1,ishodnik$)
        EndIf
      Next
      
      
      AddGadgetItem(result,-1,ishodnik$)
      Debug " "
    Next
  EndIf
Until event = #PB_Event_CloseWindow
