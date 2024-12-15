.ORIG x3000              ; Начальный адрес программы
LD    R1, NUM1           ; Загружает значение NUM1 в регистр R1
LD    R2, NUM2           ; Загружает значение NUM2 в регистр R2

ADD   R3, R1, R2         ; Складывает значения из R1 и R2, сохраняет результат в R3
LEA R0, STR1
PUTS
AND R0, R0, #0
ADD R0, R0, R3
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT
LEA R0, STR_END
PUTS

NOT   R4, R2 
ADD   R4, R4, #1    
ADD   R4, R1, R4         ; Складывает значения R1 и -R2, сохраняет результат в R4

LEA R0, STR2
PUTS
AND R0, R0, #0
ADD R0, R0, R4
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT
LEA R0, STR_END
PUTS

AND   R5, R5, #0         ; Обнуляет регистр R5

LOOP  AND   R6, R6, #0   ; Обнуляет регистр R6
      ADD   R6, R6, R1   ; Копирует значение из R1 в R6
      ADD   R5, R5, R6   ; Складывает R5 и R6, сохраняет результат в R5
      ADD   R2, R2, #-1  ; Уменьшает значение R2 на 1
      BRp   LOOP         ; Переходит к началу цикла (LOOP), если R2 > 0

LEA R0, STR3
PUTS
AND R0, R0, #0
ADD R0, R0, R5
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT
LEA R0, STR_END
PUTS

HALT               ; Останавливает выполнение программы

NUM1  .FILL #3      ; Определяет ячейку памяти с меткой NUM1
NUM2  .FILL #3      ; Определяет ячейку памяти с меткой NUM2
STR1 .STRINGZ "3+3="
STR2 .STRINGZ "3-3="
STR3 .STRINGZ "3*3="
STR_END .STRINGZ "\n"
.END
