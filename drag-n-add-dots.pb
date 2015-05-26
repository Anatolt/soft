#canvasWidth = 300
#canvasHeigh = 300
#white = 16777215
;Debug RGB(255,255,255)
#black = 0
;Debug RGB(0,0,0)
Enumeration
  #wnd
  #canva
  #editor
  #Add
  #Move
  #Delete
  #Hide
  #Random
  #Clear
  #Save
  #Open
  #canvas2editor
  #editor2canvas
EndEnumeration

Structure dot
  x.w
  y.w
EndStructure

Global NewList all.dot(), R = 5, color$

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
  StartDrawing(CanvasOutput(#canva))
  Box(0,0,#canvasWidth,#canvasHeigh,#black)
  For i = 0 To ListSize(all())-1
    SelectElement(all(),i)
    x = all()\x
    y = all()\y
    Circle(x,y,R,#white)
    If i > 0
      SelectElement(all(),i-1)
      x2 = all()\x
      y2 = all()\y
      LineXY(x,y,x2,y2,#white)
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

Procedure canvas2editor()
  ClearGadgetItems(#editor)
  ForEach all()
    AddGadgetItem(#editor,-1,Str(all()\x)+","+Str(all()\y))
  Next
EndProcedure

Procedure editor2canvas()
  ClearList(all())
  For i=0 To CountGadgetItems(#editor)-1
    string$ = GetGadgetItemText(#editor,i)
    
    tempX$ = StringField(string$, 1, ",")
    Debug "tempX$="+tempX$
    
    tempY$  = Mid(string$,FindString(string$, ",")+1)
    Debug "tempY$="+tempY$
    
    x = Val(tempX$)
    Debug "x="+x
    
    y = Val(tempY$)
    Debug "y="+y
    
    addDot(x,y)
    tempX$ = ""
    tempY$ = ""
    
  Next
EndProcedure
  
OpenWindow(#wnd,#PB_Ignore,#PB_Ignore,#canvasWidth+100,#canvasHeigh+90+25,"drag-n-add-lines v0.11", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )

ButtonGadget(#Add,   0,               #canvasHeigh,#canvasWidth/3,30,"Add Dot")
ButtonGadget(#Move,  #canvasWidth/3,  #canvasHeigh,#canvasWidth/3,30,"Move Dot")
ButtonGadget(#Delete,#canvasWidth/3*2,#canvasHeigh,#canvasWidth/3,30,"Delete Dot")

ButtonGadget(#Random,0,              #canvasHeigh+30,#canvasWidth/3,30,"Random")
CheckBoxGadget(#Hide, 10+#canvasWidth/3,  #canvasHeigh+30,#canvasWidth/3-10,30,"Hide Dots")
ButtonGadget(#Clear,#canvasWidth/3*2,#canvasHeigh+30,#canvasWidth/3,30,"Clear")

ButtonGadget(#Save, 0,               #canvasHeigh+60,#canvasWidth/3,30,"Save")
ButtonGadget(#Open, #canvasWidth/3,  #canvasHeigh+60,#canvasWidth/3,30,"Open",#PB_Button_Toggle)

ButtonGadget(#canvas2editor, #canvasWidth,                 #canvasHeigh,   #canvasWidth/3,30,"Canvas → Editor")
ButtonGadget(#editor2canvas, #canvasWidth,  #canvasHeigh+30,#canvasWidth/3,30,"Editor → Canvas");←

CreateStatusBar(666, WindowID(#wnd))
AddStatusBarField(#canvasWidth)
CanvasGadget(#canva,0,0,#canvasWidth,#canvasHeigh)

EditorGadget(#editor,#canvasWidth,0,#canvasWidth/3,#canvasHeigh)

addFewDots(13)

CurrentMode = #Move
DisableGadget(#Move,1)

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget
    Select EventGadget() 
      Case #canva
        mouseX = GetGadgetAttribute(#canva, #PB_Canvas_MouseX)
        mouseY = GetGadgetAttribute(#canva, #PB_Canvas_MouseY)
        ;         StartDrawing(CanvasOutput(#canva))
        ;         color$ = ", color:"+Str(Point(MouseX,MouseY))
        ;         StopDrawing()
        StatusBarText(666, 0, Str(MouseX)+","+Str(MouseY)+color$)
        
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
        addFewDots(13)
        
      Case #Hide
        If GetGadgetState(#Hide)
          R = 0
        Else
          R = 5
        EndIf
        
      Case #Clear
        ClearList(all())
        
      Case #Open
        file = 0
        File$ = OpenFileRequester("Load Text...", "", "TXT Files|*.txt|All Files|*.*", 0)
        If File$
          Debug "file opened ok"
          If ReadFile(file,File$)
            Debug "read file ok"
            ClearGadgetItems(#editor)
            ClearList(all())
            While Eof(file) = 0
              string$=ReadString(file)
              AddGadgetItem(#editor,-1,string$)
            Wend
            CloseFile(file)
            editor2canvas()
          Else
            MessageRequester("Ooops", "Cannot load file: " + File$)
          EndIf
        EndIf
        
      Case #Save
        canvas2editor()
        File$ = SaveFileRequester("Save Text...", File$, "TXT Files|*.txt|All Files|*.*", 0)
        If File$ And (FileSize(File$) = -1)
          If GetGadgetItemText(#editor,0) And CreateFile(file,File$)
            counter = CountGadgetItems(#editor) - 1
            For position = 0 To counter 
              WriteStringN(file,GetGadgetItemText(#editor,position))
            Next
            CloseFile(file)
          Else
            MessageRequester("Ой","Почему-то не могу создать файл")
          EndIf       
        EndIf
        
      Case #canvas2editor
        canvas2editor()
        
      Case #editor2canvas
        editor2canvas()
    EndSelect
    drawAll()
  EndIf
Until event = #PB_Event_CloseWindow

;===Суть!
;Программа сохраняет нарисованное пользователем в виде процедурного кода PureBasic.
;Этот код потом можно запустить при следующем запуске программы, получив все нарисованные линии.
;Линии возможно изменять после повторной генерации.

;===План
; Завершить полигон - Enter
; Создание текста процедуры рисования линий, соответствующих полигону
; Перетаскивать линию - ЛКМ, удалять - СКМ, добавлять - ПКМ

;===Далекое будущее
;проверяем не нажал ли пользователь на саму линию (формулы вычисления линии?)
;возможность изменять уже нарисованную линию, кликнув по самой линии
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба
;задержка рисования полигона
;Ctrl+Z
;подсветка точки и координаты в списке

;===Работаю над
; заливка
; запись не только результатов, но и действий
; заменить hide на галочку
; изменение координат точки вручную
