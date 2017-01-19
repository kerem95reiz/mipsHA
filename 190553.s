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
		read_breite:
			syscall            # read from file. 
			#beqz $v0, file_fucked       # Check EOF. Jump to error and end the programm. Write it late.
        	#bltz $v0, filed_fucked      # …Read-failure check. Jump to error and end the programm. Write it late.
			li $t1, 57
			li $t2, 48
			la $t9, buffer
			lw $t0, 0($t9)					# $t0 holds byte just read

			bgt $t0, $t1, end_read_breite		# if > 57 then end_read_breite
			blt $t0, $t2, end_read_breite		# if < 48

			la $s3, buffer_breite		# $s3 holds adress of buffer_breite from now and will be pushed forward
			sw $t0, 0($s3)				# we saved $t0 to the adress $s3 holds
			addi $s3, $s3, 1			# ... then move $s3 one byte forward (for the next byte)
			addi $s1, $s1, 1			# breite counter counts up...
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


		read_hoehe:
			syscall			#read
			#beqz $v0, file_fucked       # Check EOF. Jump to error and end the programm. Write it late.
        	#bltz $v0, filed_fucked      # …Read-failure check. Jump to error and end the programm. Write it late.
			li $t1, 57
			li $t2, 48
			la $t9, buffer
			lw $t0, 0($t9)

			bgt $t0, $t1, end_read_hoehe		# if > 57 then end_read_hoehe
			blt $t0, $t2, end_read_hoehe		# if < 48
			
			la $s4, buffer_hoehe		# load adress of buffer_breite to $s3. (buffer_breite ist 4-byte length)
			sw $t0, 0($s4)					# load byte just read
			addi $s4, $s4, 1			# ... then move $s4 one byte forward (for the next byte)
			addi $s2, $s2, 1			# hoehe counter counts up...
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
####
#### Convert data to int:
		convert_breite:
			la $s3, ibreite				# $s3 holds adress of ibreite
			li $t0, 2					# $t0 = 2 so we can compare it with length of buffer_
			la	$t1, buffer_breite		# $t1 holds address buffer_breite 
			lw	$t2, 0($t1)   			# $t2 holds first byte of buffer_breite
			beq	$t0, $s1, convert_breite_2	# if length == 2 then jump to convert for 2 char. Else:
			## THIS IS FOR LENGTH==3
			li $t9, 100
			mult $t2, $t9			    # $t0 * $t1 = Hi and Lo registers
			mflo	$t3					# $t3 holds result (for now 200). Don't TOUCH!.    copy Lo to $t3
			##			
			li $t9, 10
			lw	$t2, 1($t1)   			# $t2 holds 2nd byte of buffer_breite
			mult	$t0, $t1			# $t0 * $t1 = Hi and Lo registers
			mflo	$t4					# copy Lo to $t4
			add $t3, $t3, $t4			# $t3 holds result (for now 250). Don't TOUCH!
			##
			lw	$t2, 2($t1)   			# $t2 holds 3th byte of buffer_breite
			add $t3, $t3, $t2			# $t3 should be now 256
			## Now we save it into ibreite
			sw		$t3, 0($s3)		    #done
			

		convert_breite_2:
			## THIS IS FOR LENGTH==2
			li $t9, 10
			mult $t2, $t9			    # $t0 * $t1 = Hi and Lo registers
			mflo	$t3					# $t3 holds result (for now 60). Don't TOUCH!.    copy Lo to $t3
			##
			lw	$t2, 1($t1)   			# $t2 holds 2th byte of buffer_breite
			add $t3, $t3, $t2			# $t3 should be now 64
			## Now we save it into ibreite
			sw		$t3, 0($s3)		    #done



convert_hoehe:
			la $s3, ihoehe				# $s3 holds adress of ihoehe
			li $t0, 2					# $t0 = 2 so we can compare it with length of buffer_
			la	$t1, buffer_hoehe		# $t1 holds address buffer_hoehe
			lw	$t2, 0($t1)   			# $t2 holds first byte of buffer_hoehe
			beq	$t0, $s2, convert_hoehe_2	# if length == 2 then jump to convert for 2 char. Else:
			## THIS IS FOR LENGTH==3
			li $t9, 100
			mult $t2, $t9			    # $t0 * $t1 = Hi and Lo registers
			mflo	$t3					# $t3 holds result (for now 200). Don't TOUCH!.    copy Lo to $t3
			##			
			li $t9, 10
			lw	$t2, 1($t1)   			# $t2 holds 2nd byte of buffer_hoehe
			mult	$t0, $t1			# $t0 * $t1 = Hi and Lo registers
			mflo	$t4					# copy Lo to $t4
			add $t3, $t3, $t4			# $t3 holds result (for now 250). Don't TOUCH!
			##
			lw	$t2, 2($t1)   			# $t2 holds 3th byte of buffer_hoehe
			add $t3, $t3, $t2			# $t3 should be now 256
			## Now we save it into $ibreite
			sw		$t3, 0($s3)		    #done
			

		convert_hoehe_2:
			## THIS IS FOR LENGTH==2
			li $t9, 10
			mult $t2, $t9			    # $t0 * $t1 = Hi and Lo registers
			mflo	$t3					# $t3 holds result (for now 60). Don't TOUCH!.    copy Lo to $t3
			##
			lw	$t2, 1($t1)   			# $t2 holds 2th byte of buffer_hoehe
			add $t3, $t3, $t2			# $t3 should be now 64
			## Now we save it into ihoehe
			sw		$t3, 0($s3)		    #done
		













# UP THERE !!!!
###########
###########
###########



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
mflo $s1
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
