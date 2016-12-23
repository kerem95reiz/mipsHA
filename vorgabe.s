# Aufgabe 1: Bilder laden und speichern

.data  #
filename: .asciiz  "sky.PGM"	# load_img
textSpace: .space 1050		#
array:	   .space 2000

.text
load_img:	
    jr $ra				
    li $v0, 13			# open a file
    li $a1, 0			# file flag (read)
    la $a0, filename		#load file name
    add $a2, $zero, $zero	# file mode (unsused)
    syscall
    
    move $a0, $v0		#load file decriptor
    li $v0, 14			#read from file
    la $a1, textSpace		#alloctae spcae for the bytes loaded
    li $a2, 1050		#number of bytes to be read
    syscall
    la $a0, textSpace		#adress of string to be printed
    li $v0, 1			#print array element
    syscall
   
   
read_img: 
 
    
#########################################

#
# store_img: 
#

store_img:
    jr $ra
    

#########################################


# Aufgabe 2: Verringern der Bildauflösung

#
# interpolate2
#

interpolate2:
    jr $ra

#########################################

#
# interpolate:
#

interpolate:
    jr $ra

#########################################

# Aufgabe 3: Verringern der Farbtiefe

#
# quantize:
#

quantize:
    jr $ra

#########################################



# Vorgabe eines Beispiel-Bildes um Aufgabe 2 und 3 unabhaengig von Aufgabe 1 loesen zu koennen
.data
beispiel_bild: .word 0x3, 0x1b, 0x1e, 0x18, 0x1c, 0x20, 0x1f, 0x25, 0x16, 0x24, 0xf, 0xd, 0x1e, 0x20, 0x35, 0x21, 0x1b, 0x1d, 0x1d, 0x31, 0x30, 0x2d, 0x29, 0x24, 0xa, 0x13, 0x27, 0x23, 0x26, 0x21, 0x25, 0xe, 0x1e, 0x1a, 0x45, 0x55, 0x46, 0x3d, 0x22, 0x2a, 0x11, 0x19, 0x39, 0x29, 0x29, 0x24, 0x2e, 0x22, 0x3a, 0x22, 0x21, 0x28, 0x51, 0x22, 0x2f, 0x2a, 0x12, 0x24, 0x1b, 0x32, 0x32, 0x50, 0x21, 0x32, 0x8, 0x3, 0xf, 0x24, 0x2b, 0x36, 0x1f, 0x24, 0x22, 0x22, 0x28, 0xc, 0x14, 0x1d, 0x33, 0x1f, 0x2b, 0x1a, 0x19, 0x16, 0x11, 0x13, 0x10, 0x1b, 0xb, 0xa, 0x16, 0x26, 0x1b, 0x22, 0x2f, 0x37, 0x19, 0x3f, 0x47, 0x27, 0x2e, 0x1e, 0x34, 0x3c, 0x30, 0x8, 0x1d, 0x1f, 0x3e, 0x38, 0x1a, 0x1e, 0x3f, 0x2c, 0x4f, 0x23, 0x33, 0x41, 0x2c, 0x13, 0x25, 0x15, 0x4a, 0x3a, 0x2e, 0x39, 0x3b, 0x1d, 0x15, 0x6, 0x0, 0x26, 0x28, 0x27, 0x33, 0x28, 0x3b, 0x66, 0x25, 0x15, 0x7, 0x1c, 0x3b, 0x23, 0x21, 0x26, 0x33, 0x26, 0x18, 0x11, 0x1c, 0x32, 0x20, 0xa, 0x35, 0x1e, 0x29, 0x30, 0x26, 0x32, 0x11, 0x21, 0x2d, 0x2d, 0x55, 0x64, 0x3b, 0x36, 0x19, 0x9, 0x31, 0x27, 0x3f, 0x29, 0x20, 0x1e, 0x47, 0x2f, 0x22, 0x3a, 0x43, 0x11, 0x19, 0x1f, 0x29, 0x37, 0x2a, 0x32, 0x49, 0x20, 0x21, 0x1d, 0x23, 0x23, 0x19, 0x16, 0x43, 0x34, 0x3e, 0x35, 0x3d, 0x2b, 0x25, 0x25, 0x1c, 0x2a, 0x35, 0x2f, 0x1e, 0x22, 0x38, 0x21, 0x2e, 0x2e, 0x2e, 0x27, 0x1d, 0x10, 0x3a, 0x2a, 0x1d, 0x27, 0x26, 0x1e, 0x1b, 0x19, 0x3d, 0x33, 0x3d, 0x2d, 0x40, 0x29, 0x21, 0xc, 0x38, 0x37, 0x30, 0x38, 0x2f, 0x3d, 0x30, 0x30, 0x5d, 0x2d, 0x13, 0x32, 0x1f, 0x29, 0x27, 0x29, 0x2d, 0x43, 0x1c, 0x12, 0x13, 0x2d, 0x35, 0x43, 0x47, 0x3, 0x2e, 0x4d, 0x32, 0x32, 0x2e, 0x34, 0x26, 0x1b, 0x2e, 0x1f, 0x25, 0x30, 0x2e, 0x33, 0x2a, 0x30, 0x3a, 0x10, 0x2e, 0x32, 0x2b, 0x24, 0x37, 0x25, 0x29, 0x30, 0x36, 0x42, 0x14, 0x38, 0x35, 0x2d, 0x1b, 0x43, 0x2e, 0x4a, 0x1d, 0x17, 0x21, 0x57, 0x20, 0x3f, 0x32, 0x3e, 0x63, 0x66, 0x2e, 0x1f, 0x78, 0x29, 0x24, 0x4e, 0x2f, 0x3f, 0x40, 0x3d, 0x23, 0x22, 0x49, 0x31, 0x49, 0x28, 0x41, 0x2a, 0x1a, 0x50, 0x3c, 0x47, 0x4d, 0x5e, 0x28, 0xa, 0x20, 0x27, 0x2b, 0x20, 0x29, 0x27, 0x1f, 0x1b, 0x1f, 0xb, 0x1a, 0x24, 0x23, 0x2a, 0x1f, 0x19, 0x1b, 0x38, 0x32, 0x4f, 0x17, 0x44, 0x51, 0x4c, 0x30, 0x54, 0x45, 0x44, 0x21, 0x36, 0x54, 0x63, 0x4f, 0x35, 0x62, 0x33, 0x1d, 0x46, 0x5c, 0x2d, 0x35, 0x71, 0x55, 0x2d, 0x57, 0x4d, 0x31, 0x22, 0x14, 0x55, 0x43, 0x4e, 0x28, 0x3c, 0x3a, 0x64, 0x4f, 0x2b, 0x4b, 0x76, 0x4c, 0x2a, 0x46, 0x32, 0xc, 0x32, 0x2a, 0x3b, 0x3d, 0x44, 0x32, 0x3d, 0x3b, 0x28, 0x31, 0x3c, 0x3a, 0x2e, 0x56, 0x2e, 0x16, 0x3d, 0x42, 0x41, 0x35, 0x2a, 0x5a, 0x42, 0x5a, 0x5a, 0x47, 0x49, 0x27, 0x3b, 0x4c, 0x4e, 0x48, 0x4e, 0x3a, 0x26, 0x33, 0x5f, 0x12, 0x2f, 0x47, 0x26, 0x31, 0x59, 0x2b, 0x44, 0x38, 0x18, 0x20, 0x58, 0x68, 0x7e, 0x2a, 0x2f, 0x5c, 0x4b, 0x7b, 0x5a, 0x57, 0x44, 0x4f, 0x42, 0x2f, 0x2c, 0x1d, 0xb, 0x4d, 0x35, 0x24, 0x24, 0x1d, 0x1f, 0x1b, 0x24, 0x10, 0x16, 0x1b, 0x38, 0x22, 0x27, 0xf, 0x2c, 0x2c, 0x2c, 0x37, 0x28, 0x47, 0x63, 0x7f, 0x4b, 0x6c, 0x62, 0x21, 0x66, 0x6d, 0x5e, 0x4e, 0x59, 0x41, 0x36, 0x37, 0x21, 0x23, 0x51, 0x39, 0x51, 0x28, 0x30, 0x74, 0x62, 0x9, 0x33, 0x30, 0x20, 0x73, 0x60, 0x26, 0x44, 0x31, 0x36, 0x3a, 0x65, 0x42, 0x51, 0x41, 0x47, 0x31, 0x45, 0x3c, 0x12, 0x1f, 0x2f, 0x35, 0x43, 0x3d, 0x3b, 0x40, 0x4a, 0x1f, 0x2c, 0x2c, 0x44, 0x49, 0x2f, 0x1b, 0x35, 0x3c, 0x44, 0x61, 0x38, 0x1f, 0x6d, 0x77, 0x7d, 0x49, 0x52, 0x37, 0x5c, 0x62, 0x60, 0x76, 0x58, 0x3f, 0x33, 0x4a, 0x12, 0x2e, 0x20, 0x2c, 0x3f, 0x2c, 0x2e, 0x32, 0x1b, 0x4b, 0x1f, 0x35, 0x23, 0x33, 0x47, 0x2e, 0x32, 0x31, 0x2b, 0x3e, 0x2d, 0x40, 0x3c, 0x70, 0x38, 0x49, 0x31, 0x3a, 0x41, 0x12, 0x2d, 0x2e, 0x1a, 0x15, 0x12, 0x1b, 0x2b, 0x15, 0x21, 0x31, 0x54, 0x50, 0x3e, 0x19, 0x44, 0x2b, 0x34, 0x38, 0x55, 0x18, 0x47, 0x61, 0x6a, 0x58, 0x72, 0x6c, 0x1e, 0x97, 0x9c, 0x8e, 0x42, 0x45, 0x50, 0x46, 0x14, 0x32, 0x3b, 0x2d, 0x26, 0x71, 0x25, 0x23, 0x15, 0x25, 0x54, 0x14, 0x37, 0x15, 0x33, 0x4f, 0x3b, 0x2f, 0x4d, 0x1f, 0x61, 0x46, 0x54, 0x2b, 0x36, 0x38, 0x4e, 0x54, 0x2e, 0x18, 0x34, 0x35, 0x22, 0x25, 0x25, 0x2a, 0x3a, 0x24, 0x2d, 0x31, 0x34, 0x47, 0x71, 0x23, 0x46, 0x38, 0x2d, 0x2d, 0x49, 0xf, 0x27, 0x46, 0x31, 0x25, 0x46, 0x4d, 0x32, 0xa6, 0x4c, 0x50, 0x58, 0x56, 0x4a, 0x33, 0x32, 0x33, 0x1d, 0x1d, 0x15, 0x1e, 0x3f, 0x14, 0x1b, 0x49, 0x27, 0x6a, 0x1a, 0x35, 0x1b, 0x2d, 0x2f, 0x4b, 0x37, 0x48, 0x46, 0x5c, 0x32, 0x59, 0x2a, 0x32, 0x34, 0x2b, 0x32, 0x31, 0x37, 0x35, 0x5c, 0x4b, 0x61, 0x4c, 0x44, 0x39, 0x1f, 0x32, 0x4e, 0x3e, 0x38, 0x45, 0x2b, 0x30, 0x35, 0x37, 0x31, 0xb, 0x33, 0x1d, 0x2c, 0x35, 0x3b, 0x32, 0x1f, 0x37, 0x6f, 0x48, 0x54, 0x6b, 0x1a, 0x5c, 0x26, 0x25, 0x35, 0x27, 0x24, 0x1b, 0x1e, 0x16, 0x17, 0x34, 0x40, 0x32, 0x56, 0x2b, 0x27, 0x41, 0x38, 0x21, 0x3e, 0x58, 0x69, 0x31, 0x4a, 0x38, 0x34, 0x35, 0x28, 0x45, 0x49, 0x3b, 0x44, 0x66, 0x40, 0x30, 0x37, 0x3d, 0x3e, 0x30, 0x45, 0x49, 0x51, 0x28, 0x46, 0x49, 0x39, 0x3b, 0x4d, 0x4e, 0x24, 0x16, 0x40, 0x32, 0x20, 0x3f, 0x52, 0x21, 0x24, 0x2f, 0x38, 0x6a, 0x63, 0x30, 0x37, 0x4b, 0x3f, 0x3a, 0x2b, 0x22, 0x3a, 0x30, 0x26, 0x23, 0x1e, 0x1f, 0x3e, 0x31, 0x32, 0x4b, 0x4c, 0x3d, 0x43, 0x72, 0x36, 0x44, 0x3e, 0x44, 0x2a, 0x4c, 0x23, 0x20, 0x38, 0x28, 0x2b, 0x7b, 0x1a, 0x30, 0x40, 0x3e, 0x48, 0x47, 0x30, 0x4c, 0x5b, 0x48, 0x42, 0x38, 0x35, 0x4d, 0x50, 0x54, 0x42, 0x4e, 0x17, 0x28, 0x3e, 0x3d, 0x32, 0x29, 0x59, 0x2a, 0x28, 0x43, 0x32, 0x61, 0x63, 0x13, 0x72, 0x46, 0x3b, 0x2f, 0x2a, 0x40, 0x25, 0x1f, 0x30, 0x37, 0x21, 0x23, 0x11, 0x37, 0x26, 0x65, 0x2a, 0x32, 0x41, 0x5a, 0x59, 0x54, 0x58, 0x27, 0x53, 0x38, 0x26, 0x23, 0x29, 0x45, 0x3a, 0x31, 0x20, 0x43, 0x44, 0x43, 0x44, 0x3b, 0x4a, 0x55, 0x57, 0x65, 0x5e, 0x4e, 0x45, 0x54, 0x54, 0x56, 0x4b, 0x53, 0xc, 0x42, 0x41, 0x39, 0x37, 0x36, 0x53, 0x4d, 0x29, 0x43, 0x45, 0x6b, 0x1e, 0x4c, 0x5e, 0x4a, 0x40, 0x29, 0x45, 0x54, 0x2f, 0x38, 0x30, 0x35, 0x47, 0x19, 0x35, 0x26, 0x3e, 0x21, 0x40, 0x36, 0x58, 0x40, 0x85, 0x4a, 0x4f, 0x4f, 0x3e, 0x4e, 0x2b, 0x31, 0x4b, 0x4b, 0x50, 0x58, 0x1f, 0x47, 0x4b, 0x67, 0x5e, 0x30, 0x65, 0x41, 0x3c, 0x2a, 0x3a, 0x35, 0x3c, 0x42, 0x3b, 0x4d, 0x3a, 0x9, 0x14, 0x34, 0x3a, 0x3a, 0x53, 0x63, 0x65, 0x2c, 0x63, 0x4e, 0x58, 0x55, 0x1b, 0x6d, 0x64, 0x47, 0x2f, 0x43, 0x33, 0x6e, 0x85, 0x4d, 0x4b, 0x3f, 0x2e, 0x26, 0x1e, 0x36, 0x40, 0x1e, 0x2b, 0x31, 0x31, 0x57, 0x25, 0x54, 0x44, 0x38, 0x20, 0x24, 0x37, 0x74, 0x55, 0x26, 0x5a, 0x70, 0x4c, 0x25, 0x3f, 0x67, 0x5d, 0x5a, 0x3f, 0x84, 0x4c, 0x41, 0x25, 0x3a, 0x9d, 0x5f, 0x37, 0x59, 0x28, 0x11, 0x57, 0x42, 0x36, 0x41, 0x49, 0x58, 0x33, 0x58, 0x66, 0x71, 0x87, 0x22, 0x3b, 0x4b, 0x76, 0x3c, 0x38, 0x29, 0x7a, 0x75, 0x36, 0x4f, 0x4f, 0x38, 0x38, 0x18, 0x1c, 0x52, 0x3a, 0x5d, 0x15, 0x4b, 0x24, 0x23, 0x2c, 0x2d, 0x3c, 0x32, 0x2a, 0x27, 0x41, 0x39, 0x52, 0x5f, 0x20, 0x60, 0x49, 0x54, 0x62, 0x55, 0x3c, 0x55, 0x4a, 0x2b, 0x35, 0x2a, 0x3a, 0x71, 0x75, 0x5e, 0x2e, 0x4b, 0x1a, 0xd, 0x32, 0x34, 0x3b, 0x2d, 0x49, 0x3f, 0x2e, 0x5b, 0x74, 0x7a, 0x30, 0x31, 0x62, 0x58, 0x5d, 0x58, 0x4c, 0x61, 0x3c, 0x5f, 0x44, 0x38, 0x21, 0x2b, 0x1f, 0x24, 0x26, 0x25, 0x38, 0x4f, 0x39, 0x3c, 0x3d, 0x31, 0x1b, 0x41, 0x1a, 0x2d, 0x35, 0x4c, 0x22, 0x4e, 0x67, 0x5a, 0x2f, 0x15, 0x60, 0x66, 0x46, 0x60, 0x5a, 0x51, 0x48, 0x3e, 0x34, 0x36, 0x2b, 0x27, 0x24, 0x2e, 0x39, 0x3c, 0x3b, 0xc, 0x21, 0x29, 0x2b, 0x41, 0x2e, 0x1f, 0x17, 0x36, 0x4c, 0x37, 0x47, 0x61, 0x45, 0x6c, 0x54, 0x6a, 0x75, 0x50, 0x5a, 0x2a, 0x45, 0x30, 0x1a, 0x22, 0x26, 0x4a, 0x26, 0x1f, 0x5d, 0x63, 0x50, 0x27, 0x48, 0x2c, 0x2d, 0x23, 0x1c, 0x3f, 0x73, 0x3c, 0x61, 0x3d, 0x38, 0x53, 0x57, 0x54, 0xc, 0x68, 0x34, 0x8d, 0x7a, 0x4f, 0x33, 0x28, 0x22, 0x28, 0x2d, 0x21, 0x2c, 0x2b, 0x38, 0x32, 0x38, 0x28, 0x12, 0x43, 0x3d, 0x48, 0x45, 0x31, 0x40, 0x36, 0x2f, 0x16, 0x68, 0x62, 0x5e, 0x55, 0x53, 0x47, 0x6d, 0x71, 0x34, 0x44, 0x37, 0x1f, 0x1f, 0x2b, 0x58, 0x27, 0x29, 0x46, 0x29, 0x77, 0x56, 0x11, 0x18, 0x2a, 0x6f, 0x18, 0x43, 0x68, 0x3d, 0x41, 0x56, 0x2d, 0x57, 0x2c, 0x4f, 0x5f, 0x6c, 0x25, 0x29, 0x5e, 0xa1, 0x24, 0x23, 0x36, 0x30, 0x3e, 0x35, 0x1a, 0x20, 0x24, 0x21, 0x47, 0x3a, 0x3e, 0x9, 0x28, 0x30, 0x4f, 0x47, 0x46, 0x42, 0x37, 0x5e, 0x42, 0x15, 0x5e, 0x92, 0x6a, 0x31, 0x56, 0x57, 0x5a, 0x5c, 0x3e, 0x3c, 0x3b, 0x3b, 0x2c, 0x2b, 0x40, 0x34, 0x23, 0x20, 0x46, 0x33, 0x27, 0x18, 0x33, 0x43, 0x3e, 0x53, 0x3e, 0x4f, 0x5d, 0x35, 0x1a, 0x35, 0x27, 0x33, 0x55, 0x4d, 0x55, 0xc7, 0x4c, 0x80, 0x3d, 0x31, 0x22, 0x30, 0x3d, 0x1d, 0x25, 0x16, 0x2f, 0x20, 0x3e, 0x26, 0x2d, 0x23, 0x1c, 0x55, 0x36, 0x2e, 0x35, 0x38, 0x44, 0x4b, 0x34, 0x25, 0x87, 0x6f, 0x5c, 0x36, 0x3d, 0x41, 0x4b, 0x66, 0x40, 0x33, 0x2c, 0x3e, 0x33, 0x2c, 0x5e, 0x5d, 0x30, 0x36, 0x1d, 0x39, 0x3c, 0x43, 0x14, 0x16, 0x1e, 0x27, 0x44, 0x56, 0x5d, 0x1f, 0x11, 0x2f, 0x30, 0x26, 0x3f, 0x3d, 0x4c, 0x50, 0x8d, 0x20, 0x4c, 0x33, 0x48, 0x39, 0x33, 0x3a, 0x3e, 0x32, 0x17, 0x35, 0x23, 0x32, 0x3e, 0x22, 0x27, 0x4a, 0x34, 0x40, 0x44, 0x34, 0x37, 0x43, 0x2d, 0x21, 0x60, 0x68, 0x4f, 0x61, 0x33, 0x67, 0x54, 0x47, 0x51, 0x27, 0x3e, 0x2b, 0x47, 0x32, 0x37, 0x51, 0x3c, 0x2b, 0x13, 0x33, 0x23, 0x37, 0x4c, 0x21, 0x63, 0x46, 0x20, 0x29, 0x23, 0x28, 0x10, 0x37, 0x2b, 0x4e, 0x32, 0x34, 0x36, 0x24, 0x60, 0x26, 0x1b, 0x6e, 0x42, 0x2b, 0x43, 0x35, 0x29, 0x26, 0x34, 0x2b, 0x35, 0x4a, 0x2e, 0x24, 0x22, 0x34, 0x5a, 0x60, 0x4f, 0x2e, 0x18, 0x22, 0x4a, 0x97, 0x2d, 0x55, 0x57, 0x4d, 0x38, 0x3f, 0x4d, 0x5b, 0x4e, 0x4b, 0x45, 0x26, 0x53, 0x42, 0x2e, 0x3a, 0x58, 0x28, 0x14, 0x2a, 0x29, 0x27, 0x38, 0x2f, 0x4d, 0x36, 0x53, 0x41, 0x2c, 0xf, 0x3b, 0x45, 0x29, 0x3a, 0x4e, 0x24, 0x22, 0x3e, 0x3d, 0x4f, 0x6, 0x36, 0x52, 0x43, 0x21, 0x35, 0x41, 0x47, 0x53, 0x2c, 0x36, 0x30, 0x40, 0x2b, 0x22, 0x44, 0x2c, 0x3a, 0x45, 0x25, 0x33, 0x20, 0x35, 0x5f, 0xae, 0x3b, 0x3c, 0x58, 0x55, 0x22, 0x4f, 0x4b, 0x52, 0x68, 0x34, 0x3d, 0x59, 0x34, 0x30, 0x19, 0x26, 0x12, 0xf, 0x11, 0x2c, 0x31, 0x3c, 0x34, 0x33, 0x35, 0x55, 0x44, 0x4d, 0x17, 0x3c, 0x2b, 0x34, 0x3c, 0x35, 0x27, 0x1f, 0x3e, 0x3a, 0x4f, 0x3d, 0x4, 0x2d, 0x3f, 0x36, 0x4c, 0x45, 0x23, 0x32, 0x2f, 0x37, 0x37, 0x46, 0x1a, 0x4d, 0x4f, 0x46, 0x34, 0x45, 0x36, 0x44, 0x35, 0x44, 0x45, 0x8a, 0x83, 0x29, 0x43, 0x64, 0x3c, 0x34, 0x55, 0x5a, 0x55, 0x31, 0x33, 0x1c, 0x14, 0x19, 0x2d, 0x34, 0x3e, 0x35, 0x38, 0x29, 0x3f, 0x2a, 0x28, 0x27, 0x40, 0x3e, 0x58, 0x3b, 0x34, 0x37, 0x44, 0x45, 0x36, 0x1d, 0x42, 0x36, 0x31, 0x4e, 0x38, 0x53, 0x27, 0x6, 0x3c, 0x41, 0x22, 0x29, 0x46, 0x54, 0x65, 0x4a, 0x57, 0x3a, 0x25, 0x55, 0x4f, 0x3f, 0x5e, 0x44, 0x4e, 0x39, 0x37, 0x4e, 0x35, 0x45, 0x7b, 0x46, 0x48, 0x5a, 0x45, 0x19, 0x1c, 0x1d, 0x14, 0x12, 0x21, 0x35, 0x38, 0x5e, 0x56, 0x54, 0x59, 0x45, 0x1a, 0x37, 0x2c, 0x33, 0x38, 0x4f, 0x64, 0x41, 0x6b, 0x32, 0x43, 0x52, 0x46, 0x4a, 0x56, 0x31, 0x48, 0x39, 0x4d, 0x30, 0x54, 0x2d, 0x65, 0x20, 0x15, 0x22, 0x32, 0x54, 0x43, 0x43, 0x3f, 0x40, 0x4b, 0x2a, 0x3a, 0x5b, 0x67, 0x5c, 0x3d, 0x64, 0x4c, 0x38, 0x45, 0x49, 0x4b, 0x2f, 0x88, 0x72, 0x67, 0x54, 0x1e, 0x22, 0x1f, 0x31, 0x45, 0x55, 0x48, 0x31, 0x71, 0x4f, 0x4f, 0x75, 0x65, 0x2e, 0x34, 0x2d, 0x5a, 0x22, 0x34, 0x4a, 0x5b, 0x56, 0x3b, 0x29, 0x36, 0x2a, 0x39, 0x3a, 0x39, 0x60, 0x40, 0x29, 0x63, 0x29, 0x4a, 0x41, 0x4d, 0x55, 0x12, 0x1b, 0x4a, 0x35, 0x45, 0x6f, 0x72, 0x6b, 0x90, 0x2c, 0x6c, 0x71, 0x6a, 0x5d, 0x69, 0x47, 0x5c, 0x4f, 0x4d, 0x27, 0x43, 0x37, 0x56, 0x8e, 0x32, 0x2f, 0x16, 0x4f, 0x3e, 0x44, 0x52, 0x62, 0x61, 0x27, 0x70, 0x3c, 0x4b, 0x86, 0x5c, 0x30, 0x45, 0x85, 0x72, 0x47, 0x58, 0x3e, 0x58, 0x62, 0x31, 0x40, 0x3b, 0x2c, 0x40, 0x4f, 0x28, 0x41, 0x4d, 0x27, 0x42, 0x67, 0x2f, 0x59, 0x5e, 0x35, 0x59, 0x21, 0x28, 0x78, 0x64, 0x57, 0x72, 0x76, 0x7f, 0x28, 0xa2, 0x72, 0x90, 0x8d, 0x74, 0x78, 0x36, 0x59, 0x4c, 0x3e, 0x2c, 0x56, 0x44, 0x53, 0x2d, 0x4b, 0x27, 0x44, 0x68, 0x4b, 0x58, 0x6a, 0x53, 0x4f, 0x3b, 0x43, 0x45, 0x3e, 0x50, 0x1f, 0x3c, 0x7c, 0x74, 0x71, 0x63, 0x77, 0x59, 0x73, 0x31, 0x3c, 0x44, 0x28, 0x2d, 0x7b, 0x2f, 0x50, 0x40, 0x43, 0x2c, 0x47, 0x3c, 0x58, 0x86, 0x61, 0x4e, 0x4d, 0x49, 0x2d, 0x7a, 0x90, 0x6f, 0x70, 0x7d, 0x3e, 0x7d, 0x9e, 0x87, 0x91, 0x9a, 0x59, 0x6a, 0x33, 0x53, 0x22, 0x15, 0x2d, 0x1f, 0x21, 0x5c, 0x4e, 0x5d, 0x1e, 0x69, 0x6b, 0x64, 0x50, 0x51, 0x47, 0x61, 0x4c, 0x36, 0x54, 0x3f, 0x3c, 0x26, 0x31, 0x48, 0x3a, 0x63, 0x76, 0x6b, 0x6f, 0x3e, 0x6d, 0x50, 0x28, 0x39, 0x5e, 0x3d, 0x45, 0x34, 0x33, 0x2a, 0x38, 0x61, 0x43, 0x56, 0x96, 0x2f, 0x68, 0x82, 0x41, 0x65, 0x85, 0x98, 0x9c, 0x91, 0x49, 0x99, 0x75, 0x99, 0x88, 0x9e, 0x82, 0x65, 0x42, 0x36, 0x3f, 0x4c, 0x35, 0x35, 0x39, 0x84, 0x46, 0x90, 0x13, 0x66, 0x7b, 0x6b, 0x4c, 0x62, 0x3c, 0x54, 0x35, 0x34, 0x49, 0x49, 0x3f, 0x31, 0x4b, 0x61, 0x4b, 0x36, 0x4e, 0x59, 0x57, 0x6e, 0x4e, 0x57, 0x50, 0x4c, 0x59, 0x71, 0x4a, 0x37, 0x3b, 0x47, 0x39, 0x6f, 0x47, 0x52, 0x8a, 0x25, 0x56, 0x50, 0xb8, 0x4a, 0x8f, 0x98, 0x7a, 0x87, 0x7b, 0x89, 0x9c, 0x9a, 0x9c, 0x73, 0x4a, 0x37, 0x34, 0x34, 0x5c, 0x4c, 0x44, 0x49, 0x31, 0x6b, 0x5b, 0x91, 0x3c, 0x3a, 0x7a, 0x5b, 0x4b, 0x4f, 0x31, 0x49, 0x47, 0x38, 0x25, 0x43, 0x3b, 0x2e, 0x3a, 0x53, 0x46, 0x4c, 0x42, 0x56, 0x4c, 0x7e, 0x39, 0x67, 0x4a, 0x51, 0x58, 0x51, 0x3d, 0x26, 0x2d, 0x42, 0x47, 0x61, 0x57, 0x51, 0x5c, 0x40, 0x5a, 0x64, 0x83, 0xc1, 0x63, 0x59, 0xb5, 0x7f, 0xa3, 0xc7, 0xa4, 0x8a, 0x4f, 0x46, 0x52, 0x63, 0x66, 0x3f, 0x67, 0x79, 0x3f, 0x57, 0x47, 0x6c, 0x66, 0x77, 0x37, 0x2a, 0x4c, 0x53, 0x3a, 0x40, 0x3b, 0x54, 0x5f, 0x31, 0x35, 0x49, 0x50, 0x42, 0x47, 0x4e, 0x3c, 0x5a, 0x33, 0x41, 0x6a, 0xa5, 0x49, 0x50, 0x1c, 0x34, 0x40, 0x3b, 0x40, 0x32, 0x2f, 0x4f, 0x34, 0x55, 0x3d, 0x80, 0x5c, 0x58, 0x42, 0x81, 0x81, 0x96, 0x98, 0x98, 0x5c, 0x8c, 0x97, 0x6e, 0x77, 0x9c, 0xae, 0x9c, 0x68, 0x60, 0x55, 0x43, 0x4e, 0x61, 0x61, 0x70, 0x40, 0x66, 0x51, 0x2f, 0x48, 0x5a, 0x55, 0x7d, 0x61, 0x45, 0x2c, 0x2c, 0x2e, 0x23, 0x1c, 0x25, 0x25, 0x1d, 0x2d, 0x4b, 0x39, 0xe, 0xa, 0x14, 0x19, 0x52, 0x5a, 0x3b, 0x12, 0x3b, 0x45, 0x4b, 0x41, 0x34, 0x2b, 0x5b, 0x35, 0x71, 0x59, 0x53, 0x66, 0x5a, 0x4a, 0x58, 0x72, 0x75, 0x90, 0x79, 0xa3, 0xb5, 0xa1, 0x81, 0xce, 0xb5, 0xbe, 0xb3, 0x69, 0x57, 0x6f, 0x4e, 0x4e, 0x84, 0x4b, 0x7e, 0x4a, 0x5a, 0x76, 0x2a, 0x64, 0x54, 0x67, 0x5c, 0x5f, 0x53, 0x2e, 0x3d, 0x9b, 0x42, 0x42, 0x63, 0x38, 0x42, 0x7, 0xd, 0xb, 0x21, 0x4b, 0x4b, 0x3f, 0xa1, 0x69, 0x52, 0x19, 0x27, 0x2a, 0x42, 0x39, 0x2e, 0x2f, 0x56, 0x40, 0x48, 0x40, 0x48, 0x5d, 0x7b, 0x46, 0x77, 0x79, 0x83, 0xa0, 0x7a, 0x96, 0x7e, 0xb8, 0xb7, 0xb9, 0xbe, 0xbe, 0xae, 0x85, 0x4e, 0x3f, 0x2b, 0x40, 0x6a, 0x5a, 0x6d, 0x45, 0x57, 0x79, 0x34, 0x58, 0x5d, 0x58, 0x4d, 0x47, 0x48, 0x2c, 0x43, 0x8c, 0x4d, 0x3e, 0x57, 0x41, 0x42, 0x2e, 0x29, 0x36, 0x5f, 0x49, 0x56, 0x30, 0x75, 0x6b, 0x62, 0x2d, 0x3a, 0x4b, 0x4b, 0x34, 0x2d, 0x33, 0x4a, 0x2c, 0x3b, 0x41, 0x2f, 0x78, 0x43, 0x67, 0x56, 0x66, 0x90, 0xaa, 0x8b, 0x53, 0x75, 0xc4, 0xa2, 0xb7, 0xa8, 0xaf, 0x98, 0x6c, 0x57, 0x81, 0x51, 0x65, 0x7c, 0x2b, 0x29, 0x18, 0x32, 0x3b, 0x30, 0x4c, 0x7f, 0x5f, 0x74, 0x5a, 0x51, 0x31, 0x39, 0x58, 0x51, 0x47, 0x6a, 0x3a, 0x4a, 0x2a, 0x47, 0x36, 0x38, 0x3b, 0x3e, 0x2a, 0x30, 0x67, 0x57, 0x44, 0x1a, 0x2b, 0x50, 0x49, 0x2b, 0x36, 0x50, 0x38, 0x50, 0x25, 0x39, 0x64, 0x29, 0x70, 0x5f, 0x79, 0x81, 0x66, 0x85, 0x12, 0x9f, 0x73, 0xa6, 0xa0, 0xb4, 0xb6, 0x75, 0x7f, 0x54, 0x9b, 0x4d, 0x70, 0x6b, 0x5a, 0x5c, 0x49, 0x60, 0x1b, 0x32, 0x40, 0x3d, 0x4f, 0x48, 0x44, 0x59, 0x25, 0x54, 0x61, 0x44, 0x60, 0x54, 0x30, 0x29, 0x2a, 0x2c, 0x33, 0x2b, 0x55, 0x3d, 0x46, 0x35, 0x72, 0x2c, 0x56, 0x1f, 0x24, 0x3a, 0x38, 0x27, 0x41, 0x3e, 0x43, 0x51, 0x35, 0x3c, 0x58, 0x52, 0x6e, 0x5f, 0x72, 0x65, 0x7d, 0x13, 0x3f, 0x9c, 0x6f, 0x6a, 0x8c, 0xb7, 0xa3, 0xa2, 0x65, 0x94, 0x77, 0x6c, 0x80, 0x49, 0x4f, 0x51, 0x3d, 0x8b, 0x1d, 0x4a, 0x5c, 0x6f, 0x4d, 0x5a, 0x52, 0x75, 0x49, 0x34, 0x56, 0x4b, 0x33, 0x58, 0x42, 0x21, 0x31, 0x20, 0x3d, 0x2c, 0x21, 0x2d, 0x49, 0x23, 0x61, 0x3a, 0x67, 0x27, 0x2b, 0x34, 0x44, 0x2b, 0x4a, 0x3e, 0x53, 0x48, 0x39, 0x43, 0x39, 0x4e, 0x55, 0x5e, 0x63, 0x73, 0x4e, 0x5, 0x7a, 0x83, 0x87, 0x57, 0x6a, 0x8d, 0x8e, 0x92, 0x74, 0x8d, 0x68, 0x6d, 0x91, 0x46, 0x4c, 0x59, 0x3c, 0x70, 0x1b, 0x59, 0x4e, 0x5c, 0x55, 0x71, 0x3c, 0x5c, 0x36, 0x3e, 0x3b, 0x42, 0x20, 0x5e, 0x3c, 0x21, 0x3b, 0x1b, 0x2c, 0x36, 0x27, 0x28, 0x28, 0x20, 0x33, 0x4e, 0x69, 0x37, 0x2e, 0x29, 0x4c, 0x2e, 0x28, 0x40, 0x74, 0x2b, 0x3f, 0x39, 0x44, 0x50, 0x5c, 0x6a, 0x6e, 0x43, 0x11, 0x16, 0x6d, 0x63, 0x7c, 0x6c, 0x2c, 0x98, 0x63, 0x6f, 0x96, 0x59, 0x80, 0x95, 0x6b, 0x6e, 0x52, 0x59, 0x61, 0x31, 0x31, 0x3b, 0x5b, 0x38, 0x59, 0x69, 0x3a, 0x4d, 0x33, 0x4a, 0x45, 0x39, 0x24, 0x5d, 0x3c, 0x14, 0x21, 0x23, 0x17, 0x48, 0x22, 0x17, 0x29, 0x27, 0x16, 0x55, 0x35, 0x55, 0x26, 0x36, 0x28, 0x33, 0x2b, 0x40, 0x24, 0x1e, 0x5d, 0x2e, 0x3f, 0x32, 0x46, 0x68, 0x4, 0x32, 0x23, 0x4f, 0x40, 0x49, 0x5d, 0x63, 0x43, 0x42, 0x89, 0x62, 0x44, 0x56, 0x8c, 0x87, 0x5e, 0x5b, 0x4d, 0x4b, 0x7d, 0x1e, 0x45, 0x3b, 0x59, 0x51, 0x46, 0x38, 0x4c, 0x33, 0x39, 0x54, 0x5b, 0x23, 0x25, 0x27, 0x38, 0x25, 0x38, 0x29, 0x20, 0x3a, 0x32, 0x38, 0x10, 0x29, 0x1e, 0x30, 0x39, 0x48, 0x2f, 0x2e, 0x1f, 0x32, 0x13, 0x1c, 0x28, 0x4d, 0x27, 0x57, 0x2b, 0x3e, 0x2f, 0x7, 0x43, 0x54, 0x3d, 0x40, 0x46, 0x2d, 0x3e, 0x57, 0x40, 0x71, 0x61, 0x52, 0x31, 0x5a, 0x71, 0x57, 0x56, 0x43, 0x4a, 0x61, 0x25, 0x48, 0x35, 0x3e, 0x35, 0x35, 0x50, 0x33, 0x43, 0x1c, 0x3f, 0x37, 0x59, 0x38, 0x64, 0x3f, 0x15, 0x1c, 0x18, 0x20, 0x1f, 0x23, 0x2c, 0x3c, 0x2c, 0x1b, 0x1d, 0x14, 0x4c, 0x3e, 0x34, 0x1e, 0x19, 0x19, 0x2e, 0x22, 0x41, 0x2b, 0x54, 0x37, 0x42, 0x26, 0x11, 0xa, 0x3a, 0x3e, 0x48, 0x50, 0x6b, 0x1f, 0x59, 0x7d, 0x44, 0x36, 0x50, 0x4b, 0x7d, 0x43, 0x4f, 0x43, 0x64, 0x3e, 0x55, 0x4b, 0x32, 0x40, 0x49, 0x56, 0x2a, 0x41, 0x57, 0x1d, 0x31, 0x1b, 0x47, 0x38, 0x32, 0x3f, 0x69, 0x56, 0x2b, 0x4b, 0x1d, 0x19, 0x21, 0x19, 0x2e, 0x2f, 0x3e, 0x19, 0x23, 0x18, 0x37, 0x39, 0x50, 0x2b, 0x20, 0x20, 0x29, 0x23, 0x1a, 0x54, 0x39, 0x4f, 0x39, 0x29, 0xa, 0x2c, 0x30, 0x50, 0x34, 0x32, 0x4b, 0x12, 0x29, 0x55, 0x62, 0x3d, 0x44, 0x49, 0x5f, 0x5c, 0x3b, 0x43, 0x32, 0x38, 0x3f, 0x26, 0x41, 0x32, 0x52, 0x4c, 0x4b, 0x2a, 0x3f, 0x45, 0x2c, 0x29, 0x20, 0x38, 0x2c, 0x51, 0x63, 0x76, 0x4d, 0x5c, 0x12, 0x1d, 0x2c, 0x13, 0x21, 0x22, 0x24, 0x26, 0x23, 0x21, 0xa, 0x2d, 0x33, 0x56, 0x25, 0x32, 0x1c, 0x1e, 0x23, 0x25, 0x35, 0x34, 0x46, 0x27, 0x19, 0x47, 0x3c, 0x35, 0x40, 0x36, 0x33, 0x10, 0x35, 0x5e, 0x7b, 0x8f, 0x35, 0x4a, 0x60, 0x53, 0x4c, 0x40, 0x2d, 0x47, 0x1a, 0x41, 0x3b, 0x4b, 0x3c, 0x45, 0x3e, 0x4a, 0x21, 0x49, 0x24, 0x31, 0x5d, 0x1d, 0x32, 0x1e, 0x34, 0x62, 0x8c, 0x30, 0x20, 0x10, 0x25, 0x2c, 0x1d, 0x2d, 0x26, 0x23, 0x18, 0x13, 0x9, 0x27, 0x33, 0x6b, 0x42, 0x20, 0x26, 0x21, 0x22, 0x29, 0x2c, 0x3c, 0x49, 0x12, 0x27, 0x2c, 0x21, 0x3d, 0x4d, 0x34, 0x3d, 0x6, 0x20, 0x60, 0x51, 0x46, 0x69, 0x28, 0x51, 0x60, 0x43, 0x23, 0x3d, 0x1e, 0x43, 0x15, 0x2d, 0x4d, 0x36, 0x34, 0x42, 0x29, 0x7f, 0x45, 0x33, 0x3c, 0x32, 0x4e, 0x15, 0x2c, 0x2d, 0x54, 0x5c, 0x1c, 0x2d, 0x1c, 0x12, 0x49, 0x24, 0x25, 0x2a, 0x3d, 0x17, 0x1c, 0x1a, 0x16, 0x23, 0x24, 0x61, 0x2a, 0x2a, 0x41, 0x32, 0x36, 0x29, 0x23, 0x34, 0x25, 0x2d, 0x22, 0x38, 0x33, 0x2d, 0x38, 0x38, 0xa, 0xb, 0x4c, 0x66, 0x60, 0x4d, 0x43, 0x51, 0x2e, 0x35, 0x36, 0x27, 0x3c, 0x36, 0x3e, 0x1c, 0x36, 0x31, 0x46, 0x26, 0x3b, 0x2b, 0x26, 0x29, 0x53, 0x5a, 0x25, 0x1b, 0x14, 0x1c, 0x41, 0x30, 0x1d, 0x2a, 0x2a, 0x13, 0x2f, 0x31, 0x29, 0x22, 0xa, 0x16, 0x1f, 0x1c, 0x1c, 0x1f, 0x2d, 0x1b, 0x5c, 0x31, 0x23, 0x36, 0x2b, 0x23, 0x35, 0x24, 0x35, 0x2c, 0x39, 0x2b, 0x2b, 0x43, 0x37, 0x2c, 0x10, 0x3, 0x4c, 0x4b, 0x63, 0x49, 0x43, 0x26, 0x2e, 0x39, 0x24, 0x3f, 0x35, 0x3f, 0x3e, 0x47, 0x2c, 0x23, 0x2c, 0x2f, 0x38, 0x2e, 0x2a, 0x43, 0x41, 0x28, 0x22, 0x24, 0x10, 0x23, 0x74, 0x25, 0x1e, 0x1c, 0x1f, 0x17, 0xc, 0x1b, 0x9, 0x25, 0x1e, 0x2f, 0x24, 0x20, 0x14, 0x20, 0x14, 0x18, 0x1b, 0x42, 0x6e, 0x1b, 0x24, 0x2d, 0x24, 0x30, 0x1b, 0x27, 0x1f, 0x2a, 0x43, 0x39, 0x36, 0x33, 0xe, 0x3, 0x38, 0x5c, 0x3d, 0x3e, 0x4f, 0x3d, 0xe, 0x3b, 0x40, 0x31, 0x2a, 0x3f, 0x38, 0x3c, 0x58, 0x45, 0x25, 0x27, 0x28, 0x2a, 0x33, 0x2b, 0x61, 0x31, 0x31, 0x1b, 0x13, 0x28, 0x41, 0x35, 0x19, 0x10, 0x6, 0xb, 0x24, 0x18, 0x45, 0x37, 0x28, 0x2c, 0x1d, 0x1c, 0x1e, 0xf, 0x10, 0x1d, 0x1e, 0x10, 0x52, 0x4b, 0x29, 0x29, 0x19, 0x22, 0x1d, 0x26, 0x17, 0x1c, 0x28, 0x2a, 0x16, 0x4, 0x11, 0x23, 0x22, 0x5f, 0x53, 0x42, 0x2a, 0x52, 0x29, 0x2e, 0x45, 0x3b, 0x2a, 0x24, 0x42, 0x4a, 0x7f, 0x2e, 0x4a, 0x1c, 0x27, 0x17, 0x20, 0x42, 0x29, 0x37, 0x33, 0x17, 0x1e, 0x39, 0x5e, 0x2a, 0x32, 0xe, 0xb, 0x30, 0x22, 0x1a, 0x42, 0x28, 0x27, 0x19, 0x2a, 0x1b, 0x1c, 0x28, 0x29, 0x1f, 0x12, 0x1d, 0x14, 0x1a, 0x2b, 0x25, 0x23, 0x19, 0x2a, 0x33, 0x1f, 0x20, 0x22, 0x2c, 0x1a, 0x2, 0x12, 0x61, 0x2e, 0x1e, 0x36, 0x35, 0x32, 0x3b, 0x4d, 0xe, 0x36, 0x34, 0x34, 0x28, 0x22, 0x75, 0x28, 0x38, 0x2d, 0x39, 0x32, 0x37, 0x12, 0x27, 0x30, 0x2b, 0x17, 0x19, 0x13, 0x34, 0x8c, 0x31, 0x37, 0x11, 0x11, 0x14, 0x19, 0x28, 0x1b, 0x3d, 0x21, 0x18, 0x19, 0x24, 0x11, 0x24, 0x2a, 0x20, 0x1a, 0x21, 0x15, 0x13, 0x21, 0x28, 0x4c, 0x31, 0x26, 0x26, 0x2a, 0x2c, 0x25, 0x1c, 0xd, 0x2, 0x8, 0x2b, 0x3f, 0x26, 0x25, 0x2f, 0x38, 0x2d, 0x37, 0x33, 0x11, 0x4c, 0x3b, 0x34, 0x44, 0x1f, 0x31, 0x23, 0x37, 0x40, 0x42, 0x31, 0x2e, 0x10, 0x1c, 0x35, 0x2d, 0x12, 0x13, 0x3b, 0x58, 0x86, 0x28, 0x10, 0xd, 0x16, 0x17, 0x29, 0x1c, 0x17, 0x3b, 0x1a, 0x1b, 0x12, 0x18, 0xe, 0x27, 0x2c, 0x16, 0x19, 0xe, 0x10, 0x1c, 0x3a, 0x29, 0x3b, 0x45, 0x35, 0x23, 0x17, 0x1d, 0x1c, 0x12, 0x7, 0x2, 0x29, 0x32, 0x30, 0x23, 0x2d, 0x1f, 0x2e, 0x34, 0x28, 0x2a, 0x10, 0x6f, 0x4f, 0x1e, 0x21, 0x20, 0x34, 0x3c, 0x48, 0x41, 0x32, 0x2c, 0x30, 0x18, 0x20, 0x21, 0x17, 0x15, 0x32, 0x71, 0x49, 0x35, 0xa, 0xb, 0xb, 0x15, 0x17, 0x2b, 0x11, 0x23, 0x2f, 0xc, 0x10, 0xa, 0x1d, 0x22, 0x30, 0x34, 0x16, 0xc, 0xe, 0x10, 0xc, 0x24, 0x20, 0x29, 0x39, 0x44, 0x3c, 0x25, 0x1e, 0x25, 0x11, 0x0, 0x1a, 0x24, 0x21, 0x1d, 0x18, 0x1e, 0x25, 0x11, 0x25, 0x49, 0x22, 0x28, 0x2e, 0x26, 0x16, 0x1d, 0x1f, 0x48, 0x36, 0x52, 0x37, 0x22, 0x41, 0x21, 0xc, 0x14, 0x18, 0x25, 0x31, 0x62, 0x4c, 0x36, 0xd, 0x7, 0x12, 0xa, 0x16, 0x11, 0x14, 0xc, 0x25, 0xd, 0xc, 0x14, 0x1c, 0x1c, 0x22, 0x2f, 0x1e, 0x1a, 0x14, 0xf, 0x12, 0xc, 0xd, 0x15, 0x1b, 0x39, 0x68, 0x8e, 0x68, 0x3c, 0x1d, 0x0, 0x2e, 0x34, 0x20, 0x1b, 0x1e, 0x1b, 0x1f, 0x1f, 0x2e, 0x29, 0x30, 0x11, 0x33, 0x3b, 0x15, 0x14, 0x25, 0x31, 0x66, 0x43, 0x3d, 0x67, 0x23, 0x2e, 0x19, 0xc, 0xb, 0x11, 0x35, 0x2b, 0x4e, 0x29, 0xa, 0xd, 0x7, 0x9, 0xa, 0x18, 0x1d, 0x15, 0x6, 0x14, 0x25, 0xa, 0xf, 0x20, 0x21, 0xc, 0x24, 0x27, 0x1b, 0x1f, 0x20, 0x1c, 0x16, 0x17, 0x14, 0xe, 0x11, 0x16, 0x9, 0x18, 0x23, 0x0, 0xa, 0x1b, 0x1f, 0x15, 0x20, 0x22, 0x25, 0x10, 0x18, 0x28, 0x29, 0x1f, 0x3b, 0x2f, 0x3d, 0xe, 0x16, 0x1c, 0x2f, 0x35, 0x57, 0x56, 0x46, 0x19, 0x30, 0x15, 0x12, 0x8, 0x2b, 0x33, 0x1a, 0x37, 0xf, 0xd, 0xc, 0x5, 0xc, 0xe, 0x14, 0xd, 0xa, 0x11, 0x22, 0x14, 0x10, 0x17, 0xf, 0x28, 0x22, 0x22, 0x21, 0x2c, 0x28, 0x20, 0x17, 0x1c, 0x13, 0x1b, 0x13, 0x17, 0xc, 0x3, 0x2, 0x6, 0x9, 0x17, 0x22, 0x20, 0x14, 0x22, 0x31, 0x1b, 0x16, 0x2f, 0x28, 0x1c, 0x1b, 0x3b, 0x3c, 0x3e, 0x12, 0xc, 0x25, 0x2c, 0x5c, 0x46, 0x2b, 0x3b, 0x1f, 0x30, 0x10, 0x10, 0x11, 0x11, 0x27, 0x7, 0x7, 0xc, 0x9, 0xf, 0xe, 0x9, 0xc, 0xd, 0xe, 0x11, 0xa, 0x15, 0x11, 0x11, 0x17, 0x17, 0x19, 0x16, 0x22, 0x1e, 0x2c, 0x37, 0x25, 0x1a, 0x12, 0x18, 0x11, 0x10, 0x14, 0x6, 0x0, 0xe, 0x14, 0x17, 0xe, 0x15, 0x14, 0x1e, 0x23, 0x2e, 0x9, 0xa, 0x14, 0x22, 0x18, 0x2a, 0x34, 0x22, 0x2e, 0x10, 0xa, 0x1f, 0x30, 0x77, 0x37, 0x30, 0x33, 0x17, 0x24, 0x26, 0x2b, 0x2c, 0xe, 0x11, 0x3, 0x5, 0xf, 0xf, 0xf, 0xe, 0xa, 0x15, 0xe, 0xe, 0x16, 0x9, 0xf, 0xd, 0x10, 0x10, 0xe, 0xf, 0x1a, 0x1e, 0x22, 0x20, 0x21, 0x1c, 0x1a, 0x1d, 0x24, 0x13, 0x13, 0x7, 0x0, 0x7, 0x1f, 0x19, 0x19, 0x1a, 0x15, 0xe, 0x16, 0x20, 0x1c, 0x19, 0x18, 0x1c, 0x26, 0x1e, 0x1b, 0x1d, 0x18, 0x29, 0x7, 0xc, 0x24, 0x2f, 0x6e, 0x3a, 0x38, 0x1e, 0x1f, 0x41, 0x32, 0x18, 0x18, 0x10, 0x5, 0x7, 0x9, 0xb, 0x11, 0x11, 0x11, 0xd, 0x18, 0x11, 0x15, 0xd, 0xc, 0xe, 0x1a, 0xd, 0x13, 0x18, 0x12, 0x1a, 0x1a, 0x25, 0x33, 0x1e, 0x1c, 0x19, 0x1c, 0x10, 0x17, 0x9, 0x0, 0x7, 0x10, 0x1f, 0x14, 0xa, 0x14, 0x1b, 0x14, 0x13, 0x26, 0xd, 0x1d, 0x12, 0x10, 0x18, 0x15, 0x1e, 0x1b, 0x19, 0x13, 0x9, 0x15, 0x1c, 0x2a, 0x4d, 0x2e, 0x28, 0x1c, 0x24, 0x37, 0x1e, 0x13, 0x1f, 0x9, 0x6, 0x4, 0x9, 0xa, 0x17, 0xf, 0x10, 0xc, 0xd, 0x11, 0x10, 0xe, 0x10, 0xa, 0x15, 0xe, 0xc, 0xc, 0x14, 0xf, 0x15, 0x27, 0x2b, 0x20, 0x1f, 0x24, 0x1e, 0x14, 0x6, 0x0, 0x2, 0x1c, 0x1c, 0x14, 0x15, 0x12, 0x11, 0x10, 0x20, 0x26, 0xd, 0x1d, 0x16, 0x13, 0x13, 0x23, 0x14, 0xf, 0x15, 0x15, 0x3, 0x18, 0x1c, 0x1c, 0x3e, 0x4c, 0x1d, 0x1d, 0x22, 0x1f, 0x21, 0x14, 0x12, 0xb, 0x6, 0x6, 0x6, 0xa, 0x6, 0x16, 0x1b, 0x9, 0xc, 0x9, 0xb, 0x10, 0xc, 0x12, 0xf, 0x12, 0x8, 0x11, 0xf, 0xd, 0x10, 0x14, 0x1a, 0x1b, 0x1c, 0x15, 0x20, 0x16, 0x4, 0x0, 0x4, 0x16, 0x1b, 0x19, 0xb, 0x10, 0xe, 0x11, 0x14, 0xb, 0x17, 0xc, 0x13, 0xc, 0xc, 0xe, 0x1b, 0x19, 0xe, 0x1b, 0xc, 0xa, 0x15, 0x15, 0x1f, 0x3b, 0x2b, 0x20, 0x27, 0x1b, 0x11, 0x10, 0x1e
beispiel_bild_width: .word 64
beispiel_bild_height: .word 64


#array: .word -1, 0, 78, 14, 9, 13, -18, 55, -8, 48, -11, 11
n:     .word 12


#
# main
#

.text
.globl main

main:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    #jal loadimg



    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

#########################################
