; возвращать значение пикселя
; показывать координаты мышки
; заменить hide на галочку

;===Суть!
;Программа сохраняет нарисованное пользователем в виде процедурного кода PureBasic.
;Этот код потом можно запустить при следующем запуске программы, получив все нарисованные линии.
;Линии возможно изменять после повторной генерации.

;===План
; Завершить полигон - Enter
; Создание текста процедуры рисования линий, соответствующих полигону
; Перетаскивать линию - ЛКМ, удалять - СКМ, добавлять - ПКМ

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
;задержка рисования полигона

#canvasWidth = 400
#canvasHeigh = 400

Enumeration
  #Add
  #Move
  #Delete
  #Hide
  #Random
  #Clear
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
  Box(0,0,#canvasWidth,#canvasHeigh,$ffffff)
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

Procedure addFewDots(num)
  For i = 0 To num
    addDot(Random(#canvasWidth),Random(#canvasHeigh))
  Next
EndProcedure

OpenWindow(13,#PB_Ignore,#PB_Ignore,#canvasWidth,#canvasHeigh+85,"drag-n-add-lines v0.9", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )
     ButtonGadget(#Add,0,#canvasWidth,#canvasWidth/3,30,"Add Dot")
   ButtonGadget(#Move,#canvasWidth/3,#canvasWidth,#canvasWidth/3,30,"Move Dot")
ButtonGadget(#Delete,#canvasWidth/3*2,#canvasWidth,#canvasWidth/3,30,"Delete Dot")
ButtonGadget(#Random,0,#canvasWidth+30,#canvasWidth/3,30,"Random")
  ButtonGadget(#Hide,#canvasWidth/3,#canvasWidth+30,#canvasWidth/3,30,"Hide Dots",#PB_Button_Toggle)
 ButtonGadget(#Clear,#canvasWidth/3*2,#canvasWidth+30,#canvasWidth/3,30,"Clear")
 CreateStatusBar(666, WindowID(13))
AddStatusBarField(#canvasWidth)
 CanvasGadget(13,0,0,#canvasWidth,#canvasHeigh)

addFewDots(10)

CurrentMode = #Add
DisableGadget(#Add,1)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget
    Select EventGadget() 
      Case 13
        mouseX = GetGadgetAttribute(13, #PB_Canvas_MouseX)
        mouseY = GetGadgetAttribute(13, #PB_Canvas_MouseY)
        StatusBarText(666, 0, Str(MouseX)+","+Str(MouseY))
        
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
        
      Case #Random
        ClearList(all())
        addFewDots(10)
        
      Case #Hide
        If GetGadgetState(#Hide)
          R = 0
        Else
          R = 5
        EndIf
        
      Case #Clear
        ClearList(all())
        
    EndSelect
    drawAll()
  EndIf
Until event = #PB_Event_CloseWindow