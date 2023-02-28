section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	push 	ebp ;-|
	push    esp ;-|=> enter
    pop 	ebp ;-|
	

    push 	dword[ebp + 8]
	pop 	eax ;a
	push 	dword[ebp + 12]
	pop 	ebx ;b
	push 	eax
	pop		ecx ;x = ecx = eax = a
	push	ebx 
	pop 	edx ;y = edx = ebx = b ; egalam input-urile cu alte 2 variabile pentru a le salva

again: ;while
	cmp 	ecx, edx ;compara x si y
	ja 		if1 ;if(x>y)
	jmp 	if2 ;else
			
if1:
	sub 	ecx, edx ;x -= y
	cmp 	edx, 0 ;comapra y cu 0
	je 		done ;daca y = 0 iese din while
	jmp 	again ;intra din nou in while

if2:	
	sub 	edx, ecx ;y -= x
	cmp 	edx, 0 ;compara y cu 0
	je 		done ;daca y = 0 iese din while
	jmp 	again ;intra din nou in while

done:
	mul 	ebx ; eax = eax * ebx sau a *= b
	div 	ecx ; eax = eax / ecx sau a /= x (x este cmmdc, iar cmmmc = a*b/cmmdc)

	
	push	ebp ;-|
	pop 	esp ;-|=> leave
	pop 	ebp ;-|
	ret
