# Create 8 values to add
li $1, 96
sw $1, 0x0
li $1, 102
sw $1, 0x1
li $1, 2
sw $1, 0x2
li $1, 44
sw $1, 0x3
li $1, 36
sw $1, 0x4
li $1, 1337
sw $1, 0x5
li $1, 42
sw $1, 0x6
li $1, 80085
sw $1, 0x7

# Sum the values
move $1, $0
lw $2, 0x0
add $1, $1, $2
lw $2, 0x1
add $1, $1, $2
lw $2, 0x2
add $1, $1, $2
lw $2, 0x3
add $1, $1, $2
lw $2, 0x4
add $1, $1, $2
lw $2, 0x5
add $1, $1, $2
lw $2, 0x6
add $1, $1, $2
lw $2, 0x7
add $1, $1, $2

# Compute mean
srl $1, $1, 3

# Set LEDs
move $30, $1

# Store result in memory
sw $1, 0x10
