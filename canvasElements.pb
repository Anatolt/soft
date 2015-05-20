Enumeration
  #wnd
  #canvas
  #Add
  #Move
  #Delete
EndEnumeration

Enumeration type
  #circle
  #box
EndEnumeration

Structure color
  r.a
  g.a
  b.a
  a.a
EndStructure

Structure object
  type.b
  x.w
  y.w
  w.w
  h.w
  color.color
EndStructure

NewList objects.object()

Procedure isInRect(mouseX, mouseY, objectX, objectY, objW, objH)
  If mouseX >= objectX And mouseX <= objW And mouseY >= objectY And mouseY <= objH
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False
EndProcedure

Procedure addObject(type.b, x, y, w, h, r, g, b, a = 255)
  Shared objects()
  AddElement(objects())
  objects()\type = type
  objects()\x = x
  objects()\y = y
  objects()\w = w
  objects()\h = h
  objects()\color\r = r
  objects()\color\g = g
  objects()\color\b = b
  objects()\color\a = a
EndProcedure

Procedure drawObjects()
  Shared objects()
  StartDrawing(CanvasOutput(#canvas))
  DrawingMode(#PB_2DDrawing_AlphaBlend) ; если закоментить - не будет прозрачности
  Box(0,0,800,600,$ffffffff)            ; эта строка стирает предыдущее содержимое. 8 цифр, т.к. последние 2 - альфа канал
  ForEach objects()
    Select objects()\type
      Case #box
        Box(objects()\x,objects()\y,objects()\w,objects()\h,RGBA(objects()\color\r,objects()\color\g,objects()\color\b,objects()\color\a))
      Case #circle
        Ellipse(objects()\x+objects()\w/2,objects()\y+objects()\h/2,objects()\w/2,objects()\h/2,RGBA(objects()\color\r,objects()\color\g,objects()\color\b,objects()\color\a))
    EndSelect
  Next
  StopDrawing()
EndProcedure

OpenWindow(#wnd,#PB_Ignore,#PB_Ignore,800,630,"canvasElements",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
CanvasGadget(#canvas,0,0,800,600)
ButtonGadget(#Add,0,600,100,30,"Add Dot")
ButtonGadget(#Move,100,600,100,30,"Move Dot")
ButtonGadget(#Delete,200,600,100,30,"Delete Dot")

For i = 0 To 100
  addObject(Random(1),Random(800),Random(600),Random(100,10),Random(100,10),Random(255,50),Random(255,50),Random(255,50),150)
Next

selectedObject = -1
drawObjects()
CurrentMode = #Move
DisableGadget(#Move,1)

Repeat
  ev = WaitWindowEvent()
  If ev = #PB_Event_Gadget
    Select EventGadget() 
      Case #canvas
        mouseX = GetGadgetAttribute(#canvas,#PB_Canvas_MouseX)
        mouseY = GetGadgetAttribute(#canvas,#PB_Canvas_MouseY)
        
        Select CurrentMode
          Case #Add
            If EventType() = #PB_EventType_LeftButtonDown
              width.w = Random(100,10)
              height.w = Random(100,10)
              addObject(Random(1),mouseX-width/2,mouseY-height/2,width,height,Random(255,50),Random(255,50),Random(255,50),150)
            EndIf
            
          Case #Move
            If EventType() = #PB_EventType_LeftButtonDown And Not buttonPressed
              buttonPressed = #True
              For i = ListSize(objects())-1 To 0 Step -1
                SelectElement(objects(),i)
                If isInRect(mouseX,mouseY,objects()\x,objects()\y,objects()\x+objects()\w,objects()\y+objects()\h)
                  offsetX = mouseX - objects()\x
                  offsetY = mouseY - objects()\y
                  MoveElement(objects(),#PB_List_Last)
                  selectedObject = ListSize(objects())-1
                  Break
                EndIf
              Next
            ElseIf EventType() = #PB_EventType_MouseMove And buttonPressed And selectedObject > -1
              SelectElement(objects(),selectedObject)
              objects()\x = mouseX - offsetX
              objects()\y = mouseY - offsetY
            ElseIf EventType() = #PB_EventType_LeftButtonUp And buttonPressed
              buttonPressed = #False
              selectedObject = -1
            EndIf
            
          Case #Delete
            If EventType() = #PB_EventType_LeftButtonDown And Not buttonPressed
              buttonPressed = #True
              For i = ListSize(objects())-1 To 0 Step -1
                SelectElement(objects(),i)
                If isInRect(mouseX,mouseY,objects()\x,objects()\y,objects()\x+objects()\w,objects()\y+objects()\h)
                  offsetX = mouseX - objects()\x
                  offsetY = mouseY - objects()\y
                  MoveElement(objects(),#PB_List_Last)
                  selectedObject = ListSize(objects())-1
                  Break
                EndIf
              Next
            ElseIf EventType() = #PB_EventType_LeftButtonUp And buttonPressed
              DeleteElement(objects())
              buttonPressed = #False
              selectedObject = -1
            EndIf
        EndSelect
        drawObjects()
        
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
    
  EndIf
Until ev = #PB_Event_CloseWindow
