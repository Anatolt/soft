  If OpenWindow(0, 0, 0, 200, 200, "2DDrawing Example", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
    If CreateImage(0, 200, 200) And StartDrawing(ImageOutput(0))
      x = 0
      y = 0
      width = 20
      height = 20
      skruglenie = 7
      Radius = 30
      
      ;Box(x, y, Width, Height [, Color])
      Box(x, y, width, height, RGB(Random(255), Random(255), Random(255)))
      ;RoundBox(x, y, Width, Height, RoundX, RoundY [, Color])
      RoundBox(30, y, width, height, skruglenie, skruglenie, RGB(Random(255), Random(255), Random(255)))
      ;Line(x, y, Width, Height [, Color]) 
      Line(x, 20, 199, height, RGB(Random(255), Random(255), Random(255)))
      ;LineXY(x1, y1, x2, y2 [, Color]) 
      LineXY(x, 21, 100+Cos(Radian(Angle))*90, 100+Sin(Radian(Angle))*90, RGB(Random(255), Random(255), Random(255)))
      ;Circle(x, y, Radius [, Color]) 
      Circle(30, 70, Radius, RGB(Random(255), Random(255), Random(255))) 
      ;Ellipse(x, y, RadiusX, RadiusY [, Color]) 
      Ellipse(110, 110, Radius+10, Radius, RGB(Random(255), Random(255), Random(255))) 
      
      StopDrawing() 
      ImageGadget(0, 0, 0, 200, 200, ImageID(0))
    EndIf
    
    Repeat
      Event = WaitWindowEvent()
    Until Event = #PB_Event_CloseWindow
  EndIf
