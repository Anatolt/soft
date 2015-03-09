versin$ = "v0.1"

OpenWindow(0,200,200,500,530,"Читалка текстовых файлов "+version$)
editor = EditorGadget(#PB_Any,0,30,500,500)
btn_read = ButtonGadget(#PB_Any,0,0,250,30,"Читать файл")
btn_write = ButtonGadget(#PB_Any,250,0,250,30,"Сохранить файл")
Repeat
  event = WaitWindowEvent() 
  If event = #PB_Event_Gadget
    Select EventGadget()
      Case btn_read
        If ReadFile(file,"reader.txt")
          ClearGadgetItems(editor)
          While Eof(i) = 0
            AddGadgetItem(editor,-1,ReadString(i))
          Wend
          CloseFile(file)
        Else
          MessageRequester("Ой","Файла reader.txt рядом с программой нету. Напишите что-нибудь и нажмите Сохранить")
        EndIf
      Case btn_write
        If GetGadgetItemText(editor,0) And CreateFile(file,"reader.txt")
          counter = CountGadgetItems(editor) - 1
          For position = 0 To counter 
            WriteStringN(file,GetGadgetItemText(editor,position))
          Next
          CloseFile(file)
        Else
          MessageRequester("Ой","Почему-то не могу создать файл")
        EndIf
    EndSelect
    
  EndIf
Until event = #PB_Event_CloseWindow
