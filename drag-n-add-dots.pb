IncludeFile "drop-dot-form.pbf"

#start = 1
#stop = 2
#area = 3
#white = 16777215
Enumeration
  #up
  #down
  #left
  #right
  #return
  #canvas2editor
  #IMAGE_Color
EndEnumeration

Structure dot
  type.b
  x.w
  y.w
  color.l
EndStructure

Global NewList all.dot(), R = 5;, color$

Procedure addDot(x,y,type=#start,color=#white)
  AddElement(all())
  all()\type = type
  all()\x = x
  all()\y = y
  all()\color = color ;Random(#white-100)
EndProcedure

Procedure popal(mX, mY, objX, objY, objW = 5, objH = 5)
  If mX >= objX-R And mX <= objX+R And mY >= objY-R And mY <= objY+R
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False
EndProcedure

Macro macroDrawAll
  StartDrawing(CanvasOutput(#canva))
  Box(0,0,300,300,0)
  For i = 0 To ListSize(all())-1
    SelectElement(all(),i)
    type = all()\type
    x = all()\x
    y = all()\y
    color = all()\color
    Select type
      Case #start
        Circle(x,y,R,color)
        If i > 0 And Not type = #stop
          SelectElement(all(),i-1)
          x2 = all()\x
          y2 = all()\y
          LineXY(x,y,x2,y2,color)
          SelectElement(all(),i) ;без этой строчки при добавлении новой точки рядом с ней появляется еще одна
        EndIf
      Case #stop  
        Circle(x,y,R,color)
      Case #area
        FillArea(x,y,-1,color)
    EndSelect
  Next
  StopDrawing()
EndMacro

Procedure drawAll()
  macroDrawAll
EndProcedure

Procedure editor2canvas()
  ClearList(all())
  For i=0 To CountGadgetItems(#editor)-1
    string$ = GetGadgetItemText(#editor,i)
    x = Val(StringField(string$, 1, ","))
    pos_type = FindString(string$, ",")+1
    y = Val(Mid(string$,pos_type))
    pos_color = FindString(string$, ",", pos_type+1)
    type = Val(Mid(string$,FindString(string$, ",", pos_type+1)+1))
    color = Val(Mid(string$,FindString(string$, ",", pos_color+1)+1))
    addDot(x,y,type,color)
  Next
EndProcedure

Procedure proc(text$)
  AddGadgetItem(#editor2proc,-1,text$)
EndProcedure

Procedure canvas2editor()
  ClearGadgetItems(#editor2proc)
  ;proc(macroDrawAll) - так к сожалению не работает
  ;#CRLF$ - символ переноса строки
  ;здесь нужно добавить структуру all()
proc("#canva = 13")
proc("#start = 1")
proc("#stop = 2")
proc("#area = 3")
proc("#white = 16777215")
  proc("Structure dot")
    proc("type.b")
    proc("x.w")
    proc("y.w")
    proc("color.l")
    proc("EndStructure")
    proc("Global NewList all.dot()")
    proc("Procedure drawAll()")
  proc("StartDrawing(CanvasOutput(#canva))")
  proc("Box(0,0,300,300,0)")
  proc("For i = 0 To ListSize(all())-1")
  proc("SelectElement(all(),i)")
      proc("type = all()\type")
      proc("x = all()\x")
      proc("y = all()\y")
      proc("color = all()\color")
      proc("Select type")
        proc("Case #start")
          proc("Circle(x,y,R,color)")
          proc("If i > 0 And Not type = #stop")
            proc("SelectElement(all(),i-1)")
            proc("x2 = all()\x")
            proc("y2 = all()\y")
            proc("LineXY(x,y,x2,y2,color)")
            proc("SelectElement(all(),i)")
          proc("EndIf")
        proc("Case #stop")
          proc("Circle(x,y,R,color)")
        proc("Case #area")
          proc("FillArea(x,y,-1,color)")
      proc("EndSelect")
    proc("Next")
    proc("StopDrawing()")
    proc("EndProcedure")
    proc("Procedure addDot(x,y,type=#start,color=#white)")
  proc("AddElement(all())")
  proc("all()\type = type")
  proc("all()\x = x")
  proc("all()\y = y")
  proc("all()\color = color")
  proc("EndProcedure")
  ;здесь нужно дописать добавление всех точек из editor в структуру all

  ClearGadgetItems(#editor)
  ForEach all()
    txt$ = Str(all()\x)+","+Str(all()\y)+","+Str(all()\type)+","+Str(all()\color)
    AddGadgetItem(#editor,-1,txt$)
    AddGadgetItem(#editor2proc,-1,"addDot("+txt$+")")
  Next
  ;тут нужно добавить окно с канвой
  proc("OpenWindow(0,#PB_Ignore,#PB_Ignore,300,300,"+#DQUOTE$+#DQUOTE$+", #PB_Window_SystemMenu | #PB_Window_ScreenCentered )")
  proc("CanvasGadget(#canva,0,0,300,300)")
  proc("drawAll()")
  proc("Repeat")
    proc("Until WaitWindowEvent() = #PB_Event_CloseWindow")
EndProcedure

Procedure addFewDots(num)
  For i = 0 To num
    addDot(Random(300),Random(300),#start,Random(#white))
  Next
  canvas2editor()
EndProcedure

CurrentColor = Red(255)
CreateImage(#IMAGE_Color, 35, 35, 24)
StartDrawing(ImageOutput(#IMAGE_Color))
Box(0,0,100,30,CurrentColor)
StopDrawing()

Openwnd()
addFewDots(13)

CurrentMode = #Move
DisableGadget(#Move,1)

AddKeyboardShortcut(#wnd,#PB_Shortcut_W,#up)
AddKeyboardShortcut(#wnd,#PB_Shortcut_S,#down)
AddKeyboardShortcut(#wnd,#PB_Shortcut_A,#left)
AddKeyboardShortcut(#wnd,#PB_Shortcut_D,#right)
AddKeyboardShortcut(#wnd,#PB_Shortcut_Space,#stopLine)

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
        StatusBarText(0, 0, Str(mX)+","+Str(mY)+color$)
        
        Select EventType() 
          Case #PB_EventType_LeftButtonDown
            If Not buttonPressed
              buttonPressed = #True
              If CurrentMode = #Add
                addDot(mX, mY,#start,CurrentColor)
                SelectElement(all(),ListSize(all())-1)
                all()\x = mX - R/2
                all()\y = mY - R/2
                Debug "added element ["+Str(all()\x) + "," + Str(all()\y) +"]"
              ElseIf CurrentMode = #Fill
                addDot(mX,mY,#area,CurrentColor) ;areaFill
              ElseIf CurrentMode = #AddClickArea
                StartDrawing(CanvasOutput(#canva))
                DrawingMode(#PB_2DDrawing_Outlined)
                Box(mX, mY, x-mX, y-mY, CurrentColor)
                StopDrawing()
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
            canvas2editor()
        EndSelect
        
      Case #Add, #Delete, #Move, #Fill, #AddClickArea
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
      Case #GADGET_Color
        CurrentColor = ColorRequester(CurrentColor)
        If StartDrawing(ImageOutput(#IMAGE_Color))
          Box(0, 0, 100, 30, CurrentColor)
          StopDrawing()
          SetGadgetAttribute(#GADGET_Color, #PB_Button_Image, ImageID(#IMAGE_Color))
        EndIf
      Case #stop
        SelectElement(all(),ListSize(all())-1)
        all()\type = #stop
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
      Case #stopLine
        SelectElement(all(),ListSize(all())-1)
        all()\type = #stop
        drawAll()
    EndSelect
  EndIf
Until event = #PB_Event_CloseWindow

;===Суть!
;Результат работы программы - код, которым можно вставить в другую программу на PB. 
;Программа сохраняет нарисованное пользователем в виде процедурного кода PureBasic.
;Этот код потом можно запустить при следующем запуске программы, получив все нарисованные линии.
;Линии возможно изменять после повторной генерации.

;===Далекое будущее
;сохранять при выходе без спроса
;переделать панель инструментов. сделать ее слева от канваса
;проверяем не нажал ли пользователь на саму линию (формулы вычисления линии?)
;возможность изменять уже нарисованную линию, кликнув по самой линии
;изменение масштаба
;редактор пиксельной графики (рисование квадратами) only после изучения изменения масштаба
;сделать чтобы новые координаты точек сразу попадали в едитор и наоборот
;задержка рисования полигона
;Ctrl+Z
;подсветка точки и координаты в списке

;===Работаю над
; активные прямоугольники
; нужнен интерфейс для добавления активных зон, который будут кнопками в другом интерфейсе
; Перетаскивать линию - ЛКМ, удалять - СКМ, добавлять - ПКМ
; перезапись файла не работает!
; использовать завершение линии по Enter только если курсор на канве
; упростить вывод текста процедуры до линий
; написать инструкцию по искользованию при запуске. Мастер?
; изначально не отображается цвет гаджета выбора цвета
; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 296
; FirstLine = 267
; Folding = --
; EnableUnicode
; EnableXP