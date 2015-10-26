    .text
    add $s0, $s1, $s2
    or $s3, $s4, $s5
    beq $s0, $s1, skip1
    add $s0, $s1, $s2
skip1:
    j skip2
    add $s0, $s1, $s2
skip2:
    jr $ra
