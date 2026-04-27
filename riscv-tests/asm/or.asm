
/home/hbyasts/riscv-tool/self/riscv-tests/elf/or.elf:     file format elf32-littleriscv


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
80000090:	00c5e733          	or	x14,x11,x12
80000094:	ff1003b7          	lui	x7,0xff100
80000098:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
8000009c:	4a771263          	bne	x14,x7,80000540 <fail>

800000a0 <test_3>:
800000a0:	00300193          	addi	x3,x0,3
800000a4:	0ff015b7          	lui	x11,0xff01
800000a8:	ff058593          	addi	x11,x11,-16 # ff00ff0 <_start-0x700ff010>
800000ac:	f0f0f637          	lui	x12,0xf0f0f
800000b0:	0f060613          	addi	x12,x12,240 # f0f0f0f0 <_end+0x70f0d0f0>
800000b4:	00c5e733          	or	x14,x11,x12
800000b8:	fff103b7          	lui	x7,0xfff10
800000bc:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
800000c0:	48771063          	bne	x14,x7,80000540 <fail>

800000c4 <test_4>:
800000c4:	00400193          	addi	x3,x0,4
800000c8:	00ff05b7          	lui	x11,0xff0
800000cc:	0ff58593          	addi	x11,x11,255 # ff00ff <_start-0x7f00ff01>
800000d0:	0f0f1637          	lui	x12,0xf0f1
800000d4:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
800000d8:	00c5e733          	or	x14,x11,x12
800000dc:	0fff13b7          	lui	x7,0xfff1
800000e0:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
800000e4:	44771e63          	bne	x14,x7,80000540 <fail>

800000e8 <test_5>:
800000e8:	00500193          	addi	x3,x0,5
800000ec:	f00ff5b7          	lui	x11,0xf00ff
800000f0:	00f58593          	addi	x11,x11,15 # f00ff00f <_end+0x700fd00f>
800000f4:	f0f0f637          	lui	x12,0xf0f0f
800000f8:	0f060613          	addi	x12,x12,240 # f0f0f0f0 <_end+0x70f0d0f0>
800000fc:	00c5e733          	or	x14,x11,x12
80000100:	f0fff3b7          	lui	x7,0xf0fff
80000104:	0ff38393          	addi	x7,x7,255 # f0fff0ff <_end+0x70ffd0ff>
80000108:	42771c63          	bne	x14,x7,80000540 <fail>

8000010c <test_6>:
8000010c:	00600193          	addi	x3,x0,6
80000110:	ff0105b7          	lui	x11,0xff010
80000114:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
80000118:	0f0f1637          	lui	x12,0xf0f1
8000011c:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
80000120:	00c5e5b3          	or	x11,x11,x12
80000124:	ff1003b7          	lui	x7,0xff100
80000128:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
8000012c:	40759a63          	bne	x11,x7,80000540 <fail>

80000130 <test_7>:
80000130:	00700193          	addi	x3,x0,7
80000134:	ff0105b7          	lui	x11,0xff010
80000138:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
8000013c:	0f0f1637          	lui	x12,0xf0f1
80000140:	f0f60613          	addi	x12,x12,-241 # f0f0f0f <_start-0x70f0f0f1>
80000144:	00c5e633          	or	x12,x11,x12
80000148:	ff1003b7          	lui	x7,0xff100
8000014c:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
80000150:	3e761863          	bne	x12,x7,80000540 <fail>

80000154 <test_8>:
80000154:	00800193          	addi	x3,x0,8
80000158:	ff0105b7          	lui	x11,0xff010
8000015c:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
80000160:	00b5e5b3          	or	x11,x11,x11
80000164:	ff0103b7          	lui	x7,0xff010
80000168:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
8000016c:	3c759a63          	bne	x11,x7,80000540 <fail>

80000170 <test_9>:
80000170:	00900193          	addi	x3,x0,9
80000174:	00000213          	addi	x4,x0,0
80000178:	ff0100b7          	lui	x1,0xff010
8000017c:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000180:	0f0f1137          	lui	x2,0xf0f1
80000184:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000188:	0020e733          	or	x14,x1,x2
8000018c:	00070313          	addi	x6,x14,0
80000190:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000194:	00200293          	addi	x5,x0,2
80000198:	fe5210e3          	bne	x4,x5,80000178 <test_9+0x8>
8000019c:	ff1003b7          	lui	x7,0xff100
800001a0:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
800001a4:	38731e63          	bne	x6,x7,80000540 <fail>

800001a8 <test_10>:
800001a8:	00a00193          	addi	x3,x0,10
800001ac:	00000213          	addi	x4,x0,0
800001b0:	0ff010b7          	lui	x1,0xff01
800001b4:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800001b8:	f0f0f137          	lui	x2,0xf0f0f
800001bc:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
800001c0:	0020e733          	or	x14,x1,x2
800001c4:	00000013          	addi	x0,x0,0
800001c8:	00070313          	addi	x6,x14,0
800001cc:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001d0:	00200293          	addi	x5,x0,2
800001d4:	fc521ee3          	bne	x4,x5,800001b0 <test_10+0x8>
800001d8:	fff103b7          	lui	x7,0xfff10
800001dc:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
800001e0:	36731063          	bne	x6,x7,80000540 <fail>

800001e4 <test_11>:
800001e4:	00b00193          	addi	x3,x0,11
800001e8:	00000213          	addi	x4,x0,0
800001ec:	00ff00b7          	lui	x1,0xff0
800001f0:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800001f4:	0f0f1137          	lui	x2,0xf0f1
800001f8:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800001fc:	0020e733          	or	x14,x1,x2
80000200:	00000013          	addi	x0,x0,0
80000204:	00000013          	addi	x0,x0,0
80000208:	00070313          	addi	x6,x14,0
8000020c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000210:	00200293          	addi	x5,x0,2
80000214:	fc521ce3          	bne	x4,x5,800001ec <test_11+0x8>
80000218:	0fff13b7          	lui	x7,0xfff1
8000021c:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
80000220:	32731063          	bne	x6,x7,80000540 <fail>

80000224 <test_12>:
80000224:	00c00193          	addi	x3,x0,12
80000228:	00000213          	addi	x4,x0,0
8000022c:	ff0100b7          	lui	x1,0xff010
80000230:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000234:	0f0f1137          	lui	x2,0xf0f1
80000238:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
8000023c:	0020e733          	or	x14,x1,x2
80000240:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000244:	00200293          	addi	x5,x0,2
80000248:	fe5212e3          	bne	x4,x5,8000022c <test_12+0x8>
8000024c:	ff1003b7          	lui	x7,0xff100
80000250:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
80000254:	2e771663          	bne	x14,x7,80000540 <fail>

80000258 <test_13>:
80000258:	00d00193          	addi	x3,x0,13
8000025c:	00000213          	addi	x4,x0,0
80000260:	0ff010b7          	lui	x1,0xff01
80000264:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000268:	f0f0f137          	lui	x2,0xf0f0f
8000026c:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
80000270:	00000013          	addi	x0,x0,0
80000274:	0020e733          	or	x14,x1,x2
80000278:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000027c:	00200293          	addi	x5,x0,2
80000280:	fe5210e3          	bne	x4,x5,80000260 <test_13+0x8>
80000284:	fff103b7          	lui	x7,0xfff10
80000288:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
8000028c:	2a771a63          	bne	x14,x7,80000540 <fail>

80000290 <test_14>:
80000290:	00e00193          	addi	x3,x0,14
80000294:	00000213          	addi	x4,x0,0
80000298:	00ff00b7          	lui	x1,0xff0
8000029c:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800002a0:	0f0f1137          	lui	x2,0xf0f1
800002a4:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800002a8:	00000013          	addi	x0,x0,0
800002ac:	00000013          	addi	x0,x0,0
800002b0:	0020e733          	or	x14,x1,x2
800002b4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002b8:	00200293          	addi	x5,x0,2
800002bc:	fc521ee3          	bne	x4,x5,80000298 <test_14+0x8>
800002c0:	0fff13b7          	lui	x7,0xfff1
800002c4:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
800002c8:	26771c63          	bne	x14,x7,80000540 <fail>

800002cc <test_15>:
800002cc:	00f00193          	addi	x3,x0,15
800002d0:	00000213          	addi	x4,x0,0
800002d4:	ff0100b7          	lui	x1,0xff010
800002d8:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
800002dc:	00000013          	addi	x0,x0,0
800002e0:	0f0f1137          	lui	x2,0xf0f1
800002e4:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800002e8:	0020e733          	or	x14,x1,x2
800002ec:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002f0:	00200293          	addi	x5,x0,2
800002f4:	fe5210e3          	bne	x4,x5,800002d4 <test_15+0x8>
800002f8:	ff1003b7          	lui	x7,0xff100
800002fc:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
80000300:	24771063          	bne	x14,x7,80000540 <fail>

80000304 <test_16>:
80000304:	01000193          	addi	x3,x0,16
80000308:	00000213          	addi	x4,x0,0
8000030c:	0ff010b7          	lui	x1,0xff01
80000310:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000314:	00000013          	addi	x0,x0,0
80000318:	f0f0f137          	lui	x2,0xf0f0f
8000031c:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
80000320:	00000013          	addi	x0,x0,0
80000324:	0020e733          	or	x14,x1,x2
80000328:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000032c:	00200293          	addi	x5,x0,2
80000330:	fc521ee3          	bne	x4,x5,8000030c <test_16+0x8>
80000334:	fff103b7          	lui	x7,0xfff10
80000338:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
8000033c:	20771263          	bne	x14,x7,80000540 <fail>

80000340 <test_17>:
80000340:	01100193          	addi	x3,x0,17
80000344:	00000213          	addi	x4,x0,0
80000348:	00ff00b7          	lui	x1,0xff0
8000034c:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
80000350:	00000013          	addi	x0,x0,0
80000354:	00000013          	addi	x0,x0,0
80000358:	0f0f1137          	lui	x2,0xf0f1
8000035c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000360:	0020e733          	or	x14,x1,x2
80000364:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000368:	00200293          	addi	x5,x0,2
8000036c:	fc521ee3          	bne	x4,x5,80000348 <test_17+0x8>
80000370:	0fff13b7          	lui	x7,0xfff1
80000374:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
80000378:	1c771463          	bne	x14,x7,80000540 <fail>

8000037c <test_18>:
8000037c:	01200193          	addi	x3,x0,18
80000380:	00000213          	addi	x4,x0,0
80000384:	0f0f1137          	lui	x2,0xf0f1
80000388:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
8000038c:	ff0100b7          	lui	x1,0xff010
80000390:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000394:	0020e733          	or	x14,x1,x2
80000398:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000039c:	00200293          	addi	x5,x0,2
800003a0:	fe5212e3          	bne	x4,x5,80000384 <test_18+0x8>
800003a4:	ff1003b7          	lui	x7,0xff100
800003a8:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
800003ac:	18771a63          	bne	x14,x7,80000540 <fail>

800003b0 <test_19>:
800003b0:	01300193          	addi	x3,x0,19
800003b4:	00000213          	addi	x4,x0,0
800003b8:	f0f0f137          	lui	x2,0xf0f0f
800003bc:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
800003c0:	0ff010b7          	lui	x1,0xff01
800003c4:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800003c8:	00000013          	addi	x0,x0,0
800003cc:	0020e733          	or	x14,x1,x2
800003d0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800003d4:	00200293          	addi	x5,x0,2
800003d8:	fe5210e3          	bne	x4,x5,800003b8 <test_19+0x8>
800003dc:	fff103b7          	lui	x7,0xfff10
800003e0:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
800003e4:	14771e63          	bne	x14,x7,80000540 <fail>

800003e8 <test_20>:
800003e8:	01400193          	addi	x3,x0,20
800003ec:	00000213          	addi	x4,x0,0
800003f0:	0f0f1137          	lui	x2,0xf0f1
800003f4:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800003f8:	00ff00b7          	lui	x1,0xff0
800003fc:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
80000400:	00000013          	addi	x0,x0,0
80000404:	00000013          	addi	x0,x0,0
80000408:	0020e733          	or	x14,x1,x2
8000040c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000410:	00200293          	addi	x5,x0,2
80000414:	fc521ee3          	bne	x4,x5,800003f0 <test_20+0x8>
80000418:	0fff13b7          	lui	x7,0xfff1
8000041c:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
80000420:	12771063          	bne	x14,x7,80000540 <fail>

80000424 <test_21>:
80000424:	01500193          	addi	x3,x0,21
80000428:	00000213          	addi	x4,x0,0
8000042c:	0f0f1137          	lui	x2,0xf0f1
80000430:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
80000434:	00000013          	addi	x0,x0,0
80000438:	ff0100b7          	lui	x1,0xff010
8000043c:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
80000440:	0020e733          	or	x14,x1,x2
80000444:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000448:	00200293          	addi	x5,x0,2
8000044c:	fe5210e3          	bne	x4,x5,8000042c <test_21+0x8>
80000450:	ff1003b7          	lui	x7,0xff100
80000454:	f0f38393          	addi	x7,x7,-241 # ff0fff0f <_end+0x7f0fdf0f>
80000458:	0e771463          	bne	x14,x7,80000540 <fail>

8000045c <test_22>:
8000045c:	01600193          	addi	x3,x0,22
80000460:	00000213          	addi	x4,x0,0
80000464:	f0f0f137          	lui	x2,0xf0f0f
80000468:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0x70f0d0f0>
8000046c:	00000013          	addi	x0,x0,0
80000470:	0ff010b7          	lui	x1,0xff01
80000474:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000478:	00000013          	addi	x0,x0,0
8000047c:	0020e733          	or	x14,x1,x2
80000480:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000484:	00200293          	addi	x5,x0,2
80000488:	fc521ee3          	bne	x4,x5,80000464 <test_22+0x8>
8000048c:	fff103b7          	lui	x7,0xfff10
80000490:	ff038393          	addi	x7,x7,-16 # fff0fff0 <_end+0x7ff0dff0>
80000494:	0a771663          	bne	x14,x7,80000540 <fail>

80000498 <test_23>:
80000498:	01700193          	addi	x3,x0,23
8000049c:	00000213          	addi	x4,x0,0
800004a0:	0f0f1137          	lui	x2,0xf0f1
800004a4:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_start-0x70f0f0f1>
800004a8:	00000013          	addi	x0,x0,0
800004ac:	00000013          	addi	x0,x0,0
800004b0:	00ff00b7          	lui	x1,0xff0
800004b4:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800004b8:	0020e733          	or	x14,x1,x2
800004bc:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800004c0:	00200293          	addi	x5,x0,2
800004c4:	fc521ee3          	bne	x4,x5,800004a0 <test_23+0x8>
800004c8:	0fff13b7          	lui	x7,0xfff1
800004cc:	fff38393          	addi	x7,x7,-1 # fff0fff <_start-0x7000f001>
800004d0:	06771863          	bne	x14,x7,80000540 <fail>

800004d4 <test_24>:
800004d4:	01800193          	addi	x3,x0,24
800004d8:	ff0100b7          	lui	x1,0xff010
800004dc:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0x7f00df00>
800004e0:	00106133          	or	x2,x0,x1
800004e4:	ff0103b7          	lui	x7,0xff010
800004e8:	f0038393          	addi	x7,x7,-256 # ff00ff00 <_end+0x7f00df00>
800004ec:	04711a63          	bne	x2,x7,80000540 <fail>

800004f0 <test_25>:
800004f0:	01900193          	addi	x3,x0,25
800004f4:	00ff00b7          	lui	x1,0xff0
800004f8:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800004fc:	0000e133          	or	x2,x1,x0
80000500:	00ff03b7          	lui	x7,0xff0
80000504:	0ff38393          	addi	x7,x7,255 # ff00ff <_start-0x7f00ff01>
80000508:	02711c63          	bne	x2,x7,80000540 <fail>

8000050c <test_26>:
8000050c:	01a00193          	addi	x3,x0,26
80000510:	000060b3          	or	x1,x0,x0
80000514:	00000393          	addi	x7,x0,0
80000518:	02709463          	bne	x1,x7,80000540 <fail>

8000051c <test_27>:
8000051c:	01b00193          	addi	x3,x0,27
80000520:	111110b7          	lui	x1,0x11111
80000524:	11108093          	addi	x1,x1,273 # 11111111 <_start-0x6eeeeeef>
80000528:	22222137          	lui	x2,0x22222
8000052c:	22210113          	addi	x2,x2,546 # 22222222 <_start-0x5dddddde>
80000530:	0020e033          	or	x0,x1,x2
80000534:	00000393          	addi	x7,x0,0
80000538:	00701463          	bne	x0,x7,80000540 <fail>
8000053c:	02301063          	bne	x0,x3,8000055c <pass>

80000540 <fail>:
80000540:	00018063          	beq	x3,x0,80000540 <fail>
80000544:	00119193          	slli	x3,x3,0x1
80000548:	0011e193          	ori	x3,x3,1
8000054c:	00001297          	auipc	x5,0x1
80000550:	ab428293          	addi	x5,x5,-1356 # 80001000 <tohost>
80000554:	0032a023          	sw	x3,0(x5)
80000558:	0000006f          	jal	x0,80000558 <fail+0x18>

8000055c <pass>:
8000055c:	00001297          	auipc	x5,0x1
80000560:	aa428293          	addi	x5,x5,-1372 # 80001000 <tohost>
80000564:	00100313          	addi	x6,x0,1
80000568:	0062a023          	sw	x6,0(x5)
8000056c:	0000006f          	jal	x0,8000056c <pass+0x10>
80000570:	c0001073          	unimp
80000574:	00000013          	addi	x0,x0,0
80000578:	00000013          	addi	x0,x0,0
8000057c:	00000013          	addi	x0,x0,0
80000580:	00000013          	addi	x0,x0,0
