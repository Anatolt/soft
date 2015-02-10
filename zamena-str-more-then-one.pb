; заменялка строчная

; я понял наконец, что команда Mid вторым агрументом считает длинну отрезка, а не позицию!..
; удалось победить пример с цифрами, но пример с текстом пока не по силам. 

OpenWindow(0,100,100,320,160,"Заменялка строчная")

; с такими данными - не работает
;ishodnik = StringGadget(#PB_Any,10,10,300,20,"Строка тестового текста здесь. тестовоготекста. еще этих французских тестовых текста здесь")
;chto_ischem = StringGadget(#PB_Any,10,40,300,20,"текста")
;na_chto_menyaem = StringGadget(#PB_Any,10,70,300,20,"хуекста")

ishodnik = StringGadget(#PB_Any,10,10,300,20,"123y56y789y0")
chto_ischem = StringGadget(#PB_Any,10,40,300,20,"y")
na_chto_menyaem = StringGadget(#PB_Any,10,70,300,20,"хx")
btn = ButtonGadget(#PB_Any,10,100,300,20,"Выполнить")
result = StringGadget(#PB_Any,10,130,300,20,"")

Repeat
  event = WaitWindowEvent()
  ; закрывалка по эскейпу
  If CreatePopupMenu(0) : MenuItem(2, "Quit") : EndIf
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf
  AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2)
  
  If event = #PB_Event_Gadget And EventGadget() = btn
    txt$ = ""
    SetGadgetText(result,txt$)
    chto_ischem$ = GetGadgetText(chto_ischem)
    na_chto_menyaem$ = GetGadgetText(na_chto_menyaem)
    ishodnik$ = GetGadgetText(ishodnik)
    dlina_ishodnik = Len(ishodnik$) :     Debug "dlina_ishodnik = " + Str(dlina_ishodnik)
    dlina_chto_ischem = Len(chto_ischem$) :     Debug "dlina_chto_ischem = " + Str(dlina_chto_ischem)
    search = FindString(ishodnik$,chto_ischem$,1,#PB_String_NoCase) : Debug ishodnik$ + " ishodnik" : Debug "search position " + Str(search)
    cut$ = Mid(ishodnik$,0,search-1) : Debug "cut$ = " + cut$
    If search
      Repeat
        txt$ = txt$ + cut$ + "[" + na_chto_menyaem$ + "]": Debug "result$ = " + txt$
        SetGadgetText(result, txt$)
        i = search + 1 : Debug "i = " + Str(i)
        search = FindString(ishodnik$,chto_ischem$,i,#PB_String_NoCase) : Debug ishodnik$ + " ishodnik" : Debug "search = " + Str(search)
        j = search - i: Debug "j = " + Str(j)
        cut$ = Mid(ishodnik$,i,j) : Debug "cut$ = " + cut$
        Debug " "
      Until search = 0
      cut$ = Mid(ishodnik$,i) : Debug "cut$ = " + cut$
      txt$ = txt$ + cut$
      SetGadgetText(result, txt$)
    Else
      elsetxt$ = "Не найдено " + chto_ischem$
      SetGadgetText(result, elsetxt$)
    EndIf
  EndIf
  
Until event = #PB_Event_CloseWindow
