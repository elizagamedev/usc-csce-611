    move $7, $0 # pos_x
    move $6, $0 # pos_y
    li $2, 1 # direction_x
    li $3, 30 # radius
    li $4, 40 # center_x
    li $5, 30 # center_y
    sll $3, $3, 9
    sll $4, $4, 9
    sll $5, $5, 9
    li $20, 0xffffff # color
    li $21, 80 # horizontal resolution
loop:
    li $10, 0xff
delay:
    addi $10, $10, -1
    bne $0, $10, delay
clear:
    add $10, $7, $4
    add $11, $6, $5
    srl $10, $10, 9
    srl $11, $11, 9
    sll $11, $11, 7
    or $10, $10, $11
    addi $10, $10, 0xC000
    sw $0, 0($10)

    # change radius
increase_radius:
    andi $10, $29, 2
    beq $10, $0, decrease_radius
    addi $3, $3, 1
decrease_radius:
    andi $10, $29, 1
    beq $10, $0, move
    addi $3, $3, -1

    # move x position
move:
    beq $0, $2, moveleft
moveright:
    addi $7, $7, 1
    j boundstest_right
moveleft:
    addi $7, $7, -1

boundstest_right:
    slt $10, $3, $7
    beq $10, $0, boundstest_left
    # out of bounds on right
    move $7, $3
    xori $2, 1
boundstest_left:
    sub $10, $0, $3
    slt $11, $7, $10
    beq $11, $0, movey
    # out of bounds on left
    move $7, $10
    xori $2, 1

movey:
    mult $3, $3
    mflo $10
    mult $7, $7
    mflo $11
    sub $10, $10, $11 # radius^2 - pos_x^2

    # square root of $10
    move $11, $0 # guess
    move $12, $3 # step
sqrtloop:
    mult $11, $11
    mflo $13
    sub $13, $13, $10 # $13 = guess^2 - solution
    beq $13, $0, sqrtdone
    slt $13, $13, $0
    bne $13, $0, sqrtlt0
sqrtgt0:
    sub $11, $11, $12
    j sqrtchk
sqrtlt0:
    add $11, $11, $12
sqrtchk:
    srl $12, $12, 1
    bne $12, $0, sqrtloop
sqrtdone:
    beq $0, $2, moveyleft
moveyright:
    move $6, $11
    j draw
moveyleft:
    sub $6, $0, $11

draw:
    add $10, $7, $4
    add $11, $6, $5
    srl $10, $10, 9
    srl $11, $11, 9
    sll $11, $11, 7
    or $10, $10, $11
    addi $10, $10, 0xC000
    sw $20, 0($10)

    j loop
