; научитлся открывать файлы (не все)

; планы
; использовать тулбар
; подсвечивать выбранную кнопку 
; подгонять содержимое под размер окна
; использовать значки винды
; привязать класиатурные команды для управления видом

OpenWindow(0,200,200,500,300,"Открывалка файлов",#PB_Window_SizeGadget|#PB_Window_SystemMenu )
btn_LargeIcon = ButtonGadget(#PB_Any, 0, 0, 130, 30, "LargeIcon")
btn_SmallIcon = ButtonGadget(#PB_Any, 140, 0, 130, 30, "SmallIcon")
     btn_List = ButtonGadget(#PB_Any, 280, 0, 100, 30, "List")
   btn_Report = ButtonGadget(#PB_Any, 390, 0, 110, 30, "Report")
;folders = ExplorerTreeGadget(#PB_Any,0,30,500,200,dir$)
;ExplorerComboGadget(#PB_Any,0,0,300,30,dir$)
folders = ExplorerListGadget(#PB_Any,0,30,500,200,dir$)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case btn_LargeIcon 
        value = #PB_Explorer_LargeIcon
      Case btn_SmallIcon 
        value = #PB_Explorer_SmallIcon
      Case btn_List 
        value = #PB_Explorer_List     
      Case btn_Report  
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
    SetGadgetAttribute(folders,#PB_Explorer_DisplayMode, value)
  EndIf
  
Until event = #PB_Event_CloseWindow
