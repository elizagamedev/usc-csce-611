.text
addi $3, $1, 12			# ($3) <= 23
addiu $4, $2, 13			# ($4) <= 30
andi $5, $3, 0xf			# ($5) <= 7
ori $6, $5, 0x10			# ($6) <= 23
xori $7, $6, 0x1F			# ($7) <= 8
lui $8,0xBEEF			# ($8) <= 0xBEEF0000
sw $8,-3($4) 			# address 27 <= 0xBEEF0000
lw $9,4($6)			# ($9) <= 0xBEEF0000
