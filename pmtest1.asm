; ==========================================
; pmtest1.asm
<<<<<<< HEAD
; ���뷽����nasm pmtest1.asm -o pmtest1.bin
; ==========================================

%include	"pm.inc"	; ����, ��, �Լ�һЩ˵��

org	07c00h
=======
; ±àÒë·½·¨£ºnasm pmtest1.asm -o pmtest1.bin
; ==========================================

%include	"pm.inc"	; ³£Á¿, ºê, ÒÔ¼°Ò»Ð©ËµÃ÷

org	0100h
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
	jmp	LABEL_BEGIN

[SECTION .gdt]
; GDT
<<<<<<< HEAD
;                              �λ�ַ,       �ν���     , ����
LABEL_GDT:	   Descriptor       0,                0, 0           ; ��������
LABEL_DESC_CODE32: Descriptor       0, SegCode32Len - 1, DA_C + DA_32; ��һ�´����
LABEL_DESC_VIDEO:  Descriptor 0B8000h,           0ffffh, DA_DRW	     ; �Դ��׵�ַ
; GDT ����

GdtLen		equ	$ - LABEL_GDT	; GDT����
GdtPtr		dw	GdtLen - 1	; GDT����
		dd	0		; GDT����ַ

; GDT ѡ����
=======
;                              ¶Î»ùÖ·,       ¶Î½çÏÞ     , ÊôÐÔ
LABEL_GDT:	   Descriptor       0,                0, 0           ; ¿ÕÃèÊö·û
LABEL_DESC_CODE32: Descriptor       0, SegCode32Len - 1, DA_C + DA_32; ·ÇÒ»ÖÂ´úÂë¶Î
LABEL_DESC_VIDEO:  Descriptor 0B8000h,           0ffffh, DA_DRW	     ; ÏÔ´æÊ×µØÖ·
; GDT ½áÊø

GdtLen		equ	$ - LABEL_GDT	; GDT³¤¶È
GdtPtr		dw	GdtLen - 1	; GDT½çÏÞ
		dd	0		; GDT»ùµØÖ·sdsssssjjjjsafdsdf篇经验ssss

; GDT Ñ¡Ôñ×Ó
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
SelectorCode32		equ	LABEL_DESC_CODE32	- LABEL_GDT
SelectorVideo		equ	LABEL_DESC_VIDEO	- LABEL_GDT
; END of [SECTION .gdt]

[SECTION .s16]
[BITS	16]
LABEL_BEGIN:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	ss, ax
	mov	sp, 0100h

<<<<<<< HEAD
	; ��ʼ�� 32 λ�����������
=======
	; ³õÊ¼»¯ 32 Î»´úÂë¶ÎÃèÊö·û
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
	xor	eax, eax
	mov	ax, cs
	shl	eax, 4
	add	eax, LABEL_SEG_CODE32
	mov	word [LABEL_DESC_CODE32 + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_CODE32 + 4], al
	mov	byte [LABEL_DESC_CODE32 + 7], ah

<<<<<<< HEAD
	; Ϊ���� GDTR ��׼��
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_GDT		; eax <- gdt ����ַ
	mov	dword [GdtPtr + 2], eax	; [GdtPtr + 2] <- gdt ����ַ

	; ���� GDTR
	lgdt	[GdtPtr]

	; ���ж�
	cli

	; �򿪵�ַ��A20
=======
	; Îª¼ÓÔØ GDTR ×÷×¼±¸
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_GDT		; eax <- gdt »ùµØÖ·
	mov	dword [GdtPtr + 2], eax	; [GdtPtr + 2] <- gdt »ùµØÖ·

	; ¼ÓÔØ GDTR
	lgdt	[GdtPtr]

	; ¹ØÖÐ¶Ï
	cli

	; ´ò¿ªµØÖ·ÏßA20
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
	in	al, 92h
	or	al, 00000010b
	out	92h, al

<<<<<<< HEAD
	; ׼���л�������ģʽ
=======
	; ×¼±¸ÇÐ»»µ½±£»¤Ä£Ê½
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
	mov	eax, cr0
	or	eax, 1
	mov	cr0, eax

<<<<<<< HEAD
	; �������뱣��ģʽ
	jmp	dword SelectorCode32:0	; ִ����һ���� SelectorCode32 װ�� cs,
					; ����ת�� Code32Selector:0  ��
; END of [SECTION .s16]


[SECTION .s32]; 32 λ�����. ��ʵģʽ����.
=======
	; ÕæÕý½øÈë±£»¤Ä£Ê½
	jmp	dword SelectorCode32:0	; Ö´ÐÐÕâÒ»¾ä»á°Ñ SelectorCode32 ×°Èë cs,
					; ²¢Ìø×ªµ½ Code32Selector:0  ´¦
; END of [SECTION .s16]


[SECTION .s32]; 32 Î»´úÂë¶Î. ÓÉÊµÄ£Ê½ÌøÈë.
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
[BITS	32]

LABEL_SEG_CODE32:
	mov	ax, SelectorVideo
<<<<<<< HEAD
	mov	gs, ax			; ��Ƶ��ѡ����(Ŀ��)

	mov	edi, (80 * 11 + 79) * 2	; ��Ļ�� 11 ��, �� 79 �С�
	mov	ah, 0Ch			; 0000: �ڵ�    1100: ����
	mov	al, 'P'
	mov	[gs:edi], ax

	; ����ֹͣ
=======
	mov	gs, ax			; ÊÓÆµ¶ÎÑ¡Ôñ×Ó(Ä¿µÄ)

	mov	edi, (80 * 11 + 79) * 2	; ÆÁÄ»µÚ 11 ÐÐ, µÚ 79 ÁÐ¡£
	mov	ah, 0Ch			; 0000: ºÚµ×    1100: ºì×Ö
	mov	al, 'P'
	mov	[gs:edi], ax

	; µ½´ËÍ£Ö¹
>>>>>>> 2ee49122d5ab24fd479852a2b1bc7bd7ac65e138
	jmp	$

SegCode32Len	equ	$ - LABEL_SEG_CODE32
; END of [SECTION .s32]

