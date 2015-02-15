OpenWindow(0,100,100,500,200,"Изучаем LCase()")
ishodnik$ = "пРоГрАммиРоВаТь нАдо С Утра, а то ВечЕром ничерта Не сОобРжаешь"
ishodnik = StringGadget(#PB_Any,0,0, 600,50,ishodnik$)
  btn_up = ButtonGadget(#PB_Any,0,50,600,50,"все буквы в нижний регистр")
btn_down = ButtonGadget(#PB_Any,0,100,600,50,"ВСЕ БУКВЫ В ВЕРХНИЙ РЕГИСТР")
  result = StringGadget(#PB_Any,0,150,600,50,result$)
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget 
    Select EventGadget() 
      Case btn_down
        SetGadgetText(result,UCase(ishodnik$))
      Case btn_up
        SetGadgetText(result,LCase(ishodnik$))
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow
