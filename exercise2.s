# Alex Zaharia, Skyler Edwards
# Practice 1, Exercise 2
    
.text 
	#Function string_compare ( char A[], char B[] )    		
    string_compare:			li t0 0
                            
                            beq a1 t0 error #if no address is inputted into a1 or a2, jump to error, which returns -1
                            beq a2 t0 error
                            
    						lb t1 0(a1) #load first characters of the strings into t3 and t4 using addresses of strings stored in t1 and t2
    						lb t2 0(a2)
                            
            #Start of Loop to iterate through the strings, one address at a time                
            loop:			bne t1 t2 different	#if first characters are different jump to 'different' label, which returns 0
                            beqz t1 same #if we reach the end of the string, it jumps to 'same' label, which returns 1, indicating the strings are the same
            				                          
    						addi a1 a1 1 #Add 1 to the addresses of the strings to move to the next letter
            				addi a2 a2 1
                            lb t1 0(a1) #load letters into registers t3 and t4
    						lb t2 0(a2)
            				j loop  #continue loop
    			
              same:			li a0 1 #return 1 into a0(strings are the same)
              				jr ra  
                
              different: 	li a0 0 #return 0 into a0(strings are different)
              				jr ra
                            
              error:		li a0 -1 #return -1 into a0(there is an error)
              				jr ra
                            
    #Function study_energy (char password[]) 
    study_energy:			addi sp, sp, -4 #make space in stack to add return address
							sw ra, 0(sp)
                            
                            la a1 password
            				la a2 strC
                            
    	loop2:				li a7 4 #print "letter: number of cycles".... ex: "a: 14"
                            la a0 strC
                            ecall
                            li a7 4
                            la a0 text
                            ecall
                            
                            rdcycle t3 # the cycles executed up to now are stored in t0
                            jal ra string_compare  # jump to string_compare
                            rdcycle t4 # get cycles executed so far
                            sub t3 t4 t3 # t0: number of cycles consumed                                          
                           
                            mv a0 t3# print the number of cycles executed
                            li a7 1
                            ecall
                            
                            la a0, newline #Prints a new line
							li a7, 4
							ecall
                            
                            la a6 strC	# iterate through alphabet starting with a
                            lb t6 0(a6)
                            addi t6 t6 1
                            sb t6 0(a6)
                            la a5 iter
                            lb t5 0(a5)
                            
                            bne t6 t5 loop2 # if t6(a letter) is not equal to t5(letter '{' --> letter after z), then go to loop2
                            
                            lw ra 0(sp) #load in ra the return address stored in stack so we can use jr ra to go back to main
                            addi sp, sp, 4
                            jr ra			
            
            



