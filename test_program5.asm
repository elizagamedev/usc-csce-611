    li $4,1
    li $5,2
    beq $4,$5,target1	# not taken
b:
    bne $4,$5,target2	# taken
c:
    bgez $4,target3     # taken
d:
    jal target4
    j exit

target1:
    j b
target2:
    j c
target3:
    j d
target4:
    jr $31
exit:
