OpenWindow(0,#PB_Ignore,#PB_Ignore,300,300,"String randomiser v0.1",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
StringGadget(1,0,0,300,30,"Эта программа меняет слова местами")
ButtonGadget(2,0,30,300,30,"Randomise")
EditorGadget(3,0,60,300,300-60)

Procedure.s rtip(txt$)
  Day+1
  Lives_cnt-1
  Mood_cnt-1
  txt$ = LCase(txt$)
  NewList words.s()
  ;
  LenghWord = FindString(txt$," ")
  word$ = Mid(txt$,startSearch,LenghWord-startSearch-1)
  AddElement(words())
  words() = word$
  word_cnt + 1
  startSearch = LenghWord + 1
  ; если удалить кусок кода выше - прога добавляет лишний пробел после первого слова
  While Not LenghWord = 0
    word$ = Mid(txt$,startSearch,LenghWord-startSearch)
    AddElement(words())
    words() = word$
    word_cnt + 1
    startSearch = LenghWord + 1
    LenghWord = FindString(txt$," ",startSearch)
  Wend
  ;
  word$ = Mid(txt$,startSearch,Len(txt$)-1)
  AddElement(words())
  words() = word$
  word_cnt + 1
  ;если удалить кусок кода выше - то пропадает последнее слово
  RandomizeList(words())
  ForEach words()
    output$ + words() + " "; а вот эта зараза добавляет лишнюю _ куда-попало.
  Next
  output$ = UCase(Mid(output$,0,1))+Mid(output$,2)
  Debug output$
  AddGadgetItem(3,-1,output$)
EndProcedure

;привести всё к такому виду
Procedure.s separateString2words(txt$)
  For i = 1 To CountString(txt$," ")+1
    AddGadgetItem(3,-1,StringField(txt$,i," "))
  Next
EndProcedure

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = 2
    rtip(GetGadgetText(1))
  EndIf
Until event = #PB_Event_CloseWindow
