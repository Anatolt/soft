OpenWindow(0,#PB_Ignore,#PB_Ignore,300,300,"String2words v0.1",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
StringGadget(1,0,0,300,30,"эта программа делит строку на отдельные слова")
ButtonGadget(2,0,30,300,30,"Do")
EditorGadget(3,0,60,300,300-60)
Procedure.s separateString2words(txt$)
  NewList words.s()
  LenghWord = FindString(txt$," ")
  While Not LenghWord = 0
    word$ = Mid(txt$,startSearch,LenghWord-startSearch)
    AddElement(words())
    words() = word$
    word_cnt + 1
    startSearch = LenghWord + 1
    LenghWord = FindString(txt$," ",startSearch)
  Wend
  word$ = Mid(txt$,startSearch)
  AddElement(words())
  words() = word$
  word_cnt + 1
  ForEach words()
    AddGadgetItem(3,-1,words())
  Next
EndProcedure
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = 2
    separateString2words(GetGadgetText(1))
  EndIf
Until event = #PB_Event_CloseWindow
