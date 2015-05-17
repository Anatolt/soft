;Рисуем точку на канве.
;Пользователь может ее перетащить в другое место, нажав и удерживая ЛКМ

;План
;Добавляем вторую точку (глобализуем переменные, выносим действие по переносу в процедуру)
;Протягиваем между ними линию. 
;Заставляем линию следовать за точками после их перемещения.
;Проверяем не нажал ли пользователь на саму линию (формулы вычисления линии?)

;Пишем прогу, которая рисует линии. 
;нажимаем первый раз на мышь - ставится первая точка, от неё тянется линия. 
;нажимаем второй раз - линия прекращает следовать за мышкой и остаётся видна на экране. как в AutoCAD. 
;сохраняется лог положения линии, чтобы потом из него можно было собрать процедурный рисунок

;Далекое будущее
;возможность изменять уже нарисованную линию, кликнув по ней
;заливка 
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба

v$ = "v0.3"
OpenWindow(13,#PB_Ignore,#PB_Ignore,500,500,"Pain-t "+v$, #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
CanvasGadget(13,0,0,500,500)
StartDrawing(CanvasOutput(13))
X = 30
Y = 30
R = 5
Circle(X,Y,R,$000)
StopDrawing()
Repeat
  event = WaitWindowEvent()
  If Event = #PB_Event_Gadget And EventGadget() = 13
    ;If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(13, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
    If EventType() = #PB_EventType_LeftButtonDown
      X2 = GetGadgetAttribute(13, #PB_Canvas_MouseX)
      Y2 = GetGadgetAttribute(13, #PB_Canvas_MouseY)
      If X2 < X+R And X2 > X-R And Y2 < Y+R And X2 > Y-R 
        Debug "popal"
        popal = 1
      EndIf
    ElseIf popal And EventType() = #PB_EventType_LeftButtonUp
      Debug 1
      StartDrawing(CanvasOutput(13))
      Circle(X,Y,R,$ffffff)
      X = GetGadgetAttribute(13, #PB_Canvas_MouseX)
      Y = GetGadgetAttribute(13, #PB_Canvas_MouseY)
      Circle(X,Y,R,$000000)
      StopDrawing()
      ;popal = 0
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow
