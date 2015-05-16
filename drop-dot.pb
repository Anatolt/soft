;Рисуем точку на канве.
;Пользователь может ее перетащить в другое место, нажав и удерживая ЛКМ
;Добавляем вторую точку (глобализуем переменные, выносим действие по переносу в процедуру)

EnableExplicit ;проверяет продекларированы ли переменные

Global wFlags, appQuit, dragOn, canvasMouseXOffset, canvasMouseYOffset

Enumeration
  #MainWindow
  #Canvas_circle_start
  #Canvas_line
  #Canvas_circle_end
  #Image
EndEnumeration

Procedure iliketomoveit(canva)
  Select EventType()
    Case #PB_EventType_LeftButtonDown
      dragOn = 1
      canvasMouseXOffset = GetGadgetAttribute(canva, #PB_Canvas_MouseX)
      canvasMouseYOffset = GetGadgetAttribute(canva, #PB_Canvas_MouseY)
    Case #PB_EventType_LeftButtonUp
      dragOn = 0
    Case #PB_EventType_MouseMove
      If dragOn
        ResizeGadget(canva, WindowMouseX(#MainWindow) - canvasMouseXOffset, 
                     WindowMouseY(#MainWindow) - canvasMouseYOffset, #PB_Ignore, #PB_Ignore)
      EndIf
  EndSelect
EndProcedure

;Рисуем точку на канве.
;Если пользователь нажимает на неё, он может ее перетащить в другое место.

If LoadImage(#Image, "CS.bmp")
  
  wFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
  OpenWindow(#MainWindow, #PB_Any, #PB_Any, 640, 480, "Drag&Drop CanvasGadget", wFlags)
  
  CanvasGadget(#Canvas_circle_start, 10, 10, 21, 21)
  StartDrawing(CanvasOutput(#Canvas_circle_start))
  Circle(10,10,10,$000000)
  StopDrawing()
  
  CanvasGadget(#Canvas_circle_end, 590, 390, 30, 30)
  StartDrawing(CanvasOutput(#Canvas_circle_end))
  Circle(10,10,10,$000000)
  StopDrawing()
  ;SetGadgetAttribute(#Canvas, #PB_Canvas_Image, ImageID(#Image))
  SetWindowColor(#MainWindow, $ffffff)
  
  Repeat
    Select WaitWindowEvent()
      Case #PB_Event_Gadget
        Select EventGadget()
          Case #Canvas_circle_start
            iliketomoveit(#Canvas_circle_start)
          Case #Canvas_circle_end
            iliketomoveit(#Canvas_circle_end)
        EndSelect
      Case #PB_Event_CloseWindow
        appQuit = 1
    EndSelect
  Until appQuit = 1
EndIf
