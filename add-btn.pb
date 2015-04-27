; подход 2
; придумал логику программы. 
; она будет добавлять кнопки под собой пока не достигнет размеров монитора затем добавит еще один столбец
x = 0
y = 0
width = 200
height = 60
OpenWindow(0,x,y,width+20,height+20,"window change size",#PB_Window_SystemMenu)
btn = ButtonGadget(1,x+10,x+10,width,height,"add btn",#PB_Button_MultiLine)

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
        Case 1
          ButtonGadget(2,x+10,y+80,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*2+20*2-10)
          DisableGadget(1,1)
        Case 2
          ButtonGadget(3,x+10,y+80*2-10,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*3+20*2)
          DisableGadget(2,1)
        Case 3
          ButtonGadget(4,x+10,y+80*3-20,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*4+20*2+10)
          DisableGadget(3,1)
        Case 4
          ButtonGadget(5,x+10,y+80*4-30,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*5+20*2+20)
          DisableGadget(4,1)
        Case 5
          ButtonGadget(6,x+10,y+80*5-40,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*6+20*2+30)
          DisableGadget(5,1)
        Case 6
          ButtonGadget(7,x+10,y+80*6-50,width,height,"add btn",#PB_Button_MultiLine)
          ResizeWindow(0,0,0,width+20,height*7+20*2+40)
          DisableGadget(6,1)
      EndSelect
  EndIf : Until event = #PB_Event_CloseWindow
