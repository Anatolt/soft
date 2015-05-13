;пишем прогу, которая рисует линии. 
;нажимаем первый раз на мышь - ставится первая точка, от неё тянется линия. 
;нажимаем второй раз - линия прекращает следовать за мышкой и остаётся видна на экране. как на автокаде. 
;сохраняется лог положения линии, чтобы потом из него можно было собрать процедурный рисунок

;дальше
;возможность изменять уже нарисованную линию, кликнув по ней
;заливка 
;изменение масштаба

OpenWindow(13,#PB_Ignore,#PB_Ignore,500,500,"Pain", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
CanvasGadget(13,0,0,500,500)
Repeat
  event = WaitWindowEvent()
  If Event = #PB_Event_Gadget And EventGadget() = 13
    If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(13, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
      StartDrawing(CanvasOutput(13))
      x = GetGadgetAttribute(13, #PB_Canvas_MouseX)
      y = GetGadgetAttribute(13, #PB_Canvas_MouseY)
      Circle(x,y,10,RGB(0,255,255))
      StopDrawing()
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
