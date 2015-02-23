OpenWindow(0,200,200,500,300,"Открывалка файлов")
;ExplorerComboGadget(#PB_Any,0,0,300,30,dir$)
btn = ButtonGadget(#PB_Any, 0,0,500,30,"Сменить вид")
folders = ExplorerListGadget(#PB_Any,0,30,500,200,dir$)
;ExplorerTreeGadget(#PB_Any,0,130,300,100,dir$)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = btn
    If dice<4
      dice+1
    Else
      dice = 1
    EndIf
    
    Select dice
      Case 1
        value = #PB_Explorer_LargeIcon
      Case 2
        value = #PB_Explorer_SmallIcon
      Case 3
        value = #PB_Explorer_List     
      Case 4
        value = #PB_Explorer_Report   
    EndSelect
    SetGadgetAttribute(folders,#PB_Explorer_DisplayMode, value)
  EndIf
  
Until event = #PB_Event_CloseWindow
