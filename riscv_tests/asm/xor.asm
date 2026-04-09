
soc_workspace_rv32ui/elf/xor.elf:     file format elf32-littleriscv


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
80000080:	ff0105b7          	lui	x11,0xff010
80000084:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
80000088:	0f0f1637          	lui	x12,0xf0f1
8000008c:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
80000090:	00c5c733          	xor	x14,x11,x12
80000094:	f00ff3b7          	lui	x7,0xf00ff
80000098:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
8000009c:	4a771063          	bne	x14,x7,8000053c <fail>

800000a0 <test_3>:
800000a0:	00300193          	addi	x3,x0,3
800000a4:	0ff015b7          	lui	x11,0xff01
800000a8:	ff058593          	addi	x11,x11,-16 # ff00ff0 <_start-0x700ff010>
800000ac:	f0f0f637          	lui	x12,0xf0f0f
800000b0:	0f060613          	addi	x12,x12,240 # f0f0f0f0 <_end+0x70f0d0f0>
800000b4:	00c5c733          	xor	x14,x11,x12
800000b8:	ff0103b7          	lui	x7,0xff010
800000bc:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
800000c0:	46771e63          	bne	x14,x7,8000053c <fail>

800000c4 <test_4>:
800000c4:	00400193          	addi	x3,x0,4
800000c8:	00ff05b7          	lui	x11,0xff0
800000cc:	0ff58593          	addi	x11,x11,255 # ff00ff <_start-0x7f00ff01>
800000d0:	0f0f1637          	lui	x12,0xf0f1
800000d4:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
800000d8:	00c5c733          	xor	x14,x11,x12
800000dc:	0ff013b7          	lui	x7,0xff01
800000e0:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
800000e4:	44771c63          	bne	x14,x7,8000053c <fail>

800000e8 <test_5>:
800000e8:	00500193          	addi	x3,x0,5
800000ec:	f00ff5b7          	lui	x11,0xf00ff
800000f0:	00f58593          	addi	x11,x11,15 # f00ff00f <_end+0x700fd00f>
800000f4:	f0f0f637          	lui	x12,0xf0f0f
800000f8:	0f060613          	addi	x12,x12,240 # f0f0f0f0 <_end+0x70f0d0f0>
800000fc:	00c5c733          	xor	x14,x11,x12
80000100:	00ff03b7          	lui	x7,0xff0
80000104:	0ff38393          	addi	x7,x7,255 # ff00ff <_start-0x7f00ff01>
80000108:	42771a63          	bne	x14,x7,8000053c <fail>

8000010c <test_6>:
8000010c:	00600193          	addi	x3,x0,6
80000110:	ff0105b7          	lui	x11,0xff010
80000114:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
80000118:	0f0f1637          	lui	x12,0xf0f1
8000011c:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
80000120:	00c5c5b3          	xor	x11,x11,x12
80000124:	f00ff3b7          	lui	x7,0xf00ff
80000128:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
8000012c:	40759863          	bne	x11,x7,8000053c <fail>

80000130 <test_7>:
80000130:	00700193          	addi	x3,x0,7
80000134:	ff0105b7          	lui	x11,0xff010
80000138:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
8000013c:	0f0f1637          	lui	x12,0xf0f1
80000140:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
80000144:	00c5c633          	xor	x12,x11,x12
80000148:	f00ff3b7          	lui	x7,0xf00ff
8000014c:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
80000150:	3e761663          	bne	x12,x7,8000053c <fail>

80000154 <test_8>:
80000154:	00800193          	addi	x3,x0,8
80000158:	ff0105b7          	lui	x11,0xff010
8000015c:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
80000160:	00b5c5b3          	xor	x11,x11,x11
80000164:	00000393          	addi	x7,x0,0
80000168:	3c759a63          	bne	x11,x7,8000053c <fail>

8000016c <test_9>:
8000016c:	00900193          	addi	x3,x0,9
80000170:	00000213          	addi	x4,x0,0
80000174:	ff0100b7          	lui	x1,0xff010
80000178:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
8000017c:	0f0f1137          	lui	x2,0xf0f1
80000180:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000184:	0020c733          	xor	x14,x1,x2
80000188:	00070313          	addi	x6,x14,0
8000018c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000190:	00200293          	addi	x5,x0,2
80000194:	fe5210e3          	bne	x4,x5,80000174 <test_9+0x8>
80000198:	f00ff3b7          	lui	x7,0xf00ff
8000019c:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
800001a0:	38731e63          	bne	x6,x7,8000053c <fail>

800001a4 <test_10>:
800001a4:	00a00193          	addi	x3,x0,10
800001a8:	00000213          	addi	x4,x0,0
800001ac:	0ff010b7          	lui	x1,0xff01
800001b0:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800001b4:	f0f0f137          	lui	x2,0xf0f0f
800001b8:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
800001bc:	0020c733          	xor	x14,x1,x2
800001c0:	00000013          	addi	x0,x0,0
800001c4:	00070313          	addi	x6,x14,0
800001c8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001cc:	00200293          	addi	x5,x0,2
800001d0:	fc521ee3          	bne	x4,x5,800001ac <test_10+0x8>
800001d4:	ff0103b7          	lui	x7,0xff010
800001d8:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
800001dc:	36731063          	bne	x6,x7,8000053c <fail>

800001e0 <test_11>:
800001e0:	00b00193          	addi	x3,x0,11
800001e4:	00000213          	addi	x4,x0,0
800001e8:	00ff00b7          	lui	x1,0xff0
800001ec:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800001f0:	0f0f1137          	lui	x2,0xf0f1
800001f4:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800001f8:	0020c733          	xor	x14,x1,x2
800001fc:	00000013          	addi	x0,x0,0
80000200:	00000013          	addi	x0,x0,0
80000204:	00070313          	addi	x6,x14,0
80000208:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000020c:	00200293          	addi	x5,x0,2
80000210:	fc521ce3          	bne	x4,x5,800001e8 <test_11+0x8>
80000214:	0ff013b7          	lui	x7,0xff01
80000218:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
8000021c:	32731063          	bne	x6,x7,8000053c <fail>

80000220 <test_12>:
80000220:	00c00193          	addi	x3,x0,12
80000224:	00000213          	addi	x4,x0,0
80000228:	ff0100b7          	lui	x1,0xff010
8000022c:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000230:	0f0f1137          	lui	x2,0xf0f1
80000234:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000238:	0020c733          	xor	x14,x1,x2
8000023c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000240:	00200293          	addi	x5,x0,2
80000244:	fe5212e3          	bne	x4,x5,80000228 <test_12+0x8>
80000248:	f00ff3b7          	lui	x7,0xf00ff
8000024c:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
80000250:	2e771663          	bne	x14,x7,8000053c <fail>

80000254 <test_13>:
80000254:	00d00193          	addi	x3,x0,13
80000258:	00000213          	addi	x4,x0,0
8000025c:	0ff010b7          	lui	x1,0xff01
80000260:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000264:	f0f0f137          	lui	x2,0xf0f0f
80000268:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
8000026c:	00000013          	addi	x0,x0,0
80000270:	0020c733          	xor	x14,x1,x2
80000274:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000278:	00200293          	addi	x5,x0,2
8000027c:	fe5210e3          	bne	x4,x5,8000025c <test_13+0x8>
80000280:	ff0103b7          	lui	x7,0xff010
80000284:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
80000288:	2a771a63          	bne	x14,x7,8000053c <fail>

8000028c <test_14>:
8000028c:	00e00193          	addi	x3,x0,14
80000290:	00000213          	addi	x4,x0,0
80000294:	00ff00b7          	lui	x1,0xff0
80000298:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
8000029c:	0f0f1137          	lui	x2,0xf0f1
800002a0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800002a4:	00000013          	addi	x0,x0,0
800002a8:	00000013          	addi	x0,x0,0
800002ac:	0020c733          	xor	x14,x1,x2
800002b0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002b4:	00200293          	addi	x5,x0,2
800002b8:	fc521ee3          	bne	x4,x5,80000294 <test_14+0x8>
800002bc:	0ff013b7          	lui	x7,0xff01
800002c0:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
800002c4:	26771c63          	bne	x14,x7,8000053c <fail>

800002c8 <test_15>:
800002c8:	00f00193          	addi	x3,x0,15
800002cc:	00000213          	addi	x4,x0,0
800002d0:	ff0100b7          	lui	x1,0xff010
800002d4:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
800002d8:	00000013          	addi	x0,x0,0
800002dc:	0f0f1137          	lui	x2,0xf0f1
800002e0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800002e4:	0020c733          	xor	x14,x1,x2
800002e8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002ec:	00200293          	addi	x5,x0,2
800002f0:	fe5210e3          	bne	x4,x5,800002d0 <test_15+0x8>
800002f4:	f00ff3b7          	lui	x7,0xf00ff
800002f8:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
800002fc:	24771063          	bne	x14,x7,8000053c <fail>

80000300 <test_16>:
80000300:	01000193          	addi	x3,x0,16
80000304:	00000213          	addi	x4,x0,0
80000308:	0ff010b7          	lui	x1,0xff01
8000030c:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000310:	00000013          	addi	x0,x0,0
80000314:	f0f0f137          	lui	x2,0xf0f0f
80000318:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
8000031c:	00000013          	addi	x0,x0,0
80000320:	0020c733          	xor	x14,x1,x2
80000324:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000328:	00200293          	addi	x5,x0,2
8000032c:	fc521ee3          	bne	x4,x5,80000308 <test_16+0x8>
80000330:	ff0103b7          	lui	x7,0xff010
80000334:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
80000338:	20771263          	bne	x14,x7,8000053c <fail>

8000033c <test_17>:
8000033c:	01100193          	addi	x3,x0,17
80000340:	00000213          	addi	x4,x0,0
80000344:	00ff00b7          	lui	x1,0xff0
80000348:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
8000034c:	00000013          	addi	x0,x0,0
80000350:	00000013          	addi	x0,x0,0
80000354:	0f0f1137          	lui	x2,0xf0f1
80000358:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
8000035c:	0020c733          	xor	x14,x1,x2
80000360:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000364:	00200293          	addi	x5,x0,2
80000368:	fc521ee3          	bne	x4,x5,80000344 <test_17+0x8>
8000036c:	0ff013b7          	lui	x7,0xff01
80000370:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
80000374:	1c771463          	bne	x14,x7,8000053c <fail>

80000378 <test_18>:
80000378:	01200193          	addi	x3,x0,18
8000037c:	00000213          	addi	x4,x0,0
80000380:	0f0f1137          	lui	x2,0xf0f1
80000384:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000388:	ff0100b7          	lui	x1,0xff010
8000038c:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000390:	0020c733          	xor	x14,x1,x2
80000394:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000398:	00200293          	addi	x5,x0,2
8000039c:	fe5212e3          	bne	x4,x5,80000380 <test_18+0x8>
800003a0:	f00ff3b7          	lui	x7,0xf00ff
800003a4:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
800003a8:	18771a63          	bne	x14,x7,8000053c <fail>

800003ac <test_19>:
800003ac:	01300193          	addi	x3,x0,19
800003b0:	00000213          	addi	x4,x0,0
800003b4:	f0f0f137          	lui	x2,0xf0f0f
800003b8:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
800003bc:	0ff010b7          	lui	x1,0xff01
800003c0:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800003c4:	00000013          	addi	x0,x0,0
800003c8:	0020c733          	xor	x14,x1,x2
800003cc:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800003d0:	00200293          	addi	x5,x0,2
800003d4:	fe5210e3          	bne	x4,x5,800003b4 <test_19+0x8>
800003d8:	ff0103b7          	lui	x7,0xff010
800003dc:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
800003e0:	14771e63          	bne	x14,x7,8000053c <fail>

800003e4 <test_20>:
800003e4:	01400193          	addi	x3,x0,20
800003e8:	00000213          	addi	x4,x0,0
800003ec:	0f0f1137          	lui	x2,0xf0f1
800003f0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800003f4:	00ff00b7          	lui	x1,0xff0
800003f8:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800003fc:	00000013          	addi	x0,x0,0
80000400:	00000013          	addi	x0,x0,0
80000404:	0020c733          	xor	x14,x1,x2
80000408:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000040c:	00200293          	addi	x5,x0,2
80000410:	fc521ee3          	bne	x4,x5,800003ec <test_20+0x8>
80000414:	0ff013b7          	lui	x7,0xff01
80000418:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
8000041c:	12771063          	bne	x14,x7,8000053c <fail>

80000420 <test_21>:
80000420:	01500193          	addi	x3,x0,21
80000424:	00000213          	addi	x4,x0,0
80000428:	0f0f1137          	lui	x2,0xf0f1
8000042c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000430:	00000013          	addi	x0,x0,0
80000434:	ff0100b7          	lui	x1,0xff010
80000438:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
8000043c:	0020c733          	xor	x14,x1,x2
80000440:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000444:	00200293          	addi	x5,x0,2
80000448:	fe5210e3          	bne	x4,x5,80000428 <test_21+0x8>
8000044c:	f00ff3b7          	lui	x7,0xf00ff
80000450:	00f38393          	addi	x7,x7,15 # f00ff00f <_end+0x700fd00f>
80000454:	0e771463          	bne	x14,x7,8000053c <fail>

80000458 <test_22>:
80000458:	01600193          	addi	x3,x0,22
8000045c:	00000213          	addi	x4,x0,0
80000460:	f0f0f137          	lui	x2,0xf0f0f
80000464:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
80000468:	00000013          	addi	x0,x0,0
8000046c:	0ff010b7          	lui	x1,0xff01
80000470:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000474:	00000013          	addi	x0,x0,0
80000478:	0020c733          	xor	x14,x1,x2
8000047c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000480:	00200293          	addi	x5,x0,2
80000484:	fc521ee3          	bne	x4,x5,80000460 <test_22+0x8>
80000488:	ff0103b7          	lui	x7,0xff010
8000048c:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
80000490:	0a771663          	bne	x14,x7,8000053c <fail>

80000494 <test_23>:
80000494:	01700193          	addi	x3,x0,23
80000498:	00000213          	addi	x4,x0,0
8000049c:	0f0f1137          	lui	x2,0xf0f1
800004a0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800004a4:	00000013          	addi	x0,x0,0
800004a8:	00000013          	addi	x0,x0,0
800004ac:	00ff00b7          	lui	x1,0xff0
800004b0:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800004b4:	0020c733          	xor	x14,x1,x2
800004b8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800004bc:	00200293          	addi	x5,x0,2
800004c0:	fc521ee3          	bne	x4,x5,8000049c <test_23+0x8>
800004c4:	0ff013b7          	lui	x7,0xff01
800004c8:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
800004cc:	06771863          	bne	x14,x7,8000053c <fail>

800004d0 <test_24>:
800004d0:	01800193          	addi	x3,x0,24
800004d4:	ff0100b7          	lui	x1,0xff010
800004d8:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
800004dc:	00104133          	xor	x2,x0,x1
800004e0:	ff0103b7          	lui	x7,0xff010
800004e4:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
800004e8:	04711a63          	bne	x2,x7,8000053c <fail>

800004ec <test_25>:
800004ec:	01900193          	addi	x3,x0,25
800004f0:	00ff00b7          	lui	x1,0xff0
800004f4:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800004f8:	0000c133          	xor	x2,x1,x0
800004fc:	00ff03b7          	lui	x7,0xff0
80000500:	0ff38393          	addi	x7,x7,255 # ff00ff <_start-0x7f00ff01>
80000504:	02711c63          	bne	x2,x7,8000053c <fail>

80000508 <test_26>:
80000508:	01a00193          	addi	x3,x0,26
8000050c:	000040b3          	xor	x1,x0,x0
80000510:	00000393          	addi	x7,x0,0
80000514:	02709463          	bne	x1,x7,8000053c <fail>

80000518 <test_27>:
80000518:	01b00193          	addi	x3,x0,27
8000051c:	111110b7          	lui	x1,0x11111
80000520:	11108093          	addi	x1,x1,273 # 11111111 <_start-0x6eeeeeef>
80000524:	22222137          	lui	x2,0x22222
80000528:	22210113          	addi	x2,x2,546 # 22222222 <_start-0x5dddddde>
8000052c:	0020c033          	xor	x0,x1,x2
80000530:	00000393          	addi	x7,x0,0
80000534:	00701463          	bne	x0,x7,8000053c <fail>
80000538:	02301063          	bne	x0,x3,80000558 <pass>

8000053c <fail>:
8000053c:	00018063          	beq	x3,x0,8000053c <fail>
80000540:	00119193          	slli	x3,x3,0x1
80000544:	0011e193          	ori	x3,x3,1
80000548:	00001297          	auipc	x5,0x1
8000054c:	ab828293          	addi	x5,x5,-1352 # 80001000 <tohost>
80000550:	0032a023          	sw	x3,0(x5)
80000554:	0000006f          	jal	x0,80000554 <fail+0x18>

80000558 <pass>:
80000558:	00001297          	auipc	x5,0x1
8000055c:	aa828293          	addi	x5,x5,-1368 # 80001000 <tohost>
80000560:	00100313          	addi	x6,x0,1
80000564:	0062a023          	sw	x6,0(x5)
80000568:	0000006f          	jal	x0,80000568 <pass+0x10>
8000056c:	c0001073          	unimp
80000570:	00000013          	addi	x0,x0,0
80000574:	00000013          	addi	x0,x0,0
80000578:	00000013          	addi	x0,x0,0
8000057c:	00000013          	addi	x0,x0,0
80000580:	00000013          	addi	x0,x0,0
