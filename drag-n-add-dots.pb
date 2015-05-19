;очищай канвас и не еби мозги (с) Сенсей
;Вчера скомпилил симулятор вебмастера для винды
;как запускать код который я пишу
;типы переменных https://dl.dropboxusercontent.com/u/943974/Screenshots/ce-_zem_sw5x.png в блоге искать проще чем в переписке скайпа

;План
;Добавление точек помимо заданных. 
;Перетаскивание их
;Проверяем не нажал ли пользователь на саму линию (формулы вычисления линии?)

;Пишем прогу, которая рисует линии. 
;нажимаем первый раз на мышь - ставится первая точка, от неё тянется линия. 
;нажимаем второй раз - линия прекращает следовать за мышкой и остаётся видна на экране. как в AutoCAD. 
;сохраняется лог положения линии, чтобы потом из него можно было собрать процедурный рисунок

;Далекое будущее
;возможность изменять уже нарисованную линию, кликнув по самой линии
;заливка 
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба

;Суть!
;Программа сохраняет нарисованное пользователем в виде процедурного кода, который потом можно запустить при следующем запуске программы, получив все нарисованные линии

Enumeration
  #Add
  #Move
  #Delete
EndEnumeration

Structure dot
  x.w
  y.w
EndStructure

Global NewList dots.dot(), R = 5

Procedure addDot(x,y)
  AddElement(dots())
  dots()\x = x
  dots()\y = y
EndProcedure

Procedure popal(mouseX, mouseY, objX, objY, objW = 5, objH = 5)
  If mouseX >= objX-R And mouseX <= objX+R And mouseY >= objY-R And mouseY <= objY+R
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False
EndProcedure

Procedure drawAll()
  StartDrawing(CanvasOutput(13))
  Box(0,0,300,300,$ffffffff)
  ForEach dots()
    Circle(dots()\x, dots()\y,R,0)
  Next
  StopDrawing()
EndProcedure

OpenWindow(13,#PB_Ignore,#PB_Ignore,300,330,"Drag Dot v0.5", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
ButtonGadget(#Add,0,300,100,30,"Add Dot")
ButtonGadget(#Move,100,300,100,30,"Move Dot")
ButtonGadget(#Delete,200,300,100,30,"Delete Dot")
CanvasGadget(13,0,0,300,300)

CurrentMode = #Add
Repeat
  event = WaitWindowEvent()
  If Event = #PB_Event_Gadget 
    Select EventGadget() 
      Case 13
        ;If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(13, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
        If EventType() = #PB_EventType_LeftButtonDown
          mouseX = GetGadgetAttribute(13, #PB_Canvas_MouseX)
          mouseY = GetGadgetAttribute(13, #PB_Canvas_MouseY)
          
          Select CurrentMode
            Case #Add
              addDot(mouseX, mouseY)
            Case #Move
              If popal(mouseX, mouseY, dots()\x, dots()\y)
                Debug "popal"
                popal = 1
              Else
                Debug "ne popal"
                popal = 0
              EndIf
          EndSelect
        EndIf
        
      Case #Add
        DisableGadget(#Add, 1)
        DisableGadget(#Delete, 0)
        DisableGadget(#Move, 0)
        CurrentMode = #Add
      Case #Delete
        DisableGadget(#Add, 0)
        DisableGadget(#Delete, 1)
        DisableGadget(#Move, 0)
        CurrentMode = #Delete
      Case #Move
        DisableGadget(#Add, 0)
        DisableGadget(#Delete, 0)
        DisableGadget(#Move, 1)
        CurrentMode = #Move
    EndSelect
    drawAll()
  EndIf
Until event = #PB_Event_CloseWindow
