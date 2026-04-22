
/home/hbyasts/riscv-tool/self/riscv-tests/elf/st_ld.elf:     file format elf32-littleriscv


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
80000094:	fdd00393          	addi	x7,x0,-35
80000098:	6c771663          	bne	x14,x7,80000764 <fail>

8000009c <test_3>:
8000009c:	00300193          	addi	x3,x0,3
800000a0:	00002117          	auipc	x2,0x2
800000a4:	f6010113          	addi	x2,x2,-160 # 80002000 <begin_signature>
800000a8:	fcd00093          	addi	x1,x0,-51
800000ac:	001100a3          	sb	x1,1(x2)
800000b0:	00110703          	lb	x14,1(x2)
800000b4:	fcd00393          	addi	x7,x0,-51
800000b8:	6a771663          	bne	x14,x7,80000764 <fail>

800000bc <test_4>:
800000bc:	00400193          	addi	x3,x0,4
800000c0:	00002117          	auipc	x2,0x2
800000c4:	f4010113          	addi	x2,x2,-192 # 80002000 <begin_signature>
800000c8:	fcc00093          	addi	x1,x0,-52
800000cc:	00110123          	sb	x1,2(x2)
800000d0:	00210703          	lb	x14,2(x2)
800000d4:	fcc00393          	addi	x7,x0,-52
800000d8:	68771663          	bne	x14,x7,80000764 <fail>

800000dc <test_5>:
800000dc:	00500193          	addi	x3,x0,5
800000e0:	00002117          	auipc	x2,0x2
800000e4:	f2010113          	addi	x2,x2,-224 # 80002000 <begin_signature>
800000e8:	fbc00093          	addi	x1,x0,-68
800000ec:	001101a3          	sb	x1,3(x2)
800000f0:	00310703          	lb	x14,3(x2)
800000f4:	fbc00393          	addi	x7,x0,-68
800000f8:	66771663          	bne	x14,x7,80000764 <fail>

800000fc <test_6>:
800000fc:	00600193          	addi	x3,x0,6
80000100:	00002117          	auipc	x2,0x2
80000104:	f0010113          	addi	x2,x2,-256 # 80002000 <begin_signature>
80000108:	fbb00093          	addi	x1,x0,-69
8000010c:	00110223          	sb	x1,4(x2)
80000110:	00410703          	lb	x14,4(x2)
80000114:	fbb00393          	addi	x7,x0,-69
80000118:	64771663          	bne	x14,x7,80000764 <fail>

8000011c <test_7>:
8000011c:	00700193          	addi	x3,x0,7
80000120:	00002117          	auipc	x2,0x2
80000124:	ee010113          	addi	x2,x2,-288 # 80002000 <begin_signature>
80000128:	fab00093          	addi	x1,x0,-85
8000012c:	001102a3          	sb	x1,5(x2)
80000130:	00510703          	lb	x14,5(x2)
80000134:	fab00393          	addi	x7,x0,-85
80000138:	62771663          	bne	x14,x7,80000764 <fail>

8000013c <test_8>:
8000013c:	00800193          	addi	x3,x0,8
80000140:	00002117          	auipc	x2,0x2
80000144:	ec010113          	addi	x2,x2,-320 # 80002000 <begin_signature>
80000148:	03300093          	addi	x1,x0,51
8000014c:	00110023          	sb	x1,0(x2)
80000150:	00010703          	lb	x14,0(x2)
80000154:	03300393          	addi	x7,x0,51
80000158:	60771663          	bne	x14,x7,80000764 <fail>

8000015c <test_9>:
8000015c:	00900193          	addi	x3,x0,9
80000160:	00002117          	auipc	x2,0x2
80000164:	ea010113          	addi	x2,x2,-352 # 80002000 <begin_signature>
80000168:	02300093          	addi	x1,x0,35
8000016c:	001100a3          	sb	x1,1(x2)
80000170:	00110703          	lb	x14,1(x2)
80000174:	02300393          	addi	x7,x0,35
80000178:	5e771663          	bne	x14,x7,80000764 <fail>

8000017c <test_10>:
8000017c:	00a00193          	addi	x3,x0,10
80000180:	00002117          	auipc	x2,0x2
80000184:	e8010113          	addi	x2,x2,-384 # 80002000 <begin_signature>
80000188:	02200093          	addi	x1,x0,34
8000018c:	00110123          	sb	x1,2(x2)
80000190:	00210703          	lb	x14,2(x2)
80000194:	02200393          	addi	x7,x0,34
80000198:	5c771663          	bne	x14,x7,80000764 <fail>

8000019c <test_11>:
8000019c:	00b00193          	addi	x3,x0,11
800001a0:	00002117          	auipc	x2,0x2
800001a4:	e6010113          	addi	x2,x2,-416 # 80002000 <begin_signature>
800001a8:	01200093          	addi	x1,x0,18
800001ac:	001101a3          	sb	x1,3(x2)
800001b0:	00310703          	lb	x14,3(x2)
800001b4:	01200393          	addi	x7,x0,18
800001b8:	5a771663          	bne	x14,x7,80000764 <fail>

800001bc <test_12>:
800001bc:	00c00193          	addi	x3,x0,12
800001c0:	00002117          	auipc	x2,0x2
800001c4:	e4010113          	addi	x2,x2,-448 # 80002000 <begin_signature>
800001c8:	01100093          	addi	x1,x0,17
800001cc:	00110223          	sb	x1,4(x2)
800001d0:	00410703          	lb	x14,4(x2)
800001d4:	01100393          	addi	x7,x0,17
800001d8:	58771663          	bne	x14,x7,80000764 <fail>

800001dc <test_13>:
800001dc:	00d00193          	addi	x3,x0,13
800001e0:	00002117          	auipc	x2,0x2
800001e4:	e2010113          	addi	x2,x2,-480 # 80002000 <begin_signature>
800001e8:	00100093          	addi	x1,x0,1
800001ec:	001102a3          	sb	x1,5(x2)
800001f0:	00510703          	lb	x14,5(x2)
800001f4:	00100393          	addi	x7,x0,1
800001f8:	56771663          	bne	x14,x7,80000764 <fail>

800001fc <test_14>:
800001fc:	00e00193          	addi	x3,x0,14
80000200:	00002117          	auipc	x2,0x2
80000204:	e0010113          	addi	x2,x2,-512 # 80002000 <begin_signature>
80000208:	03300093          	addi	x1,x0,51
8000020c:	00110023          	sb	x1,0(x2)
80000210:	00014703          	lbu	x14,0(x2)
80000214:	03300393          	addi	x7,x0,51
80000218:	54771663          	bne	x14,x7,80000764 <fail>

8000021c <test_15>:
8000021c:	00f00193          	addi	x3,x0,15
80000220:	00002117          	auipc	x2,0x2
80000224:	de010113          	addi	x2,x2,-544 # 80002000 <begin_signature>
80000228:	02300093          	addi	x1,x0,35
8000022c:	001100a3          	sb	x1,1(x2)
80000230:	00114703          	lbu	x14,1(x2)
80000234:	02300393          	addi	x7,x0,35
80000238:	52771663          	bne	x14,x7,80000764 <fail>

8000023c <test_16>:
8000023c:	01000193          	addi	x3,x0,16
80000240:	00002117          	auipc	x2,0x2
80000244:	dc010113          	addi	x2,x2,-576 # 80002000 <begin_signature>
80000248:	02200093          	addi	x1,x0,34
8000024c:	00110123          	sb	x1,2(x2)
80000250:	00214703          	lbu	x14,2(x2)
80000254:	02200393          	addi	x7,x0,34
80000258:	50771663          	bne	x14,x7,80000764 <fail>

8000025c <test_17>:
8000025c:	01100193          	addi	x3,x0,17
80000260:	00002117          	auipc	x2,0x2
80000264:	da010113          	addi	x2,x2,-608 # 80002000 <begin_signature>
80000268:	01200093          	addi	x1,x0,18
8000026c:	001101a3          	sb	x1,3(x2)
80000270:	00314703          	lbu	x14,3(x2)
80000274:	01200393          	addi	x7,x0,18
80000278:	4e771663          	bne	x14,x7,80000764 <fail>

8000027c <test_18>:
8000027c:	01200193          	addi	x3,x0,18
80000280:	00002117          	auipc	x2,0x2
80000284:	d8010113          	addi	x2,x2,-640 # 80002000 <begin_signature>
80000288:	01100093          	addi	x1,x0,17
8000028c:	00110223          	sb	x1,4(x2)
80000290:	00414703          	lbu	x14,4(x2)
80000294:	01100393          	addi	x7,x0,17
80000298:	4c771663          	bne	x14,x7,80000764 <fail>

8000029c <test_19>:
8000029c:	01300193          	addi	x3,x0,19
800002a0:	00002117          	auipc	x2,0x2
800002a4:	d6010113          	addi	x2,x2,-672 # 80002000 <begin_signature>
800002a8:	00100093          	addi	x1,x0,1
800002ac:	001102a3          	sb	x1,5(x2)
800002b0:	00514703          	lbu	x14,5(x2)
800002b4:	00100393          	addi	x7,x0,1
800002b8:	4a771663          	bne	x14,x7,80000764 <fail>

800002bc <test_20>:
800002bc:	01400193          	addi	x3,x0,20
800002c0:	00002117          	auipc	x2,0x2
800002c4:	d4010113          	addi	x2,x2,-704 # 80002000 <begin_signature>
800002c8:	aabbd0b7          	lui	x1,0xaabbd
800002cc:	cdd08093          	addi	x1,x1,-803 # aabbccdd <_end+0x2abbac8d>
800002d0:	00112023          	sw	x1,0(x2)
800002d4:	00012703          	lw	x14,0(x2)
800002d8:	aabbd3b7          	lui	x7,0xaabbd
800002dc:	cdd38393          	addi	x7,x7,-803 # aabbccdd <_end+0x2abbac8d>
800002e0:	48771263          	bne	x14,x7,80000764 <fail>

800002e4 <test_21>:
800002e4:	01500193          	addi	x3,x0,21
800002e8:	00002117          	auipc	x2,0x2
800002ec:	d1810113          	addi	x2,x2,-744 # 80002000 <begin_signature>
800002f0:	daabc0b7          	lui	x1,0xdaabc
800002f4:	ccd08093          	addi	x1,x1,-819 # daabbccd <_end+0x5aab9c7d>
800002f8:	00112223          	sw	x1,4(x2)
800002fc:	00412703          	lw	x14,4(x2)
80000300:	daabc3b7          	lui	x7,0xdaabc
80000304:	ccd38393          	addi	x7,x7,-819 # daabbccd <_end+0x5aab9c7d>
80000308:	44771e63          	bne	x14,x7,80000764 <fail>

8000030c <test_22>:
8000030c:	01600193          	addi	x3,x0,22
80000310:	00002117          	auipc	x2,0x2
80000314:	cf010113          	addi	x2,x2,-784 # 80002000 <begin_signature>
80000318:	ddaac0b7          	lui	x1,0xddaac
8000031c:	bcc08093          	addi	x1,x1,-1076 # ddaabbcc <_end+0x5daa9b7c>
80000320:	00112423          	sw	x1,8(x2)
80000324:	00812703          	lw	x14,8(x2)
80000328:	ddaac3b7          	lui	x7,0xddaac
8000032c:	bcc38393          	addi	x7,x7,-1076 # ddaabbcc <_end+0x5daa9b7c>
80000330:	42771a63          	bne	x14,x7,80000764 <fail>

80000334 <test_23>:
80000334:	01700193          	addi	x3,x0,23
80000338:	00002117          	auipc	x2,0x2
8000033c:	cc810113          	addi	x2,x2,-824 # 80002000 <begin_signature>
80000340:	cddab0b7          	lui	x1,0xcddab
80000344:	bbc08093          	addi	x1,x1,-1092 # cddaabbc <_end+0x4dda8b6c>
80000348:	00112623          	sw	x1,12(x2)
8000034c:	00c12703          	lw	x14,12(x2)
80000350:	cddab3b7          	lui	x7,0xcddab
80000354:	bbc38393          	addi	x7,x7,-1092 # cddaabbc <_end+0x4dda8b6c>
80000358:	40771663          	bne	x14,x7,80000764 <fail>

8000035c <test_24>:
8000035c:	01800193          	addi	x3,x0,24
80000360:	00002117          	auipc	x2,0x2
80000364:	ca010113          	addi	x2,x2,-864 # 80002000 <begin_signature>
80000368:	ccddb0b7          	lui	x1,0xccddb
8000036c:	abb08093          	addi	x1,x1,-1349 # ccddaabb <_end+0x4cdd8a6b>
80000370:	00112823          	sw	x1,16(x2)
80000374:	01012703          	lw	x14,16(x2)
80000378:	ccddb3b7          	lui	x7,0xccddb
8000037c:	abb38393          	addi	x7,x7,-1349 # ccddaabb <_end+0x4cdd8a6b>
80000380:	3e771263          	bne	x14,x7,80000764 <fail>

80000384 <test_25>:
80000384:	01900193          	addi	x3,x0,25
80000388:	00002117          	auipc	x2,0x2
8000038c:	c7810113          	addi	x2,x2,-904 # 80002000 <begin_signature>
80000390:	bccde0b7          	lui	x1,0xbccde
80000394:	aab08093          	addi	x1,x1,-1365 # bccddaab <_end+0x3ccdba5b>
80000398:	00112a23          	sw	x1,20(x2)
8000039c:	01412703          	lw	x14,20(x2)
800003a0:	bccde3b7          	lui	x7,0xbccde
800003a4:	aab38393          	addi	x7,x7,-1365 # bccddaab <_end+0x3ccdba5b>
800003a8:	3a771e63          	bne	x14,x7,80000764 <fail>

800003ac <test_26>:
800003ac:	01a00193          	addi	x3,x0,26
800003b0:	00002117          	auipc	x2,0x2
800003b4:	c5010113          	addi	x2,x2,-944 # 80002000 <begin_signature>
800003b8:	001120b7          	lui	x1,0x112
800003bc:	23308093          	addi	x1,x1,563 # 112233 <_start-0x7feeddcd>
800003c0:	00112023          	sw	x1,0(x2)
800003c4:	00012703          	lw	x14,0(x2)
800003c8:	001123b7          	lui	x7,0x112
800003cc:	23338393          	addi	x7,x7,563 # 112233 <_start-0x7feeddcd>
800003d0:	38771a63          	bne	x14,x7,80000764 <fail>

800003d4 <test_27>:
800003d4:	01b00193          	addi	x3,x0,27
800003d8:	00002117          	auipc	x2,0x2
800003dc:	c2810113          	addi	x2,x2,-984 # 80002000 <begin_signature>
800003e0:	300110b7          	lui	x1,0x30011
800003e4:	22308093          	addi	x1,x1,547 # 30011223 <_start-0x4ffeeddd>
800003e8:	00112223          	sw	x1,4(x2)
800003ec:	00412703          	lw	x14,4(x2)
800003f0:	300113b7          	lui	x7,0x30011
800003f4:	22338393          	addi	x7,x7,547 # 30011223 <_start-0x4ffeeddd>
800003f8:	36771663          	bne	x14,x7,80000764 <fail>

800003fc <test_28>:
800003fc:	01c00193          	addi	x3,x0,28
80000400:	00002117          	auipc	x2,0x2
80000404:	c0010113          	addi	x2,x2,-1024 # 80002000 <begin_signature>
80000408:	330010b7          	lui	x1,0x33001
8000040c:	12208093          	addi	x1,x1,290 # 33001122 <_start-0x4cffeede>
80000410:	00112423          	sw	x1,8(x2)
80000414:	00812703          	lw	x14,8(x2)
80000418:	330013b7          	lui	x7,0x33001
8000041c:	12238393          	addi	x7,x7,290 # 33001122 <_start-0x4cffeede>
80000420:	34771263          	bne	x14,x7,80000764 <fail>

80000424 <test_29>:
80000424:	01d00193          	addi	x3,x0,29
80000428:	00002117          	auipc	x2,0x2
8000042c:	bd810113          	addi	x2,x2,-1064 # 80002000 <begin_signature>
80000430:	233000b7          	lui	x1,0x23300
80000434:	11208093          	addi	x1,x1,274 # 23300112 <_start-0x5ccffeee>
80000438:	00112623          	sw	x1,12(x2)
8000043c:	00c12703          	lw	x14,12(x2)
80000440:	233003b7          	lui	x7,0x23300
80000444:	11238393          	addi	x7,x7,274 # 23300112 <_start-0x5ccffeee>
80000448:	30771e63          	bne	x14,x7,80000764 <fail>

8000044c <test_30>:
8000044c:	01e00193          	addi	x3,x0,30
80000450:	00002117          	auipc	x2,0x2
80000454:	bb010113          	addi	x2,x2,-1104 # 80002000 <begin_signature>
80000458:	223300b7          	lui	x1,0x22330
8000045c:	01108093          	addi	x1,x1,17 # 22330011 <_start-0x5dccffef>
80000460:	00112823          	sw	x1,16(x2)
80000464:	01012703          	lw	x14,16(x2)
80000468:	223303b7          	lui	x7,0x22330
8000046c:	01138393          	addi	x7,x7,17 # 22330011 <_start-0x5dccffef>
80000470:	2e771a63          	bne	x14,x7,80000764 <fail>

80000474 <test_31>:
80000474:	01f00193          	addi	x3,x0,31
80000478:	00002117          	auipc	x2,0x2
8000047c:	b8810113          	addi	x2,x2,-1144 # 80002000 <begin_signature>
80000480:	122330b7          	lui	x1,0x12233
80000484:	00108093          	addi	x1,x1,1 # 12233001 <_start-0x6ddccfff>
80000488:	00112a23          	sw	x1,20(x2)
8000048c:	01412703          	lw	x14,20(x2)
80000490:	122333b7          	lui	x7,0x12233
80000494:	00138393          	addi	x7,x7,1 # 12233001 <_start-0x6ddccfff>
80000498:	2c771663          	bne	x14,x7,80000764 <fail>

8000049c <test_32>:
8000049c:	02000193          	addi	x3,x0,32
800004a0:	00002117          	auipc	x2,0x2
800004a4:	b6010113          	addi	x2,x2,-1184 # 80002000 <begin_signature>
800004a8:	ffffd0b7          	lui	x1,0xffffd
800004ac:	cdd08093          	addi	x1,x1,-803 # ffffccdd <_end+0x7fffac8d>
800004b0:	00111023          	sh	x1,0(x2)
800004b4:	00011703          	lh	x14,0(x2)
800004b8:	ffffd3b7          	lui	x7,0xffffd
800004bc:	cdd38393          	addi	x7,x7,-803 # ffffccdd <_end+0x7fffac8d>
800004c0:	2a771263          	bne	x14,x7,80000764 <fail>

800004c4 <test_33>:
800004c4:	02100193          	addi	x3,x0,33
800004c8:	00002117          	auipc	x2,0x2
800004cc:	b3810113          	addi	x2,x2,-1224 # 80002000 <begin_signature>
800004d0:	ffffc0b7          	lui	x1,0xffffc
800004d4:	ccd08093          	addi	x1,x1,-819 # ffffbccd <_end+0x7fff9c7d>
800004d8:	00111123          	sh	x1,2(x2)
800004dc:	00211703          	lh	x14,2(x2)
800004e0:	ffffc3b7          	lui	x7,0xffffc
800004e4:	ccd38393          	addi	x7,x7,-819 # ffffbccd <_end+0x7fff9c7d>
800004e8:	26771e63          	bne	x14,x7,80000764 <fail>

800004ec <test_34>:
800004ec:	02200193          	addi	x3,x0,34
800004f0:	00002117          	auipc	x2,0x2
800004f4:	b1010113          	addi	x2,x2,-1264 # 80002000 <begin_signature>
800004f8:	ffffc0b7          	lui	x1,0xffffc
800004fc:	bcc08093          	addi	x1,x1,-1076 # ffffbbcc <_end+0x7fff9b7c>
80000500:	00111223          	sh	x1,4(x2)
80000504:	00411703          	lh	x14,4(x2)
80000508:	ffffc3b7          	lui	x7,0xffffc
8000050c:	bcc38393          	addi	x7,x7,-1076 # ffffbbcc <_end+0x7fff9b7c>
80000510:	24771a63          	bne	x14,x7,80000764 <fail>

80000514 <test_35>:
80000514:	02300193          	addi	x3,x0,35
80000518:	00002117          	auipc	x2,0x2
8000051c:	ae810113          	addi	x2,x2,-1304 # 80002000 <begin_signature>
80000520:	ffffb0b7          	lui	x1,0xffffb
80000524:	bbc08093          	addi	x1,x1,-1092 # ffffabbc <_end+0x7fff8b6c>
80000528:	00111323          	sh	x1,6(x2)
8000052c:	00611703          	lh	x14,6(x2)
80000530:	ffffb3b7          	lui	x7,0xffffb
80000534:	bbc38393          	addi	x7,x7,-1092 # ffffabbc <_end+0x7fff8b6c>
80000538:	22771663          	bne	x14,x7,80000764 <fail>

8000053c <test_36>:
8000053c:	02400193          	addi	x3,x0,36
80000540:	00002117          	auipc	x2,0x2
80000544:	ac010113          	addi	x2,x2,-1344 # 80002000 <begin_signature>
80000548:	ffffb0b7          	lui	x1,0xffffb
8000054c:	abb08093          	addi	x1,x1,-1349 # ffffaabb <_end+0x7fff8a6b>
80000550:	00111423          	sh	x1,8(x2)
80000554:	00811703          	lh	x14,8(x2)
80000558:	ffffb3b7          	lui	x7,0xffffb
8000055c:	abb38393          	addi	x7,x7,-1349 # ffffaabb <_end+0x7fff8a6b>
80000560:	20771263          	bne	x14,x7,80000764 <fail>

80000564 <test_37>:
80000564:	02500193          	addi	x3,x0,37
80000568:	00002117          	auipc	x2,0x2
8000056c:	a9810113          	addi	x2,x2,-1384 # 80002000 <begin_signature>
80000570:	ffffe0b7          	lui	x1,0xffffe
80000574:	aab08093          	addi	x1,x1,-1365 # ffffdaab <_end+0x7fffba5b>
80000578:	00111523          	sh	x1,10(x2)
8000057c:	00a11703          	lh	x14,10(x2)
80000580:	ffffe3b7          	lui	x7,0xffffe
80000584:	aab38393          	addi	x7,x7,-1365 # ffffdaab <_end+0x7fffba5b>
80000588:	1c771e63          	bne	x14,x7,80000764 <fail>

8000058c <test_38>:
8000058c:	02600193          	addi	x3,x0,38
80000590:	00002117          	auipc	x2,0x2
80000594:	a7010113          	addi	x2,x2,-1424 # 80002000 <begin_signature>
80000598:	000020b7          	lui	x1,0x2
8000059c:	23308093          	addi	x1,x1,563 # 2233 <_start-0x7fffddcd>
800005a0:	00111023          	sh	x1,0(x2)
800005a4:	00011703          	lh	x14,0(x2)
800005a8:	000023b7          	lui	x7,0x2
800005ac:	23338393          	addi	x7,x7,563 # 2233 <_start-0x7fffddcd>
800005b0:	1a771a63          	bne	x14,x7,80000764 <fail>

800005b4 <test_39>:
800005b4:	02700193          	addi	x3,x0,39
800005b8:	00002117          	auipc	x2,0x2
800005bc:	a4810113          	addi	x2,x2,-1464 # 80002000 <begin_signature>
800005c0:	000010b7          	lui	x1,0x1
800005c4:	22308093          	addi	x1,x1,547 # 1223 <_start-0x7fffeddd>
800005c8:	00111123          	sh	x1,2(x2)
800005cc:	00211703          	lh	x14,2(x2)
800005d0:	000013b7          	lui	x7,0x1
800005d4:	22338393          	addi	x7,x7,547 # 1223 <_start-0x7fffeddd>
800005d8:	18771663          	bne	x14,x7,80000764 <fail>

800005dc <test_40>:
800005dc:	02800193          	addi	x3,x0,40
800005e0:	00002117          	auipc	x2,0x2
800005e4:	a2010113          	addi	x2,x2,-1504 # 80002000 <begin_signature>
800005e8:	000010b7          	lui	x1,0x1
800005ec:	12208093          	addi	x1,x1,290 # 1122 <_start-0x7fffeede>
800005f0:	00111223          	sh	x1,4(x2)
800005f4:	00411703          	lh	x14,4(x2)
800005f8:	000013b7          	lui	x7,0x1
800005fc:	12238393          	addi	x7,x7,290 # 1122 <_start-0x7fffeede>
80000600:	16771263          	bne	x14,x7,80000764 <fail>

80000604 <test_41>:
80000604:	02900193          	addi	x3,x0,41
80000608:	00002117          	auipc	x2,0x2
8000060c:	9f810113          	addi	x2,x2,-1544 # 80002000 <begin_signature>
80000610:	11200093          	addi	x1,x0,274
80000614:	00111323          	sh	x1,6(x2)
80000618:	00611703          	lh	x14,6(x2)
8000061c:	11200393          	addi	x7,x0,274
80000620:	14771263          	bne	x14,x7,80000764 <fail>

80000624 <test_42>:
80000624:	02a00193          	addi	x3,x0,42
80000628:	00002117          	auipc	x2,0x2
8000062c:	9d810113          	addi	x2,x2,-1576 # 80002000 <begin_signature>
80000630:	01100093          	addi	x1,x0,17
80000634:	00111423          	sh	x1,8(x2)
80000638:	00811703          	lh	x14,8(x2)
8000063c:	01100393          	addi	x7,x0,17
80000640:	12771263          	bne	x14,x7,80000764 <fail>

80000644 <test_43>:
80000644:	02b00193          	addi	x3,x0,43
80000648:	00002117          	auipc	x2,0x2
8000064c:	9b810113          	addi	x2,x2,-1608 # 80002000 <begin_signature>
80000650:	000030b7          	lui	x1,0x3
80000654:	00108093          	addi	x1,x1,1 # 3001 <_start-0x7fffcfff>
80000658:	00111523          	sh	x1,10(x2)
8000065c:	00a11703          	lh	x14,10(x2)
80000660:	000033b7          	lui	x7,0x3
80000664:	00138393          	addi	x7,x7,1 # 3001 <_start-0x7fffcfff>
80000668:	0e771e63          	bne	x14,x7,80000764 <fail>

8000066c <test_44>:
8000066c:	02c00193          	addi	x3,x0,44
80000670:	00002117          	auipc	x2,0x2
80000674:	99010113          	addi	x2,x2,-1648 # 80002000 <begin_signature>
80000678:	000020b7          	lui	x1,0x2
8000067c:	23308093          	addi	x1,x1,563 # 2233 <_start-0x7fffddcd>
80000680:	00111023          	sh	x1,0(x2)
80000684:	00015703          	lhu	x14,0(x2)
80000688:	000023b7          	lui	x7,0x2
8000068c:	23338393          	addi	x7,x7,563 # 2233 <_start-0x7fffddcd>
80000690:	0c771a63          	bne	x14,x7,80000764 <fail>

80000694 <test_45>:
80000694:	02d00193          	addi	x3,x0,45
80000698:	00002117          	auipc	x2,0x2
8000069c:	96810113          	addi	x2,x2,-1688 # 80002000 <begin_signature>
800006a0:	000010b7          	lui	x1,0x1
800006a4:	22308093          	addi	x1,x1,547 # 1223 <_start-0x7fffeddd>
800006a8:	00111123          	sh	x1,2(x2)
800006ac:	00215703          	lhu	x14,2(x2)
800006b0:	000013b7          	lui	x7,0x1
800006b4:	22338393          	addi	x7,x7,547 # 1223 <_start-0x7fffeddd>
800006b8:	0a771663          	bne	x14,x7,80000764 <fail>

800006bc <test_46>:
800006bc:	02e00193          	addi	x3,x0,46
800006c0:	00002117          	auipc	x2,0x2
800006c4:	94010113          	addi	x2,x2,-1728 # 80002000 <begin_signature>
800006c8:	000010b7          	lui	x1,0x1
800006cc:	12208093          	addi	x1,x1,290 # 1122 <_start-0x7fffeede>
800006d0:	00111223          	sh	x1,4(x2)
800006d4:	00415703          	lhu	x14,4(x2)
800006d8:	000013b7          	lui	x7,0x1
800006dc:	12238393          	addi	x7,x7,290 # 1122 <_start-0x7fffeede>
800006e0:	08771263          	bne	x14,x7,80000764 <fail>

800006e4 <test_47>:
800006e4:	02f00193          	addi	x3,x0,47
800006e8:	00002117          	auipc	x2,0x2
800006ec:	91810113          	addi	x2,x2,-1768 # 80002000 <begin_signature>
800006f0:	11200093          	addi	x1,x0,274
800006f4:	00111323          	sh	x1,6(x2)
800006f8:	00615703          	lhu	x14,6(x2)
800006fc:	11200393          	addi	x7,x0,274
80000700:	06771263          	bne	x14,x7,80000764 <fail>

80000704 <test_48>:
80000704:	03000193          	addi	x3,x0,48
80000708:	00002117          	auipc	x2,0x2
8000070c:	8f810113          	addi	x2,x2,-1800 # 80002000 <begin_signature>
80000710:	01100093          	addi	x1,x0,17
80000714:	00111423          	sh	x1,8(x2)
80000718:	00815703          	lhu	x14,8(x2)
8000071c:	01100393          	addi	x7,x0,17
80000720:	04771263          	bne	x14,x7,80000764 <fail>

80000724 <test_49>:
80000724:	03100193          	addi	x3,x0,49
80000728:	00002117          	auipc	x2,0x2
8000072c:	8d810113          	addi	x2,x2,-1832 # 80002000 <begin_signature>
80000730:	000030b7          	lui	x1,0x3
80000734:	00108093          	addi	x1,x1,1 # 3001 <_start-0x7fffcfff>
80000738:	00111523          	sh	x1,10(x2)
8000073c:	00a15703          	lhu	x14,10(x2)
80000740:	000033b7          	lui	x7,0x3
80000744:	00138393          	addi	x7,x7,1 # 3001 <_start-0x7fffcfff>
80000748:	00771e63          	bne	x14,x7,80000764 <fail>
8000074c:	0ef00513          	addi	x10,x0,239
80000750:	00002597          	auipc	x11,0x2
80000754:	8b058593          	addi	x11,x11,-1872 # 80002000 <begin_signature>
80000758:	00a581a3          	sb	x10,3(x11)
8000075c:	00358603          	lb	x12,3(x11)
80000760:	02301063          	bne	x0,x3,80000780 <pass>

80000764 <fail>:
80000764:	00018063          	beq	x3,x0,80000764 <fail>
80000768:	00119193          	slli	x3,x3,0x1
8000076c:	0011e193          	ori	x3,x3,1
80000770:	00001297          	auipc	x5,0x1
80000774:	89028293          	addi	x5,x5,-1904 # 80001000 <tohost>
80000778:	0032a023          	sw	x3,0(x5)
8000077c:	0000006f          	jal	x0,8000077c <fail+0x18>

80000780 <pass>:
80000780:	00001297          	auipc	x5,0x1
80000784:	88028293          	addi	x5,x5,-1920 # 80001000 <tohost>
80000788:	00100313          	addi	x6,x0,1
8000078c:	0062a023          	sw	x6,0(x5)
80000790:	0000006f          	jal	x0,80000790 <pass+0x10>
80000794:	c0001073          	unimp
80000798:	00000013          	addi	x0,x0,0
8000079c:	00000013          	addi	x0,x0,0
800007a0:	00000013          	addi	x0,x0,0
800007a4:	00000013          	addi	x0,x0,0
800007a8:	00000013          	addi	x0,x0,0
800007ac:	00000013          	addi	x0,x0,0
800007b0:	00000013          	addi	x0,x0,0
800007b4:	00000013          	addi	x0,x0,0
800007b8:	00000013          	addi	x0,x0,0
800007bc:	00000013          	addi	x0,x0,0
800007c0:	00000013          	addi	x0,x0,0
