.ORIG x3000
START   LEA R0, STRING
        PUTS
        
        LEA R1, BUFFER         ; адрес начала буфера для строки
        ADD R2, R1, #0         ; R2 используется для перемещения по буферу

READ
        GETC
        OUT

        ADD R4, R0, #-10       ; проверяем, не символ ли это новой строки
        BRz PRINT              ; если это символ новой строки, выводим строку
        
        STR R0, R2, #0         ; сохраняем считанный символ в буфере
        ADD R2, R2, #1         ; переходим к следующему месту в буфере
        BRnzp READ             ; повторяем чтение следующего символа

PRINT   
        LEA R0, BUFFER         ; выводим введенную строку
        PUTS
        
HALT

STRING .STRINGZ "Enter a string: "
BUFFER .BLKW  1024

.END
