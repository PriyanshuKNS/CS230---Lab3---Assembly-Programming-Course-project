
# For loop format: 
    # addi $t0, $zero, 0
    # Loop_p:
    #     slt $t7, $t0, <n>
    #     beq $t7, $zero, Exit_x

    #     addi $t0, $t0, 1 # i++
    #     j Loop_p
    # Exit_p:



.data
star: .asciiz " **"
comma: .asciiz ","
newline: .asciiz "\n"
mx: .asciiz "mx: "
ijk: .asciiz "i,j,k: "
lmr: .asciiz "l,m,r: "
e1e2: .asciiz "e1,e2: "
array: .asciiz "array: "


.text
main:

    # Taking input n
    li $v0, 5
    syscall
    move $s7, $v0   # s7 = n

    # Allocate heap memory for array
    li $v0, 9
    addi $a0, $zero, 20000
    add $a0, $a0, $a0   # a0 = 40,000
    syscall
    move $s6, $v0

    # Fill the Array
    addi $t0, $zero, 0
    Loop_1: 
        slt $t7, $t0, $s7
        beq $t7, $zero, Exit_1
        li $v0, 5   # cin >> t
        syscall
        move $t1, $v0

        sll $t2, $t0, 2 # t2 = 4*i
        add $t2, $s6, $t2
        sw $t1, 0($t2)

        addi $t0, $t0, 1 # i++
        j Loop_1
    Exit_1:

    # Check for input of values in the array
    # addi $t0, $zero, 0
    # Loop_x:
    #     slt $t7, $t0, $s7
    #     beq $t7, $zero, Exit_x
    #     sll $t2, $t0, 2
    #     add $t2, $s6, $t2
    #     lw $t1, 0($t2)
    #     li $v0, 1
    #     move $a0, $t1
    #     syscall
    #     li $v0, 4
    #     la $a0, comma
    #     syscall
    #     addi $t0, $t0, 1 # i++
    #     j Loop_x
    # Exit_x:


    # Merge Sort iterative
    addi $s5, $zero, 1
    Loop_a:
        slt $t7, $s5, $s7 # t7=1 if curr_size < n else 0
        beq $t7, $zero, Exit_a

    



        # Body
        addi $s4, $zero, 0
        Loop_b:
            sub $t0, $s7, 1  # t0 = n-1
            slt $t7, $s4, $t0 # t7=1 if left_start < n-1 else 0
            beq $t7, $zero, Exit_b

            # Body
            # int mid = min(left_start + curr_size - 1, n-1);
            add $t1, $s4, $s5
            addi $t1, $t1, -1   # t1 = left_start + curr_size-1
            slt $t2, $t1, $t0   # t2 = 1 if left_start + .. < n-1
            beq $t2, $zero, else_1
                move $t6, $t1
                j Exit_if_1
            else_1: 
                move $t6, $t0   # t6 = n-1
            Exit_if_1:

            # int right_end = min(left_start + 2*curr_size - 1, n-1);
            add $t1, $t1, $s5   # t1 = ls + 2*curr - 1
            slt $t2, $t1, $t0
            beq $t2, $zero, else_2
                move $t5, $t1
                j Exit_if_2
            else_2:
                move $t5, $t0
            Exit_if_2:


            # PRINT l, m, r ****
            # li $v0, 4
            # la $a0, lmr
            # syscall
            # li $v0, 1
            # move $a0, $s4
            # syscall
            # li $v0, 4
            # la $a0, comma
            # syscall
            # li $v0, 1
            # move $a0, $t6
            # syscall
            # li $v0, 4
            # la $a0, comma
            # syscall
            # li $v0, 1
            # move $a0, $t5
            # syscall
            # li $v0, 4
            # la $a0, newline
            # syscall


            jal MERGE_IN_PLACE


            sll $t0, $s5, 1 # t0 = 2*curr_size
            add $s4, $s4, $t0   # left_start = left_start + 2*curr_size
            j Loop_b
        Exit_b:




        sll $s5, $s5, 1 # curr_size = 2*curr_size
        j Loop_a
    Exit_a:
    


    # PRINTING FINAL VALUES
    



    # Check for input of values in the array
    addi $t0, $zero, 0
    Loop_x:
        slt $t7, $t0, $s7
        beq $t7, $zero, Exit_x
        sll $t2, $t0, 2
        add $t2, $s6, $t2
        lw $t1, 0($t2)
        li $v0, 1
        move $a0, $t1
        syscall
        li $v0, 4
        la $a0, newline
        syscall
        addi $t0, $t0, 1 # i++
        j Loop_x
    Exit_x:

    li $v0, 4
    la $a0, newline
    syscall




    # Exit
    li $v0, 10
    syscall

# --------------------------

MERGE_IN_PLACE:

    # t0 = 4*m
    sll $t0, $t6, 2
    # t0 = 4*m + arr
    add $t0, $t0, $s6
    # t0 = a[m]
    lw $t0, 0($t0)

    # t1 = 4*r
    sll $t1, $t5, 2
    # t1 = 4*r + arr
    add $t1, $t1, $s6
    # t1 = a[r]
    lw $t1, 0($t1)

    # if a[m] < a[r] : mx = a[m] else mx = a[r]
    slt $t2, $t0, $t1
    bne $t2, $zero, else3 
        # mx = a[m]
        move $s3, $t0
        j exit3
    else3:
        # mx = a[r]
        move $s3, $t1
    exit3:

    addi $s3, $s3, 1

    # PRINTING mx
    # li $v0, 4
    # la $a0, mx
    # syscall
    # li $v0, 1
    # move $a0, $s3
    # syscall
    # li $v0, 4
    # la $a0, newline
    # syscall


    
    # i = l
    move $s0, $s4
    # j = m + 1
    addi $s1, $t6, 1
    # k = l
    move $s2, $s4

    WHILE1:
        # i <= m
        addi $t0, $t6, 1
        slt $t0, $s0, $t0
        # j <= r
        addi $t1, $t5, 1
        slt $t1, $s1, $t1
        # k <= r
        addi $t2, $t5, 1
        slt $t2, $s2, $t2

        # i<=m && j<=r && k<=r
        and $t0, $t0, $t1
        and $t0, $t0, $t2

        beq $t0, $zero, OUT1

        # PRINT i,j,k
        # li $v0, 4
        # la $a0, ijk
        # syscall
        # li $v0, 1
        # move $a0, $s0
        # syscall
        # li $v0, 4
        # la $a0, comma
        # syscall
        # li $v0, 1
        # move $a0, $s1
        # syscall
        # li $v0, 4
        # la $a0, comma
        # syscall
        # li $v0, 1
        # move $a0, $s2
        # syscall
        # li $v0, 4
        # la $a0, newline
        # syscall

        # a[i]
        
        sll $t0, $s0, 2
        add $t0, $t0, $s6
        lw $t0, 0($t0)
        div $t0, $t0, $s3
        mfhi $t3    # t3 = e1

        sll $t0, $s1, 2
        add $t0, $t0, $s6
        lw $t0, 0($t0)
        div $t0, $t0, $s3
        mfhi $t4    # t4 = e2

        # PRINT e1,e2
        # li $v0, 4
        # la $a0, e1e2
        # syscall
        # li $v0, 1
        # move $a0, $t3
        # syscall
        # li $v0, 4
        # la $a0, comma
        # syscall
        # li $v0, 1
        # move $a0, $t4
        # syscall
        # li $v0, 4
        # la $a0, newline
        # syscall

        slt $t0, $t4, $t3
        bne $t0, $zero, else4
            # a[k] = a[k] + e1*mx
            sll $t0, $s2, 2
            add $t0, $t0, $s6
            lw $t1, 0($t0)
            mul $t2, $t3, $s3
            add $t1, $t1, $t2
            sw $t1, 0($t0)

            # i++
            addi $s0, $s0, 1
            # k++
            addi $s2, $s2, 1
            j exit4

        else4:
            # a[k] = a[k] + e2*mx
            sll $t0, $s2, 2
            add $t0, $t0, $s6
            lw $t1, 0($t0)
            mul $t2, $t4, $s3
            add $t1, $t1, $t2
            sw $t1, 0($t0)

            # j++
            addi $s1, $s1, 1
            # k++
            addi $s2, $s2, 1

        exit4:

        j WHILE1
    OUT1:



    WHILE2:
        slt $t0, $t6, $s0
        bne $t0, $zero, OUT2


        sll $t0, $s0, 2
        add $t0, $t0, $s6
        lw $t0, 0($t0)
        div $t0, $t0, $s3
        mfhi $t2    # t2 = el

        sll $t0, $s2, 2
        add $t0, $t0, $s6
        lw $t1, 0($t0)
        mul $t2, $t2, $s3
        add $t1, $t1, $t2
        sw $t1, 0($t0)

        addi $s0, $s0, 1
        addi $s2, $s2, 1

        j WHILE2
    OUT2:


    WHILE3:
        slt $t0, $t5, $s1
        bne $t0, $zero, OUT3


        sll $t0, $s1, 2
        add $t0, $t0, $s6
        lw $t0, 0($t0)
        div $t0, $t0, $s3
        mfhi $t2    # t2 = el

        sll $t0, $s2, 2
        add $t0, $t0, $s6
        lw $t1, 0($t0)
        mul $t2, $t2, $s3
        add $t1, $t1, $t2
        sw $t1, 0($t0)

        addi $s1, $s1, 1
        addi $s2, $s2, 1

        j WHILE3
    OUT3:


    # For loop format: 
    add $t2, $zero, $s4
    FOR1:
        # t1 = r+1
        addi $t1, $t5, 1
        # i < r+1
        slt $t7, $t2, $t1 
        beq $t7, $zero, END1

        sll $t0, $t2, 2
        add $t0, $t0, $s6
        lw $t1, 0($t0)
        div $t1, $t1, $s3
        mflo $t1    # t2 = a[i]/mx
        sw $t1, 0($t0)


        addi $t2, $t2, 1 # i++
        j FOR1
    END1:


    # PRINTING THE ARRAY
    # addi $t0, $zero, 0
    # li $v0, 4
    # la $a0, array
    # syscall
    # addi $t0, $zero, 0
    # FOR7:
    #     slt $t7, $t0, $s7
    #     beq $t7, $zero, OUT7
    #     sll $t2, $t0, 2
    #     add $t2, $s6, $t2
    #     lw $t1, 0($t2)
    #     li $v0, 1
    #     move $a0, $t1
    #     syscall
    #     li $v0, 4
    #     la $a0, comma
    #     syscall
    #     addi $t0, $t0, 1 # i++
    #     j FOR7
    # OUT7:

    # li $v0, 4
    # la $a0, newline
    # syscall
    # li $v0, 4
    # la $a0, newline
    # syscall


    jr $ra
    





    
































