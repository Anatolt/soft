;Пишем прогу, которая рисует линии. 
;нажимаем первый раз на мышь - ставится первая точка, от неё тянется линия. 
;нажимаем второй раз - линия прекращает следовать за мышкой и остаётся видна на экране. как в AutoCAD. 
;сохраняется лог положения линии, чтобы потом из него можно было собрать процедурный рисунок

;План
;возможность изменять уже нарисованную линию, кликнув по ней
;заливка 
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба

v$ = "v0.2"
OpenWindow(13,#PB_Ignore,#PB_Ignore,500,500,"Pain-t "+v$, #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
CanvasGadget(13,0,0,500,500)
Repeat
  event = WaitWindowEvent()
  If Event = #PB_Event_Gadget And EventGadget() = 13
    ;If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(13, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
    If EventType() = #PB_EventType_LeftButtonDown
      Select trigger
        Case 0
          StartDrawing(CanvasOutput(13))
          startX = GetGadgetAttribute(13, #PB_Canvas_MouseX)
          startY = GetGadgetAttribute(13, #PB_Canvas_MouseY)
          Circle(startX,startY,5,$000)
          StopDrawing()
          trigger = 1
        Case 1
          StartDrawing(CanvasOutput(13))
          endX = GetGadgetAttribute(13, #PB_Canvas_MouseX)
          endY = GetGadgetAttribute(13, #PB_Canvas_MouseY)
          Circle(endX,endY,5,$000)
          LineXY(startX, startY, endX, endY, $000)
          StopDrawing()
          trigger = 0
      EndSelect
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
