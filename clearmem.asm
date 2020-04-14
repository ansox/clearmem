  processor 6502

  seg code
  org $F000       ; define the code origin at $F000

Start:
  SEI         ; disable interrupts
  CLD         ; disable the BCD decimal math mode
  LDX #$FF    ; loads the X register with #$FF
  TXS         ; transfer X register to S(tack) register

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Clear the Zero Page region ($00 to $ff)
  ; Meaning the entire TIA register space also RAM
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDA #0      ; A = 0
  LDX #$FF    ; X = #$FF
  STA $FF     ; make sure $FF is zeroed before the loop starts 

MemLoop:
  DEX         ; x--
  STA $0,X    ; store zero at address $0 + X
  BNE MemLoop ; loop until X== 0 (z-flag set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; File ROM size to exactly 4k
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFFC
  .word Start ; reset vector at $FFFC (where program starts)
  .word Start ; interrupt vector at $FFFE (unused in VCS)