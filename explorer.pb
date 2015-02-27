; сделал меню с помощью тулбаров. 
; научился их подсвечивать

; планы
; подгонять содержимое под размер окна
; использовать значки винды
; привязать клавиатурные команды для управления видом
; научиться открывать все файлы
; научиться рисовать

Enumeration
  #Large
  #Small
  #List
  #Report
EndEnumeration

OpenWindow(0,200,200,500,300,"Открывалка файлов",#PB_Window_SizeGadget|#PB_Window_SystemMenu )
;btn_LargeIcon = ButtonGadget(#PB_Any, 0, 0, 130, 30, "LargeIcon")
;btn_SmallIcon = ButtonGadget(#PB_Any, 140, 0, 130, 30, "SmallIcon")
;btn_List = ButtonGadget(#PB_Any, 280, 0, 100, 30, "List")
;btn_Report = ButtonGadget(#PB_Any, 390, 0, 110, 30, "Report")
;folders = ExplorerTreeGadget(#PB_Any,0,30,500,200,dir$)
;ExplorerComboGadget(#PB_Any,0,0,300,30,dir$)
If CreateToolBar(0,WindowID(0))
  ToolBarStandardButton(#Large, #PB_ToolBarIcon_Help)
  ToolBarStandardButton(#Small, #PB_ToolBarIcon_Help)
  ToolBarStandardButton(#List, #PB_ToolBarIcon_Help)
  ToolBarStandardButton(#Report, #PB_ToolBarIcon_Help)
EndIf
folders = ExplorerListGadget(#PB_Any,0,30,500,200,dir$)
SetToolBarButtonState(0,#Report,#PB_ToolBar_Toggle)

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Menu 
    Select EventGadget() 
      Case #Large 
        value = #PB_Explorer_LargeIcon
      Case #Small 
        value = #PB_Explorer_SmallIcon
      Case #List 
        value = #PB_Explorer_List     
      Case #Report  
        value = #PB_Explorer_Report  
      Case folders
        Select EventType()
          Case #PB_EventType_Change
            Debug "что-то поменялось (#PB_EventType_Change)"
          Case #PB_EventType_LeftDoubleClick 
            Debug "#PB_EventType_LeftDoubleClick"
            Debug GetGadgetItemText(folders,GetGadgetState(folders))
            RunProgram(GetGadgetItemText(folders,GetGadgetState(folders)))
        EndSelect
        ;RunProgram()
    EndSelect
    SetGadgetAttribute(folders,#PB_Explorer_DisplayMode,value)
    For i = #Large To #Report
      SetToolBarButtonState(0,i,#PB_ToolBar_Normal)
    Next
    SetToolBarButtonState(0,EventGadget(),#PB_ToolBar_Toggle)
  EndIf
  
Until event = #PB_Event_CloseWindow
