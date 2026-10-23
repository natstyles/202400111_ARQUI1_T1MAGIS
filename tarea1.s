    .ifndef A_LO
    .set A_LO, 0x0000000000000000
    .endif
    .ifndef A_HI
    .set A_HI, 0x0000000000000001
    .endif
    .ifndef B_LO
    .set B_LO, 0xFFFFFFFFFFFFFFFF
    .endif
    .ifndef B_HI
    .set B_HI, 0x0000000000000000
    .endif

    .text
    .global _start
    .global fin_cmp

_start:
    ldr     x0, =A_LO
    ldr     x1, =A_HI
    ldr     x2, =B_LO
    ldr     x3, =B_HI

    subs    x4, x0, x2
    sbcs    x5, x1, x3

    mrs     x6, nzcv
    bic     x6, x6, #(1 << 30)
    orr     x7, x4, x5
    cmp     x7, #0
    cset    x8, eq
    orr     x6, x6, x8, lsl #30
    msr     nzcv, x6

fin_cmp:
    mov     x9, #1
    mov     x10, #2
    csel    x0, x9, x10, lt
    csel    x0, xzr, x0, eq

    mov     x8, #93
    svc     #0
