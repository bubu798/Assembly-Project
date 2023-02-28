section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string


cpu_manufact_id:
	enter 	0, 0
	push 	edi
	push 	esi
	push 	ebx
	xor 	eax, eax ; eax = 0
	cpuid ; ofera informatii despre procesor in functie de valorile care se afla in eax si ecx
	mov 	eax, [ebp + 8]
	mov 	[eax], ebx 
	mov 	[eax + 4], edx
	mov 	[eax + 8], ecx 
	;mai sus am pus string ul in (ebx, edx, ecx)
	pop 	ebx
	pop		esi
	pop 	edi
	leave
	ret

;; void features(char *vmx, char *rdrand, char *avx)
;
;  checks whether vmx, rdrand and avx are supported by the cpu
;  if a feature is supported, 1 is written in the corresponding variable
;  0 is written otherwise
features:
	enter 	0, 0
	push 	edi
	push 	esi
	push 	ebx
	mov 	eax, 1
	cpuid ; ofera informatii despre procesor in functie de valorile care se afla in eax si ecx
	;CPUID_FEAT_ECX_VMX = 1 << 5
	push 	ecx
	shr 	ecx, 5
	and 	ecx, 1
	mov 	eax, [ebp + 8]
	mov 	[eax], ecx ;ECX = VMX
	pop 	ecx
	;CPUID_FEAT_ECX_RDRAND = 1 << 30
	push 	ecx
	shr 	ecx, 30
	and 	ecx, 1
	mov 	eax, [ebp + 12]
	mov 	[eax], ecx ;ECX = RDRAND
	pop 	ecx
	;CPUID_FEAT_ECX_AVX = 1 << 28
	push 	ecx
	shr 	ecx, 28
	and 	ecx, 1
	mov 	eax, [ebp + 16]
	mov 	[eax], ecx ; ECX = AVX
	pop 	ecx
	pop 	ebx
	pop		esi
	pop 	edi
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters

;cache size = (EBX[31:22] + 1) * (EBX[21:12] + 1) * (EBX[11:0] + 1)
l2_cache_info:
	enter 	0, 0
	push 	edi
	push 	esi	
	push 	ebx
	mov 	eax, 4
	mov 	ecx, 2
	cpuid ; ofera informatii despre procesor in functie de valorile care se afla in eax si ecx
	;line_size = (EBX[11:0] + 1)
	;mai jos voi face operatii pe biti pentru a obtine (EBX[11:0] + 1)
	mov 	edx, 1
	shl 	edx, 12
	dec 	edx
	and 	edx, ebx
	inc 	edx 
	mov 	eax, [ebp + 8]
	mov 	[eax], edx ;line_size = edx
	;(EBX[21:12] + 1)
	; shr 	ebx, 12
	; mov 	edx, 1
	; shl 	edx, 10
	; dec 	edx
	; and 	edx, ebx
	; inc 	edx
	;mai jos voi face shift right 22 pentru a obtine(EBX[31:22] + 1)
	shr 	ebx, 22
	inc 	ebx
	inc 	ecx
	;cache_size = (EBX[31:22] + 1) * (EBX[21:12] + 1) * (EBX[11:0] + 1) * (ECX + 1)
	mov 	eax, 1
	mul 	dx ; eax *= edx
	mul 	bx ; eax *= ebx
	mul 	ecx; eax *= ecx
	mov 	dx, 0 
	mov		bx, 1024
	div 	ebx ; eax /= ebx
	mov 	ecx, [ebp + 12]
	mov 	[ecx], eax ;cache_size  = eax
	pop 	ebx
	pop		esi
	pop 	edi
	leave
	ret
