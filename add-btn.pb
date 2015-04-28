; подход 3
; переписал всё процедурой
Global btn_hei, number, width, height

width = 200
height = 60
OpenWindow(0,x,y,width+20,height+20,"window change size",#PB_Window_SystemMenu)
btn = ButtonGadget(1,x+10,x+10,width,height,"add btn",#PB_Button_MultiLine)

Procedure new_btn(number)
  ButtonGadget(number+1,x+10,y+80*number-(number-1)*10,width,height,Str(number+1),#PB_Button_MultiLine)
  If number = 1
    btn_hei = height*(number+1)+20*2-10
  ElseIf number = 2
    btn_hei = height*(number+1)+20*2
  Else
    btn_hei = height*(number+1)+20*2+(number-2)*10
  EndIf
  ResizeWindow(0,0,0,width+20,btn_hei)
  DisableGadget(number,1)
EndProcedure

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case 1
        new_btn(1)
      Case 2
        new_btn(2)
      Case 3
        new_btn(3)
      Case 4
        new_btn(4)
      Case 5
        new_btn(5)
      Case 6
        new_btn(6)
    EndSelect
EndIf : Until event = #PB_Event_CloseWindow
