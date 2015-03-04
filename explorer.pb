version$ = "v0.8"
; аккордовые сочетания так просто! #PB_Shortcut_Alt | #PB_Shortcut_1 Alt+1
; оказывается можно складывать текстовые строки прямо внутри гаджетов!

; планы
; использовать значки винды
; научиться открывать все файлы

Enumeration
  #Large
  #Small
  #List
  #Report
EndEnumeration

Procedure CreateButtons()
  CreateImage(#Large,16,16)
  StartDrawing(ImageOutput(#Large))
  Circle(7,7,4,$009900)
  StopDrawing()
  CreateImage(#Small,16,16)
  StartDrawing(ImageOutput(#Small))
  Circle(4,4,2,$009900)
  Circle(4,11,2,$009900)
  Circle(11,4,2,$009900)
  Circle(11,11,2,$009900)
  StopDrawing()
  CreateImage(#List,16,16)
  StartDrawing(ImageOutput(#List))
  Ellipse(8,8,6,3,$009900)
  StopDrawing()
  CreateImage(#Report,16,16)
  StartDrawing(ImageOutput(#Report))
  Ellipse(8,8,3,6,$009900)
  StopDrawing()
EndProcedure
CreateButtons()

OpenWindow(0,200,200,500,300,"Открывалка не всех файлов " + version$,#PB_Window_SizeGadget|#PB_Window_SystemMenu )
If CreateToolBar(0,WindowID(0))
  ToolBarImageButton(#Large, ImageID(#Large))
  ToolBarImageButton(#Small, ImageID(#Small))
  ToolBarImageButton(#List, ImageID(#List))
  ToolBarImageButton(#Report, ImageID(#Report))
;  ToolBarStandardButton(#List, #PB_ToolBarIcon_Help)
 ; ToolBarStandardButton(#Report, #PB_ToolBarIcon_Help)
EndIf
AddKeyboardShortcut(0, #PB_Shortcut_Alt | #PB_Shortcut_1, #Large)
AddKeyboardShortcut(0, #PB_Shortcut_Alt | #PB_Shortcut_2, #Small)
AddKeyboardShortcut(0, #PB_Shortcut_Alt | #PB_Shortcut_3, #List)
AddKeyboardShortcut(0, #PB_Shortcut_Alt | #PB_Shortcut_4, #Report)
fwidth = WindowWidth(0) - 6
fheight = WindowHeight(0)-ToolBarHeight(0) - 6
folders = ExplorerListGadget(#PB_Any,3,ToolBarHeight(0)+3,fwidth,fheight,dir$)
;folders = ExplorerListGadget(#PB_Any,0,30,500,200,dir$)
SetToolBarButtonState(0,#Report,#PB_ToolBar_Toggle)


Repeat
  event = WaitWindowEvent()
  Select event
    Case #PB_Event_SizeWindow
      fwidth = WindowWidth(0) - 6
      fheight = WindowHeight(0)-ToolBarHeight(0) - 6
      ResizeGadget(folders, 3, ToolBarHeight(0)+3, fwidth, fheight)
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
      EndSelect
      SetGadgetAttribute(folders,#PB_Explorer_DisplayMode,value)
      For i = #Large To #Report
        SetToolBarButtonState(0,i,#PB_ToolBar_Normal)
      Next
      SetToolBarButtonState(0,EventGadget(),#PB_ToolBar_Toggle)
  EndSelect
  
Until event = #PB_Event_CloseWindow
