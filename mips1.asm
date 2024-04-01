	.data
		prompt1: .asciiz "Vnesi kolku broevi"
		prompt2: .asciiz "Vnesi broj"
		prompt3: .asciiz "Sumata na prostite broevi koi gi vnese e: "
		
	.text
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
		add $a1, $a1, $zero #registar za sumiranje
		loop: beqz $t0, kraj
			li $v0, 5
			syscall
			move $t1, $v0
			
			add $a0, $t1, $zero
			addi $sp, $sp, -36
			sw $t0, 32($sp)
			sw $t1, 28($sp)
			sw $t2, 24($sp)
			sw $t3, 20($sp)
			sw $t4, 16($sp)
			sw $t5, 12($sp)
			sw $t6, 8($sp)
			sw $t7, 4($sp)
			sw $t8, 0($sp)
			
			jal proverka
			
			lw $t0, 32($sp)
			lw $t1, 28($sp)
			lw $t2, 24($sp)
			lw $t3, 20($sp)
			lw $t4, 16($sp)
			lw $t5, 12($sp)
			lw $t6, 8($sp)
			lw $t7, 4($sp)
			lw $t8, 0($sp)
			addi $sp, $sp, 36
			
			beqz $v0, ne_e_prost
			add $a1, $a1, $t1
			addi $t0, $t0, -1
			j loop
			ne_e_prost:
			addi $t0, $t0, -1
			j loop
		
		kraj: li $v0, 4
			la $a0, prompt3
			syscall
			li $v0, 1
			move $a0, $a1
			syscall
			li $v0,10
			syscall
			
	proverka:
		addi $sp, $sp, -12
		sw $s0, 8($sp)
		sw $s1, 4($sp)
		sw $s2, 0($sp)
		
		add $t3 , $a0, $zero
		li $t2, 2
		div $a0, $t2
		mflo $t6
		li $t4, 0
		li $t8, 1
		add $t5, $t3, -1
		beq $t8, $t3, ne_prost
			jamka: beq $t5, $t8, prost
			div $t3, $t5
			mfhi $t7
			beq $t7, $t4, ne_prost
			addi $t5, $t5, -1
			j jamka
		ne_prost:
			li $v0, 0
			j konkraj
		prost:
			li $v0, 1
			j konkraj
		konkraj:
			
			lw $s0, 8($sp)
			lw $s1, 4($sp)
			lw $s2, 0($sp)
			addi $sp, $sp, 12
			jr $ra