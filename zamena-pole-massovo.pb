; заменялка полей массовая 
OpenWindow(0,100,100,420,670,"Массовая заменялка")
ishodnik = EditorGadget(#PB_Any,10,10,400,200)
chto = EditorGadget(#PB_Any,10,210,200,200)
na_chto = EditorGadget(#PB_Any,210,210,200,200)
btn = ButtonGadget(#PB_Any,10,420,400,30,"Зробыть дiло")
result = EditorGadget(#PB_Any,10,460,400,200)

;SetGadgetText(ishodnik, "Тестовый текст. текстовый текст. Тестовый тестовый. Пиздец какой тестовый. Тестовее некуда тестовый")
AddGadgetItem(ishodnik,-1,"Тестовый текст. текстовый текст.")
AddGadgetItem(ishodnik,-1,"Пиздец какой тестовый.")
   SetGadgetText(chto, "тестовый")
SetGadgetText(na_chto, "хуестовый")

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = btn
    Debug "кнопка нажата, стартуем"
    CntIshodnik = CountGadgetItems(ishodnik) : Debug "Cколько строк в ishodnik: " + Str(CntIshodnik)
    CntChto = CountGadgetItems(chto) : Debug "Cколько строк в chto: " + Str(CntChto)
    CntNaChto = CountGadgetItems(na_chto) : Debug "Cколько строк в na_chto: " + Str(CntNaChto)
    For pos_ishodnik = 0 To CntIshodnik
      ishodnik$ = GetGadgetItemText(ishodnik,pos_ishodnik)
      For pos_chto = 0 To CntChto
        chto$ = GetGadgetItemText(chto,pos_chto)
        For pos_na_chto = 0 To CntNaChto
          na_chto$ = GetGadgetItemText(na_chto,pos_na_chto)
          Debug ishodnik$  + " - исходник. Строка " + Str(pos_ishodnik)
          Debug chto$ + " - что ищем Строка " + Str(pos_chto)
          Debug na_chto$ + " - на что меняем Строка " + Str(pos_na_chto)
          search = FindString(ishodnik$,chto$,1,#PB_String_NoCase)
          If search
            Repeat
              i = search + 1
              Debug Str(search) + " - позиция поиска"
              txt$ = ReplaceString(ishodnik$,chto$,na_chto$,#PB_String_NoCase)
              AddGadgetItem(result,-1,txt$)
              search = FindString(ishodnik$,chto$,i,#PB_String_NoCase)
              Debug " "
            Until search = 0
          ;Else : SetGadgetItemText(result,-1,"Ничего не найдено")
          EndIf
        Next
      Next
    Next
  EndIf
  
Until event = #PB_Event_CloseWindow
