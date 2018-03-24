BasicUpstart2(start)

.var music = LoadSid("~/ka/m/MUSICIANS/D/Dalton/Game.sid")

*=music.location "SID file"

.label music_init =*                    // <- You can define label with any value (not just at the current pc position as in 'music_init:')
.label music_play =*+3                  // <- and that is useful here

.fill music.size, music.getData(i)

* = $4000 "Code"

start:

lda #$00
sta $d020
sta $d021

lda #$00
sta $0286

lda #$93
jsr $ffd2

lda #$00
jsr music_init


ldx #$00

screen1o:

lda $1000,x
sta $0400,x
lda $1000+$100,x
sta $0500,x
lda $1000+$200,x
sta $0600,x
lda $1000+$248,x
sta $0648,x
inx
bne screen1o


ldx #$00
statusset:
lda status,x
sta $0770,x
lda #$01
sta $db70,x
inx
cpx #$28
bne statusset


sei
lda #$35
sta $01
lda #<irq1
sta $fffe
lda #>irq1
sta $ffff
lda #$81
sta $d01a
lda #$7f
sta $dc0d
sta $dd0d
lda $dc0d
lda $dd0d
lda #$ff
sta $d019
cli
jmp *

irq1:

pha
txa
pha
tya
pha
lda #$ff
sta $d019

lda #$00
cmp $d012
bne *-3
sranje:
lda #$00
sta $d020


lda #$31
cmp $d012
bne *-3
lda #$0b
sta $d020
sta $d021
ldy #$0b
dey
bne *-1
lda #$00
sta $d020
sta $d021

lda #$18
sta $d018
lda #$d8
sta $d016

lda #$0b
sta $d022
lda #$03
sta $d023


// --------------------------------------------------------------------
// BLOK 2
// --------------------------------------------------------------------

lda #$a0
cmp $d012
bne *-3
lda #$0b
sta $d020
sta $d021
ldy #$0b
dey
bne *-1
lda #$00
sta $d020
sta $d021



// --------------------------------------------------------------------
// BLOK 4 TEXT
// --------------------------------------------------------------------

lda #$e2
cmp $d012
bne *-3

lda #$00
sta $d020

lda #$15
sta $d018
lda #$08
sta $d016

// mute
// jsr music_play

pla
tay
pla
tax
pla
rti


status:
//.text"1234567890123456789012345678901234567890"
.text  "             presents                   "
