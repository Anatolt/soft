OpenWindow(0,100,100,600,200,"Изучаем LCase()")
ishodnik = StringGadget(#PB_Any,0, 0, 600,50,"пРоГрАммиРоВаТь нАдо С Утра, а то ВечЕром ничерта Не сОобРжаешь")
btn_down = ButtonGadget(#PB_Any,0,50, 600,50,"все буквы в нижний регистр")
 btn_up  = ButtonGadget(#PB_Any,0,100,600,50,"ВСЕ БУКВЫ В ВЕРХНИЙ РЕГИСТР")
  result = StringGadget(#PB_Any,0,150,600,50,result$)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case btn_down
        SetGadgetText(result,LCase(GetGadgetText(ishodnik))) ;меньше
      Case btn_up
        SetGadgetText(result,UCase(GetGadgetText(ishodnik))) ;БОЛЬШЕ
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow
