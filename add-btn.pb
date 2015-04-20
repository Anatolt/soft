x = 0
y = 0
width = 200
height = 60
OpenWindow(0,x,y,width+20,height+20,"window change size",#PB_Window_SystemMenu)
btn = ButtonGadget(#PB_Any,x+10,x+10,width,height,"add btn",#PB_Button_MultiLine)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = btn
    ButtonGadget(#PB_Any,x+10,y+80,width,height,"add btn",#PB_Button_MultiLine)
    ResizeWindow(0,0,0,width+20,height*2+20*2)
    DisableGadget(btn,1)
  EndIf : Until event = #PB_Event_CloseWindow
