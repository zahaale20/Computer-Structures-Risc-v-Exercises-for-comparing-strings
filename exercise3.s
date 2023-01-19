# Alex Zaharia, Skyler Edwards
# Practice 1, Exercise 3
    
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

	#Function attack ( char password[], char dummy[] )
    attack: 				addi sp, sp, -4 #make space in stack to add return address
							sw ra, 0(sp)
                            
            				la a1 password
            				la a2 dummy
                                                
       loop6:               rdcycle t3 # calculate the number of cycles
                            jal ra string_compare
                            rdcycle t4 
                            sub t3 t4 t3 # number of cycles stored in t3
                            
                            lb t6 0(a2)
                            addi t1 t6 0 #store current letter in t1 in case t3 is the correct letter (has the most cycles)
                            addi t6 t6 1 # iterate to next letter
                            sb t6 0(a2) # store next letter back in dummy at same index
                            
                            rdcycle t3 # calculate the number of cycles
                            jal ra string_compare
                            rdcycle t4 
                            sub t5 t4 t3 # number of cycles stored in t5
                            
                            bgt t3 t5 next1 # if t3 (original letter) has a higher number of cycles than t5 (next letter), go to next1
                            beq t5 t3 loop6 # if t5 == t3, that means they have the same number of cycles and aren't the letters we are looking for, continue looping
                            
         next1:             sb t1 0(a2) #store original letter back into dummy at the correct index
                            j next2   
                            
         next2:			    addi a2 a2 1 #iterate to next index of password and dummy
          					addi a1 a1 1
          					lb t6 0(a2)
                            beqz t6 done
                            j loop6
                                             
         done:              lw ra 0(sp) #load in ra the return address stored in stack so we can use jr ra to go back to main
                            addi sp, sp, 4
                            jr ra
            
            



