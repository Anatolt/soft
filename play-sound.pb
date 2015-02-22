OpenWindow(0,200,200,200,200,"Sound ChecK")
btn = ButtonGadget(1,0,0,200,200,"Play sound")
InitSound()
Sound = LoadSound(#PB_Any,"sound.wav")
Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget ;And EventGadget() = btn
    Debug "кнопка нажата"
    PlaySound(Sound)
  EndIf
Until event = #PB_Event_CloseWindow
