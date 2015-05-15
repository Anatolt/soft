;Рисуем точку на канве.
;Если пользователь нажимает на неё, он может ее перетащить в другое место.

EnableExplicit

Enumeration
  #MainWindow
  #Canvas
  #Image
EndEnumeration

Define wFlags, appQuit, dragOn, canvasMouseXOffset, canvasMouseYOffset

If LoadImage(#Image, "CS.bmp")

  wFlags = #PB_Window_SystemMenu |#PB_Window_ScreenCentered
  OpenWindow(#MainWindow, #PB_Any, #PB_Any, 640, 480, "Drag&Drop CanvasGadget", wFlags)
  CanvasGadget(#Canvas, 10, 10, 200, 205, #PB_Canvas_Border)
  SetGadgetAttribute(#Canvas, #PB_Canvas_Image, ImageID(#Image))

  Repeat
    Select WaitWindowEvent()
      Case #PB_Event_CloseWindow
        appQuit = 1
      Case #PB_Event_Gadget
        Select EventGadget()
          Case #Canvas
            Select EventType()
              Case #PB_EventType_LeftButtonDown
                dragOn = 1
                canvasMouseXOffset = GetGadgetAttribute(#Canvas, #PB_Canvas_MouseX)
                canvasMouseYOffset = GetGadgetAttribute(#Canvas, #PB_Canvas_MouseY)
              Case #PB_EventType_LeftButtonUp
                dragOn = 0
              Case #PB_EventType_MouseMove
                If dragOn
                  ResizeGadget(#Canvas, WindowMouseX(#MainWindow) - canvasMouseXOffset, 
                               WindowMouseY(#MainWindow) - canvasMouseYOffset, #PB_Ignore, #PB_Ignore)
                EndIf
            EndSelect
        EndSelect
    EndSelect
  Until appQuit = 1
EndIf
