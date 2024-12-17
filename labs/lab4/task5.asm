.ORIG x3000

LD 	R2, INIT
LEA R1, NUMBERS

LOOP_READ
	ADD R2, R2, #1
	LEA	R0, STRING
	PUTS
	GETС
	OUT

	ADD R3, R0, #0
	LD R4, NEG48         ; Загружает значение -48
	ADD R3, R3, R4       ; Преобразует ASCII-код символа в число
	STR R3, R1, #0       ; Сохраняет число (результат вычитания) в массив по адресу в R1
	ADD R1, R1, #1       ; Увеличивает адрес в массиве на 1, переходя к следующему элементу массива

	LEA R0, NEWLINE      ; Загружает адрес строки с новой строкой в R0
	PUTS

	ADD R3, R2, #-5
	BRz SORT             ; Если R3 == 0 (введено 5 чисел), переходит к метке SORT
	BRnzp LOOP_READ

SORT
	LD 	R6, COUNT
	ADD R4, R6, #0

OUTLOOP

	ADD R4, R4, #-1     ; Уменьшает счетчик внешнего цикла R4 на 1
	BRz OUTPUT_LOOP     ; Если R4 == 0, переходит к циклу вывода
	LEA R3, NUMBERS     ; Загружает начальный адрес массива в R3
	ADD R5, R4, #0      ; Копирует значение R4 в R5 (для внутреннего цикла)

INLOOP

	LDR R0, R3, #0
	LDR R1, R3, #1
	NOT R2, R1
	ADD R2, R2, #1
	ADD R2, R0, R2      ; Вычисляет R2 = R0 - R1
	BRN SWAP            ; Если R2 < 0 (R0 < R1), переходит к метке SWAP
SKIP_SWAP
	ADD R3, R3, #1
	ADD R5, R5, #-1
	BRp INLOOP
	BRnzp OUTLOOP

SWAP
	STR R1, R3, #0      ; Записывает значение R1 в текущую позицию массива
	STR R0, R3, #1      ; Записывает значение R0 в следующую позицию массива
	BRnzp SKIP_SWAP

OUTPUT_LOOP

	LEA R1, NUMBERS     ; Загружает адрес начала массива
	LD R2, INIT

LOOP_PRINT

	LDR R0, R1, #0
	LD 	R4, POS48
	ADD R0, R0, R4 
	OUT
	LEA R0, NEWLINE
	PUTS
	ADD R1, R1, #1
	ADD R2, R2, #1
	ADD R3, R2, #-5
	BRz END             ; Если R3 == 0 (выведено 5 чисел), переходит к метке END
	BRnzp LOOP_PRINT

END                    
HALT                

INIT    .FILL #0
STRING  .STRINGZ "Enter a number: "
NEWLINE .STRINGZ "\n"
POS48   .FILL #48
NEG48   .FILL #-48
NUMBERS .BLKW #5
COUNT   .FILL #5
.END                 ; Обозначает конец программы
