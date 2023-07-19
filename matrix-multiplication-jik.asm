        section .text
        global matrix_mult

matrix_mult:
        push rdi                       ; pointer to mat1
        push rsi                       ; row count of mat1
        push rdx                       ; column count of mat1
        push rcx                       ; pointer to mat2
        push r8                        ; row count of mat2
        push r9                        ; column count of mat2
        push r10                       ; pointer to mat3
        push r11
        push r12
        push r13

; ; 0-indexing on all matrices
; ; mat1[i][j] = rdi+(rdx*i+j)*8
; ; assume rdx = r8
; ; GOAL - Perform matrix multiplication of mat1, mat2 and save result in mat3

; ; TODO - Fill your code here performing the matrix multiplication in the following order
; ; for j in range(c2) { for i in range(r1) { for k in range(c1) { mat3[i][j] += mat1[i][k]*mat2[k][j] } } }



        push r14
	push r15
	push rbx

	xor r11, r11	; i, r1 == rsi
	xor r12, r12	; j, c2 == r9
	xor r13, r13	; k, c1 == rdx

       
FOR1:

	cmp r12, r9
	jnl EXIT1

	xor r11, r11

	FOR2:

		cmp r11, rsi
		jnl EXIT2

		; push rdx
		; r15 = mat3[i][j]
		mov rax, r11	; rax = i
		mul r9		; rax = i*c2
		add rax, r12	; rax = i*c2 + j
		shl rax, 3	; rax = 8*(i*c2 + j)
		add rax, r10	; rax = a3 + 8*(i*c2 + j)
		mov r15, rax	; rax = &mat3[i][j], its the address, thats what is needed to perform store
		
		xor r13, r13

		FOR3: 
	
			cmp r13, r8
			jnl EXIT3

			; rbx = mat1[i][k]
			mov rax, r11	; rax = i
			mul r8		; rax = i*c1
			add rax, r13	; rax = i*c1 + k
			shl rax, 3	; rax = 8*(i*c1 + k)
			add rax, rdi	; rax = a1 + 8*(i*c1 + k)
			mov rbx, [rax]	; rax = mat1[i][k]
			
			; r14 = mat2[k][j]
			mov rax, r13	; rax = k
			mul r9		; rax = k*c2
			add rax, r12	; rax = k*c2 + j
			shl rax, 3	; rax = 8*(k*c2 + j)
			add rax, rcx	; rax = a2 + 8*(k*c2 + j)
			mov r14, [rax]	; rax = mat2[k][j]

			

			; mat3[i][j] += mat1[i][k] * mat2[k][j]
			mov rax, rbx
			mul r14
			add [r15], rax

			inc r13
			jmp FOR3
		EXIT3:


		inc r11
		jmp FOR2
	EXIT2:


	inc r12

	jmp FOR1

EXIT1:

	pop rbx 
	pop r15
	pop r14 














; ; End of code to be filled

        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rcx
        pop rdx
        pop rsi
        pop rdi
        ret
