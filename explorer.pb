; научился изменять размер окна: #PB_Window_SizeGadget
; сделал 4 кнопки переключения вида 

; Планы
; подсвечивать выбранную кнопку 
; подгонять содержимое под размер окна
; научиться открывать файлы
; использовать значки винды
; привязать класиатурные команды для управления видом
; переключатель между List Tree и Combo 

OpenWindow(0,200,200,500,300,"Открывалка файлов",#PB_Window_SizeGadget|#PB_Window_SystemMenu )
btn_LargeIcon = ButtonGadget(#PB_Any, 0, 0, 130, 30, "LargeIcon")
btn_SmallIcon = ButtonGadget(#PB_Any, 140, 0, 130, 30, "SmallIcon")
     btn_List = ButtonGadget(#PB_Any, 280, 0, 100, 30, "List")
   btn_Report = ButtonGadget(#PB_Any, 390, 0, 110, 30, "Report")
;folders = ExplorerTreeGadget(#PB_Any,0,30,500,200,dir$)
;folders = ExplorerComboGadget(#PB_Any,0,0,300,30,dir$)
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
    EndSelect
    SetGadgetAttribute(folders,#PB_Explorer_DisplayMode, value)
  EndIf
  
Until event = #PB_Event_CloseWindow
