section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	push 	ebp ;-|
	push    esp ;-|=> enter
    pop 	ebp ;-|

	push 	dword[ebp + 8]
	pop 	esi      ;str_lenght
	push 	dword[ebp + 12]
	pop 	ebx      ;str
	push 	0   ;return
	pop 	eax ;return
	push 	0   ;iteraor
	pop 	ecx ;iteraor
	push 	0	;decider
	pop 	edx ;decider

for:
	cmp 	ecx, esi
	jge		done
	cmp 	byte[ebx + ecx], 40
	je 		if1      ;if(str[iterator] == '(') ++decider;
	jmp 	if2 	 ;else if2


if1: 
	inc 	edx 	 ;++decider
	inc 	ecx 	 ;++iterator
	jmp 	for 	 ;if(iterator <= len) iterate for again

if2:
	cmp 	edx, 0
	je		return0  ;if(decider == 0) return 0;
	dec 	edx 	 ;--decider
	inc 	ecx 	 ;++iterator
	jmp		for 	 ;if(iterator <= len) iterate for again

return0:
	push 	0
	pop 	eax 	 ;return 0;
	jmp 	end

return1:
	push 	1  	 	 ;return 1;
	pop 	eax
	jmp 	end


done:
	cmp 	edx, 0
	je 		return1 ;if(decider == 0)return 1;
	jmp 	return0 ;else return 0;

end:
	push	ebp ;-|
	pop 	esp ;-|=> leave
	pop 	ebp ;-|
	ret
