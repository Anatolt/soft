;не работает перемещение
; удаляется только последний элемент
; если элементов не осталось, а мы нажимаем удалить - прога виснет

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

OpenWindow(13,#PB_Ignore,#PB_Ignore,300,330,"Drag Dot v0.6", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
ButtonGadget(#Add,0,300,100,30,"Add Dot")
ButtonGadget(#Move,100,300,100,30,"Move Dot")
ButtonGadget(#Delete,200,300,100,30,"Delete Dot")
CanvasGadget(13,0,0,300,300)

CurrentMode = #Add
DisableGadget(#Add,1)
Repeat
  event = WaitWindowEvent()
  If Event = #PB_Event_Gadget 
    Select EventGadget() 
      Case 13
        mouseX = GetGadgetAttribute(13, #PB_Canvas_MouseX)
        mouseY = GetGadgetAttribute(13, #PB_Canvas_MouseY)
        ;If EventType() = #PB_EventType_LeftButtonDown Or (EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(13, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
        If EventType() = #PB_EventType_LeftButtonDown
          Select CurrentMode
            Case #Add
              addDot(mouseX, mouseY)
              
            Case #Move
              If EventType() = #PB_EventType_LeftButtonDown And Not buttonPressed
                buttonPressed = #True
                For i = ListSize(dots())-1 To 0 Step -1
                  SelectElement(dots(),i)
                  If popal(mouseX,mouseY,dots()\x,dots()\y)
                    Debug "popal"
                    offsetX = mouseX - dots()\x
                    offsetY = mouseY - dots()\y
                    MoveElement(dots(),#PB_List_Last)
                    selectedObject = ListSize(dots())-1
                    Break
                  EndIf
                Next
              ElseIf EventType() = #PB_EventType_MouseMove And buttonPressed And selectedObject > -1
                SelectElement(dots(),selectedObject)
                dots()\x = mouseX - offsetX
                dots()\y = mouseY - offsetY
              ElseIf EventType() = #PB_EventType_LeftButtonUp And buttonPressed
                buttonPressed = #False
                selectedObject = -1
              EndIf
              
            Case #Delete
              If popal(mouseX, mouseY, dots()\x, dots()\y)
                DeleteElement(dots())
              EndIf
          EndSelect
        EndIf

      Case #Add, #Delete, #Move
        EventGadget = EventGadget()
        For Gadget = #Add To #Delete
          If Gadget = EventGadget
            DisableGadget(Gadget, 1) 
          Else
            DisableGadget(Gadget, 0) ; unset the state of all other gadgets
          EndIf
        Next Gadget          
        CurrentMode = EventGadget 
    EndSelect
    drawAll()
  EndIf
Until event = #PB_Event_CloseWindow
