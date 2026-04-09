
soc_workspace_rv32ui/elf/sh.elf:     file format elf32-littleriscv


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
80000088:	0aa00093          	addi	x1,x0,170
8000008c:	00000797          	auipc	x15,0x0
80000090:	01478793          	addi	x15,x15,20 # 800000a0 <test_2+0x24>
80000094:	00111023          	sh	x1,0(x2)
80000098:	00011703          	lh	x14,0(x2)
8000009c:	0080006f          	jal	x0,800000a4 <test_2+0x28>
800000a0:	00008713          	addi	x14,x1,0
800000a4:	0aa00393          	addi	x7,x0,170
800000a8:	4c771663          	bne	x14,x7,80000574 <fail>

800000ac <test_3>:
800000ac:	00300193          	addi	x3,x0,3
800000b0:	00002117          	auipc	x2,0x2
800000b4:	f5010113          	addi	x2,x2,-176 # 80002000 <begin_signature>
800000b8:	ffffb0b7          	lui	x1,0xffffb
800000bc:	a0008093          	addi	x1,x1,-1536 # ffffaa00 <_end+0x7fff89e0>
800000c0:	00000797          	auipc	x15,0x0
800000c4:	01478793          	addi	x15,x15,20 # 800000d4 <test_3+0x28>
800000c8:	00111123          	sh	x1,2(x2)
800000cc:	00211703          	lh	x14,2(x2)
800000d0:	0080006f          	jal	x0,800000d8 <test_3+0x2c>
800000d4:	00008713          	addi	x14,x1,0
800000d8:	ffffb3b7          	lui	x7,0xffffb
800000dc:	a0038393          	addi	x7,x7,-1536 # ffffaa00 <_end+0x7fff89e0>
800000e0:	48771a63          	bne	x14,x7,80000574 <fail>

800000e4 <test_4>:
800000e4:	00400193          	addi	x3,x0,4
800000e8:	00002117          	auipc	x2,0x2
800000ec:	f1810113          	addi	x2,x2,-232 # 80002000 <begin_signature>
800000f0:	beef10b7          	lui	x1,0xbeef1
800000f4:	aa008093          	addi	x1,x1,-1376 # beef0aa0 <_end+0x3eeeea80>
800000f8:	00000797          	auipc	x15,0x0
800000fc:	01478793          	addi	x15,x15,20 # 8000010c <test_4+0x28>
80000100:	00111223          	sh	x1,4(x2)
80000104:	00412703          	lw	x14,4(x2)
80000108:	0080006f          	jal	x0,80000110 <test_4+0x2c>
8000010c:	00008713          	addi	x14,x1,0
80000110:	beef13b7          	lui	x7,0xbeef1
80000114:	aa038393          	addi	x7,x7,-1376 # beef0aa0 <_end+0x3eeeea80>
80000118:	44771e63          	bne	x14,x7,80000574 <fail>

8000011c <test_5>:
8000011c:	00500193          	addi	x3,x0,5
80000120:	00002117          	auipc	x2,0x2
80000124:	ee010113          	addi	x2,x2,-288 # 80002000 <begin_signature>
80000128:	ffffa0b7          	lui	x1,0xffffa
8000012c:	00a08093          	addi	x1,x1,10 # ffffa00a <_end+0x7fff7fea>
80000130:	00000797          	auipc	x15,0x0
80000134:	01478793          	addi	x15,x15,20 # 80000144 <test_5+0x28>
80000138:	00111323          	sh	x1,6(x2)
8000013c:	00611703          	lh	x14,6(x2)
80000140:	0080006f          	jal	x0,80000148 <test_5+0x2c>
80000144:	00008713          	addi	x14,x1,0
80000148:	ffffa3b7          	lui	x7,0xffffa
8000014c:	00a38393          	addi	x7,x7,10 # ffffa00a <_end+0x7fff7fea>
80000150:	42771263          	bne	x14,x7,80000574 <fail>

80000154 <test_6>:
80000154:	00600193          	addi	x3,x0,6
80000158:	00002117          	auipc	x2,0x2
8000015c:	eb610113          	addi	x2,x2,-330 # 8000200e <tdat8>
80000160:	0aa00093          	addi	x1,x0,170
80000164:	00000797          	auipc	x15,0x0
80000168:	01478793          	addi	x15,x15,20 # 80000178 <test_6+0x24>
8000016c:	fe111d23          	sh	x1,-6(x2)
80000170:	ffa11703          	lh	x14,-6(x2)
80000174:	0080006f          	jal	x0,8000017c <test_6+0x28>
80000178:	00008713          	addi	x14,x1,0
8000017c:	0aa00393          	addi	x7,x0,170
80000180:	3e771a63          	bne	x14,x7,80000574 <fail>

80000184 <test_7>:
80000184:	00700193          	addi	x3,x0,7
80000188:	00002117          	auipc	x2,0x2
8000018c:	e8610113          	addi	x2,x2,-378 # 8000200e <tdat8>
80000190:	ffffb0b7          	lui	x1,0xffffb
80000194:	a0008093          	addi	x1,x1,-1536 # ffffaa00 <_end+0x7fff89e0>
80000198:	00000797          	auipc	x15,0x0
8000019c:	01478793          	addi	x15,x15,20 # 800001ac <test_7+0x28>
800001a0:	fe111e23          	sh	x1,-4(x2)
800001a4:	ffc11703          	lh	x14,-4(x2)
800001a8:	0080006f          	jal	x0,800001b0 <test_7+0x2c>
800001ac:	00008713          	addi	x14,x1,0
800001b0:	ffffb3b7          	lui	x7,0xffffb
800001b4:	a0038393          	addi	x7,x7,-1536 # ffffaa00 <_end+0x7fff89e0>
800001b8:	3a771e63          	bne	x14,x7,80000574 <fail>

800001bc <test_8>:
800001bc:	00800193          	addi	x3,x0,8
800001c0:	00002117          	auipc	x2,0x2
800001c4:	e4e10113          	addi	x2,x2,-434 # 8000200e <tdat8>
800001c8:	000010b7          	lui	x1,0x1
800001cc:	aa008093          	addi	x1,x1,-1376 # aa0 <_start-0x7ffff560>
800001d0:	00000797          	auipc	x15,0x0
800001d4:	01478793          	addi	x15,x15,20 # 800001e4 <test_8+0x28>
800001d8:	fe111f23          	sh	x1,-2(x2)
800001dc:	ffe11703          	lh	x14,-2(x2)
800001e0:	0080006f          	jal	x0,800001e8 <test_8+0x2c>
800001e4:	00008713          	addi	x14,x1,0
800001e8:	000013b7          	lui	x7,0x1
800001ec:	aa038393          	addi	x7,x7,-1376 # aa0 <_start-0x7ffff560>
800001f0:	38771263          	bne	x14,x7,80000574 <fail>

800001f4 <test_9>:
800001f4:	00900193          	addi	x3,x0,9
800001f8:	00002117          	auipc	x2,0x2
800001fc:	e1610113          	addi	x2,x2,-490 # 8000200e <tdat8>
80000200:	ffffa0b7          	lui	x1,0xffffa
80000204:	00a08093          	addi	x1,x1,10 # ffffa00a <_end+0x7fff7fea>
80000208:	00000797          	auipc	x15,0x0
8000020c:	01478793          	addi	x15,x15,20 # 8000021c <test_9+0x28>
80000210:	00111023          	sh	x1,0(x2)
80000214:	00011703          	lh	x14,0(x2)
80000218:	0080006f          	jal	x0,80000220 <test_9+0x2c>
8000021c:	00008713          	addi	x14,x1,0
80000220:	ffffa3b7          	lui	x7,0xffffa
80000224:	00a38393          	addi	x7,x7,10 # ffffa00a <_end+0x7fff7fea>
80000228:	34771663          	bne	x14,x7,80000574 <fail>

8000022c <test_10>:
8000022c:	00a00193          	addi	x3,x0,10
80000230:	00002097          	auipc	x1,0x2
80000234:	de008093          	addi	x1,x1,-544 # 80002010 <tdat9>
80000238:	12345137          	lui	x2,0x12345
8000023c:	67810113          	addi	x2,x2,1656 # 12345678 <_start-0x6dcba988>
80000240:	fe008213          	addi	x4,x1,-32
80000244:	02221023          	sh	x2,32(x4) # 20 <_start-0x7fffffe0>
80000248:	00009283          	lh	x5,0(x1)
8000024c:	000053b7          	lui	x7,0x5
80000250:	67838393          	addi	x7,x7,1656 # 5678 <_start-0x7fffa988>
80000254:	32729063          	bne	x5,x7,80000574 <fail>

80000258 <test_11>:
80000258:	00b00193          	addi	x3,x0,11
8000025c:	00002097          	auipc	x1,0x2
80000260:	db408093          	addi	x1,x1,-588 # 80002010 <tdat9>
80000264:	00003137          	lui	x2,0x3
80000268:	09810113          	addi	x2,x2,152 # 3098 <_start-0x7fffcf68>
8000026c:	ffb08093          	addi	x1,x1,-5
80000270:	002093a3          	sh	x2,7(x1)
80000274:	00002217          	auipc	x4,0x2
80000278:	d9e20213          	addi	x4,x4,-610 # 80002012 <tdat10>
8000027c:	00021283          	lh	x5,0(x4) # 0 <_start-0x80000000>
80000280:	000033b7          	lui	x7,0x3
80000284:	09838393          	addi	x7,x7,152 # 3098 <_start-0x7fffcf68>
80000288:	2e729663          	bne	x5,x7,80000574 <fail>

8000028c <test_12>:
8000028c:	00c00193          	addi	x3,x0,12
80000290:	00000213          	addi	x4,x0,0
80000294:	ffffd6b7          	lui	x13,0xffffd
80000298:	cdd68693          	addi	x13,x13,-803 # ffffccdd <_end+0x7fffacbd>
8000029c:	00002617          	auipc	x12,0x2
800002a0:	d6460613          	addi	x12,x12,-668 # 80002000 <begin_signature>
800002a4:	00d61023          	sh	x13,0(x12)
800002a8:	00061703          	lh	x14,0(x12)
800002ac:	ffffd3b7          	lui	x7,0xffffd
800002b0:	cdd38393          	addi	x7,x7,-803 # ffffccdd <_end+0x7fffacbd>
800002b4:	2c771063          	bne	x14,x7,80000574 <fail>
800002b8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002bc:	00200293          	addi	x5,x0,2
800002c0:	fc521ae3          	bne	x4,x5,80000294 <test_12+0x8>

800002c4 <test_13>:
800002c4:	00d00193          	addi	x3,x0,13
800002c8:	00000213          	addi	x4,x0,0
800002cc:	ffffc6b7          	lui	x13,0xffffc
800002d0:	ccd68693          	addi	x13,x13,-819 # ffffbccd <_end+0x7fff9cad>
800002d4:	00002617          	auipc	x12,0x2
800002d8:	d2c60613          	addi	x12,x12,-724 # 80002000 <begin_signature>
800002dc:	00000013          	addi	x0,x0,0
800002e0:	00d61123          	sh	x13,2(x12)
800002e4:	00261703          	lh	x14,2(x12)
800002e8:	ffffc3b7          	lui	x7,0xffffc
800002ec:	ccd38393          	addi	x7,x7,-819 # ffffbccd <_end+0x7fff9cad>
800002f0:	28771263          	bne	x14,x7,80000574 <fail>
800002f4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002f8:	00200293          	addi	x5,x0,2
800002fc:	fc5218e3          	bne	x4,x5,800002cc <test_13+0x8>

80000300 <test_14>:
80000300:	00e00193          	addi	x3,x0,14
80000304:	00000213          	addi	x4,x0,0
80000308:	ffffc6b7          	lui	x13,0xffffc
8000030c:	bcc68693          	addi	x13,x13,-1076 # ffffbbcc <_end+0x7fff9bac>
80000310:	00002617          	auipc	x12,0x2
80000314:	cf060613          	addi	x12,x12,-784 # 80002000 <begin_signature>
80000318:	00000013          	addi	x0,x0,0
8000031c:	00000013          	addi	x0,x0,0
80000320:	00d61223          	sh	x13,4(x12)
80000324:	00461703          	lh	x14,4(x12)
80000328:	ffffc3b7          	lui	x7,0xffffc
8000032c:	bcc38393          	addi	x7,x7,-1076 # ffffbbcc <_end+0x7fff9bac>
80000330:	24771263          	bne	x14,x7,80000574 <fail>
80000334:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000338:	00200293          	addi	x5,x0,2
8000033c:	fc5216e3          	bne	x4,x5,80000308 <test_14+0x8>

80000340 <test_15>:
80000340:	00f00193          	addi	x3,x0,15
80000344:	00000213          	addi	x4,x0,0
80000348:	ffffb6b7          	lui	x13,0xffffb
8000034c:	bbc68693          	addi	x13,x13,-1092 # ffffabbc <_end+0x7fff8b9c>
80000350:	00000013          	addi	x0,x0,0
80000354:	00002617          	auipc	x12,0x2
80000358:	cac60613          	addi	x12,x12,-852 # 80002000 <begin_signature>
8000035c:	00d61323          	sh	x13,6(x12)
80000360:	00661703          	lh	x14,6(x12)
80000364:	ffffb3b7          	lui	x7,0xffffb
80000368:	bbc38393          	addi	x7,x7,-1092 # ffffabbc <_end+0x7fff8b9c>
8000036c:	20771463          	bne	x14,x7,80000574 <fail>
80000370:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000374:	00200293          	addi	x5,x0,2
80000378:	fc5218e3          	bne	x4,x5,80000348 <test_15+0x8>

8000037c <test_16>:
8000037c:	01000193          	addi	x3,x0,16
80000380:	00000213          	addi	x4,x0,0
80000384:	ffffb6b7          	lui	x13,0xffffb
80000388:	abb68693          	addi	x13,x13,-1349 # ffffaabb <_end+0x7fff8a9b>
8000038c:	00000013          	addi	x0,x0,0
80000390:	00002617          	auipc	x12,0x2
80000394:	c7060613          	addi	x12,x12,-912 # 80002000 <begin_signature>
80000398:	00000013          	addi	x0,x0,0
8000039c:	00d61423          	sh	x13,8(x12)
800003a0:	00861703          	lh	x14,8(x12)
800003a4:	ffffb3b7          	lui	x7,0xffffb
800003a8:	abb38393          	addi	x7,x7,-1349 # ffffaabb <_end+0x7fff8a9b>
800003ac:	1c771463          	bne	x14,x7,80000574 <fail>
800003b0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800003b4:	00200293          	addi	x5,x0,2
800003b8:	fc5216e3          	bne	x4,x5,80000384 <test_16+0x8>

800003bc <test_17>:
800003bc:	01100193          	addi	x3,x0,17
800003c0:	00000213          	addi	x4,x0,0
800003c4:	ffffe6b7          	lui	x13,0xffffe
800003c8:	aab68693          	addi	x13,x13,-1365 # ffffdaab <_end+0x7fffba8b>
800003cc:	00000013          	addi	x0,x0,0
800003d0:	00000013          	addi	x0,x0,0
800003d4:	00002617          	auipc	x12,0x2
800003d8:	c2c60613          	addi	x12,x12,-980 # 80002000 <begin_signature>
800003dc:	00d61523          	sh	x13,10(x12)
800003e0:	00a61703          	lh	x14,10(x12)
800003e4:	ffffe3b7          	lui	x7,0xffffe
800003e8:	aab38393          	addi	x7,x7,-1365 # ffffdaab <_end+0x7fffba8b>
800003ec:	18771463          	bne	x14,x7,80000574 <fail>
800003f0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800003f4:	00200293          	addi	x5,x0,2
800003f8:	fc5216e3          	bne	x4,x5,800003c4 <test_17+0x8>

800003fc <test_18>:
800003fc:	01200193          	addi	x3,x0,18
80000400:	00000213          	addi	x4,x0,0
80000404:	00002117          	auipc	x2,0x2
80000408:	bfc10113          	addi	x2,x2,-1028 # 80002000 <begin_signature>
8000040c:	000020b7          	lui	x1,0x2
80000410:	23308093          	addi	x1,x1,563 # 2233 <_start-0x7fffddcd>
80000414:	00111023          	sh	x1,0(x2)
80000418:	00011703          	lh	x14,0(x2)
8000041c:	000023b7          	lui	x7,0x2
80000420:	23338393          	addi	x7,x7,563 # 2233 <_start-0x7fffddcd>
80000424:	14771863          	bne	x14,x7,80000574 <fail>
80000428:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000042c:	00200293          	addi	x5,x0,2
80000430:	fc521ae3          	bne	x4,x5,80000404 <test_18+0x8>

80000434 <test_19>:
80000434:	01300193          	addi	x3,x0,19
80000438:	00000213          	addi	x4,x0,0
8000043c:	00002117          	auipc	x2,0x2
80000440:	bc410113          	addi	x2,x2,-1084 # 80002000 <begin_signature>
80000444:	000010b7          	lui	x1,0x1
80000448:	22308093          	addi	x1,x1,547 # 1223 <_start-0x7fffeddd>
8000044c:	00000013          	addi	x0,x0,0
80000450:	00111123          	sh	x1,2(x2)
80000454:	00211703          	lh	x14,2(x2)
80000458:	000013b7          	lui	x7,0x1
8000045c:	22338393          	addi	x7,x7,547 # 1223 <_start-0x7fffeddd>
80000460:	10771a63          	bne	x14,x7,80000574 <fail>
80000464:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000468:	00200293          	addi	x5,x0,2
8000046c:	fc5218e3          	bne	x4,x5,8000043c <test_19+0x8>

80000470 <test_20>:
80000470:	01400193          	addi	x3,x0,20
80000474:	00000213          	addi	x4,x0,0
80000478:	00002117          	auipc	x2,0x2
8000047c:	b8810113          	addi	x2,x2,-1144 # 80002000 <begin_signature>
80000480:	000010b7          	lui	x1,0x1
80000484:	12208093          	addi	x1,x1,290 # 1122 <_start-0x7fffeede>
80000488:	00000013          	addi	x0,x0,0
8000048c:	00000013          	addi	x0,x0,0
80000490:	00111223          	sh	x1,4(x2)
80000494:	00411703          	lh	x14,4(x2)
80000498:	000013b7          	lui	x7,0x1
8000049c:	12238393          	addi	x7,x7,290 # 1122 <_start-0x7fffeede>
800004a0:	0c771a63          	bne	x14,x7,80000574 <fail>
800004a4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800004a8:	00200293          	addi	x5,x0,2
800004ac:	fc5216e3          	bne	x4,x5,80000478 <test_20+0x8>

800004b0 <test_21>:
800004b0:	01500193          	addi	x3,x0,21
800004b4:	00000213          	addi	x4,x0,0
800004b8:	00002117          	auipc	x2,0x2
800004bc:	b4810113          	addi	x2,x2,-1208 # 80002000 <begin_signature>
800004c0:	00000013          	addi	x0,x0,0
800004c4:	11200093          	addi	x1,x0,274
800004c8:	00111323          	sh	x1,6(x2)
800004cc:	00611703          	lh	x14,6(x2)
800004d0:	11200393          	addi	x7,x0,274
800004d4:	0a771063          	bne	x14,x7,80000574 <fail>
800004d8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800004dc:	00200293          	addi	x5,x0,2
800004e0:	fc521ce3          	bne	x4,x5,800004b8 <test_21+0x8>

800004e4 <test_22>:
800004e4:	01600193          	addi	x3,x0,22
800004e8:	00000213          	addi	x4,x0,0
800004ec:	00002117          	auipc	x2,0x2
800004f0:	b1410113          	addi	x2,x2,-1260 # 80002000 <begin_signature>
800004f4:	00000013          	addi	x0,x0,0
800004f8:	01100093          	addi	x1,x0,17
800004fc:	00000013          	addi	x0,x0,0
80000500:	00111423          	sh	x1,8(x2)
80000504:	00811703          	lh	x14,8(x2)
80000508:	01100393          	addi	x7,x0,17
8000050c:	06771463          	bne	x14,x7,80000574 <fail>
80000510:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000514:	00200293          	addi	x5,x0,2
80000518:	fc521ae3          	bne	x4,x5,800004ec <test_22+0x8>

8000051c <test_23>:
8000051c:	01700193          	addi	x3,x0,23
80000520:	00000213          	addi	x4,x0,0
80000524:	00002117          	auipc	x2,0x2
80000528:	adc10113          	addi	x2,x2,-1316 # 80002000 <begin_signature>
8000052c:	00000013          	addi	x0,x0,0
80000530:	00000013          	addi	x0,x0,0
80000534:	000030b7          	lui	x1,0x3
80000538:	00108093          	addi	x1,x1,1 # 3001 <_start-0x7fffcfff>
8000053c:	00111523          	sh	x1,10(x2)
80000540:	00a11703          	lh	x14,10(x2)
80000544:	000033b7          	lui	x7,0x3
80000548:	00138393          	addi	x7,x7,1 # 3001 <_start-0x7fffcfff>
8000054c:	02771463          	bne	x14,x7,80000574 <fail>
80000550:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000554:	00200293          	addi	x5,x0,2
80000558:	fc5216e3          	bne	x4,x5,80000524 <test_23+0x8>
8000055c:	0000c537          	lui	x10,0xc
80000560:	eef50513          	addi	x10,x10,-273 # beef <_start-0x7fff4111>
80000564:	00002597          	auipc	x11,0x2
80000568:	a9c58593          	addi	x11,x11,-1380 # 80002000 <begin_signature>
8000056c:	00a59323          	sh	x10,6(x11)
80000570:	02301063          	bne	x0,x3,80000590 <pass>

80000574 <fail>:
80000574:	00018063          	beq	x3,x0,80000574 <fail>
80000578:	00119193          	slli	x3,x3,0x1
8000057c:	0011e193          	ori	x3,x3,1
80000580:	00001297          	auipc	x5,0x1
80000584:	a8028293          	addi	x5,x5,-1408 # 80001000 <tohost>
80000588:	0032a023          	sw	x3,0(x5)
8000058c:	0000006f          	jal	x0,8000058c <fail+0x18>

80000590 <pass>:
80000590:	00001297          	auipc	x5,0x1
80000594:	a7028293          	addi	x5,x5,-1424 # 80001000 <tohost>
80000598:	00100313          	addi	x6,x0,1
8000059c:	0062a023          	sw	x6,0(x5)
800005a0:	0000006f          	jal	x0,800005a0 <pass+0x10>
800005a4:	c0001073          	unimp
800005a8:	00000013          	addi	x0,x0,0
800005ac:	00000013          	addi	x0,x0,0
800005b0:	00000013          	addi	x0,x0,0
800005b4:	00000013          	addi	x0,x0,0
800005b8:	00000013          	addi	x0,x0,0
800005bc:	00000013          	addi	x0,x0,0
800005c0:	00000013          	addi	x0,x0,0
