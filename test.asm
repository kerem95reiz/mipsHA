.data  
fin: .asciiz "sky.pgm"      # filename for input
buffer: .space 128
buffer1: .asciiz "\n"
val : .space 1280
newline: .asciiz "\n"
space: .asciiz "" 
buffer3: .space 4

.text

################################################ fileRead:

# Open file for reading



li   $v0, 13       # system call for open file
la   $a0, fin      # input file name
li   $a1, 0        # flag for reading
li   $a2, 0        # mode is ignored
syscall            # open a file 
move $s0, $v0      # save the file descriptor 

# reading from file just opened

li   $v0, 14       # system call for reading from file
move $a0, $s0      # file descriptor 
la   $a1, buffer   # address of buffer from which to read
li   $a2,  1010    # hardcoded buffer length
syscall            # read from file

#li  $v0, 4          # 
#la  $a0, buffer     # buffer contains the values
#syscall             # print int


# header lesen P
addi $t0, $zero, 0
lb $t1, buffer($t0)
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 1
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 2
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 1
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 1
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 2
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall
# read 5
addi $t0, $t0, 1
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

# read 5
addi $t0, $t0, 1
lb $t1, buffer($t0)
addi $t1, $t1, -48
li $v0, 1
move $a0, $t1
syscall

li $v0, 4
la $a0, newline
syscall

addi $t0, $t0, 1  		# i++
##loop1:
#addi $t0, $zero, 0		#i++
#lb $t1, buffer($t0)		# buffer wird auf $t1 gespeichert
#addi $t2, $zero, 32		# $t2 wird 32 zugewiesen (32 bedeutet in ascii 'space')
#beq $t2, $t1, addi1		# er vergleicht jezt die aus dem Buffer gelesene Zahl mit 32(also einem space), wenn er ein Space findet, dann i++
#sb $t1, buffer3($t3)
				
				# die erste Zahl aus dem Buffer 1. * 100, 2. * 10, 3.*1

#addi $t1, $t1, 1		# i ++

#li $v0, 1			# print int
#move $a0, $t3	
#syscall			


#j loop1

#addi1: 

#addi $t1, $t1, 1		# i++






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
