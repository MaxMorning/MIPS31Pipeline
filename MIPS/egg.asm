  400758:       27bdffb8        addiu   sp,sp,-72
  40075c:       afbe0044        sw      s8,68(sp)
  400760:       afb60040        sw      s6,64(sp)
  400764:       afb5003c        sw      s5,60(sp)
  400768:       afb40038        sw      s4,56(sp)
  40076c:       afb30034        sw      s3,52(sp)
  400770:       afb20030        sw      s2,48(sp)
  400774:       afb1002c        sw      s1,44(sp)
  400778:       afb00028        sw      s0,40(sp)
  40077c:       03a0f025        move    s8,sp
  400780:       3c088000        lui     t0,0x8000
  400784:       8d030000        lw      v1,0(t0)
  400788:       8d020004        lw      v0,4(t0)
  40078c:       20090000        addi    t1,zero,0
  400790:       00035880        sll     t3,v1,0x2
  400794:       00026080        sll     t4,v0,0x2
  400798:       218c0004        addi    t4,t4,4
  40079c:       216a0000        addi    t2,t3,0

004007a0 <COMPARE>:
  4007a0:       112b0008        beq     t1,t3,4007c4 <FINISH_ASM>
  4007a4:       00000000        nop
  4007a8:       00000000        nop
  4007ac:       ad2a0000        sw      t2,0(t1)
  4007b0:       25290004        addiu   t1,t1,4
  4007b4:       014c5021        addu    t2,t2,t4
  4007b8:       1000fff9        b       4007a0 <COMPARE>
  4007bc:       00000000        nop
  4007c0:       00000000        nop

004007c4 <FINISH_ASM>:
  4007c4:       afc30004        sw      v1,4(s8)
  4007c8:       afc20008        sw      v0,8(s8)
  4007cc:       afc0000c        sw      zero,12(s8)
  4007d0:       00008025        move    s0,zero
  4007d4:       10000008        b       4007f8 <FINISH_ASM+0x34>
  4007d8:       00000000        nop
  4007dc:       8fc2000c        lw      v0,12(s8)
  4007e0:       8c430000        lw      v1,0(v0)
  4007e4:       02001025        move    v0,s0
  4007e8:       00021080        sll     v0,v0,0x2
  4007ec:       00621021        addu    v0,v1,v0
  4007f0:       ac500000        sw      s0,0(v0)
  4007f4:       26100001        addiu   s0,s0,1
  4007f8:       8fc20008        lw      v0,8(s8)
  4007fc:       0050102a        slt     v0,v0,s0
  400800:       1040fff6        beqz    v0,4007dc <FINISH_ASM+0x18>
  400804:       00000000        nop
  400808:       00008025        move    s0,zero
  40080c:       10000008        b       400830 <FINISH_ASM+0x6c>
  400810:       00000000        nop
  400814:       02001025        move    v0,s0
  400818:       00021080        sll     v0,v0,0x2
  40081c:       8fc3000c        lw      v1,12(s8)
  400820:       00621021        addu    v0,v1,v0
  400824:       8c420000        lw      v0,0(v0)
  400828:       ac400000        sw      zero,0(v0)
  40082c:       26100001        addiu   s0,s0,1
  400830:       8fc20004        lw      v0,4(s8)
  400834:       0202102a        slt     v0,s0,v0
  400838:       1440fff6        bnez    v0,400814 <FINISH_ASM+0x50>
  40083c:       00000000        nop
  400840:       24110001        li      s1,1
  400844:       1000008c        b       400a78 <FINISH_ASM+0x2b4>
  400848:       00000000        nop
  40084c:       24100001        li      s0,1
  400850:       10000084        b       400a64 <FINISH_ASM+0x2a0>
  400854:       00000000        nop
  400858:       24120001        li      s2,1
  40085c:       02009825        move    s3,s0
  400860:       1000002c        b       400914 <FINISH_ASM+0x150>
  400864:       00000000        nop
  400868:       02531021        addu    v0,s2,s3
  40086c:       00021fc2        srl     v1,v0,0x1f
  400870:       00621021        addu    v0,v1,v0
  400874:       00021043        sra     v0,v0,0x1
  400878:       0040a025        move    s4,v0
  40087c:       02201825        move    v1,s1
  400880:       3c023fff        lui     v0,0x3fff
  400884:       3442ffff        ori     v0,v0,0xffff
  400888:       00621021        addu    v0,v1,v0
  40088c:       00021080        sll     v0,v0,0x2
  400890:       8fc3000c        lw      v1,12(s8)
  400894:       00621021        addu    v0,v1,v0
  400898:       8c430000        lw      v1,0(v0)
  40089c:       02802025        move    a0,s4
  4008a0:       3c023fff        lui     v0,0x3fff
  4008a4:       3442ffff        ori     v0,v0,0xffff
  4008a8:       00821021        addu    v0,a0,v0
  4008ac:       00021080        sll     v0,v0,0x2
  4008b0:       00621021        addu    v0,v1,v0
  4008b4:       8c560000        lw      s6,0(v0)
  4008b8:       02201025        move    v0,s1
  4008bc:       00021080        sll     v0,v0,0x2
  4008c0:       8fc3000c        lw      v1,12(s8)
  4008c4:       00621021        addu    v0,v1,v0
  4008c8:       8c430000        lw      v1,0(v0)
  4008cc:       02141023        subu    v0,s0,s4
  4008d0:       00021080        sll     v0,v0,0x2
  4008d4:       00621021        addu    v0,v1,v0
  4008d8:       8c550000        lw      s5,0(v0)
  4008dc:       02d5102a        slt     v0,s6,s5
  4008e0:       10400004        beqz    v0,4008f4 <FINISH_ASM+0x130>
  4008e4:       00000000        nop
  4008e8:       02809025        move    s2,s4
  4008ec:       10000009        b       400914 <FINISH_ASM+0x150>
  4008f0:       00000000        nop
  4008f4:       02b6102a        slt     v0,s5,s6
  4008f8:       10400004        beqz    v0,40090c <FINISH_ASM+0x148>
  4008fc:       00000000        nop
  400900:       02809825        move    s3,s4
  400904:       10000003        b       400914 <FINISH_ASM+0x150>
  400908:       00000000        nop
  40090c:       02809025        move    s2,s4
  400910:       02809825        move    s3,s4
  400914:       26420001        addiu   v0,s2,1
  400918:       0053102a        slt     v0,v0,s3
  40091c:       1440ffd2        bnez    v0,400868 <FINISH_ASM+0xa4>
  400920:       00000000        nop
  400924:       02201825        move    v1,s1
  400928:       3c023fff        lui     v0,0x3fff
  40092c:       3442ffff        ori     v0,v0,0xffff
  400930:       00621021        addu    v0,v1,v0
  400934:       00021080        sll     v0,v0,0x2
  400938:       8fc3000c        lw      v1,12(s8)
  40093c:       00621021        addu    v0,v1,v0
  400940:       8c430000        lw      v1,0(v0)
  400944:       02402025        move    a0,s2
  400948:       3c023fff        lui     v0,0x3fff
  40094c:       3442ffff        ori     v0,v0,0xffff
  400950:       00821021        addu    v0,a0,v0
  400954:       00021080        sll     v0,v0,0x2
  400958:       00621021        addu    v0,v1,v0
  40095c:       8c430000        lw      v1,0(v0)
  400960:       02201025        move    v0,s1
  400964:       00021080        sll     v0,v0,0x2
  400968:       8fc4000c        lw      a0,12(s8)
  40096c:       00821021        addu    v0,a0,v0
  400970:       8c440000        lw      a0,0(v0)
  400974:       02121023        subu    v0,s0,s2
  400978:       00021080        sll     v0,v0,0x2
  40097c:       00821021        addu    v0,a0,v0
  400980:       8c420000        lw      v0,0(v0)
  400984:       afc30020        sw      v1,32(s8)
  400988:       afc20024        sw      v0,36(s8)
  40098c:       8fc20024        lw      v0,36(s8)
  400990:       8fc40020        lw      a0,32(s8)
  400994:       8fc30020        lw      v1,32(s8)
  400998:       0082202a        slt     a0,a0,v0
  40099c:       0044180b        movn    v1,v0,a0
  4009a0:       02202025        move    a0,s1
  4009a4:       3c023fff        lui     v0,0x3fff
  4009a8:       3442ffff        ori     v0,v0,0xffff
  4009ac:       00821021        addu    v0,a0,v0
  4009b0:       00021080        sll     v0,v0,0x2
  4009b4:       8fc4000c        lw      a0,12(s8)
  4009b8:       00821021        addu    v0,a0,v0
  4009bc:       8c440000        lw      a0,0(v0)
  4009c0:       02602825        move    a1,s3
  4009c4:       3c023fff        lui     v0,0x3fff
  4009c8:       3442ffff        ori     v0,v0,0xffff
  4009cc:       00a21021        addu    v0,a1,v0
  4009d0:       00021080        sll     v0,v0,0x2
  4009d4:       00821021        addu    v0,a0,v0
  4009d8:       8c440000        lw      a0,0(v0)
  4009dc:       02201025        move    v0,s1
  4009e0:       00021080        sll     v0,v0,0x2
  4009e4:       8fc5000c        lw      a1,12(s8)
  4009e8:       00a21021        addu    v0,a1,v0
  4009ec:       8c450000        lw      a1,0(v0)
  4009f0:       02131023        subu    v0,s0,s3
  4009f4:       00021080        sll     v0,v0,0x2
  4009f8:       00a21021        addu    v0,a1,v0
  4009fc:       8c420000        lw      v0,0(v0)
  400a00:       afc40018        sw      a0,24(s8)
  400a04:       afc2001c        sw      v0,28(s8)
  400a08:       8fc2001c        lw      v0,28(s8)
  400a0c:       8fc50018        lw      a1,24(s8)
  400a10:       8fc40018        lw      a0,24(s8)
  400a14:       00a2282a        slt     a1,a1,v0
  400a18:       0085100a        movz    v0,a0,a1
  400a1c:       afc30010        sw      v1,16(s8)
  400a20:       afc20014        sw      v0,20(s8)
  400a24:       8fc20014        lw      v0,20(s8)
  400a28:       8fc40010        lw      a0,16(s8)
  400a2c:       8fc30010        lw      v1,16(s8)
  400a30:       0044202a        slt     a0,v0,a0
  400a34:       0044180b        movn    v1,v0,a0
  400a38:       02201025        move    v0,s1
  400a3c:       00021080        sll     v0,v0,0x2
  400a40:       8fc4000c        lw      a0,12(s8)
  400a44:       00821021        addu    v0,a0,v0
  400a48:       8c440000        lw      a0,0(v0)
  400a4c:       02001025        move    v0,s0
  400a50:       00021080        sll     v0,v0,0x2
  400a54:       00821021        addu    v0,a0,v0
  400a58:       24630001        addiu   v1,v1,1
  400a5c:       ac430000        sw      v1,0(v0)
  400a60:       26100001        addiu   s0,s0,1
  400a64:       8fc20008        lw      v0,8(s8)
  400a68:       0050102a        slt     v0,v0,s0
  400a6c:       1040ff7a        beqz    v0,400858 <FINISH_ASM+0x94>
  400a70:       00000000        nop
  400a74:       26310001        addiu   s1,s1,1
  400a78:       8fc20004        lw      v0,4(s8)
  400a7c:       0222102a        slt     v0,s1,v0
  400a80:       1440ff72        bnez    v0,40084c <FINISH_ASM+0x88>
  400a84:       00000000        nop
  400a88:       8fc30004        lw      v1,4(s8)
  400a8c:       3c023fff        lui     v0,0x3fff
  400a90:       3442ffff        ori     v0,v0,0xffff
  400a94:       00621021        addu    v0,v1,v0
  400a98:       00021080        sll     v0,v0,0x2
  400a9c:       8fc3000c        lw      v1,12(s8)
  400aa0:       00621021        addu    v0,v1,v0
  400aa4:       8c430000        lw      v1,0(v0)
  400aa8:       8fc20008        lw      v0,8(s8)
  400aac:       00021080        sll     v0,v0,0x2
  400ab0:       00621021        addu    v0,v1,v0
  400ab4:       8c420000        lw      v0,0(v0)
  400ab8:       3c088000        lui     t0,0x8000
  400abc:       ad020008        sw      v0,8(t0)
  400ac0:       00001025        move    v0,zero
  400ac4:       03c0e825        move    sp,s8
  400ac8:       8fbe0044        lw      s8,68(sp)
  400acc:       8fb60040        lw      s6,64(sp)
  400ad0:       8fb5003c        lw      s5,60(sp)
  400ad4:       8fb40038        lw      s4,56(sp)
  400ad8:       8fb30034        lw      s3,52(sp)
  400adc:       8fb20030        lw      s2,48(sp)
  400ae0:       8fb1002c        lw      s1,44(sp)
  400ae4:       8fb00028        lw      s0,40(sp)
  400ae8:       27bd0048        addiu   sp,sp,72
  400aec:       03e00008        jr      ra
  400af0:       00000000        nop