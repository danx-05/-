.ORIG x3000
LEA R0, FIRSTPROMPT 
PUTS
LEA R0, SPACE
PUTS
LEA R0, SAMPLE
PUTS
LD R3, POINTER
LD R6, IOCOUNTER

INPUT
    IN ; Считывание символа с клавиатуры
    AND R2, R2, x0
    AND R5, R5, x0
    LD R5, PLACEHUNDRED
    LD R2, HEXN48
    ADD R0, R0, R2
    ADD R2, R0, x0
    AND R0, R0, x0
; Добавление сотен в текущее число
FIRST_NUM  
ADD R0, R0, R2
ADD R5, R5, x-1
BRp FIRST_NUM
ADD R1, R0, x0
AND R0, R0, x0
; Добавление десятков в текущее число
IN
AND R2, R2, x0
AND R5, R5, x0
LD R5, PLACETEN
LD R2, HEXN48
ADD R0, R0, R2
ADD R2, R0, x0
AND R0, R0, x0

SECOND_NUM
ADD R0, R0, R2
ADD R5, R5, x-1
BRp SECOND_NUM
ADD R4, R0, x0
AND R0, R0, x0

IN
AND R2, R2, x0
LD R2, HEXN48
ADD R0, R0, R2
AND R2, R2, x0
; Сбор числа из сотен (R1), десятков (R4) и единиц (R0), запись числа в память
ADD R2, R1, R4
ADD R2, R0, R2
STR R2, R3, x0  ; Запись числа в память по адресу, указанному в R3
ADD R3, R3, x1  ; Инкремент указателя на следующий элемент массива
ADD R6, R6, x-1 ; Декремент счётчика вводимых чисел
BRp INPUT       ; Если есть ещё числа для ввода, продолжить цикл

JSR BUBBLESORT
JSR PRODUCTLOOP
HALT

BUBBLESORT
AND R3, R3, x0
LD R3, POINTER; Загружаем в R3 указатель на начало области памяти для сортировки
AND R4, R4, x0
LD R4, IOCOUNTER; Загружаем в R4 счётчик чисел для внешнего цикла сортировки
AND R5, R5, x0
LD R5, IOCOUNTER

FINALOUT_LOOP ; пока массив не отсортирован
ADD R4, R4, x-1; Декрементируем счётчик внешнего цикла
BRz SORTED
ADD R5, R4, x0; Копируем значение счётчика внешнего цикла в R5 для внутреннего цикла
LD R3, POINTER; Сбрасываем указатель на начало массива для нового прохода сортировки

FINALIN_LOOP
LDR R0, R3, x0            ; Загружаем текущий элемент (R0) из массива в R3
LDR R1, R3, x1            ; Загружаем следующий элемент (R1) из массива
AND R2, R2, x0            ; Обнуляем R2 (будет использован для проверки необходимости обмена)
NOT R2, R1                ; Инвертируем следующий элемент для последующего сравнения
ADD R2, R2, x1            ; Готовим значение для вычисления разности R0 - R1
ADD R2, R0, R2            ; Вычисляем разность R0 - R1
BRn AUTOSWAP              ; Если R0 < R1, переход к метке AUTOSWAP для обмена элементами

; Обмен элементами не требуется; сохраняем их и переходим к следующей итерации
STR R1, R3, x0            ; Сохраняем следующий элемент (R1) на место текущего (R0)
STR R0, R3, x1            ; Сохраняем текущий элемент (R0) на место следующего (R1)

; Метка автоматического обмена элементов, если было выполнено условие BRn выше
AUTOSWAP
ADD R3, R3, x1            ; Инкрементируем указатель на массив для перехода к следующему элементу
ADD R5, R5, x-1           ; Декрементируем счётчик внутреннего цикла
BRp FINALIN_LOOP          ; Если счётчик внутреннего цикла не стал нулём, продолжаем сортировку
BRzp FINALOUT_LOOP        ; Если счётчик внутреннего цикла стал нулём, начинаем новый проход сортировки
SORTED                    ; Массив отсортирован
RET                       ; Возвращаем управление вызывающей подпрограмме

PRODUCTLOOP
LEA R0, PROMPTEXECUTE   ; Загружаем адрес строки приглашения в R0
PUTS                    ; Выводим строку приглашения на экран
LD R3, POINTER          ; Загружаем в R3 указатель на начало данных
LD R6, IOCOUNTER        ; Загружаем в R6 значение счетчика цикла обработки

; Основной цикл обработки чисел
RESULTLOOP
AND R1, R1, x0          ; Обнуляем регистр R1 (работает как R1 = 0)
AND R2, R2, x0          ; Обнуляем регистр R2
AND R4, R4, x0          ; Обнуляем регистр R4
AND R5, R5, x0          ; Обнуляем регистр R5
AND R0, R0, x0          ; Обнуляем регистр R0
LD R0, SPACE            ; Загружаем в R0 ASCII код пробельного символа
OUT                     ; Выводим пробел
AND R0, R0, x0          ; Снова обнуляем регистр R0
LDR R0, R3, x0          ; Загружаем в R0 значение из памяти по адресу, на который указывает R3

; Вычитаем 100 до тех пор, пока не останется менее 100
LD R2, PLACEHUNDRED     ; Загружаем в R2 значение 100 (PLACEHUNDRED)
NOT R2, R2              ; Инвертируем биты в R2 (это шаг для вычитания)
ADD R2, R2, x1          ; Добавляем 1 к R2, получаем -100 (двоичное дополнение)

MINUS01                 ; Метка цикла для вычитания 100
ADD R1, R1, x1          ; Увеличиваем счетчик в R1 (считаем сотни)
ADD R0, R0, R2          ; Вычитаем 100 из значения в R0
BRzp MINUS01            ; Повторяем, пока R0 >= 0


; Вычисляем остаток и сохраняем количество сотен
REMAINDER01
AND R2, R2, x0          ; Обнуляем R2
LD R2, PLACEHUNDRED     ; Загружаем 100 в R2 снова
ADD R0, R0, R2          ; Добавляем 100 обратно в R0
ADD R1, R1, x-1         ; Декрементируем R1 (убираем лишнюю 100)
STI R1, FIRSTNUM        ; Сохраняем значение сотен в переменную FIRSTNUM

; Вычитаем 10 до тех пор, пока не останется менее 10
AND R2, R2, x0
LD R2, PLACETEN         ; Загружаем 10 в R2
NOT R2, R2              ; Инвертируем биты в R2
ADD R2, R2, x1          ; Добавляем 1, чтобы получить -10

MINUS02                 ; Метка цикла для вычитания 10
ADD R4, R4, x1          ; Увеличиваем счетчик в R4 (считаем десятки)
ADD R0, R0, R2          ; Вычитаем 10 из R0
BRzp MINUS02            ; Повторяем, пока R0 >= 0

REMAINDER2
AND R2, R2, x0
LD R2, PLACETEN         ; Загружаем 10 в R2
ADD R5, R0, R2          ; Добавляем 10 обратно, чтобы получить цифру единиц
STI R5, THIRDNUM        ; Сохраняем цифру единиц
ADD R4, R4, x-1         ; Уменьшаем значение десятков на 1
STI R4, SECONDNUM       ; Сохраняем цифру десятков

AND R0, R0, x0
LDI R0, FIRSTNUM        ; Загружаем цифру сотен для вывода
AND R2, R2, x0
LD R2, HEX48            ; Загружаем ASCII код '0' (48 в шестнадцатеричной)
ADD R0, R0, R2          ; Превращаем цифру в символ
OUT                     ; Выводим цифру сотен
AND R0, R0, x0
LDI R0, SECONDNUM       ; Аналогично загружаем и выводим цифру десятков
AND R2, R2, x0
LD R2, HEX48
ADD R0, R0, R2
OUT
AND R0, R0, x0
LDI R0, THIRDNUM 
AND R2, R2, x0
LD R2, HEX48
ADD R0, R0, R2
OUT

ADD R3, R3, x1          ; Увеличиваем указатель на следующее число
ADD R6, R6, x-1         ; Декрементируем счетчик чисел
BRp RESULTLOOP          ; Если счетчик не достиг 0, возвращаемся в начало цикла

HALT

FIRSTPROMPT	.STRINGZ	"Input 5 numbers ranging from 000 - 100 with 3 digits."
SAMPLE		.STRINGZ	"Ex: Input 15 as 015 or 5 as 005"
PROMPTEXECUTE	.STRINGZ	"Numbers in Ascending Order: "
SPACE		.STRINGZ     "\n"	
HEXN48		.FILL	xFFD0	
HEX48		.FILL	x0030	
PLACEHUNDRED	.FILL	x0064	
PLACETEN	.FILL	x000A	
POINTER		.FILL	x4000	
IOCOUNTER	.FILL	#5
FIRSTNUM	.FILL	x400A	
SECONDNUM	.FILL	x400B	
THIRDNUM	.FILL	x400C	
.END
