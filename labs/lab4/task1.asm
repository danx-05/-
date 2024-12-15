.ORIG x3000               ; начало программы
    LEA R0, HELLO_STR     ; загрузка адреса строки в R0
    PUTS                  ; вывод строки
    HALT                  ; остановка программы
HELLO_STR .STRINGZ "Hello, World!" ; определение строки
.END
