PrintEmotionBubble: ; 17c47 (5:7c47)
	ld a, [$cd50]
	ld c, a
	ld b, $0
	ld hl, EmotionBubblesPointerTable ; $7caf
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $8f80
	ld bc, (BANK(EmotionBubblesPointerTable) << 8) + $04
	call CopyVideoData
	ld a, [$cfcb]
	push af
	ld a, $ff
	ld [$cfcb], a
	ld a, [$d736]
	bit 6, a
	ld hl, $c38f
	ld de, $c39f
	jr z, .asm_17c7a
	ld hl, $c37f
	ld de, $c38f
.asm_17c7a
	ld bc, $90
.asm_17c7d
	ld a, [hl]
	ld [de], a
	dec hl
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .asm_17c7d
	ld hl, $c104
	ld a, [$cd4f]
	swap a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hli]
	ld b, a
	inc hl
	ld a, [hl]
	add $8
	ld c, a
	ld de, EmotionBubblesOAM ; $7cb5
	xor a
	call WriteOAMBlock
	ld c, $3c
	call DelayFrames
	pop af
	ld [$cfcb], a
	call DelayFrame
	jp UpdateSprites

EmotionBubblesPointerTable: ; 17caf (5:7caf)
	dw EmotionBubbles
	dw EmotionBubbles + $40
	dw EmotionBubbles + $80

EmotionBubblesOAM: ; 17cb5 (5:7cb5)
	db $F8,$00,$F9,$00
	db $FA,$00,$FB,$00

EmotionBubbles: ; 17cbd (5:7cbd)
	INCBIN "gfx/emotion_bubbles.w16.2bpp"