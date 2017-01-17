# Aufgabe 1: Bilder laden und speichern

#
# load_img
#
.data
inputfilename: .asciiz "wood.pgm" #wood.pgm einziehen aber relativ in gleichem Verzeichnis
buffer: .space 100000
Max_size: .word 100000 #Max_groesse
.text


.globl main
main:
addi $sp, $sp, -4 #Stackpointer 
sw $ra, 0($sp) #Addresse_Speichern01

jal load_img #Jump and Link zur andere Funktion 

lw $ra,0($sp) #Stackpointer 
addi $sp,$sp,4 #PoP 

jr $ra

load_img:
#


addi $sp, $sp, -4
sw $ra, 0($sp) 

li $v0, 13 #Open_Data falls eine negative Zahl kommt ist es ein Error
la $a0, inputfilename #containing_filename
li $a1, 0 #flags
li $a2, 0 #mode
syscall

move $t7, $v0 #in_t7_speichern

li $v0, 14 #read_data_befehl
add $a0, $t7, $0 #filedescriptor
li $a1, buffer #Address_of_input_buffer
li $a2, Max_size #Max_characters 
syscall

move $t0, $a1					#move startadress in t0
addi $t1, $0, 0					#initialisiere Laufvariable i = 0


#while(i < 4){
#	array[i]	
#
#
#if (array[i] == 0x0a || array[i] == 0x20 || array[i] == 0x09){
#		
#
#		i++;	
#
#	}
#}

while_load_img01:	
	bge $t1, 4, end_load_img01
	add $t2, $t0, $t1			#array[i] 
	lbu $t3, 0($t2)				#Wert von array[i]
	

end_load_img01: 

lw $ra,0($sp) #Stackpointer
addi $sp,$sp,4 #PoP

jr $ra
#########################################
#Datai Speichern
store_img:
addi $sp, $sp, -4 #stack_push 
sw $ra, 0($sp) #register 
li $v0, 13 #oeffnen_der_Datai_open_data
la $a0, inputfilename
li $a1, 0x0100 #Flag O_CREAT
li $a2, 0x1FF #mode

jr $ra

#########################################
