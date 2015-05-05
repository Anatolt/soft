OpenWindow(0,#PB_Ignore,#PB_Ignore,300,300,"String randomiser v0.1",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
StringGadget(1,0,0,300,30,"Эта программа меняет слова местами")
ButtonGadget(2,0,30,300,30,"Randomise")
EditorGadget(3,0,60,300,300-60)

Procedure.s rtip(txt$)
  txt$ = LCase(txt$)
  NewList words.s()
  For i = 1 To CountString(txt$," ")+1
    AddElement(words())
    words() = StringField(txt$,i," ")
  Next
  RandomizeList(words())
  ForEach words()
    output$ + words() + " "
  Next
  output$ = UCase(Mid(output$,0,1))+Mid(output$,2) ; делаем первую букву большой
  Debug output$
  AddGadgetItem(3,-1,output$)
EndProcedure

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = 2
    rtip(GetGadgetText(1))
  EndIf
Until event = #PB_Event_CloseWindow
