; v0.6
; благодаря каменту учителя к прошлому уроку осознал что тулбал - тоже меню, убрал лишние строки
; нарисовал кнопку, пытался сделать её больше - не вышло.
; нашёл реагирование на изменение размера окна, но пока не понял как поменять гаджет

; планы
; подгонять содержимое под размер окна
; использовать значки винды
; научиться открывать все файлы
; научиться рисовать
; научиться присваивать аккордовые клавиатурные сочетания

Enumeration
  #Large
  #Small
  #List
  #Report
EndEnumeration

Procedure CreateButtons()
  CreateImage(#Large,16,16)
  StartDrawing(ImageOutput(#Large))
  Box(0,0,16,16,$000000)
  Box(4,4,8,8,$009900)
  StopDrawing()
EndProcedure
CreateButtons()

OpenWindow(0,200,200,500,300,"Открывалка файлов",#PB_Window_SizeGadget|#PB_Window_SystemMenu )
If CreateToolBar(0,WindowID(0))
  ToolBarImageButton(#Large, ImageID(#Large))
  ToolBarStandardButton(#Small, #PB_ToolBarIcon_Help)
  ToolBarStandardButton(#List, #PB_ToolBarIcon_Help)
  ToolBarStandardButton(#Report, #PB_ToolBarIcon_Help)
EndIf
AddKeyboardShortcut(0, #PB_Shortcut_1, #Large)
AddKeyboardShortcut(0, #PB_Shortcut_2, #Small)
AddKeyboardShortcut(0, #PB_Shortcut_3, #List)
AddKeyboardShortcut(0, #PB_Shortcut_4, #Report)
folders = ExplorerListGadget(#PB_Any,0,30,500,200,dir$)
SetToolBarButtonState(0,#Report,#PB_ToolBar_Toggle)


Repeat
  event = WaitWindowEvent()
  Select event
    Case #PB_Event_SizeWindow
      Debug WindowWidth(0)
      SetGadgetAttribute(folders,Width,WindowWidth(0))
      SetGadgetAttribute(folders,Height,WindowHeight(0)-ToolBarHeight(0))
    Case #PB_Event_Menu 
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
  EndSelect
  
Until event = #PB_Event_CloseWindow
