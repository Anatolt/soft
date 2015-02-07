; заменялка строчная

; dlinna_stroki = CountGadgetItems(str1)
; Debug dlinna_stroki 
; теперь мы знает что CountGadgetItems не считает количество символов в строках. только кол-во строк в таблице
; нашёл команды Len (измерение длины строки) и Mid (обрезка).
; прога ищет только одно - первое совпадение

OpenWindow(0,100,100,320,160,"Заменялка строчная")
str1 = StringGadget(#PB_Any,10,10,300,20,"Строка тестового текста здесь")
chto_ischem = StringGadget(#PB_Any,10,40,300,20,"текста")
na_chto_menyaem = StringGadget(#PB_Any,10,70,300,20,"хуекста")
btn = ButtonGadget(#PB_Any,10,100,300,20,"Выполнить")
str2 = StringGadget(#PB_Any,10,130,300,20,"")

Repeat
  event = WaitWindowEvent()
  If EventGadget() = btn
    chto_ischem$ = GetGadgetText(chto_ischem)
    na_chto_menyaem$ = GetGadgetText(na_chto_menyaem)
    str1$ = GetGadgetText(str1)
    dlina_stroki = Len(str1$)
    Debug "dlina_stroki " + Str(dlina_stroki)
    dlina_chto_ischem = Len(chto_ischem$)
    Debug "dlina_chto_ischem " + Str(dlina_chto_ischem)
    search = FindString(str1$,chto_ischem$)
    Debug "search " + Str(search)
    If search
      pauza = search + dlina_chto_ischem
      Debug "pauza " + Str(pauza)
      txt$ = Mid(str1$,0,search-1) + "[" + na_chto_menyaem$ + "]" + Mid(str1$,pauza,dlina_stroki)
      SetGadgetText(str2, txt$)
    Else
      elsetxt$ = "Не найдено " + chto_ischem$
      SetGadgetText(str2, elsetxt$)
    EndIf
  EndIf
  
Until event = #PB_Event_CloseWindow
