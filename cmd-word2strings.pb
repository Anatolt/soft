If OpenConsole("test")
  PrintN("Привет. Я программа по разбивке слов на буквы. ")
    PrintN("Вверите любое слово, а я напечатаю каждую его букву на новой строке")
  Repeat
    y$ = Input()
    endOfWord = Len(y$)
    For letter=1 To endOfWord
      PrintN(Mid(y$,letter,1))
    Next
    PrintN("Готово! Ещё разок? (напечатайте exit или выход чтобы выйти)")
  Until y$ = "exit" Or y$ = "выход"
EndIf
