#white = 16777215
;Debug RGB(255,255,255)
#black = 0
;Debug RGB(0,0,0)
Enumeration
  #up
  #down
  #left
  #right
  #wnd
  #canva
  #editor
  #Add
  #Move
  #Fill
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

Structure area
  x.w
  y.w
EndStructure

Global NewList all.dot(), NewList fill.area(), R = 5, color$

Procedure areaFill(x,y)
  AddElement(fill())
  fill()\x = x
  fill()\y = y
EndProcedure

Procedure addDot(x,y)
  AddElement(all())
  all()\x = x
  all()\y = y
EndProcedure

Procedure popal(mX, mY, objX, objY, objW = 5, objH = 5)
  If mX >= objX-R And mX <= objX+R And mY >= objY-R And mY <= objY+R
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False
EndProcedure

Procedure drawAll()
  StartDrawing(CanvasOutput(#canva))
  Box(0,0,300,300,#black)
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
  For i = 0 To ListSize(fill())-1
    SelectElement(fill(),i)
    x = fill()\x
    y = fill()\y
    FillArea(x,y,-1,#white)
  Next
  StopDrawing()
EndProcedure

Procedure addFewDots(num)
  For i = 0 To num
    addDot(Random(300),Random(300))
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
    x = Val(StringField(string$, 1, ","))
    y = Val(Mid(string$,FindString(string$, ",")+1))
    addDot(x,y)
  Next
EndProcedure
  
OpenWindow(#wnd,#PB_Ignore,#PB_Ignore,300+100,300+90+25,"Vector Paint v0.12", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )

ButtonGadget(#Add,   0,               300,300/3,30,"Add Dot")
ButtonGadget(#Move,  300/3,  300,300/3,30,"Move Dot")
ButtonGadget(#Delete,300/3*2,300,300/3,30,"Delete Dot")

ButtonGadget(#Random, 0,                  300+30,300/3,   30,"Random")
CheckBoxGadget(#Hide, 10+300/3,  300+30,300/3-10,30,"Hide Dots")
ButtonGadget(#Clear,  300/3*2,   300+30,300/3,   30,"Clear")

ButtonGadget(#Save, 0,               300+60,300/3,30,"Save")
ButtonGadget(#Open, 300/3,  300+60,300/3,30,"Open",#PB_Button_Toggle)

ButtonGadget(#canvas2editor, 300,  300,   300/3,30,"Canvas → Editor")
ButtonGadget(#editor2canvas, 300,  300+30,300/3,30,"Editor → Canvas");←
ButtonGadget(#Fill,          300,  300+60,300/3,30,"Fill");←

CreateStatusBar(666, WindowID(#wnd))
AddStatusBarField(300)
CanvasGadget(#canva,0,0,300,300)

EditorGadget(#editor,300,0,300/3,300)

addDot(10,10)
addFewDots(13)

CurrentMode = #Move
DisableGadget(#Move,1)

AddKeyboardShortcut(#wnd,#PB_Shortcut_Up,#up)
AddKeyboardShortcut(#wnd,#PB_Shortcut_Down,#down)
AddKeyboardShortcut(#wnd,#PB_Shortcut_Left,#left)
AddKeyboardShortcut(#wnd,#PB_Shortcut_Right,#right)

Repeat
  event = WaitWindowEvent()
  If event = #PB_Event_Gadget
    Select EventGadget() 
      Case #canva
        mX = GetGadgetAttribute(#canva, #PB_Canvas_MouseX)
        mY = GetGadgetAttribute(#canva, #PB_Canvas_MouseY)
        ;         StartDrawing(CanvasOutput(#canva))
        ;         color$ = ", color:"+Str(Point(mX,mY))
        ;         StopDrawing()
        StatusBarText(666, 0, Str(mX)+","+Str(mY)+color$)
        
        Select EventType() 
          Case #PB_EventType_LeftButtonDown
            If Not buttonPressed
              buttonPressed = #True
              If CurrentMode = #Add
                addDot(mX, mY)
                SelectElement(all(),ListSize(all())-1)
                all()\x = mX - R/2
                all()\y = mY - R/2
                Debug "added element ["+Str(all()\x) + "," + Str(all()\y) +"]"
              ElseIf CurrentMode = #Fill
                areaFill(mX,mY)
              Else
                For i = ListSize(all())-1 To 0 Step -1
                  SelectElement(all(),i)
                  If popal(mX,mY,all()\x,all()\y)
                    Debug "touched element [" + Str(all()\x) + "," + Str(all()\y) + ","+i+"]"
                    offsetX = mX - all()\x
                    offsetY = mY - all()\y
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
              all()\x = mX - offsetX
              all()\y = mY - offsetY
              ;drawAll()
            EndIf
            
          Case #PB_EventType_LeftButtonUp
            If buttonPressed
              buttonPressed = #False
              selectedObject = -1
              ;drawAll()
            EndIf
        EndSelect
        
      Case #Add, #Delete, #Move, #Fill
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
        ClearList(fill())
        
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
  If event = #PB_Event_Menu
    Select EventMenu()
      Case #down
        SelectElement(all(),0)
        all()\y + 10
        selectedObject = -1
        drawAll()
      Case #up
        SelectElement(all(),0)
        all()\y - 10
        selectedObject = -1
        drawAll()
      Case #left
        SelectElement(all(),0)
        all()\x - 10
        selectedObject = -1
        drawAll()
      Case #right
        SelectElement(all(),0)
        all()\x + 10
        selectedObject = -1
        drawAll()
    EndSelect
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
; перезапись файла не работает!
; после касания точки ее можно перемещать с клавы
; переделать панель инструментов. сделать ее слева от канваса
; сделать чтобы новые координаты точек сразу попадали в едитор и наоборот
; запись не только результатов, но и действий
; изменение координат точки вручную
