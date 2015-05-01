; (c) deseven.info
Enumeration
  #wnd
  #canvas
  #plus
  #minus
  #change
EndEnumeration

Global anima_type

points.b = 5
isAnimating = #False

Procedure drawPoints(points.b,animate.b = #False,animatePlus.b = #True,animateStep.b = 0)
  StartDrawing(CanvasOutput(#canvas))
  Box(0,0,400,40,GetWindowColor(#wnd))
  For i = 0 To points-1
    If i = points-1 And animate
      If animatePlus
        Select anima_type
          Case 1
            Box(i*40+5,5,3*animateStep,3*animateStep,$ff0000)
          Case 2
            Box(i*40+5+(30-3*animateStep)/2,5+(30-3*animateStep)/2,3*animateStep,3*animateStep,RGB(255-animateStep*25,255-animateStep*25,255))
          Case 3
            Box(i*40+5+(400-i*40+5)/animateStep+1,5,30,30,RGB(255-animateStep*25,255-animateStep*25,255))
          Case 4
            Box(i*40+5,-25+animateStep*3,30,30,RGB(255-animateStep*25,255-animateStep*25,255))
        EndSelect
      Else
        Select anima_type
          Case 1
            Box(i*40+5,5,30/animateStep,30/animateStep,$ff0000)
          Case 2
            Box(i*40+5+(30-30/animateStep)/2,5+(30-30/animateStep)/2,30/animateStep,30/animateStep,RGB(animateStep*25,animateStep*25,255))
          Case 3
            Box(400-(400-i*40+5)/animateStep,5,30,30,RGB(animateStep*25,animateStep*25,255))
          Case 4
            Box(i*40+5,5+animateStep*3,30,30,RGB(animateStep*25,animateStep*25,255))
        EndSelect
      EndIf
    Else
      Box(i*40+5,5,30,30,$ff0000)
    EndIf
  Next
  StopDrawing()
EndProcedure

OpenWindow(#wnd,#PB_Ignore,#PB_Ignore,400,120,"Простейший индикатор на канвасе",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
CanvasGadget(#canvas,0,0,400,40)
ButtonGadget(#plus,0,40,200,40,"+1")
ButtonGadget(#minus,200,40,200,40,"-1")
ButtonGadget(#change,0,80,400,40,"Change Animation")

drawPoints(points)

Repeat
  ev = WindowEvent()
  If ev
    Select EventGadget() 
      Case #plus 
        If points+1 <= 10 And EventType() = #PB_EventType_LeftClick
          newPoints = points + 1
          isAnimating = #True
        EndIf
      Case #minus 
        If points-1 >= 0 And EventType() = #PB_EventType_LeftClick
          newPoints = points - 1
          isAnimating = #True
        EndIf
      Case #change
        If anima_type > 4
          anima_type = 1
        Else
          anima_type = anima_type + 1
        EndIf
    EndSelect
  ElseIf isAnimating
    If animateStep = 10
      isAnimating = #False
      animateStep = 0
      points = newPoints
      drawPoints(points)
    Else
      animateStep + 1
      If newPoints > points
        drawPoints(newPoints,#True,#True,animateStep)
      Else
        drawPoints(points,#True,#False,animateStep)
      EndIf
    EndIf
    Delay(15)
  Else
    Delay(10)
  EndIf
Until ev = #PB_Event_CloseWindow
