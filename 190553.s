.data  
fin: .asciiz "sky.pgm"      # filename for input
buffer: .space 128
buffer1: .asciiz "\n"
val: .space 1280
newline: .asciiz "\n"
space: .asciiz " " 
buffer_breite: .space 4
buffer_hoehe: .space 4


ibreite: .byte 4
ihoehe: .byte 4


.text

################################################ fileRead:

# Open file for reading
li   $v0, 13       # system call for open file
la   $a0, fin      # input file name
li   $a1, 0        # flag for reading
li   $a2, 0        # mode is ignored
syscall            # open a file 
move $s0, $v0      # save the file descriptor at $s0.

# reading from file just opened
	li   $v0, 14       # system call for reading from file
	# here skip th 'P5\n' because i don't want to waste my time to check file format. 
	addi $s0, $s0, 3
	#####
	move $a0, $s0      # file descriptor 
	la   $a1, buffer   # save read byte to 0(buffer)
	li   $a2,  1   	   # just read 1 byte.
	##
	li $s1, 0				# we save the length of breite in buffer_breite at $s1 
	li $s2, 0				# we save the length of hoehe in buffer_hoehe at $s2 
#### 3==> this is new, 2:33 19.01

		la $s3, buffer_breite		# load adress of buffer_breite to $s3. (buffer_breite ist 4-byte length)
		read_breite:
			syscall            # read from file. 
			beqz $v0, file_fucked       # Check EOF. Jump to error and end the programm. Write it late.
        	bltz $v0, filed_fucked      # …Read-failure check. Jump to error and end the programm. Write it late.
			li $t1, 57
			li $t2, 48
			lw $t0, 0(buffer)
			bgt $t0, $t1, end_read_breite		# if > 57 then end_read_breite
			blt $t0, $t2, end_read_breite		# if < 48
			sw $s3, 0($t0)					# save that byte to the adress $s3
			addi $s1, $s1, 1			# breite counter counts up...
			addi $s3, $s3, 1			#... so do $s3 to.
			addi $s0, $s0, 1			# file descriptor move to next bytes
			## Prepare for next syscall:
				li $v0, 14		#read file
				move $a0, $s0		#load adress of file descriptor
				la   $a1, buffer   # save read byte to 0(buffer)
				li   $a2, 1   	   # just read 1 byte.
			j read_breite	# while schleife, read until we reach anything that not belong to '0'->'9'
		end_read_breite:
		## so now we end read_breite, buffer_breite holds a string with len=$s1. Now move our ass and prepare for reading hoehe:
			li $v0, 14			# read file
			addi $s0, $s0, 2	# move 2 byte forward, so we can touch the block of (hoehe)
			move $a0, $s0		# load adress of file descriptor
			la   $a1, buffer    # save read byte to 0(buffer)
			li   $a2, 1   	    # just read 1 byte.

			

		la $s3, buffer_hoehe		# load adress of buffer_hoehe to $s3. (buffer_breite ist 4-byte length)
		read_hoehe:
			syscall			#read
			beqz $v0, file_fucked       # Check EOF. Jump to error and end the programm. Write it late.
        	bltz $v0, filed_fucked      # …Read-failure check. Jump to error and end the programm. Write it late.
			li $t1, 57
			li $t2, 48
			lw $t0, 0(buffer)
			bgt $t0, $t1, end_read_hoehe		# if > 57 then end_read_hoehe
			blt $t0, $t2, end_read_hoehe		# if < 48
			sw $s3, 0($t0)					# save that byte to the adress $s3
			addi $s2, $s2, 1			# hoehe counter counts up...
			addi $s3, $s3, 1			#... so do $s3 to.
			addi $s0, $s0, 1			# file descriptor move to next bytes
			## Prepare for next syscall:
				li $v0, 14		#read file
				move $a0, $s0		#load adress of file descriptor
				la   $a1, buffer   # save read byte to 0(buffer)
				li   $a2, 1   	   # just read 1 byte.
			j read_hoehe	# while schleife, read until we reach anything that not belong to '0'->'9'
		end_read_hoehe:
		## so now we end read_hoehe, buffer_hoehe holds a string with len=$s2. Now move our ass and continue to convert data:
#### <==3 this is new, 2:33 19.01

#### Convert data to int:
		convert_hoehe:
			li $t0, 2		# $t0 = 2 so we can compare it with length of buffer_
			la		$t1, buffer_breite		#  get address buffer_breite save to $t1.
			lw		$t9, 0($t1)   			# load first byte of buffer_breite
			beq		$t0, $s1, convert_hoehe_2	# if length == 2 then jump to convert for 2 char. Else:
			
			
									


		convert_hoehe_2:













rd_breite:
addi $t0, $zero, 3		#i++
lb $t1, buffer($t0)		# buffer wird auf $t1 gespeichert
addi $t2, $zero, 48		# $t2 wird 32 zugewiesen (32 bedeutet in ascii 'space')
addi $t3, $zero, 57 
bgt $t1, $t3, end_rd_breite
blt $t1, $t2, end_rd_breite		# er vergleicht jezt die aus dem Buffer gelesene Zahl mit 32(also einem space), wenn er ein Space findet, dann i++
addi $t4, $zero, 0
sb $t1, buffer_breite($t4)
addi $t4, $t4, 1                #

				# die erste Zahl aus dem Buffer 1. * 100, 2. * 10, 3.*1

addi $t1, $t1, 1		# 
##########
li $v0, 1			# print int
move $a0, $t3	
syscall			
##########

j rd_breite

end_rd_breite:

addi $t1, $t1, 1		# i++

####### convert char to int, breite
addi $t5, $zero, 0      # $t5 hold integer value of rd_breite. for now 0
addi $t6, $zero, 2      # i
beq $t4, $t6, convert2b  # t4 = 2

la $t9, buffer_breite
lb $t1, 0($t9)             # erstes elem von buffer_breite
addi $t1, $t1, -48      # t1 = 2
mult $t1, $s1     # 2 * 100   = 200
mfhi $t1
#--
lb $t7, 1($t9)            # t8 = 5. elem von buffer_breite
addi $s1, $zero, 10
mult $t7, $s1       # t7 = 50
mfhi $s1
addi $v0, $v0, 1
#--        # v0 ++
lb $t8, 2($t9) # 6
add $t5, $t1, $t7       # 250
add $t5, $t5, $t8       # 256 
####
sb $t5, ibreite 

convert2b:
la $t9, buffer_breite
lb $t1, 0($t9)   # erstes elem von buffer_breite
addi $t1, $t1, -48      # t1 = 6
addi $s3, $s3, 10
mult $t1, $s3      # 6 * 10   = 60
mfhi $v0
lb $t7, 1($t9)             # t8 = 2. elem von buffer_breite
add $t5, $t1, $t7       # t5 = 64
####
sb $t5, ibreite 






####### convert char to int, hohe
addi $t5, $zero, 0      # $t5 hold integer value of rd_breite. for now 0
addi $t6, $zero, 2      # i
beq $t4, $t6, convert2h  # t4 = 3

la $t9, buffer_hoehe
lb $t1, 0($t9)             # erstes elem von buffer_breite
addi $t1, $t1, -48      # t1 = 2
mult $t1, $s1     # 2 * 100   = 200
mfhi $t1
#--
lb $t7, 1($t9)            # t8 = 5. elem von buffer_breite
addi $s1, $zero, 10
mult $t7, $s1       # t7 = 50
mfhi $s1
addi $v0, $v0, 1
#--        # v0 ++
lb $t8, 2($t9) # 6
add $t5, $t1, $t7       # 250
add $t5, $t5, $t8       # 256 
####
sb $t5, ihoehe 

convert2h:
la $t9, buffer_hoehe
lb $t1, 0($t9)   # erstes elem von buffer_breite
addi $t1, $t1, -48      # t1 = 6
addi $s6, $zero, 10
mult $t1, $s6       # 6 * 10   = 60
mfhi $v0
addi $v0, $v0, 1        # v0 ++
lb $t7, 1($t9)            # t8 = 2. elem von buffer_breite
add $t5, $t1, $t7       # t5 = 64
####
sb $t5, ihoehe 


li $v0, 1
la $a1, ihoehe
move $a0, $a1
syscall

li $v0, 4
la $a0, newline
syscall

li $v0, 1
la $a1, ibreite
move $a0, $a1
syscall



 









# read 2
#addi $t0, $t0, 2
#lb $t1, buffer($t0)
#addi $t1, $t1, -48
#li $v0, 1
#move $a0, $t1
#syscall


li $v0, 4
la $a0, newline
syscall


# read 2


lb $t1 , buffer


#la      $a0, buffer     #calling opening prompt
#li      $v0, 4
#syscall
#la      $a0, buffer      #initial string
#syscall
#la      $a0, newline    #newline
#syscall


strLen:                	   #getting length of string
lb      $t0, buffer($t2)   #loading value
add     $t2, $t2, 1
bne     $t0, $zero, strLen

li      $v0, 10       #load immediate - print low-level byte
Loop:
sub     $t2, $t2, 1    	 #this statement is now before the 'load address'
la      $t0, buffer($t2)   #loading value
lb      $a0, ($t0)
syscall
#This is where the sub statement used to be, which caused the loop to terminate too early
bnez    $t2, Loop
li      $v0, 10              #program done: terminating
syscall



li $v0, 4
la $a0, newline
syscall

# read space 
#addi $t0, $zero, 2
#lb 



# Close the file 

li   $v0, 16       # system call for close file
move $a0, $s6      # file descriptor to close
syscall            # close file
