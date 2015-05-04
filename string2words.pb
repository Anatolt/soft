OpenWindow(0,#PB_Ignore,#PB_Ignore,300,300,"String2words v0.1",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
StringGadget(1,0,0,300,30,"эта программа делит строку на отдельные слова")
ButtonGadget(2,0,30,300,30,"Do")
EditorGadget(3,0,60,300,300-60)
Procedure.s separateString2words(txt$)
  ClearGadgetItems(3)
  For i = 1 To CountString(txt$," ")+1
    AddGadgetItem(3,-1,StringField(txt$,i," "))
  Next
EndProcedure
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = 2
    separateString2words(GetGadgetText(1))
  EndIf
Until event = #PB_Event_CloseWindow
