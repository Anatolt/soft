; заменялка полей массовая. v1.0 Работает!

OpenWindow(0,100,100,420,670,"Массовая заменялка")
ishodnik = EditorGadget(#PB_Any,10,10,400,200)
chto = EditorGadget(#PB_Any,10,210,200,200)
na_chto = EditorGadget(#PB_Any,210,210,200,200)
btn = ButtonGadget(#PB_Any,10,420,400,30,"Зробыть дiло")
result = EditorGadget(#PB_Any,10,460,400,200)

AddGadgetItem(ishodnik,-1,"грустный текст. дуже грустный.")
AddGadgetItem(ishodnik,-1,"очень грустный текст.")
AddGadgetItem(chto,-1,"грустный")
AddGadgetItem(chto,-1,"текст")
AddGadgetItem(chto,-1,"очень")
AddGadgetItem(na_chto,-1,"веселый")
AddGadgetItem(na_chto,-1,"рассказ")
AddGadgetItem(na_chto,-1,"совершенно")
If CreatePopupMenu(0) : MenuItem(2, "Quit") : EndIf : AddKeyboardShortcut(0, #PB_Shortcut_Escape, 2); закрывалка по эскейпу ч1

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Menu And EventMenu() = 2 : event = #PB_Event_CloseWindow : EndIf ; закрывалка по эскейпу ч2
  If event = #PB_Event_Gadget And EventGadget() = btn
    ClearGadgetItems(result)
    CntIshodnik = CountGadgetItems(ishodnik)
    CntChto = CountGadgetItems(chto)
    CntNaChto = CountGadgetItems(na_chto)
    For pos_ishodnik = 0 To CntIshodnik-1
      ishodnik$ = GetGadgetItemText(ishodnik,pos_ishodnik)
      For pos_chto = 0 To CntChto-1
        chto$ = GetGadgetItemText(chto,pos_chto)
        na_chto$ = GetGadgetItemText(na_chto,pos_chto)
        ishodnik$ = ReplaceString(ishodnik$,chto$,na_chto$,#PB_String_NoCase)
      Next
      AddGadgetItem(result,-1,ishodnik$)
    Next
  EndIf
Until event = #PB_Event_CloseWindow
