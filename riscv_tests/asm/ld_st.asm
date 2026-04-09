
soc_workspace_rv32ui/elf/ld_st.elf:     file format elf32-littleriscv


Disassembly of section .text.init:

80000000 <_start>:
80000000:	00000093          	addi	x1,x0,0
80000004:	00000113          	addi	x2,x0,0
80000008:	00000193          	addi	x3,x0,0
8000000c:	00000213          	addi	x4,x0,0
80000010:	00000293          	addi	x5,x0,0
80000014:	00000313          	addi	x6,x0,0
80000018:	00000393          	addi	x7,x0,0
8000001c:	00000413          	addi	x8,x0,0
80000020:	00000493          	addi	x9,x0,0
80000024:	00000513          	addi	x10,x0,0
80000028:	00000593          	addi	x11,x0,0
8000002c:	00000613          	addi	x12,x0,0
80000030:	00000693          	addi	x13,x0,0
80000034:	00000713          	addi	x14,x0,0
80000038:	00000793          	addi	x15,x0,0
8000003c:	00000813          	addi	x16,x0,0
80000040:	00000893          	addi	x17,x0,0
80000044:	00000913          	addi	x18,x0,0
80000048:	00000993          	addi	x19,x0,0
8000004c:	00000a13          	addi	x20,x0,0
80000050:	00000a93          	addi	x21,x0,0
80000054:	00000b13          	addi	x22,x0,0
80000058:	00000b93          	addi	x23,x0,0
8000005c:	00000c13          	addi	x24,x0,0
80000060:	00000c93          	addi	x25,x0,0
80000064:	00000d13          	addi	x26,x0,0
80000068:	00000d93          	addi	x27,x0,0
8000006c:	00000e13          	addi	x28,x0,0
80000070:	00000e93          	addi	x29,x0,0
80000074:	00000f13          	addi	x30,x0,0
80000078:	00000f93          	addi	x31,x0,0

8000007c <test_2>:
8000007c:	00200193          	addi	x3,x0,2
80000080:	00002117          	auipc	x2,0x2
80000084:	f8010113          	addi	x2,x2,-128 # 80002000 <begin_signature>
80000088:	fdd00093          	addi	x1,x0,-35
8000008c:	00110023          	sb	x1,0(x2)
80000090:	00010703          	lb	x14,0(x2)
80000094:	00e10023          	sb	x14,0(x2)
80000098:	00010103          	lb	x2,0(x2)
8000009c:	fdd00393          	addi	x7,x0,-35
800000a0:	647112e3          	bne	x2,x7,80000ee4 <fail>
800000a4:	00002117          	auipc	x2,0x2
800000a8:	f5c10113          	addi	x2,x2,-164 # 80002000 <begin_signature>
800000ac:	00212423          	sw	x2,8(x2)
800000b0:	00812203          	lw	x4,8(x2)
800000b4:	00120023          	sb	x1,0(x4) # 0 <_start-0x80000000>
800000b8:	622216e3          	bne	x4,x2,80000ee4 <fail>
800000bc:	00020703          	lb	x14,0(x4) # 0 <_start-0x80000000>
800000c0:	627712e3          	bne	x14,x7,80000ee4 <fail>

800000c4 <test_3>:
800000c4:	00300193          	addi	x3,x0,3
800000c8:	00002117          	auipc	x2,0x2
800000cc:	f3810113          	addi	x2,x2,-200 # 80002000 <begin_signature>
800000d0:	fcd00093          	addi	x1,x0,-51
800000d4:	001100a3          	sb	x1,1(x2)
800000d8:	00110703          	lb	x14,1(x2)
800000dc:	00e100a3          	sb	x14,1(x2)
800000e0:	00110103          	lb	x2,1(x2)
800000e4:	fcd00393          	addi	x7,x0,-51
800000e8:	5e711ee3          	bne	x2,x7,80000ee4 <fail>
800000ec:	00002117          	auipc	x2,0x2
800000f0:	f1410113          	addi	x2,x2,-236 # 80002000 <begin_signature>
800000f4:	00212423          	sw	x2,8(x2)
800000f8:	00812203          	lw	x4,8(x2)
800000fc:	001200a3          	sb	x1,1(x4) # 1 <_start-0x7fffffff>
80000100:	5e2212e3          	bne	x4,x2,80000ee4 <fail>
80000104:	00120703          	lb	x14,1(x4) # 1 <_start-0x7fffffff>
80000108:	5c771ee3          	bne	x14,x7,80000ee4 <fail>

8000010c <test_4>:
8000010c:	00400193          	addi	x3,x0,4
80000110:	00002117          	auipc	x2,0x2
80000114:	ef010113          	addi	x2,x2,-272 # 80002000 <begin_signature>
80000118:	fcc00093          	addi	x1,x0,-52
8000011c:	00110123          	sb	x1,2(x2)
80000120:	00210703          	lb	x14,2(x2)
80000124:	00e10123          	sb	x14,2(x2)
80000128:	00210103          	lb	x2,2(x2)
8000012c:	fcc00393          	addi	x7,x0,-52
80000130:	5a711ae3          	bne	x2,x7,80000ee4 <fail>
80000134:	00002117          	auipc	x2,0x2
80000138:	ecc10113          	addi	x2,x2,-308 # 80002000 <begin_signature>
8000013c:	00212423          	sw	x2,8(x2)
80000140:	00812203          	lw	x4,8(x2)
80000144:	00120123          	sb	x1,2(x4) # 2 <_start-0x7ffffffe>
80000148:	58221ee3          	bne	x4,x2,80000ee4 <fail>
8000014c:	00220703          	lb	x14,2(x4) # 2 <_start-0x7ffffffe>
80000150:	58771ae3          	bne	x14,x7,80000ee4 <fail>

80000154 <test_5>:
80000154:	00500193          	addi	x3,x0,5
80000158:	00002117          	auipc	x2,0x2
8000015c:	ea810113          	addi	x2,x2,-344 # 80002000 <begin_signature>
80000160:	fbc00093          	addi	x1,x0,-68
80000164:	001101a3          	sb	x1,3(x2)
80000168:	00310703          	lb	x14,3(x2)
8000016c:	00e101a3          	sb	x14,3(x2)
80000170:	00310103          	lb	x2,3(x2)
80000174:	fbc00393          	addi	x7,x0,-68
80000178:	567116e3          	bne	x2,x7,80000ee4 <fail>
8000017c:	00002117          	auipc	x2,0x2
80000180:	e8410113          	addi	x2,x2,-380 # 80002000 <begin_signature>
80000184:	00212423          	sw	x2,8(x2)
80000188:	00812203          	lw	x4,8(x2)
8000018c:	001201a3          	sb	x1,3(x4) # 3 <_start-0x7ffffffd>
80000190:	54221ae3          	bne	x4,x2,80000ee4 <fail>
80000194:	00320703          	lb	x14,3(x4) # 3 <_start-0x7ffffffd>
80000198:	547716e3          	bne	x14,x7,80000ee4 <fail>

8000019c <test_6>:
8000019c:	00600193          	addi	x3,x0,6
800001a0:	00002117          	auipc	x2,0x2
800001a4:	e6010113          	addi	x2,x2,-416 # 80002000 <begin_signature>
800001a8:	fbb00093          	addi	x1,x0,-69
800001ac:	00110223          	sb	x1,4(x2)
800001b0:	00410703          	lb	x14,4(x2)
800001b4:	00e10223          	sb	x14,4(x2)
800001b8:	00410103          	lb	x2,4(x2)
800001bc:	fbb00393          	addi	x7,x0,-69
800001c0:	527112e3          	bne	x2,x7,80000ee4 <fail>
800001c4:	00002117          	auipc	x2,0x2
800001c8:	e3c10113          	addi	x2,x2,-452 # 80002000 <begin_signature>
800001cc:	00212423          	sw	x2,8(x2)
800001d0:	00812203          	lw	x4,8(x2)
800001d4:	00120223          	sb	x1,4(x4) # 4 <_start-0x7ffffffc>
800001d8:	502216e3          	bne	x4,x2,80000ee4 <fail>
800001dc:	00420703          	lb	x14,4(x4) # 4 <_start-0x7ffffffc>
800001e0:	507712e3          	bne	x14,x7,80000ee4 <fail>

800001e4 <test_7>:
800001e4:	00700193          	addi	x3,x0,7
800001e8:	00002117          	auipc	x2,0x2
800001ec:	e1810113          	addi	x2,x2,-488 # 80002000 <begin_signature>
800001f0:	fab00093          	addi	x1,x0,-85
800001f4:	001102a3          	sb	x1,5(x2)
800001f8:	00510703          	lb	x14,5(x2)
800001fc:	00e102a3          	sb	x14,5(x2)
80000200:	00510103          	lb	x2,5(x2)
80000204:	fab00393          	addi	x7,x0,-85
80000208:	4c711ee3          	bne	x2,x7,80000ee4 <fail>
8000020c:	00002117          	auipc	x2,0x2
80000210:	df410113          	addi	x2,x2,-524 # 80002000 <begin_signature>
80000214:	00212423          	sw	x2,8(x2)
80000218:	00812203          	lw	x4,8(x2)
8000021c:	001202a3          	sb	x1,5(x4) # 5 <_start-0x7ffffffb>
80000220:	4c2212e3          	bne	x4,x2,80000ee4 <fail>
80000224:	00520703          	lb	x14,5(x4) # 5 <_start-0x7ffffffb>
80000228:	4a771ee3          	bne	x14,x7,80000ee4 <fail>

8000022c <test_8>:
8000022c:	00800193          	addi	x3,x0,8
80000230:	00002117          	auipc	x2,0x2
80000234:	dd010113          	addi	x2,x2,-560 # 80002000 <begin_signature>
80000238:	03300093          	addi	x1,x0,51
8000023c:	00110023          	sb	x1,0(x2)
80000240:	00010703          	lb	x14,0(x2)
80000244:	00e10023          	sb	x14,0(x2)
80000248:	00010103          	lb	x2,0(x2)
8000024c:	03300393          	addi	x7,x0,51
80000250:	48711ae3          	bne	x2,x7,80000ee4 <fail>
80000254:	00002117          	auipc	x2,0x2
80000258:	dac10113          	addi	x2,x2,-596 # 80002000 <begin_signature>
8000025c:	00212423          	sw	x2,8(x2)
80000260:	00812203          	lw	x4,8(x2)
80000264:	00120023          	sb	x1,0(x4) # 0 <_start-0x80000000>
80000268:	46221ee3          	bne	x4,x2,80000ee4 <fail>
8000026c:	00020703          	lb	x14,0(x4) # 0 <_start-0x80000000>
80000270:	46771ae3          	bne	x14,x7,80000ee4 <fail>

80000274 <test_9>:
80000274:	00900193          	addi	x3,x0,9
80000278:	00002117          	auipc	x2,0x2
8000027c:	d8810113          	addi	x2,x2,-632 # 80002000 <begin_signature>
80000280:	02300093          	addi	x1,x0,35
80000284:	001100a3          	sb	x1,1(x2)
80000288:	00110703          	lb	x14,1(x2)
8000028c:	00e100a3          	sb	x14,1(x2)
80000290:	00110103          	lb	x2,1(x2)
80000294:	02300393          	addi	x7,x0,35
80000298:	447116e3          	bne	x2,x7,80000ee4 <fail>
8000029c:	00002117          	auipc	x2,0x2
800002a0:	d6410113          	addi	x2,x2,-668 # 80002000 <begin_signature>
800002a4:	00212423          	sw	x2,8(x2)
800002a8:	00812203          	lw	x4,8(x2)
800002ac:	001200a3          	sb	x1,1(x4) # 1 <_start-0x7fffffff>
800002b0:	42221ae3          	bne	x4,x2,80000ee4 <fail>
800002b4:	00120703          	lb	x14,1(x4) # 1 <_start-0x7fffffff>
800002b8:	427716e3          	bne	x14,x7,80000ee4 <fail>

800002bc <test_10>:
800002bc:	00a00193          	addi	x3,x0,10
800002c0:	00002117          	auipc	x2,0x2
800002c4:	d4010113          	addi	x2,x2,-704 # 80002000 <begin_signature>
800002c8:	02200093          	addi	x1,x0,34
800002cc:	00110123          	sb	x1,2(x2)
800002d0:	00210703          	lb	x14,2(x2)
800002d4:	00e10123          	sb	x14,2(x2)
800002d8:	00210103          	lb	x2,2(x2)
800002dc:	02200393          	addi	x7,x0,34
800002e0:	407112e3          	bne	x2,x7,80000ee4 <fail>
800002e4:	00002117          	auipc	x2,0x2
800002e8:	d1c10113          	addi	x2,x2,-740 # 80002000 <begin_signature>
800002ec:	00212423          	sw	x2,8(x2)
800002f0:	00812203          	lw	x4,8(x2)
800002f4:	00120123          	sb	x1,2(x4) # 2 <_start-0x7ffffffe>
800002f8:	3e2216e3          	bne	x4,x2,80000ee4 <fail>
800002fc:	00220703          	lb	x14,2(x4) # 2 <_start-0x7ffffffe>
80000300:	3e7712e3          	bne	x14,x7,80000ee4 <fail>

80000304 <test_11>:
80000304:	00b00193          	addi	x3,x0,11
80000308:	00002117          	auipc	x2,0x2
8000030c:	cf810113          	addi	x2,x2,-776 # 80002000 <begin_signature>
80000310:	01200093          	addi	x1,x0,18
80000314:	001101a3          	sb	x1,3(x2)
80000318:	00310703          	lb	x14,3(x2)
8000031c:	00e101a3          	sb	x14,3(x2)
80000320:	00310103          	lb	x2,3(x2)
80000324:	01200393          	addi	x7,x0,18
80000328:	3a711ee3          	bne	x2,x7,80000ee4 <fail>
8000032c:	00002117          	auipc	x2,0x2
80000330:	cd410113          	addi	x2,x2,-812 # 80002000 <begin_signature>
80000334:	00212423          	sw	x2,8(x2)
80000338:	00812203          	lw	x4,8(x2)
8000033c:	001201a3          	sb	x1,3(x4) # 3 <_start-0x7ffffffd>
80000340:	3a2212e3          	bne	x4,x2,80000ee4 <fail>
80000344:	00320703          	lb	x14,3(x4) # 3 <_start-0x7ffffffd>
80000348:	38771ee3          	bne	x14,x7,80000ee4 <fail>

8000034c <test_12>:
8000034c:	00c00193          	addi	x3,x0,12
80000350:	00002117          	auipc	x2,0x2
80000354:	cb010113          	addi	x2,x2,-848 # 80002000 <begin_signature>
80000358:	01100093          	addi	x1,x0,17
8000035c:	00110223          	sb	x1,4(x2)
80000360:	00410703          	lb	x14,4(x2)
80000364:	00e10223          	sb	x14,4(x2)
80000368:	00410103          	lb	x2,4(x2)
8000036c:	01100393          	addi	x7,x0,17
80000370:	36711ae3          	bne	x2,x7,80000ee4 <fail>
80000374:	00002117          	auipc	x2,0x2
80000378:	c8c10113          	addi	x2,x2,-884 # 80002000 <begin_signature>
8000037c:	00212423          	sw	x2,8(x2)
80000380:	00812203          	lw	x4,8(x2)
80000384:	00120223          	sb	x1,4(x4) # 4 <_start-0x7ffffffc>
80000388:	34221ee3          	bne	x4,x2,80000ee4 <fail>
8000038c:	00420703          	lb	x14,4(x4) # 4 <_start-0x7ffffffc>
80000390:	34771ae3          	bne	x14,x7,80000ee4 <fail>

80000394 <test_13>:
80000394:	00d00193          	addi	x3,x0,13
80000398:	00002117          	auipc	x2,0x2
8000039c:	c6810113          	addi	x2,x2,-920 # 80002000 <begin_signature>
800003a0:	00100093          	addi	x1,x0,1
800003a4:	001102a3          	sb	x1,5(x2)
800003a8:	00510703          	lb	x14,5(x2)
800003ac:	00e102a3          	sb	x14,5(x2)
800003b0:	00510103          	lb	x2,5(x2)
800003b4:	00100393          	addi	x7,x0,1
800003b8:	327116e3          	bne	x2,x7,80000ee4 <fail>
800003bc:	00002117          	auipc	x2,0x2
800003c0:	c4410113          	addi	x2,x2,-956 # 80002000 <begin_signature>
800003c4:	00212423          	sw	x2,8(x2)
800003c8:	00812203          	lw	x4,8(x2)
800003cc:	001202a3          	sb	x1,5(x4) # 5 <_start-0x7ffffffb>
800003d0:	30221ae3          	bne	x4,x2,80000ee4 <fail>
800003d4:	00520703          	lb	x14,5(x4) # 5 <_start-0x7ffffffb>
800003d8:	307716e3          	bne	x14,x7,80000ee4 <fail>

800003dc <test_14>:
800003dc:	00e00193          	addi	x3,x0,14
800003e0:	00002117          	auipc	x2,0x2
800003e4:	c2010113          	addi	x2,x2,-992 # 80002000 <begin_signature>
800003e8:	03300093          	addi	x1,x0,51
800003ec:	00110023          	sb	x1,0(x2)
800003f0:	00014703          	lbu	x14,0(x2)
800003f4:	00e10023          	sb	x14,0(x2)
800003f8:	00014103          	lbu	x2,0(x2)
800003fc:	03300393          	addi	x7,x0,51
80000400:	2e7112e3          	bne	x2,x7,80000ee4 <fail>
80000404:	00002117          	auipc	x2,0x2
80000408:	bfc10113          	addi	x2,x2,-1028 # 80002000 <begin_signature>
8000040c:	00212423          	sw	x2,8(x2)
80000410:	00812203          	lw	x4,8(x2)
80000414:	00120023          	sb	x1,0(x4) # 0 <_start-0x80000000>
80000418:	2c2216e3          	bne	x4,x2,80000ee4 <fail>
8000041c:	00024703          	lbu	x14,0(x4) # 0 <_start-0x80000000>
80000420:	2c7712e3          	bne	x14,x7,80000ee4 <fail>

80000424 <test_15>:
80000424:	00f00193          	addi	x3,x0,15
80000428:	00002117          	auipc	x2,0x2
8000042c:	bd810113          	addi	x2,x2,-1064 # 80002000 <begin_signature>
80000430:	02300093          	addi	x1,x0,35
80000434:	001100a3          	sb	x1,1(x2)
80000438:	00114703          	lbu	x14,1(x2)
8000043c:	00e100a3          	sb	x14,1(x2)
80000440:	00114103          	lbu	x2,1(x2)
80000444:	02300393          	addi	x7,x0,35
80000448:	28711ee3          	bne	x2,x7,80000ee4 <fail>
8000044c:	00002117          	auipc	x2,0x2
80000450:	bb410113          	addi	x2,x2,-1100 # 80002000 <begin_signature>
80000454:	00212423          	sw	x2,8(x2)
80000458:	00812203          	lw	x4,8(x2)
8000045c:	001200a3          	sb	x1,1(x4) # 1 <_start-0x7fffffff>
80000460:	282212e3          	bne	x4,x2,80000ee4 <fail>
80000464:	00124703          	lbu	x14,1(x4) # 1 <_start-0x7fffffff>
80000468:	26771ee3          	bne	x14,x7,80000ee4 <fail>

8000046c <test_16>:
8000046c:	01000193          	addi	x3,x0,16
80000470:	00002117          	auipc	x2,0x2
80000474:	b9010113          	addi	x2,x2,-1136 # 80002000 <begin_signature>
80000478:	02200093          	addi	x1,x0,34
8000047c:	00110123          	sb	x1,2(x2)
80000480:	00214703          	lbu	x14,2(x2)
80000484:	00e10123          	sb	x14,2(x2)
80000488:	00214103          	lbu	x2,2(x2)
8000048c:	02200393          	addi	x7,x0,34
80000490:	24711ae3          	bne	x2,x7,80000ee4 <fail>
80000494:	00002117          	auipc	x2,0x2
80000498:	b6c10113          	addi	x2,x2,-1172 # 80002000 <begin_signature>
8000049c:	00212423          	sw	x2,8(x2)
800004a0:	00812203          	lw	x4,8(x2)
800004a4:	00120123          	sb	x1,2(x4) # 2 <_start-0x7ffffffe>
800004a8:	22221ee3          	bne	x4,x2,80000ee4 <fail>
800004ac:	00224703          	lbu	x14,2(x4) # 2 <_start-0x7ffffffe>
800004b0:	22771ae3          	bne	x14,x7,80000ee4 <fail>

800004b4 <test_17>:
800004b4:	01100193          	addi	x3,x0,17
800004b8:	00002117          	auipc	x2,0x2
800004bc:	b4810113          	addi	x2,x2,-1208 # 80002000 <begin_signature>
800004c0:	01200093          	addi	x1,x0,18
800004c4:	001101a3          	sb	x1,3(x2)
800004c8:	00314703          	lbu	x14,3(x2)
800004cc:	00e101a3          	sb	x14,3(x2)
800004d0:	00314103          	lbu	x2,3(x2)
800004d4:	01200393          	addi	x7,x0,18
800004d8:	207116e3          	bne	x2,x7,80000ee4 <fail>
800004dc:	00002117          	auipc	x2,0x2
800004e0:	b2410113          	addi	x2,x2,-1244 # 80002000 <begin_signature>
800004e4:	00212423          	sw	x2,8(x2)
800004e8:	00812203          	lw	x4,8(x2)
800004ec:	001201a3          	sb	x1,3(x4) # 3 <_start-0x7ffffffd>
800004f0:	1e221ae3          	bne	x4,x2,80000ee4 <fail>
800004f4:	00324703          	lbu	x14,3(x4) # 3 <_start-0x7ffffffd>
800004f8:	1e7716e3          	bne	x14,x7,80000ee4 <fail>

800004fc <test_18>:
800004fc:	01200193          	addi	x3,x0,18
80000500:	00002117          	auipc	x2,0x2
80000504:	b0010113          	addi	x2,x2,-1280 # 80002000 <begin_signature>
80000508:	01100093          	addi	x1,x0,17
8000050c:	00110223          	sb	x1,4(x2)
80000510:	00414703          	lbu	x14,4(x2)
80000514:	00e10223          	sb	x14,4(x2)
80000518:	00414103          	lbu	x2,4(x2)
8000051c:	01100393          	addi	x7,x0,17
80000520:	1c7112e3          	bne	x2,x7,80000ee4 <fail>
80000524:	00002117          	auipc	x2,0x2
80000528:	adc10113          	addi	x2,x2,-1316 # 80002000 <begin_signature>
8000052c:	00212423          	sw	x2,8(x2)
80000530:	00812203          	lw	x4,8(x2)
80000534:	00120223          	sb	x1,4(x4) # 4 <_start-0x7ffffffc>
80000538:	1a2216e3          	bne	x4,x2,80000ee4 <fail>
8000053c:	00424703          	lbu	x14,4(x4) # 4 <_start-0x7ffffffc>
80000540:	1a7712e3          	bne	x14,x7,80000ee4 <fail>

80000544 <test_19>:
80000544:	01300193          	addi	x3,x0,19
80000548:	00002117          	auipc	x2,0x2
8000054c:	ab810113          	addi	x2,x2,-1352 # 80002000 <begin_signature>
80000550:	00100093          	addi	x1,x0,1
80000554:	001102a3          	sb	x1,5(x2)
80000558:	00514703          	lbu	x14,5(x2)
8000055c:	00e102a3          	sb	x14,5(x2)
80000560:	00514103          	lbu	x2,5(x2)
80000564:	00100393          	addi	x7,x0,1
80000568:	16711ee3          	bne	x2,x7,80000ee4 <fail>
8000056c:	00002117          	auipc	x2,0x2
80000570:	a9410113          	addi	x2,x2,-1388 # 80002000 <begin_signature>
80000574:	00212423          	sw	x2,8(x2)
80000578:	00812203          	lw	x4,8(x2)
8000057c:	001202a3          	sb	x1,5(x4) # 5 <_start-0x7ffffffb>
80000580:	162212e3          	bne	x4,x2,80000ee4 <fail>
80000584:	00524703          	lbu	x14,5(x4) # 5 <_start-0x7ffffffb>
80000588:	14771ee3          	bne	x14,x7,80000ee4 <fail>

8000058c <test_20>:
8000058c:	01400193          	addi	x3,x0,20
80000590:	00002117          	auipc	x2,0x2
80000594:	a7010113          	addi	x2,x2,-1424 # 80002000 <begin_signature>
80000598:	aabbd0b7          	lui	x1,0xaabbd
8000059c:	cdd08093          	addi	x1,x1,-803 # aabbccdd <_end+0x2abbac8d>
800005a0:	00112023          	sw	x1,0(x2)
800005a4:	00012703          	lw	x14,0(x2)
800005a8:	00e12023          	sw	x14,0(x2)
800005ac:	00012103          	lw	x2,0(x2)
800005b0:	aabbd3b7          	lui	x7,0xaabbd
800005b4:	cdd38393          	addi	x7,x7,-803 # aabbccdd <_end+0x2abbac8d>
800005b8:	127116e3          	bne	x2,x7,80000ee4 <fail>
800005bc:	00002117          	auipc	x2,0x2
800005c0:	a4410113          	addi	x2,x2,-1468 # 80002000 <begin_signature>
800005c4:	00212423          	sw	x2,8(x2)
800005c8:	00812203          	lw	x4,8(x2)
800005cc:	00122023          	sw	x1,0(x4) # 0 <_start-0x80000000>
800005d0:	10221ae3          	bne	x4,x2,80000ee4 <fail>
800005d4:	00022703          	lw	x14,0(x4) # 0 <_start-0x80000000>
800005d8:	107716e3          	bne	x14,x7,80000ee4 <fail>

800005dc <test_21>:
800005dc:	01500193          	addi	x3,x0,21
800005e0:	00002117          	auipc	x2,0x2
800005e4:	a2010113          	addi	x2,x2,-1504 # 80002000 <begin_signature>
800005e8:	daabc0b7          	lui	x1,0xdaabc
800005ec:	ccd08093          	addi	x1,x1,-819 # daabbccd <_end+0x5aab9c7d>
800005f0:	00112223          	sw	x1,4(x2)
800005f4:	00412703          	lw	x14,4(x2)
800005f8:	00e12223          	sw	x14,4(x2)
800005fc:	00412103          	lw	x2,4(x2)
80000600:	daabc3b7          	lui	x7,0xdaabc
80000604:	ccd38393          	addi	x7,x7,-819 # daabbccd <_end+0x5aab9c7d>
80000608:	0c711ee3          	bne	x2,x7,80000ee4 <fail>
8000060c:	00002117          	auipc	x2,0x2
80000610:	9f410113          	addi	x2,x2,-1548 # 80002000 <begin_signature>
80000614:	00212423          	sw	x2,8(x2)
80000618:	00812203          	lw	x4,8(x2)
8000061c:	00122223          	sw	x1,4(x4) # 4 <_start-0x7ffffffc>
80000620:	0c2212e3          	bne	x4,x2,80000ee4 <fail>
80000624:	00422703          	lw	x14,4(x4) # 4 <_start-0x7ffffffc>
80000628:	0a771ee3          	bne	x14,x7,80000ee4 <fail>

8000062c <test_22>:
8000062c:	01600193          	addi	x3,x0,22
80000630:	00002117          	auipc	x2,0x2
80000634:	9d010113          	addi	x2,x2,-1584 # 80002000 <begin_signature>
80000638:	ddaac0b7          	lui	x1,0xddaac
8000063c:	bcc08093          	addi	x1,x1,-1076 # ddaabbcc <_end+0x5daa9b7c>
80000640:	00112423          	sw	x1,8(x2)
80000644:	00812703          	lw	x14,8(x2)
80000648:	00e12423          	sw	x14,8(x2)
8000064c:	00812103          	lw	x2,8(x2)
80000650:	ddaac3b7          	lui	x7,0xddaac
80000654:	bcc38393          	addi	x7,x7,-1076 # ddaabbcc <_end+0x5daa9b7c>
80000658:	087116e3          	bne	x2,x7,80000ee4 <fail>
8000065c:	00002117          	auipc	x2,0x2
80000660:	9a410113          	addi	x2,x2,-1628 # 80002000 <begin_signature>
80000664:	00212423          	sw	x2,8(x2)
80000668:	00812203          	lw	x4,8(x2)
8000066c:	00122423          	sw	x1,8(x4) # 8 <_start-0x7ffffff8>
80000670:	06221ae3          	bne	x4,x2,80000ee4 <fail>
80000674:	00822703          	lw	x14,8(x4) # 8 <_start-0x7ffffff8>
80000678:	067716e3          	bne	x14,x7,80000ee4 <fail>

8000067c <test_23>:
8000067c:	01700193          	addi	x3,x0,23
80000680:	00002117          	auipc	x2,0x2
80000684:	98010113          	addi	x2,x2,-1664 # 80002000 <begin_signature>
80000688:	cddab0b7          	lui	x1,0xcddab
8000068c:	bbc08093          	addi	x1,x1,-1092 # cddaabbc <_end+0x4dda8b6c>
80000690:	00112623          	sw	x1,12(x2)
80000694:	00c12703          	lw	x14,12(x2)
80000698:	00e12623          	sw	x14,12(x2)
8000069c:	00c12103          	lw	x2,12(x2)
800006a0:	cddab3b7          	lui	x7,0xcddab
800006a4:	bbc38393          	addi	x7,x7,-1092 # cddaabbc <_end+0x4dda8b6c>
800006a8:	02711ee3          	bne	x2,x7,80000ee4 <fail>
800006ac:	00002117          	auipc	x2,0x2
800006b0:	95410113          	addi	x2,x2,-1708 # 80002000 <begin_signature>
800006b4:	00212423          	sw	x2,8(x2)
800006b8:	00812203          	lw	x4,8(x2)
800006bc:	00122623          	sw	x1,12(x4) # c <_start-0x7ffffff4>
800006c0:	022212e3          	bne	x4,x2,80000ee4 <fail>
800006c4:	00c22703          	lw	x14,12(x4) # c <_start-0x7ffffff4>
800006c8:	00771ee3          	bne	x14,x7,80000ee4 <fail>

800006cc <test_24>:
800006cc:	01800193          	addi	x3,x0,24
800006d0:	00002117          	auipc	x2,0x2
800006d4:	93010113          	addi	x2,x2,-1744 # 80002000 <begin_signature>
800006d8:	ccddb0b7          	lui	x1,0xccddb
800006dc:	abb08093          	addi	x1,x1,-1349 # ccddaabb <_end+0x4cdd8a6b>
800006e0:	00112823          	sw	x1,16(x2)
800006e4:	01012703          	lw	x14,16(x2)
800006e8:	00e12823          	sw	x14,16(x2)
800006ec:	01012103          	lw	x2,16(x2)
800006f0:	ccddb3b7          	lui	x7,0xccddb
800006f4:	abb38393          	addi	x7,x7,-1349 # ccddaabb <_end+0x4cdd8a6b>
800006f8:	7e711663          	bne	x2,x7,80000ee4 <fail>
800006fc:	00002117          	auipc	x2,0x2
80000700:	90410113          	addi	x2,x2,-1788 # 80002000 <begin_signature>
80000704:	00212423          	sw	x2,8(x2)
80000708:	00812203          	lw	x4,8(x2)
8000070c:	00122823          	sw	x1,16(x4) # 10 <_start-0x7ffffff0>
80000710:	7c221a63          	bne	x4,x2,80000ee4 <fail>
80000714:	01022703          	lw	x14,16(x4) # 10 <_start-0x7ffffff0>
80000718:	7c771663          	bne	x14,x7,80000ee4 <fail>

8000071c <test_25>:
8000071c:	01900193          	addi	x3,x0,25
80000720:	00002117          	auipc	x2,0x2
80000724:	8e010113          	addi	x2,x2,-1824 # 80002000 <begin_signature>
80000728:	bccde0b7          	lui	x1,0xbccde
8000072c:	aab08093          	addi	x1,x1,-1365 # bccddaab <_end+0x3ccdba5b>
80000730:	00112a23          	sw	x1,20(x2)
80000734:	01412703          	lw	x14,20(x2)
80000738:	00e12a23          	sw	x14,20(x2)
8000073c:	01412103          	lw	x2,20(x2)
80000740:	bccde3b7          	lui	x7,0xbccde
80000744:	aab38393          	addi	x7,x7,-1365 # bccddaab <_end+0x3ccdba5b>
80000748:	78711e63          	bne	x2,x7,80000ee4 <fail>
8000074c:	00002117          	auipc	x2,0x2
80000750:	8b410113          	addi	x2,x2,-1868 # 80002000 <begin_signature>
80000754:	00212423          	sw	x2,8(x2)
80000758:	00812203          	lw	x4,8(x2)
8000075c:	00122a23          	sw	x1,20(x4) # 14 <_start-0x7fffffec>
80000760:	78221263          	bne	x4,x2,80000ee4 <fail>
80000764:	01422703          	lw	x14,20(x4) # 14 <_start-0x7fffffec>
80000768:	76771e63          	bne	x14,x7,80000ee4 <fail>

8000076c <test_26>:
8000076c:	01a00193          	addi	x3,x0,26
80000770:	00002117          	auipc	x2,0x2
80000774:	89010113          	addi	x2,x2,-1904 # 80002000 <begin_signature>
80000778:	001120b7          	lui	x1,0x112
8000077c:	23308093          	addi	x1,x1,563 # 112233 <_start-0x7feeddcd>
80000780:	00112023          	sw	x1,0(x2)
80000784:	00012703          	lw	x14,0(x2)
80000788:	00e12023          	sw	x14,0(x2)
8000078c:	00012103          	lw	x2,0(x2)
80000790:	001123b7          	lui	x7,0x112
80000794:	23338393          	addi	x7,x7,563 # 112233 <_start-0x7feeddcd>
80000798:	74711663          	bne	x2,x7,80000ee4 <fail>
8000079c:	00002117          	auipc	x2,0x2
800007a0:	86410113          	addi	x2,x2,-1948 # 80002000 <begin_signature>
800007a4:	00212423          	sw	x2,8(x2)
800007a8:	00812203          	lw	x4,8(x2)
800007ac:	00122023          	sw	x1,0(x4) # 0 <_start-0x80000000>
800007b0:	72221a63          	bne	x4,x2,80000ee4 <fail>
800007b4:	00022703          	lw	x14,0(x4) # 0 <_start-0x80000000>
800007b8:	72771663          	bne	x14,x7,80000ee4 <fail>

800007bc <test_27>:
800007bc:	01b00193          	addi	x3,x0,27
800007c0:	00002117          	auipc	x2,0x2
800007c4:	84010113          	addi	x2,x2,-1984 # 80002000 <begin_signature>
800007c8:	300110b7          	lui	x1,0x30011
800007cc:	22308093          	addi	x1,x1,547 # 30011223 <_start-0x4ffeeddd>
800007d0:	00112223          	sw	x1,4(x2)
800007d4:	00412703          	lw	x14,4(x2)
800007d8:	00e12223          	sw	x14,4(x2)
800007dc:	00412103          	lw	x2,4(x2)
800007e0:	300113b7          	lui	x7,0x30011
800007e4:	22338393          	addi	x7,x7,547 # 30011223 <_start-0x4ffeeddd>
800007e8:	6e711e63          	bne	x2,x7,80000ee4 <fail>
800007ec:	00002117          	auipc	x2,0x2
800007f0:	81410113          	addi	x2,x2,-2028 # 80002000 <begin_signature>
800007f4:	00212423          	sw	x2,8(x2)
800007f8:	00812203          	lw	x4,8(x2)
800007fc:	00122223          	sw	x1,4(x4) # 4 <_start-0x7ffffffc>
80000800:	6e221263          	bne	x4,x2,80000ee4 <fail>
80000804:	00422703          	lw	x14,4(x4) # 4 <_start-0x7ffffffc>
80000808:	6c771e63          	bne	x14,x7,80000ee4 <fail>

8000080c <test_28>:
8000080c:	01c00193          	addi	x3,x0,28
80000810:	00001117          	auipc	x2,0x1
80000814:	7f010113          	addi	x2,x2,2032 # 80002000 <begin_signature>
80000818:	330010b7          	lui	x1,0x33001
8000081c:	12208093          	addi	x1,x1,290 # 33001122 <_start-0x4cffeede>
80000820:	00112423          	sw	x1,8(x2)
80000824:	00812703          	lw	x14,8(x2)
80000828:	00e12423          	sw	x14,8(x2)
8000082c:	00812103          	lw	x2,8(x2)
80000830:	330013b7          	lui	x7,0x33001
80000834:	12238393          	addi	x7,x7,290 # 33001122 <_start-0x4cffeede>
80000838:	6a711663          	bne	x2,x7,80000ee4 <fail>
8000083c:	00001117          	auipc	x2,0x1
80000840:	7c410113          	addi	x2,x2,1988 # 80002000 <begin_signature>
80000844:	00212423          	sw	x2,8(x2)
80000848:	00812203          	lw	x4,8(x2)
8000084c:	00122423          	sw	x1,8(x4) # 8 <_start-0x7ffffff8>
80000850:	68221a63          	bne	x4,x2,80000ee4 <fail>
80000854:	00822703          	lw	x14,8(x4) # 8 <_start-0x7ffffff8>
80000858:	68771663          	bne	x14,x7,80000ee4 <fail>

8000085c <test_29>:
8000085c:	01d00193          	addi	x3,x0,29
80000860:	00001117          	auipc	x2,0x1
80000864:	7a010113          	addi	x2,x2,1952 # 80002000 <begin_signature>
80000868:	233000b7          	lui	x1,0x23300
8000086c:	11208093          	addi	x1,x1,274 # 23300112 <_start-0x5ccffeee>
80000870:	00112623          	sw	x1,12(x2)
80000874:	00c12703          	lw	x14,12(x2)
80000878:	00e12623          	sw	x14,12(x2)
8000087c:	00c12103          	lw	x2,12(x2)
80000880:	233003b7          	lui	x7,0x23300
80000884:	11238393          	addi	x7,x7,274 # 23300112 <_start-0x5ccffeee>
80000888:	64711e63          	bne	x2,x7,80000ee4 <fail>
8000088c:	00001117          	auipc	x2,0x1
80000890:	77410113          	addi	x2,x2,1908 # 80002000 <begin_signature>
80000894:	00212423          	sw	x2,8(x2)
80000898:	00812203          	lw	x4,8(x2)
8000089c:	00122623          	sw	x1,12(x4) # c <_start-0x7ffffff4>
800008a0:	64221263          	bne	x4,x2,80000ee4 <fail>
800008a4:	00c22703          	lw	x14,12(x4) # c <_start-0x7ffffff4>
800008a8:	62771e63          	bne	x14,x7,80000ee4 <fail>

800008ac <test_30>:
800008ac:	01e00193          	addi	x3,x0,30
800008b0:	00001117          	auipc	x2,0x1
800008b4:	75010113          	addi	x2,x2,1872 # 80002000 <begin_signature>
800008b8:	223300b7          	lui	x1,0x22330
800008bc:	01108093          	addi	x1,x1,17 # 22330011 <_start-0x5dccffef>
800008c0:	00112823          	sw	x1,16(x2)
800008c4:	01012703          	lw	x14,16(x2)
800008c8:	00e12823          	sw	x14,16(x2)
800008cc:	01012103          	lw	x2,16(x2)
800008d0:	223303b7          	lui	x7,0x22330
800008d4:	01138393          	addi	x7,x7,17 # 22330011 <_start-0x5dccffef>
800008d8:	60711663          	bne	x2,x7,80000ee4 <fail>
800008dc:	00001117          	auipc	x2,0x1
800008e0:	72410113          	addi	x2,x2,1828 # 80002000 <begin_signature>
800008e4:	00212423          	sw	x2,8(x2)
800008e8:	00812203          	lw	x4,8(x2)
800008ec:	00122823          	sw	x1,16(x4) # 10 <_start-0x7ffffff0>
800008f0:	5e221a63          	bne	x4,x2,80000ee4 <fail>
800008f4:	01022703          	lw	x14,16(x4) # 10 <_start-0x7ffffff0>
800008f8:	5e771663          	bne	x14,x7,80000ee4 <fail>

800008fc <test_31>:
800008fc:	01f00193          	addi	x3,x0,31
80000900:	00001117          	auipc	x2,0x1
80000904:	70010113          	addi	x2,x2,1792 # 80002000 <begin_signature>
80000908:	122330b7          	lui	x1,0x12233
8000090c:	00108093          	addi	x1,x1,1 # 12233001 <_start-0x6ddccfff>
80000910:	00112a23          	sw	x1,20(x2)
80000914:	01412703          	lw	x14,20(x2)
80000918:	00e12a23          	sw	x14,20(x2)
8000091c:	01412103          	lw	x2,20(x2)
80000920:	122333b7          	lui	x7,0x12233
80000924:	00138393          	addi	x7,x7,1 # 12233001 <_start-0x6ddccfff>
80000928:	5a711e63          	bne	x2,x7,80000ee4 <fail>
8000092c:	00001117          	auipc	x2,0x1
80000930:	6d410113          	addi	x2,x2,1748 # 80002000 <begin_signature>
80000934:	00212423          	sw	x2,8(x2)
80000938:	00812203          	lw	x4,8(x2)
8000093c:	00122a23          	sw	x1,20(x4) # 14 <_start-0x7fffffec>
80000940:	5a221263          	bne	x4,x2,80000ee4 <fail>
80000944:	01422703          	lw	x14,20(x4) # 14 <_start-0x7fffffec>
80000948:	58771e63          	bne	x14,x7,80000ee4 <fail>

8000094c <test_32>:
8000094c:	02000193          	addi	x3,x0,32
80000950:	00001117          	auipc	x2,0x1
80000954:	6b010113          	addi	x2,x2,1712 # 80002000 <begin_signature>
80000958:	ffffd0b7          	lui	x1,0xffffd
8000095c:	cdd08093          	addi	x1,x1,-803 # ffffccdd <_end+0x7fffac8d>
80000960:	00111023          	sh	x1,0(x2)
80000964:	00011703          	lh	x14,0(x2)
80000968:	00e11023          	sh	x14,0(x2)
8000096c:	00011103          	lh	x2,0(x2)
80000970:	ffffd3b7          	lui	x7,0xffffd
80000974:	cdd38393          	addi	x7,x7,-803 # ffffccdd <_end+0x7fffac8d>
80000978:	56711663          	bne	x2,x7,80000ee4 <fail>
8000097c:	00001117          	auipc	x2,0x1
80000980:	68410113          	addi	x2,x2,1668 # 80002000 <begin_signature>
80000984:	00212423          	sw	x2,8(x2)
80000988:	00812203          	lw	x4,8(x2)
8000098c:	00121023          	sh	x1,0(x4) # 0 <_start-0x80000000>
80000990:	54221a63          	bne	x4,x2,80000ee4 <fail>
80000994:	00021703          	lh	x14,0(x4) # 0 <_start-0x80000000>
80000998:	54771663          	bne	x14,x7,80000ee4 <fail>

8000099c <test_33>:
8000099c:	02100193          	addi	x3,x0,33
800009a0:	00001117          	auipc	x2,0x1
800009a4:	66010113          	addi	x2,x2,1632 # 80002000 <begin_signature>
800009a8:	ffffc0b7          	lui	x1,0xffffc
800009ac:	ccd08093          	addi	x1,x1,-819 # ffffbccd <_end+0x7fff9c7d>
800009b0:	00111123          	sh	x1,2(x2)
800009b4:	00211703          	lh	x14,2(x2)
800009b8:	00e11123          	sh	x14,2(x2)
800009bc:	00211103          	lh	x2,2(x2)
800009c0:	ffffc3b7          	lui	x7,0xffffc
800009c4:	ccd38393          	addi	x7,x7,-819 # ffffbccd <_end+0x7fff9c7d>
800009c8:	50711e63          	bne	x2,x7,80000ee4 <fail>
800009cc:	00001117          	auipc	x2,0x1
800009d0:	63410113          	addi	x2,x2,1588 # 80002000 <begin_signature>
800009d4:	00212423          	sw	x2,8(x2)
800009d8:	00812203          	lw	x4,8(x2)
800009dc:	00121123          	sh	x1,2(x4) # 2 <_start-0x7ffffffe>
800009e0:	50221263          	bne	x4,x2,80000ee4 <fail>
800009e4:	00221703          	lh	x14,2(x4) # 2 <_start-0x7ffffffe>
800009e8:	4e771e63          	bne	x14,x7,80000ee4 <fail>

800009ec <test_34>:
800009ec:	02200193          	addi	x3,x0,34
800009f0:	00001117          	auipc	x2,0x1
800009f4:	61010113          	addi	x2,x2,1552 # 80002000 <begin_signature>
800009f8:	ffffc0b7          	lui	x1,0xffffc
800009fc:	bcc08093          	addi	x1,x1,-1076 # ffffbbcc <_end+0x7fff9b7c>
80000a00:	00111223          	sh	x1,4(x2)
80000a04:	00411703          	lh	x14,4(x2)
80000a08:	00e11223          	sh	x14,4(x2)
80000a0c:	00411103          	lh	x2,4(x2)
80000a10:	ffffc3b7          	lui	x7,0xffffc
80000a14:	bcc38393          	addi	x7,x7,-1076 # ffffbbcc <_end+0x7fff9b7c>
80000a18:	4c711663          	bne	x2,x7,80000ee4 <fail>
80000a1c:	00001117          	auipc	x2,0x1
80000a20:	5e410113          	addi	x2,x2,1508 # 80002000 <begin_signature>
80000a24:	00212423          	sw	x2,8(x2)
80000a28:	00812203          	lw	x4,8(x2)
80000a2c:	00121223          	sh	x1,4(x4) # 4 <_start-0x7ffffffc>
80000a30:	4a221a63          	bne	x4,x2,80000ee4 <fail>
80000a34:	00421703          	lh	x14,4(x4) # 4 <_start-0x7ffffffc>
80000a38:	4a771663          	bne	x14,x7,80000ee4 <fail>

80000a3c <test_35>:
80000a3c:	02300193          	addi	x3,x0,35
80000a40:	00001117          	auipc	x2,0x1
80000a44:	5c010113          	addi	x2,x2,1472 # 80002000 <begin_signature>
80000a48:	ffffb0b7          	lui	x1,0xffffb
80000a4c:	bbc08093          	addi	x1,x1,-1092 # ffffabbc <_end+0x7fff8b6c>
80000a50:	00111323          	sh	x1,6(x2)
80000a54:	00611703          	lh	x14,6(x2)
80000a58:	00e11323          	sh	x14,6(x2)
80000a5c:	00611103          	lh	x2,6(x2)
80000a60:	ffffb3b7          	lui	x7,0xffffb
80000a64:	bbc38393          	addi	x7,x7,-1092 # ffffabbc <_end+0x7fff8b6c>
80000a68:	46711e63          	bne	x2,x7,80000ee4 <fail>
80000a6c:	00001117          	auipc	x2,0x1
80000a70:	59410113          	addi	x2,x2,1428 # 80002000 <begin_signature>
80000a74:	00212423          	sw	x2,8(x2)
80000a78:	00812203          	lw	x4,8(x2)
80000a7c:	00121323          	sh	x1,6(x4) # 6 <_start-0x7ffffffa>
80000a80:	46221263          	bne	x4,x2,80000ee4 <fail>
80000a84:	00621703          	lh	x14,6(x4) # 6 <_start-0x7ffffffa>
80000a88:	44771e63          	bne	x14,x7,80000ee4 <fail>

80000a8c <test_36>:
80000a8c:	02400193          	addi	x3,x0,36
80000a90:	00001117          	auipc	x2,0x1
80000a94:	57010113          	addi	x2,x2,1392 # 80002000 <begin_signature>
80000a98:	ffffb0b7          	lui	x1,0xffffb
80000a9c:	abb08093          	addi	x1,x1,-1349 # ffffaabb <_end+0x7fff8a6b>
80000aa0:	00111423          	sh	x1,8(x2)
80000aa4:	00811703          	lh	x14,8(x2)
80000aa8:	00e11423          	sh	x14,8(x2)
80000aac:	00811103          	lh	x2,8(x2)
80000ab0:	ffffb3b7          	lui	x7,0xffffb
80000ab4:	abb38393          	addi	x7,x7,-1349 # ffffaabb <_end+0x7fff8a6b>
80000ab8:	42711663          	bne	x2,x7,80000ee4 <fail>
80000abc:	00001117          	auipc	x2,0x1
80000ac0:	54410113          	addi	x2,x2,1348 # 80002000 <begin_signature>
80000ac4:	00212423          	sw	x2,8(x2)
80000ac8:	00812203          	lw	x4,8(x2)
80000acc:	00121423          	sh	x1,8(x4) # 8 <_start-0x7ffffff8>
80000ad0:	40221a63          	bne	x4,x2,80000ee4 <fail>
80000ad4:	00821703          	lh	x14,8(x4) # 8 <_start-0x7ffffff8>
80000ad8:	40771663          	bne	x14,x7,80000ee4 <fail>

80000adc <test_37>:
80000adc:	02500193          	addi	x3,x0,37
80000ae0:	00001117          	auipc	x2,0x1
80000ae4:	52010113          	addi	x2,x2,1312 # 80002000 <begin_signature>
80000ae8:	ffffe0b7          	lui	x1,0xffffe
80000aec:	aab08093          	addi	x1,x1,-1365 # ffffdaab <_end+0x7fffba5b>
80000af0:	00111523          	sh	x1,10(x2)
80000af4:	00a11703          	lh	x14,10(x2)
80000af8:	00e11523          	sh	x14,10(x2)
80000afc:	00a11103          	lh	x2,10(x2)
80000b00:	ffffe3b7          	lui	x7,0xffffe
80000b04:	aab38393          	addi	x7,x7,-1365 # ffffdaab <_end+0x7fffba5b>
80000b08:	3c711e63          	bne	x2,x7,80000ee4 <fail>
80000b0c:	00001117          	auipc	x2,0x1
80000b10:	4f410113          	addi	x2,x2,1268 # 80002000 <begin_signature>
80000b14:	00212423          	sw	x2,8(x2)
80000b18:	00812203          	lw	x4,8(x2)
80000b1c:	00121523          	sh	x1,10(x4) # a <_start-0x7ffffff6>
80000b20:	3c221263          	bne	x4,x2,80000ee4 <fail>
80000b24:	00a21703          	lh	x14,10(x4) # a <_start-0x7ffffff6>
80000b28:	3a771e63          	bne	x14,x7,80000ee4 <fail>

80000b2c <test_38>:
80000b2c:	02600193          	addi	x3,x0,38
80000b30:	00001117          	auipc	x2,0x1
80000b34:	4d010113          	addi	x2,x2,1232 # 80002000 <begin_signature>
80000b38:	000020b7          	lui	x1,0x2
80000b3c:	23308093          	addi	x1,x1,563 # 2233 <_start-0x7fffddcd>
80000b40:	00111023          	sh	x1,0(x2)
80000b44:	00011703          	lh	x14,0(x2)
80000b48:	00e11023          	sh	x14,0(x2)
80000b4c:	00011103          	lh	x2,0(x2)
80000b50:	000023b7          	lui	x7,0x2
80000b54:	23338393          	addi	x7,x7,563 # 2233 <_start-0x7fffddcd>
80000b58:	38711663          	bne	x2,x7,80000ee4 <fail>
80000b5c:	00001117          	auipc	x2,0x1
80000b60:	4a410113          	addi	x2,x2,1188 # 80002000 <begin_signature>
80000b64:	00212423          	sw	x2,8(x2)
80000b68:	00812203          	lw	x4,8(x2)
80000b6c:	00121023          	sh	x1,0(x4) # 0 <_start-0x80000000>
80000b70:	36221a63          	bne	x4,x2,80000ee4 <fail>
80000b74:	00021703          	lh	x14,0(x4) # 0 <_start-0x80000000>
80000b78:	36771663          	bne	x14,x7,80000ee4 <fail>

80000b7c <test_39>:
80000b7c:	02700193          	addi	x3,x0,39
80000b80:	00001117          	auipc	x2,0x1
80000b84:	48010113          	addi	x2,x2,1152 # 80002000 <begin_signature>
80000b88:	000010b7          	lui	x1,0x1
80000b8c:	22308093          	addi	x1,x1,547 # 1223 <_start-0x7fffeddd>
80000b90:	00111123          	sh	x1,2(x2)
80000b94:	00211703          	lh	x14,2(x2)
80000b98:	00e11123          	sh	x14,2(x2)
80000b9c:	00211103          	lh	x2,2(x2)
80000ba0:	000013b7          	lui	x7,0x1
80000ba4:	22338393          	addi	x7,x7,547 # 1223 <_start-0x7fffeddd>
80000ba8:	32711e63          	bne	x2,x7,80000ee4 <fail>
80000bac:	00001117          	auipc	x2,0x1
80000bb0:	45410113          	addi	x2,x2,1108 # 80002000 <begin_signature>
80000bb4:	00212423          	sw	x2,8(x2)
80000bb8:	00812203          	lw	x4,8(x2)
80000bbc:	00121123          	sh	x1,2(x4) # 2 <_start-0x7ffffffe>
80000bc0:	32221263          	bne	x4,x2,80000ee4 <fail>
80000bc4:	00221703          	lh	x14,2(x4) # 2 <_start-0x7ffffffe>
80000bc8:	30771e63          	bne	x14,x7,80000ee4 <fail>

80000bcc <test_40>:
80000bcc:	02800193          	addi	x3,x0,40
80000bd0:	00001117          	auipc	x2,0x1
80000bd4:	43010113          	addi	x2,x2,1072 # 80002000 <begin_signature>
80000bd8:	000010b7          	lui	x1,0x1
80000bdc:	12208093          	addi	x1,x1,290 # 1122 <_start-0x7fffeede>
80000be0:	00111223          	sh	x1,4(x2)
80000be4:	00411703          	lh	x14,4(x2)
80000be8:	00e11223          	sh	x14,4(x2)
80000bec:	00411103          	lh	x2,4(x2)
80000bf0:	000013b7          	lui	x7,0x1
80000bf4:	12238393          	addi	x7,x7,290 # 1122 <_start-0x7fffeede>
80000bf8:	2e711663          	bne	x2,x7,80000ee4 <fail>
80000bfc:	00001117          	auipc	x2,0x1
80000c00:	40410113          	addi	x2,x2,1028 # 80002000 <begin_signature>
80000c04:	00212423          	sw	x2,8(x2)
80000c08:	00812203          	lw	x4,8(x2)
80000c0c:	00121223          	sh	x1,4(x4) # 4 <_start-0x7ffffffc>
80000c10:	2c221a63          	bne	x4,x2,80000ee4 <fail>
80000c14:	00421703          	lh	x14,4(x4) # 4 <_start-0x7ffffffc>
80000c18:	2c771663          	bne	x14,x7,80000ee4 <fail>

80000c1c <test_41>:
80000c1c:	02900193          	addi	x3,x0,41
80000c20:	00001117          	auipc	x2,0x1
80000c24:	3e010113          	addi	x2,x2,992 # 80002000 <begin_signature>
80000c28:	11200093          	addi	x1,x0,274
80000c2c:	00111323          	sh	x1,6(x2)
80000c30:	00611703          	lh	x14,6(x2)
80000c34:	00e11323          	sh	x14,6(x2)
80000c38:	00611103          	lh	x2,6(x2)
80000c3c:	11200393          	addi	x7,x0,274
80000c40:	2a711263          	bne	x2,x7,80000ee4 <fail>
80000c44:	00001117          	auipc	x2,0x1
80000c48:	3bc10113          	addi	x2,x2,956 # 80002000 <begin_signature>
80000c4c:	00212423          	sw	x2,8(x2)
80000c50:	00812203          	lw	x4,8(x2)
80000c54:	00121323          	sh	x1,6(x4) # 6 <_start-0x7ffffffa>
80000c58:	28221663          	bne	x4,x2,80000ee4 <fail>
80000c5c:	00621703          	lh	x14,6(x4) # 6 <_start-0x7ffffffa>
80000c60:	28771263          	bne	x14,x7,80000ee4 <fail>

80000c64 <test_42>:
80000c64:	02a00193          	addi	x3,x0,42
80000c68:	00001117          	auipc	x2,0x1
80000c6c:	39810113          	addi	x2,x2,920 # 80002000 <begin_signature>
80000c70:	01100093          	addi	x1,x0,17
80000c74:	00111423          	sh	x1,8(x2)
80000c78:	00811703          	lh	x14,8(x2)
80000c7c:	00e11423          	sh	x14,8(x2)
80000c80:	00811103          	lh	x2,8(x2)
80000c84:	01100393          	addi	x7,x0,17
80000c88:	24711e63          	bne	x2,x7,80000ee4 <fail>
80000c8c:	00001117          	auipc	x2,0x1
80000c90:	37410113          	addi	x2,x2,884 # 80002000 <begin_signature>
80000c94:	00212423          	sw	x2,8(x2)
80000c98:	00812203          	lw	x4,8(x2)
80000c9c:	00121423          	sh	x1,8(x4) # 8 <_start-0x7ffffff8>
80000ca0:	24221263          	bne	x4,x2,80000ee4 <fail>
80000ca4:	00821703          	lh	x14,8(x4) # 8 <_start-0x7ffffff8>
80000ca8:	22771e63          	bne	x14,x7,80000ee4 <fail>

80000cac <test_43>:
80000cac:	02b00193          	addi	x3,x0,43
80000cb0:	00001117          	auipc	x2,0x1
80000cb4:	35010113          	addi	x2,x2,848 # 80002000 <begin_signature>
80000cb8:	000030b7          	lui	x1,0x3
80000cbc:	00108093          	addi	x1,x1,1 # 3001 <_start-0x7fffcfff>
80000cc0:	00111523          	sh	x1,10(x2)
80000cc4:	00a11703          	lh	x14,10(x2)
80000cc8:	00e11523          	sh	x14,10(x2)
80000ccc:	00a11103          	lh	x2,10(x2)
80000cd0:	000033b7          	lui	x7,0x3
80000cd4:	00138393          	addi	x7,x7,1 # 3001 <_start-0x7fffcfff>
80000cd8:	20711663          	bne	x2,x7,80000ee4 <fail>
80000cdc:	00001117          	auipc	x2,0x1
80000ce0:	32410113          	addi	x2,x2,804 # 80002000 <begin_signature>
80000ce4:	00212423          	sw	x2,8(x2)
80000ce8:	00812203          	lw	x4,8(x2)
80000cec:	00121523          	sh	x1,10(x4) # a <_start-0x7ffffff6>
80000cf0:	1e221a63          	bne	x4,x2,80000ee4 <fail>
80000cf4:	00a21703          	lh	x14,10(x4) # a <_start-0x7ffffff6>
80000cf8:	1e771663          	bne	x14,x7,80000ee4 <fail>

80000cfc <test_44>:
80000cfc:	02c00193          	addi	x3,x0,44
80000d00:	00001117          	auipc	x2,0x1
80000d04:	30010113          	addi	x2,x2,768 # 80002000 <begin_signature>
80000d08:	000020b7          	lui	x1,0x2
80000d0c:	23308093          	addi	x1,x1,563 # 2233 <_start-0x7fffddcd>
80000d10:	00111023          	sh	x1,0(x2)
80000d14:	00015703          	lhu	x14,0(x2)
80000d18:	00e11023          	sh	x14,0(x2)
80000d1c:	00015103          	lhu	x2,0(x2)
80000d20:	000023b7          	lui	x7,0x2
80000d24:	23338393          	addi	x7,x7,563 # 2233 <_start-0x7fffddcd>
80000d28:	1a711e63          	bne	x2,x7,80000ee4 <fail>
80000d2c:	00001117          	auipc	x2,0x1
80000d30:	2d410113          	addi	x2,x2,724 # 80002000 <begin_signature>
80000d34:	00212423          	sw	x2,8(x2)
80000d38:	00812203          	lw	x4,8(x2)
80000d3c:	00121023          	sh	x1,0(x4) # 0 <_start-0x80000000>
80000d40:	1a221263          	bne	x4,x2,80000ee4 <fail>
80000d44:	00025703          	lhu	x14,0(x4) # 0 <_start-0x80000000>
80000d48:	18771e63          	bne	x14,x7,80000ee4 <fail>

80000d4c <test_45>:
80000d4c:	02d00193          	addi	x3,x0,45
80000d50:	00001117          	auipc	x2,0x1
80000d54:	2b010113          	addi	x2,x2,688 # 80002000 <begin_signature>
80000d58:	000010b7          	lui	x1,0x1
80000d5c:	22308093          	addi	x1,x1,547 # 1223 <_start-0x7fffeddd>
80000d60:	00111123          	sh	x1,2(x2)
80000d64:	00215703          	lhu	x14,2(x2)
80000d68:	00e11123          	sh	x14,2(x2)
80000d6c:	00215103          	lhu	x2,2(x2)
80000d70:	000013b7          	lui	x7,0x1
80000d74:	22338393          	addi	x7,x7,547 # 1223 <_start-0x7fffeddd>
80000d78:	16711663          	bne	x2,x7,80000ee4 <fail>
80000d7c:	00001117          	auipc	x2,0x1
80000d80:	28410113          	addi	x2,x2,644 # 80002000 <begin_signature>
80000d84:	00212423          	sw	x2,8(x2)
80000d88:	00812203          	lw	x4,8(x2)
80000d8c:	00121123          	sh	x1,2(x4) # 2 <_start-0x7ffffffe>
80000d90:	14221a63          	bne	x4,x2,80000ee4 <fail>
80000d94:	00225703          	lhu	x14,2(x4) # 2 <_start-0x7ffffffe>
80000d98:	14771663          	bne	x14,x7,80000ee4 <fail>

80000d9c <test_46>:
80000d9c:	02e00193          	addi	x3,x0,46
80000da0:	00001117          	auipc	x2,0x1
80000da4:	26010113          	addi	x2,x2,608 # 80002000 <begin_signature>
80000da8:	000010b7          	lui	x1,0x1
80000dac:	12208093          	addi	x1,x1,290 # 1122 <_start-0x7fffeede>
80000db0:	00111223          	sh	x1,4(x2)
80000db4:	00415703          	lhu	x14,4(x2)
80000db8:	00e11223          	sh	x14,4(x2)
80000dbc:	00415103          	lhu	x2,4(x2)
80000dc0:	000013b7          	lui	x7,0x1
80000dc4:	12238393          	addi	x7,x7,290 # 1122 <_start-0x7fffeede>
80000dc8:	10711e63          	bne	x2,x7,80000ee4 <fail>
80000dcc:	00001117          	auipc	x2,0x1
80000dd0:	23410113          	addi	x2,x2,564 # 80002000 <begin_signature>
80000dd4:	00212423          	sw	x2,8(x2)
80000dd8:	00812203          	lw	x4,8(x2)
80000ddc:	00121223          	sh	x1,4(x4) # 4 <_start-0x7ffffffc>
80000de0:	10221263          	bne	x4,x2,80000ee4 <fail>
80000de4:	00425703          	lhu	x14,4(x4) # 4 <_start-0x7ffffffc>
80000de8:	0e771e63          	bne	x14,x7,80000ee4 <fail>

80000dec <test_47>:
80000dec:	02f00193          	addi	x3,x0,47
80000df0:	00001117          	auipc	x2,0x1
80000df4:	21010113          	addi	x2,x2,528 # 80002000 <begin_signature>
80000df8:	11200093          	addi	x1,x0,274
80000dfc:	00111323          	sh	x1,6(x2)
80000e00:	00615703          	lhu	x14,6(x2)
80000e04:	00e11323          	sh	x14,6(x2)
80000e08:	00615103          	lhu	x2,6(x2)
80000e0c:	11200393          	addi	x7,x0,274
80000e10:	0c711a63          	bne	x2,x7,80000ee4 <fail>
80000e14:	00001117          	auipc	x2,0x1
80000e18:	1ec10113          	addi	x2,x2,492 # 80002000 <begin_signature>
80000e1c:	00212423          	sw	x2,8(x2)
80000e20:	00812203          	lw	x4,8(x2)
80000e24:	00121323          	sh	x1,6(x4) # 6 <_start-0x7ffffffa>
80000e28:	0a221e63          	bne	x4,x2,80000ee4 <fail>
80000e2c:	00625703          	lhu	x14,6(x4) # 6 <_start-0x7ffffffa>
80000e30:	0a771a63          	bne	x14,x7,80000ee4 <fail>

80000e34 <test_48>:
80000e34:	03000193          	addi	x3,x0,48
80000e38:	00001117          	auipc	x2,0x1
80000e3c:	1c810113          	addi	x2,x2,456 # 80002000 <begin_signature>
80000e40:	01100093          	addi	x1,x0,17
80000e44:	00111423          	sh	x1,8(x2)
80000e48:	00815703          	lhu	x14,8(x2)
80000e4c:	00e11423          	sh	x14,8(x2)
80000e50:	00815103          	lhu	x2,8(x2)
80000e54:	01100393          	addi	x7,x0,17
80000e58:	08711663          	bne	x2,x7,80000ee4 <fail>
80000e5c:	00001117          	auipc	x2,0x1
80000e60:	1a410113          	addi	x2,x2,420 # 80002000 <begin_signature>
80000e64:	00212423          	sw	x2,8(x2)
80000e68:	00812203          	lw	x4,8(x2)
80000e6c:	00121423          	sh	x1,8(x4) # 8 <_start-0x7ffffff8>
80000e70:	06221a63          	bne	x4,x2,80000ee4 <fail>
80000e74:	00825703          	lhu	x14,8(x4) # 8 <_start-0x7ffffff8>
80000e78:	06771663          	bne	x14,x7,80000ee4 <fail>

80000e7c <test_49>:
80000e7c:	03100193          	addi	x3,x0,49
80000e80:	00001117          	auipc	x2,0x1
80000e84:	18010113          	addi	x2,x2,384 # 80002000 <begin_signature>
80000e88:	000030b7          	lui	x1,0x3
80000e8c:	00108093          	addi	x1,x1,1 # 3001 <_start-0x7fffcfff>
80000e90:	00111523          	sh	x1,10(x2)
80000e94:	00a15703          	lhu	x14,10(x2)
80000e98:	00e11523          	sh	x14,10(x2)
80000e9c:	00a15103          	lhu	x2,10(x2)
80000ea0:	000033b7          	lui	x7,0x3
80000ea4:	00138393          	addi	x7,x7,1 # 3001 <_start-0x7fffcfff>
80000ea8:	02711e63          	bne	x2,x7,80000ee4 <fail>
80000eac:	00001117          	auipc	x2,0x1
80000eb0:	15410113          	addi	x2,x2,340 # 80002000 <begin_signature>
80000eb4:	00212423          	sw	x2,8(x2)
80000eb8:	00812203          	lw	x4,8(x2)
80000ebc:	00121523          	sh	x1,10(x4) # a <_start-0x7ffffff6>
80000ec0:	02221263          	bne	x4,x2,80000ee4 <fail>
80000ec4:	00a25703          	lhu	x14,10(x4) # a <_start-0x7ffffff6>
80000ec8:	00771e63          	bne	x14,x7,80000ee4 <fail>
80000ecc:	0ef00513          	addi	x10,x0,239
80000ed0:	00001597          	auipc	x11,0x1
80000ed4:	13058593          	addi	x11,x11,304 # 80002000 <begin_signature>
80000ed8:	00a581a3          	sb	x10,3(x11)
80000edc:	00358603          	lb	x12,3(x11)
80000ee0:	02301063          	bne	x0,x3,80000f00 <pass>

80000ee4 <fail>:
80000ee4:	00018063          	beq	x3,x0,80000ee4 <fail>
80000ee8:	00119193          	slli	x3,x3,0x1
80000eec:	0011e193          	ori	x3,x3,1
80000ef0:	00000297          	auipc	x5,0x0
80000ef4:	11028293          	addi	x5,x5,272 # 80001000 <tohost>
80000ef8:	0032a023          	sw	x3,0(x5)
80000efc:	0000006f          	jal	x0,80000efc <fail+0x18>

80000f00 <pass>:
80000f00:	00000297          	auipc	x5,0x0
80000f04:	10028293          	addi	x5,x5,256 # 80001000 <tohost>
80000f08:	00100313          	addi	x6,x0,1
80000f0c:	0062a023          	sw	x6,0(x5)
80000f10:	0000006f          	jal	x0,80000f10 <pass+0x10>
80000f14:	c0001073          	unimp
80000f18:	00000013          	addi	x0,x0,0
80000f1c:	00000013          	addi	x0,x0,0
80000f20:	00000013          	addi	x0,x0,0
80000f24:	00000013          	addi	x0,x0,0
80000f28:	00000013          	addi	x0,x0,0
80000f2c:	00000013          	addi	x0,x0,0
80000f30:	00000013          	addi	x0,x0,0
80000f34:	00000013          	addi	x0,x0,0
80000f38:	00000013          	addi	x0,x0,0
80000f3c:	00000013          	addi	x0,x0,0
80000f40:	00000013          	addi	x0,x0,0
