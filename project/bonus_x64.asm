section .text
	global intertwine

;; void intertwine(int *v1, int n1, int *v2, int n2, int *v);
;
;  Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2,
;  and intertwine them
;  The resulting array is stored in v
;v1 = rdi ,  n1 = rsi, v2 = rdx, n2 = rcx, v = r8 , r9, rax
intertwine:
	enter 0, 0
	mov 	rax, 0 					;aux = 0
	mov 	r9, 0 					;j = 0
	mov     rbx, 0 					;i = 0
	mov 	r13, 0 					;aux2 = 0


if: 								;this if decides which vector has more elements
	cmp 	rsi, rcx
	jg 		if1 					;if(n1>n2) -> if1
	jmp 	if2 					;else -> if2

if1:
	mov 	rax, rsi				;aux = n1
	jmp 	for

if2:
	mov 	rax, rcx				;aux = n2
	jmp 	for

for: 								;for(int i = 0; i < aux; ++i)
	cmp 	rbx, rax
	jge 	end 					;when i >= aux gets out of for
	cmp 	rbx, rsi
	jge 	if3 					;if(i >= n1) -> if3
	jmp 	else3 					;else -> if3

if3:
	mov 	r13, [rdx + rbx * 4]   	
	mov 	[r8 + r9 * 4], r13		;v[j] = v2[i]
	inc 	r9 						;++j
	inc 	rbx						;++i
	jmp 	for						;iterate for again

else3:
	cmp 	rbx, rcx
	jge 	else3_1 				;if(i>=n2) -> else3_1
	jmp 	else3_2	 				;else -> else3_2

else3_1:	
	mov 	r13, [rdi + rbx * 4]
	mov 	[r8 + r9 * 4], r13 		;v[j] = v1[i]
	inc 	r9 						;++j
	inc 	rbx						;++i
	jmp 	for						;iterate for again

else3_2:
	mov 	r13, [rdi + rbx * 4]   	
	mov 	[r8 + r9 * 4], r13		;v[j] = v1[i]
	inc 	r9 						;++j
	mov 	r13, [rdx + rbx * 4]   	
	mov 	[r8 + r9 * 4], r13		;v[j] = v2[i]
	inc 	r9 						;++j
	inc 	rbx						;++i
	jmp 	for						;iterate for again


end:
	leave
	ret
