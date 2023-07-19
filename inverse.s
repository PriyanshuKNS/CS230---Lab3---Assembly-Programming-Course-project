.data
str1: .asciiz ">> "
str2: .asciiz "** "
str3: .asciiz "Entered gcdxy Main\n"
str4: .asciiz "Entered gcdxy Base case\n"
newline: .asciiz "\n"
space: .asciiz " "
recursing: .asciiz "Recursing with input = "
va0: .asciiz "$a0 = "
va1: .asciiz "$a1 = "
vv0: .asciiz "$v0 = "
vv1: .asciiz "$v1 = "


.text

main: 
    li $v0, 5           # 5 is for read integer
    syscall 
    move $a0, $v0       # $a0 = a
    move $s0, $v0       # $s0 = a

    li $v0, 5
    syscall
    move $a1, $v0       # $a1 = m
    move $s1, $v0       # $s1 = m

    jal gcdxy

    move $t0, $v0       # $t0 = x
    move $t2, $v0
    move $t3, $v1       # $t1 = y
    div $t0, $t0, $s1   
    mfhi $t0            # $t0 = x % m
    add $t0, $t0, $s1   # $t0 = x%m + m
    div $t0, $t0, $s1
    mfhi $t0            # $t0 = (x%m + m) % m

    # Print integer $t0
    li $v0, 1
    move $a0, $t0
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    
    

    # Exit
    li $v0, 10
    syscall





# ---------------------------------------
gcdxy: 

    # Base case
    bne $a1, $zero, MainCase
    # PRINT string
    li $v0, 4
    la $a0, str4
    syscall

    addi $v0, $zero, 1
    move $v1, $zero
    # return
    jr $ra


MainCase:
    # Store ra in stack
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    move $t0, $a0       # $t0 = a
    move $t1, $a1       # $t1 = b
    
    # *****************
    # # PRINT string
    # li $v0, 4
    # la $a0, str3
    # syscall
    # # PRINT $a0
    # li $v0, 1
    # move $a0, $t0
    # syscall
    # # PRINT space
    # li $v0, 4
    # la $a0, space
    # syscall
    # # Print $a1
    # li $v0, 1
    # move $a0, $t1
    # syscall
    # # Print newline
    # li $v0, 4
    # la $a0, newline
    # syscall
    # ******************

    move $a0, $t1       # $a0 = b
    div $s2, $t0, $t1   
    mfhi $a1            # $a1 = a % b
    mflo $s2            # $s2 = a / b
    # store s2
    addi $sp, $sp, -4
    sw $s2, 0($sp)

    jal gcdxy           # gcdxy (b, a%b)    #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    # load s2
    lw $s2, 0($sp)
    addi $sp, $sp, 4

    move $t3, $v1         # t3 <= v1 <= y1
    move $t4, $v0         # t4 <= v0 <= x1
    

    mul $t5, $t3, $s2       
    mflo $t5                # $t5 = y1*(a/b)
    sub $t6, $t4, $t5       # $t6 = x1 - y1*(a/b)
    


    # &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    # li $v0, 1
    # move $a0, $t2
    # syscall
    # li $v0, 4
    # la $a0, str2
    # syscall
    # li $v0, 1
    # move $a0, $t3
    # syscall
    # li $v0, 4
    # la $a0, space
    # syscall
    # li $v0, 1
    # move $a0, $t6
    # syscall
    # li $v0, 4
    # la $a0, newline
    # syscall

    # &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&



    
    move $v0, $t3           # v0 = y1
    move $v1, $t6           # v1 = x1 - y1*(a/b)
    # Restoring ra value from stack
    lw $ra, 0($sp)          
    addi $sp, $sp, 4
    # return
    jr $ra




    


