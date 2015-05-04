Procedure separateString2words(txt$)
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
    Debug words()
  Next
EndProcedure
separateString2words("эта программа делит строку на отдельные слова")
