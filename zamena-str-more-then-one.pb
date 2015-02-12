; заменялка строчная

OpenWindow(0,100,100,520,160,"Заменялка строчная")

ishodnik = StringGadget(#PB_Any,10,10,500,20,"Строка текста здесь. Тестовоготекста. Ещё текста тут")
chto_ischem = StringGadget(#PB_Any,10,40,500,20,"текста") : na_chto_menyaem = StringGadget(#PB_Any,10,70,500,20,"хуекста")

; ishodnik = StringGadget(#PB_Any,10,10,500,20,"123y56y789y0") : chto_ischem = StringGadget(#PB_Any,10,40,500,20,"y") : na_chto_menyaem = StringGadget(#PB_Any,10,70,500,20,"хx")
btn = ButtonGadget(#PB_Any,10,100,500,20,"Выполнить")
result = StringGadget(#PB_Any,10,130,500,20,"")

; закрывалка по эскейпу
; убрал из цикла
If CreatePopupMenu(0) : MenuItem(2, "Quit") : EndIf : AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2)

Repeat
  event = WaitWindowEvent()
  
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf ; закрывалка по эскейпу
  
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
        search = FindString(ishodnik$,chto_ischem$,i,#PB_String_NoCase) : Debug " ishodnik " + ishodnik$: Debug "search = " + Str(search)
        j = search - i + 1 - dlina_chto_ischem: Debug "j = " + Str(j)
        cut$ = Mid(ishodnik$,i+dlina_chto_ischem-1,j) : Debug "cut$ = " + cut$
        Debug " "
      Until search = 0
      cut$ = Mid(ishodnik$,i+dlina_chto_ischem-1) : Debug "cut$ = " + cut$
      txt$ = txt$ + cut$
      SetGadgetText(result, txt$)
    Else
      elsetxt$ = "Не найдено " + chto_ischem$
      SetGadgetText(result, elsetxt$)
    EndIf
  EndIf
  
Until event = #PB_Event_CloseWindow
