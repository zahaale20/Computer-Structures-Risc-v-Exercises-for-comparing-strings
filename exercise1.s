# Alex Zaharia, Skyler Edwards
# Practice 1, Exercise 1
    
.text 
	#Function string_compare ( char A[], char B[] )    		
    string_compare:			li t0 0
    						la a1 strA
                            la a2 strB
                            
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
              				jr ra`
            
            
