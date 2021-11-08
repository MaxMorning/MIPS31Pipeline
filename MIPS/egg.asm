  400780:       3c088000        lui     t0,0x8000
  400784:       8d030000        lw      v1,0(t0)
  400788:       8d020004        lw      v0,4(t0)
  40078c:       20090000        addi    t1,zero,0
  400790:       00035880        sll     t3,v1,0x2
  400794:       00026080        sll     t4,v0,0x2
  400798:       218c0004        addi    t4,t4,4
  40079c:       216a0000        addi    t2,t3,0

004007a0 <COMPARE>:
  4007a0:       112b0006        beq     t1,t3,4007bc <FINISH_ASM>
  4007a4:       00000000        nop
  4007a8:       ad2a0000        sw      t2,0(t1)
  4007ac:       25290004        addiu   t1,t1,4
  4007b0:       014c5021        addu    t2,t2,t4
  4007b4:       1000fffa        b       4007a0 <COMPARE>
  4007b8:       00000000        nop

004007bc <FINISH_ASM>:
  4007bc:       215e0000        addi    s8,t2,0
  4007c0:       afc30004        sw      v1,4(s8)
  4007c4:       afc20008        sw      v0,8(s8)
  4007c8:       afc0000c        sw      zero,12(s8)
  4007cc:       00008025        move    s0,zero
  4007d0:       10000008        b       4007f4 <FINISH_ASM+0x38>
  4007d4:       00000000        nop
  4007d8:       8fc2000c        lw      v0,12(s8)
  4007dc:       8c430000        lw      v1,0(v0)
  4007e0:       02001025        move    v0,s0
  4007e4:       00021080        sll     v0,v0,0x2
  4007e8:       00621021        addu    v0,v1,v0
  4007ec:       ac500000        sw      s0,0(v0)
  4007f0:       26100001        addiu   s0,s0,1
  4007f4:       8fc20008        lw      v0,8(s8)
  4007f8:       0050102a        slt     v0,v0,s0
  4007fc:       1040fff6        beqz    v0,4007d8 <FINISH_ASM+0x1c>
  400800:       00000000        nop
  400804:       00008025        move    s0,zero
  400808:       10000008        b       40082c <FINISH_ASM+0x70>
  40080c:       00000000        nop
  400810:       02001025        move    v0,s0
  400814:       00021080        sll     v0,v0,0x2
  400818:       8fc3000c        lw      v1,12(s8)
  40081c:       00621021        addu    v0,v1,v0
  400820:       8c420000        lw      v0,0(v0)
  400824:       ac400000        sw      zero,0(v0)
  400828:       26100001        addiu   s0,s0,1
  40082c:       8fc20004        lw      v0,4(s8)
  400830:       0202102a        slt     v0,s0,v0
  400834:       1440fff6        bnez    v0,400810 <FINISH_ASM+0x54>
  400838:       00000000        nop
  40083c:       24110001        li      s1,1
  400840:       1000008c        b       400a74 <FINISH_ASM+0x2b8>
  400844:       00000000        nop
  400848:       24100001        li      s0,1
  40084c:       10000084        b       400a60 <FINISH_ASM+0x2a4>
  400850:       00000000        nop
  400854:       24120001        li      s2,1
  400858:       02009825        move    s3,s0
  40085c:       1000002c        b       400910 <FINISH_ASM+0x154>
  400860:       00000000        nop
  400864:       02531021        addu    v0,s2,s3
  400868:       00021fc2        srl     v1,v0,0x1f
  40086c:       00621021        addu    v0,v1,v0
  400870:       00021043        sra     v0,v0,0x1
  400874:       0040a025        move    s4,v0
  400878:       02201825        move    v1,s1
  40087c:       3c023fff        lui     v0,0x3fff
  400880:       3442ffff        ori     v0,v0,0xffff
  400884:       00621021        addu    v0,v1,v0
  400888:       00021080        sll     v0,v0,0x2
  40088c:       8fc3000c        lw      v1,12(s8)
  400890:       00621021        addu    v0,v1,v0
  400894:       8c430000        lw      v1,0(v0)
  400898:       02802025        move    a0,s4
  40089c:       3c023fff        lui     v0,0x3fff
  4008a0:       3442ffff        ori     v0,v0,0xffff
  4008a4:       00821021        addu    v0,a0,v0
  4008a8:       00021080        sll     v0,v0,0x2
  4008ac:       00621021        addu    v0,v1,v0
  4008b0:       8c560000        lw      s6,0(v0)
  4008b4:       02201025        move    v0,s1
  4008b8:       00021080        sll     v0,v0,0x2
  4008bc:       8fc3000c        lw      v1,12(s8)
  4008c0:       00621021        addu    v0,v1,v0
  4008c4:       8c430000        lw      v1,0(v0)
  4008c8:       02141023        subu    v0,s0,s4
  4008cc:       00021080        sll     v0,v0,0x2
  4008d0:       00621021        addu    v0,v1,v0
  4008d4:       8c550000        lw      s5,0(v0)
  4008d8:       02d5102a        slt     v0,s6,s5
  4008dc:       10400004        beqz    v0,4008f0 <FINISH_ASM+0x134>
  4008e0:       00000000        nop
  4008e4:       02809025        move    s2,s4
  4008e8:       10000009        b       400910 <FINISH_ASM+0x154>
  4008ec:       00000000        nop
  4008f0:       02b6102a        slt     v0,s5,s6
  4008f4:       10400004        beqz    v0,400908 <FINISH_ASM+0x14c>
  4008f8:       00000000        nop
  4008fc:       02809825        move    s3,s4
  400900:       10000003        b       400910 <FINISH_ASM+0x154>
  400904:       00000000        nop
  400908:       02809025        move    s2,s4
  40090c:       02809825        move    s3,s4
  400910:       26420001        addiu   v0,s2,1
  400914:       0053102a        slt     v0,v0,s3
  400918:       1440ffd2        bnez    v0,400864 <FINISH_ASM+0xa8>
  40091c:       00000000        nop
  400920:       02201825        move    v1,s1
  400924:       3c023fff        lui     v0,0x3fff
  400928:       3442ffff        ori     v0,v0,0xffff
  40092c:       00621021        addu    v0,v1,v0
  400930:       00021080        sll     v0,v0,0x2
  400934:       8fc3000c        lw      v1,12(s8)
  400938:       00621021        addu    v0,v1,v0
  40093c:       8c430000        lw      v1,0(v0)
  400940:       02402025        move    a0,s2
  400944:       3c023fff        lui     v0,0x3fff
  400948:       3442ffff        ori     v0,v0,0xffff
  40094c:       00821021        addu    v0,a0,v0
  400950:       00021080        sll     v0,v0,0x2
  400954:       00621021        addu    v0,v1,v0
  400958:       8c430000        lw      v1,0(v0)
  40095c:       02201025        move    v0,s1
  400960:       00021080        sll     v0,v0,0x2
  400964:       8fc4000c        lw      a0,12(s8)
  400968:       00821021        addu    v0,a0,v0
  40096c:       8c440000        lw      a0,0(v0)
  400970:       02121023        subu    v0,s0,s2
  400974:       00021080        sll     v0,v0,0x2
  400978:       00821021        addu    v0,a0,v0
  40097c:       8c420000        lw      v0,0(v0)
  400980:       afc30020        sw      v1,32(s8)
  400984:       afc20024        sw      v0,36(s8)
  400988:       8fc20024        lw      v0,36(s8)
  40098c:       8fc40020        lw      a0,32(s8)
  400990:       8fc30020        lw      v1,32(s8)
  400994:       0082202a        slt     a0,a0,v0
  400998:       0044180b        movn    v1,v0,a0
  40099c:       02202025        move    a0,s1
  4009a0:       3c023fff        lui     v0,0x3fff
  4009a4:       3442ffff        ori     v0,v0,0xffff
  4009a8:       00821021        addu    v0,a0,v0
  4009ac:       00021080        sll     v0,v0,0x2
  4009b0:       8fc4000c        lw      a0,12(s8)
  4009b4:       00821021        addu    v0,a0,v0
  4009b8:       8c440000        lw      a0,0(v0)
  4009bc:       02602825        move    a1,s3
  4009c0:       3c023fff        lui     v0,0x3fff
  4009c4:       3442ffff        ori     v0,v0,0xffff
  4009c8:       00a21021        addu    v0,a1,v0
  4009cc:       00021080        sll     v0,v0,0x2
  4009d0:       00821021        addu    v0,a0,v0
  4009d4:       8c440000        lw      a0,0(v0)
  4009d8:       02201025        move    v0,s1
  4009dc:       00021080        sll     v0,v0,0x2
  4009e0:       8fc5000c        lw      a1,12(s8)
  4009e4:       00a21021        addu    v0,a1,v0
  4009e8:       8c450000        lw      a1,0(v0)
  4009ec:       02131023        subu    v0,s0,s3
  4009f0:       00021080        sll     v0,v0,0x2
  4009f4:       00a21021        addu    v0,a1,v0
  4009f8:       8c420000        lw      v0,0(v0)
  4009fc:       afc40018        sw      a0,24(s8)
  400a00:       afc2001c        sw      v0,28(s8)
  400a04:       8fc2001c        lw      v0,28(s8)
  400a08:       8fc50018        lw      a1,24(s8)
  400a0c:       8fc40018        lw      a0,24(s8)
  400a10:       00a2282a        slt     a1,a1,v0
  400a14:       0085100a        movz    v0,a0,a1
  400a18:       afc30010        sw      v1,16(s8)
  400a1c:       afc20014        sw      v0,20(s8)
  400a20:       8fc20014        lw      v0,20(s8)
  400a24:       8fc40010        lw      a0,16(s8)
  400a28:       8fc30010        lw      v1,16(s8)
  400a2c:       0044202a        slt     a0,v0,a0
  400a30:       0044180b        movn    v1,v0,a0
  400a34:       02201025        move    v0,s1
  400a38:       00021080        sll     v0,v0,0x2
  400a3c:       8fc4000c        lw      a0,12(s8)
  400a40:       00821021        addu    v0,a0,v0
  400a44:       8c440000        lw      a0,0(v0)
  400a48:       02001025        move    v0,s0
  400a4c:       00021080        sll     v0,v0,0x2
  400a50:       00821021        addu    v0,a0,v0
  400a54:       24630001        addiu   v1,v1,1
  400a58:       ac430000        sw      v1,0(v0)
  400a5c:       26100001        addiu   s0,s0,1
  400a60:       8fc20008        lw      v0,8(s8)
  400a64:       0050102a        slt     v0,v0,s0
  400a68:       1040ff7a        beqz    v0,400854 <FINISH_ASM+0x98>
  400a6c:       00000000        nop
  400a70:       26310001        addiu   s1,s1,1
  400a74:       8fc20004        lw      v0,4(s8)
  400a78:       0222102a        slt     v0,s1,v0
  400a7c:       1440ff72        bnez    v0,400848 <FINISH_ASM+0x8c>
  400a80:       00000000        nop
  400a84:       8fc30004        lw      v1,4(s8)
  400a88:       3c023fff        lui     v0,0x3fff
  400a8c:       3442ffff        ori     v0,v0,0xffff
  400a90:       00621021        addu    v0,v1,v0
  400a94:       00021080        sll     v0,v0,0x2
  400a98:       8fc3000c        lw      v1,12(s8)
  400a9c:       00621021        addu    v0,v1,v0
  400aa0:       8c430000        lw      v1,0(v0)
  400aa4:       8fc20008        lw      v0,8(s8)
  400aa8:       00021080        sll     v0,v0,0x2
  400aac:       00621021        addu    v0,v1,v0
  400ab0:       8c420000        lw      v0,0(v0)
  400ab4:       3c088000        lui     t0,0x8000
  400ab8:       ad020008        sw      v0,8(t0)
