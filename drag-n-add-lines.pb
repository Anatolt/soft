;===Суть!
;Программа сохраняет нарисованное пользователем в виде процедурного кода PureBasic.
;Этот код потом можно запустить при следующем запуске программы, получив все нарисованные линии.
;Линии возможно изменять после повторной генерации.

;===План
;Рисование полигона по точкам
;Создание текста процедуры рисования линий, соответствующих полигону
;Перетаскивать линию - ЛКМ, удалять - СКМ, добавлять - ПКМ, завершить полигон - Enter

;Пишем прогу, которая рисует линии. 
;нажимаем первый раз на мышь - ставится первая точка, от неё тянется линия. 
;нажимаем второй раз - линия прекращает следовать за мышкой и остаётся видна на экране. как в AutoCAD. 
;сохраняется лог положения линии, чтобы потом из него можно было собрать процедурный рисунок

;Далекое будущее
;проверяем не нажал ли пользователь на саму линию (формулы вычисления линии?)
;возможность изменять уже нарисованную линию, кликнув по самой линии
;заливка 
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба

Enumeration
  #Add
  #Move
  #Delete
EndEnumeration

Structure dot
  x.w
  y.w
EndStructure

Global NewList all.dot(), R = 5

Procedure addDot(x,y)
  AddElement(all())
  all()\x = x
  all()\y = y
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
  For i = 0 To ListSize(all())-1
    SelectElement(all(),i)
    x = all()\x
    y = all()\y
    Circle(x,y,R,0)
    If i > 0
      SelectElement(all(),i-1)
      x2 = all()\x
      y2 = all()\y
      LineXY(x,y,x2,y2,0)
      SelectElement(all(),i)
    EndIf
  Next
  StopDrawing()
EndProcedure

OpenWindow(13,#PB_Ignore,#PB_Ignore,300,330,"drag-n-add-lines v0.7", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
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
        
        Select EventType() 
          Case #PB_EventType_LeftButtonDown
            If Not buttonPressed
              buttonPressed = #True
              If CurrentMode = #Add
                addDot(mouseX, mouseY)
                SelectElement(all(),ListSize(all())-1)
                all()\x = mouseX - R/2
                all()\y = mouseY - R/2
                Debug "added element ["+Str(all()\x) + "," + Str(all()\y) +"]"
              Else
                For i = ListSize(all())-1 To 0 Step -1
                  SelectElement(all(),i)
                  If popal(mouseX,mouseY,all()\x,all()\y)
                    Debug "touched element [" + Str(all()\x) + "," + Str(all()\y) + ","+i+"]"
                    offsetX = mouseX - all()\x
                    offsetY = mouseY - all()\y
                    ;MoveElement(all(),#PB_List_Last)
                    ;selectedObject = ListSize(all())-1
                    selectedObject = i
                    If CurrentMode = #Delete
                      Debug "deleted element [" + Str(all()\x) + "," + Str(all()\y) + ","+i+"]"
                      DeleteElement(all())
                    EndIf
                    Break
                  EndIf
                Next
              EndIf
              drawAll()
            EndIf
            
          Case #PB_EventType_MouseMove
            If buttonPressed And selectedObject > -1 And CurrentMode = #Move
              SelectElement(all(),selectedObject)
              all()\x = mouseX - offsetX
              all()\y = mouseY - offsetY
;               drawAll()
            EndIf
            
          Case #PB_EventType_LeftButtonUp
            If buttonPressed
              buttonPressed = #False
              selectedObject = -1
;               drawAll()
            EndIf
        EndSelect
        
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
