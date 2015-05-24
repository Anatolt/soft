#canvasWidth = 400
#canvasHeigh = 400

Procedure Linenene(x1, y1, x2, y2);
  dx = x2 - x1 ;длинна катета x
  dy = y2 - y1 ;длинна катета y
  d  = (dy << 1) - dx 
  d1 = dy << 1
  d2 = (dy - dx) << 1
  StartDrawing(CanvasOutput(13))
  Plot(x1, y1, 0)
  y = y1
  For x = x1+1 To x2
    If (d > 0)
      y = y + 1
      d = d + d2
    Else
      d = d + d1
      Plot(x, y, 0)
    EndIf
  Next
  
  LineXY(x1, y1+20, x2, y2+20,0)
  StopDrawing()
EndProcedure

OpenWindow(13,#PB_Ignore,#PB_Ignore,#canvasWidth,#canvasHeigh+60,"draw-the-lines v0.1", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
CanvasGadget(13,0,0,#canvasWidth,#canvasHeigh)

Linenene(1,1,13,26)


Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget And EventGadget() = gadget
  EndIf
Until event = #PB_Event_CloseWindow
