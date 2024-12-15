.ORIG x3000

; Инициализация данных
LD R2, INIT			; Сброс счетчика
LEA R1, BUFFER			; Адрес буфера для ввода
LD R4, ASCII_ZERO		; Код символа '0'
LD R5, NEG_ASCII_ZERO		; Код символа '-0'

LEA R0, MSG			; Адрес приглашения к вводу
PUTS 				; Вывод приглашения к вводу

; Ввод данных
READ_LOOP
	GETC			; Получение символа с ввода
	OUT			; Вывод символа

	ADD R2, R2, #1		; Увеличиваем счетчик

	STR R0, R1, #0		; Сохранение символа в буфер
	ADD R1, R1, #1		; Увеличение адреса буфера
	ADD R3, R2, #-5		; Проверяем, введено ли 5 чисел
	BRz CONVERT		; Переход к сортировке, если да
	BRnzp READ_LOOP 	; Повторение ввода символов

; Конвертация строки в числа
CONVERT
	LEA R1, BUFFER		; Адрес начала буфера
	LEA R6, ARRAY		; Адрес начала массива чисел
	LD R2, INIT		; Сброс счетчика

LEA R0, NEWLINE       		; Перейти к новой строке
PUTS				; Вывод новой строки

CONVERT_LOOP
	LDR R0, R1, #0		; Загрузка текущего символа
	ADD R0, R0, R5		; Преобразование символа в число
	STR R0, R6, #0		; Сохранение числа в массив
	ADD R1, R1, #1		; Переход к следующему символу
	ADD R6, R6, #1		; Переход к следующему элементу массива
	ADD R2, R2, #1		; Увеличение счетчика
	ADD R3, R2, #-5		; Проверка на 5 элементов
	BRz BUBBLE_SORT		; Переход к сортировке, если все элементы сконвертированы
	BRnzp CONVERT_LOOP	; Повторение конвертации

; Сортировка
BUBBLE_SORT
	LD R6, ARRAY_LEN 	; Загружаем длину массива
	ADD R4, R6, #0 		; Копируем длину массива в R4

OUTER_LOOP
	ADD R4, R4, #-1 	; Уменьшаем счетчик проходов
	BRz OUTPUT_LOOP		; Если счетчик равен 0, переходим к выводу
	LEA R3, ARRAY		; Загружаем адрес начала массива
	ADD R5, R4, #0		; Копируем R4 в R5 для внутреннего цикла

INNER_LOOP
	LDR R0, R3, #0		; Загружаем текущий элемент массива
	LDR R1, R3, #1 		; Загружаем следующий элемент массива

	; Проверка: Если R0 > R1, меняем местами
	NOT R2, R1
	ADD R2, R2, #1
	ADD R2, R0, R2 		; R2 = R0 - R1
	BRn SWAP		; Если положительное, меняем местами

SKIP_SWAP
	ADD R3, R3, #1 		; Переходим к следующему элементу
	ADD R5, R5, #-1 	; Уменьшаем внутренний счетчик
	BRp INNER_LOOP		; Продолжаем, пока R5 > 0
	BRnzp OUTER_LOOP	; Возвращаемся к внешнему циклу

SWAP
	STR R1, R3, #0 		; Меняем местами элементы
	STR R0, R3, #1
	BRnzp SKIP_SWAP		; Переходим к следующему элементу

; Вывод данных
OUTPUT_LOOP
	LEA R1, ARRAY		; Сбрасываем адрес начала массива
	LD R2, INIT		; Сбрасываем счетчик элементов

PRINT_LOOP
	LDR R0, R1, #0		; Загружаем элемент массива
	LD R4, ASCII_ZERO	; Загружаем ASCII-код '0'
	ADD R0, R0, R4		; Преобразуем число обратно в ASCII
	OUT			; Выводим символ

	

	ADD R1, R1, #1		; Переходим к следующему элементу
	ADD R2, R2, #1		; Увеличиваем счетчик
	ADD R3, R2, #-5		; Проверяем, достигнут ли лимит
	BRz END			; Если да, заканчиваем
	BRnzp PRINT_LOOP	; Иначе продолжаем вывод

; Завершение программы
END
    HALT

; Константы и данные
INIT .FILL #0
MSG .STRINGZ "Enter string: "
NEWLINE .STRINGZ "\n"
ASCII_ZERO .FILL #48		; ASCII код '0'
NEG_ASCII_ZERO .FILL #-48	; Сдвиг для преобразования
ARRAY .BLKW #5			; Массив для хранения чисел
ARRAY_LEN .FILL #5		; Длина массива
BUFFER .BLKW #5			; Буфер для ввода

.END
