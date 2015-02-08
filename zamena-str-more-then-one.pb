; впервые применил Repeat не к Event
; разобрался как найти значение в строке несколько раз

txt$ = "Тестовый текст. текстовый текст. Тестовый тестовый. Пиздец какой тестовый. Тестовее некуда тестовый"
str$ = "тестовый"
search = FindString(txt$,str$,1,#PB_String_NoCase)
If search
  Repeat
    i = search + 1
    search = FindString(txt$,str$,i,#PB_String_NoCase)
  Debug search
  Until search = 0
EndIf
