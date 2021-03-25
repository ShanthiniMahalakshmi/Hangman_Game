INCLUDE EMU8086.INC
                              

org 100h

JMP code

    msg db "Welcome to the game$"
    msg1 db "Enter your name : $"
    msg2 db "Type a letter: $"
    newline db 13, 10, "$"
    msg3 db "CONGRAGULATIONS!!! YOU WON THE GAME$"
    msg4 db "SORRY.YOU LOSE THE GAME $" 
    msg5 db "HANGMAN GAME$"      
    msg6 db "RULES AND INSTRUCTIONS : $"  
    hint1 db "HINT : A MAMMAL$"
    hint2 db "HINT : LOUD SOUND OR NOISE$"  
    hint3 db "HINT : INSTRUMENT USED FOR MURDER$"        
    word1 db "MONKEY$" 
    word2 db "SQUAWK$"
    word3 db "THUMBSCREW$"
    rule4 db "-> IF YOU SOLVE ALL THE 3 WORDS THEN YOU WILL BE PROMOTED TO NEXT LEVEL.$"
    rule1 db " -> THIS IS BASED ON HUMAN STRATEGY.$"
    rule2 db " -> THERE ARE 3 LEVELS OF DIFFICULTY.$"
    rule3 db " -> EACH LEVEL HAS ONE WORD.$" 
    level db "   LEVEL OF DIFFICULTY :$"
    lev1 db "     1. EASY $ "
    lev2 db "     2. MEDIUM $ "
    lev3 db "     3. HARD $ "
    choose db "  CHOOSE YOUR DIFFICULTY : $"
   
    word db 6 dup("-"), "$"
    dash db 10 dup("-"), "$"
    size1 db 6  
    size2 db 10
    lives db 3
    chances db 3                   
    hits db 0 
    hits2 db 0
    hits3 db 0
    errors db 0
    errors2 db 0                                                                    
    errors3 db 0  
    w equ 10
    h equ 5
    q equ 15
    b equ 1 
    a db 0

code: 

main proc 
    
    
    lea     dx,  msg
    call    print    
   
    
    lea     dx, newline
    call    print  
    
          
    lea     dx, newline
    call    print  
    lea     dx,  msg1
    call    print 
    
    mov ah,0AH
    int 21h                                                                                                
    
    
    lea     dx, newline
    call    print  
    call    print

    lea     dx,  msg5
    call    print    
  
    lea     dx, newline
    call    print  
    call    print 
    
    lea     dx,  msg6
    call    print    
  
    lea     dx, newline
    call    print  
    call    print 

    
    ;lea     dx,  msg7
    ;call    print
    
     lea     dx, rule1
     call    print
     
     lea     dx, newline
     call    print  
     call    print 

     lea     dx, rule2
     call    print    
     
     lea     dx, newline
     call    print  
     call    print 

     lea     dx, rule3
     call    print    

     
     lea     dx, newline
     call    print  
     call    print 

     ;lea     dx, rule4
     ;call    print    
                                         
     lea     dx, level
     call    print
     
     lea     dx, newline
     call    print
     call    print
     
    
     lea     dx, lev1
     call    print
     
     lea     dx, newline
     call    print
     call    print
    
    
     lea     dx, lev2
     call    print
    
     lea     dx, newline
     call    print
     call    print
     
        
     lea     dx, lev3
     call    print
    
     lea     dx, newline
     call    print
     call    print
      
    
    
     lea     dx, choose
     call    print
    
     lea     dx, newline
     call    print
     call    print
    
    
    MOV AH,01H
    INT 21H
    
    
    SUB AL,30H 
    ;mov cl,al
    mov a,al
    
    call    clear_screen
                       
           
mainloop:               
           
    
    
    lea     dx, newline
    call    print  
    call    print
    
    
    lea     dx,  msg5
    call    print    
  
    lea     dx, newline
    call    print  
    call    print  
    
    
    mov cl,a
               
    cmp cl,3
    JE dash1
    lea     dx, word
    call    print  
    
    jmp P
  dash1:
    
    lea     dx, dash
    call    print  
  
  P:
    lea     dx, newline
    call    print    
    call    print
    
    cmp cl,3
     JE level3
    ;mov bl,cl
    ;mov ah,02h
    ;int 21h
    cmp cl,2 
     JE level2
    
   mov cl,3
   
    lea     dx,  hint1
    call    print    
                 
    lea     dx, newline
    call    print  
    call    print
    call    chk
    
    lea     dx, newline
    call    print    
    call    print

    lea     dx,  msg2
    call    print
        
    call    input  
    call    update 
    
    call    clear_screen 
    
    jmp end1
    
    level2:
    
    lea     dx,  hint2
    call    print    
     
    call    chk2
    
    lea     dx, newline
    call    print    
    call    print

    lea     dx,  msg2
    call    print
        
    call    input  
    call    update2 
    
    call    clear_screen
    
    jmp end1 
    
    level3:
    
    lea     dx,  hint3
    call    print    
                 
    lea     dx, newline
    call    print  
    call    print     
    call    chk3
    
    lea     dx, newline
    call    print    
    call    print

    lea     dx,  msg2
    call    print
        
    call    input  
    call    update3 
    
    call    clear_screen
    
    jmp end1     

end1:    
  loop    mainloop 
          

print:
    mov     ah, 9
    int     21h
    ret

                           
chk:  ;check                   
    
    
    
    mov     bl, lives
    mov     bh, errors
    cmp     bl, bh
    je      game_over
    
    mov     bl, size1
    mov     bh, hits
    cmp     bl, bh
    je      gamewin
    
    ret          
    
          
update:  
    lea     si, word1
   
    lea     di, word     
    mov     bx, 0
        
    updateloop:
    cmp     byte ptr [si], "$"
    je      endword
    
  
    cmp     [di], al                ;ALREADY GUESSED 
    je      increment
    
      
    cmp     [si], al    
    je      equals
                 
    increment:
    inc     si
    inc     di   
    
    jmp     updateloop 
      
                 
    equals:
    mov     [di], al
    inc     hits
    mov     bx, 1
    ;PRINTN
    ;PRINTN
    lea     dx, newline
    call    print  

    PRINT "CORRECT GUESS"
    jmp     increment 
                
    
    endword:  
    cmp     bx, 1
    je      endupdate
    dec     chances
    inc     errors
    
    lea     dx, newline
    call    print  
    
    
    lea     dx, newline
    call    print  
         
    PRINT "WRONG GUESS"  
    
    mov ah, 0
    mov al, 13h 
    int 10h
        
    cmp errors,3
    JE E3
    cmp errors,2
    JE E2
    
    ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u3: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u3 
    
    jmp endupdate
    
    E2:
    
    ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u15: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u15 

    ; draw upper line:
    
    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u1
    
    jmp endupdate
    
    E3:  
    
     ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u16: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u16 

    ; draw upper line:
    
    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u17: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u17

    
    ; draw right line:                

    mov cx, 150+w  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u4: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u4     



; head:
 
    mov cx, 150+q  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u2: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u2

    mov cx, 150+q  ; column
    mov dx, 50+9   ; row
    mov al, 15     ; white
u5: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u5 
    
    
    mov cx, 150+q  ; column
    mov dx, 50+7   ; row
    mov al, 15     ; white
u6: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u6

    mov cx, 150+q  ; column
    mov dx, 50+11   ; row
    mov al, 15     ; white
u7: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u7
    
    mov cx, 150+q  ; column
    mov dx, 50+13   ; row
    mov al, 15     ; white
u8: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u8


; body of the hanging man                

    mov cx, 150+w  ; column
    mov dx, 83   ; row
    mov al, 15     ; white
u9: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 65
    ja u9

;leg join    
    mov cx, 150+q  ; column
    mov dx, 78+h   ; row
    mov al, 15     ; white
u10: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u10     

;left leg  
    mov cx, 150    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u11: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u11 

;right leg
    mov cx, 150+q    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u12: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u12 

;left hand  
    mov cx, 160    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u13: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 150
    ja u13 

;right hand  
    mov cx, 165    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u14: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 157
    ja u14 
    
    endupdate:  
    
    ret
    
    
chk2:  ;check for level 2                   
    
    
    
    mov     bl, lives
    mov     bh, errors2
    cmp     bl, bh
    je      game_over
    
    mov     bl, size1
    mov     bh, hits2
    cmp     bl, bh
    je      gamewin
    
    ret          
    
          
update2:  
    lea     si, word2
   
    lea     di, word     
    mov     bx, 0
        
    updateloop2:
    cmp     byte ptr [si], "$"
    je      endword2
    
  
    cmp     [di],al    ;ALREADY GUESSED 
    je      increment2
    
      
    cmp     [si],al    
    je      equals2
                 
    increment2:       
    inc     si
    inc     di   
    
    jmp     updateloop2 
      
                 
    equals2:
    mov     [di], al
    inc     hits2
    mov     bx, 1
    ;PRINTN
    ;PRINTN
    lea     dx, newline
    call    print  

    PRINT "CORRECT GUESS"
    jmp     increment 
                
    
    endword2:  
    cmp     bx, 1
    je      endupdate2
    dec     chances
    inc     errors2
    
    lea     dx, newline
    call    print  
    
    
    lea     dx, newline
    call    print  
         
    PRINT "WRONG GUESS"
    
    mov ah, 0
    mov al, 13h 
    int 10h
        
    cmp errors2,3
    JE E5
    cmp errors2,2
    JE E4
    
    ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u33: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u33 
    
    jmp endupdate2
    
    E4:
    
    ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u45: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u45 

    ; draw upper line:

    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u46: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u46
    
    jmp endupdate2
    
    E5:  
    
        ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u47: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u47 

    ; draw upper line:

    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u48: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u48

    
    ; draw right line:                

    mov cx, 150+w  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u34: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u34     



; head:
 
    mov cx, 150+q  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u32: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u32

    mov cx, 150+q  ; column
    mov dx, 50+9   ; row
    mov al, 15     ; white
u35: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u35 
    
    
    mov cx, 150+q  ; column
    mov dx, 50+7   ; row
    mov al, 15     ; white
u36: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u36

    mov cx, 150+q  ; column
    mov dx, 50+11   ; row
    mov al, 15     ; white
u37: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u37
    
    mov cx, 150+q  ; column
    mov dx, 50+13   ; row
    mov al, 15     ; white
u38: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u38


; body of the hanging man                

    mov cx, 150+w  ; column
    mov dx, 83   ; row
    mov al, 15     ; white
u39: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 65
    ja u39

;leg join    
    mov cx, 150+q  ; column
    mov dx, 78+h   ; row
    mov al, 15     ; white
u40: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u40     

;left leg  
    mov cx, 150    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u41: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u41 

;right leg
    mov cx, 150+q    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u42: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u42 

;left hand  
    mov cx, 160    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u43: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 150
    ja u43 

;right hand  
    mov cx, 165    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u44: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 157
    ja u44 

    
    endupdate2:
    
    ret 



chk3:  ;check                   
    
    
    
    mov     bl, lives
    mov     bh, errors3
    cmp     bl, bh
    je      game_over
    
    mov     bl, size2
    mov     bh, hits3
    cmp     bl, bh
    je      gamewin
    
    ret          
    
          
update3:  
    lea     si, word3
   
    lea     di, dash     
    mov     bx, 0
        
    updateloop3:
    cmp     byte ptr [si], "$"
    je      endword3
    
  
    cmp     [di], al    ;ALREADY GUESSED 
    je      increment3
    
      
    cmp     [si], al    
    je      equals3
                 
    increment3:       
    inc     si
    inc     di   
    
    jmp     updateloop3 
      
                 
    equals3:
    mov     [di], al
    inc     hits3
    mov     bx, 1
    ;PRINTN
    ;PRINTN
    lea     dx, newline
    call    print  

    PRINT "CORRECT GUESS"
    jmp     increment3 
                
    
    endword3:  
    cmp     bx, 1
    je      endupdate3
    dec     chances
    inc     errors3
    
    lea     dx, newline
    call    print  
    
    
    lea     dx, newline
    call    print  
         
    PRINT "WRONG GUESS"
     
    mov ah, 0
    mov al, 13h 
    int 10h
        
    cmp errors3,3
    JE E7
    cmp errors3,2
    JE E6
    
    ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u53: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u53 
    
    jmp endupdate3
    
    E6:
    ; draw upper line:
     ; draw left line:

    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u70: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u70 
    
    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u51: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u51
    
    jmp endupdate3
    
    E7:  
    
    mov cx, 100    ; column
    mov dx, 150+h   ; row
    mov al, 15     ; white
u71: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u71 
    
    mov cx, 150+w  ; column
    mov dx, 20     ; row
    mov al, 15     ; white
u72: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 100
    jae u72

    ; draw right line:                

    mov cx, 150+w  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u54: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 20
    ja u54     



; head:
 
    mov cx, 150+q  ; column
    mov dx, 50+h   ; row
    mov al, 15     ; white
u52: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u52

    mov cx, 150+q  ; column
    mov dx, 50+9   ; row
    mov al, 15     ; white
u55: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u55 
    
    
    mov cx, 150+q  ; column
    mov dx, 50+7   ; row
    mov al, 15     ; white
u56: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u56

    mov cx, 150+q  ; column
    mov dx, 50+11   ; row
    mov al, 15     ; white
u57: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u57
    
    mov cx, 150+q  ; column
    mov dx, 50+13   ; row
    mov al, 15     ; white
u58: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u58


; body of the hanging man                

    mov cx, 150+w  ; column
    mov dx, 83   ; row
    mov al, 15     ; white
u59: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 65
    ja u59

;leg join    
    mov cx, 150+q  ; column
    mov dx, 78+h   ; row
    mov al, 15     ; white
u60: mov ah, 0ch    ; put pixel
    int 10h
    dec cx
    cmp cx, 150
    ja u60     

;left leg  
    mov cx, 150    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u61: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u61 

;right leg
    mov cx, 150+q    ; column
    mov dx, 83+h   ; row
    mov al, 15     ; white
u62: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 82
    ja u62 

;left hand  
    mov cx, 160    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u63: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 150
    ja u63 

;right hand  
    mov cx, 165    ; column
    mov dx, 73   ; row
    mov al, 15     ; white
u64: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 157
    ja u64 

     
    endupdate3:
    
    ret


       
game_over: 
   lea     dx, newline
   call    print 
   
   lea     dx,  msg4
   call    print
   
   lea     dx, newline
   call    print  
   
   mov cl,a
            
    cmp cl,3
     JE G3
    CMP CL,2
     JE G2
    
    PRINTN
    PRINT "THE WORD IS " 
    PRINTN 
    lea     dx, word1
    call    print  
    
    
    JMP end
    G2: 
      PRINTN   
      PRINT "THE WORD IS " 
      PRINTN
      
      lea     dx, word2
      call    print    
      
      JMP end
     G3:    
      PRINTN
      PRINT "THE WORD IS " 
      PRINTN
      
      lea     dx, word3
      call    print   
      jmp end

gamewin:
    lea     dx,  msg3
    call    print
    
    jmp     end
    
 
    
clear_screen:  
    mov     ah, 0fh
    int     10h   
    
    mov     ah, 0
    int     10h
    
    ret
  
    
input:  
     jmp progstart
text db 0,0,0,0,0,36
progstart:
mov si,offset text ; Move offset of string in data region into SI register
mov ah,02ch        ; Get current second         
int 021h
mov bh,dh          ; Store current second   
readloop:
mov ah,02ch      ; Call function 02C of INT 021 to get new time
int 021h
sub dh,05h         ; Subtract 05 from new second. Giving 5 Secs for input.
                        ; For if old second in BH=05 and new second in DH-5=1,
                        ; four more
                        ; seconds must pass.
cmp bh,dh                    
je endprog         ; Exit when DH is finally equal to BH.
                     ; Example BH=05 and DH - 05 = 05, then DH = 0F and 
                     ; 05 - 0F = Five Seconds
mov ah,06h          ; Function 06h of INT 021 will directly read from the Stdin/Stdout
mov dl,255           ; Move 0ff into the DL register to read from the keyboard
int 21h              
jz readloop           ; If the zero flag of the FLAGS register is set, no key was pressed.
                           ; And this conditional jump will change the offset of IP to the readloop
                           ; label if the zero flag is set, to read again.
;mov [si],al            ; If execution made it to here it will move the byte in AL into the offset
                           ; of the string in the data region
;inc si                    ; this will increment to the next byte of the string, to store the next
                           ; character
;mov bl,[si]            ; Check to see if the end of the string has been reached.
;cmp bl,024h
;je endprog            ; If so exit.
;jmp readloop
endprog:           
;mov bx,offset text ; This rest will print out the read in string.
;add bx,03h
;mov al,024h
;mov [bx],al
;mov dx,'w'
mov ah,0
mov dx,ax  
mov al,0
mov ah,02h
int 21h
ret

end:
   jmp     end   
    
    
    mov ah, 4ch
    int 21h

   

endp

end main 
