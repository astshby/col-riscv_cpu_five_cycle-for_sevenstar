
/home/hbyasts/riscv-tool/self/riscv-tests/elf/bgeu.elf:     file format elf32-littleriscv


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
80000080:	00000093          	addi	x1,x0,0
80000084:	00000113          	addi	x2,x0,0
80000088:	0020f663          	bgeu	x1,x2,80000094 <test_2+0x18>
8000008c:	34301263          	bne	x0,x3,800003d0 <fail>
80000090:	00301663          	bne	x0,x3,8000009c <test_3>
80000094:	fe20fee3          	bgeu	x1,x2,80000090 <test_2+0x14>
80000098:	32301c63          	bne	x0,x3,800003d0 <fail>

8000009c <test_3>:
8000009c:	00300193          	addi	x3,x0,3
800000a0:	00100093          	addi	x1,x0,1
800000a4:	00100113          	addi	x2,x0,1
800000a8:	0020f663          	bgeu	x1,x2,800000b4 <test_3+0x18>
800000ac:	32301263          	bne	x0,x3,800003d0 <fail>
800000b0:	00301663          	bne	x0,x3,800000bc <test_4>
800000b4:	fe20fee3          	bgeu	x1,x2,800000b0 <test_3+0x14>
800000b8:	30301c63          	bne	x0,x3,800003d0 <fail>

800000bc <test_4>:
800000bc:	00400193          	addi	x3,x0,4
800000c0:	fff00093          	addi	x1,x0,-1
800000c4:	fff00113          	addi	x2,x0,-1
800000c8:	0020f663          	bgeu	x1,x2,800000d4 <test_4+0x18>
800000cc:	30301263          	bne	x0,x3,800003d0 <fail>
800000d0:	00301663          	bne	x0,x3,800000dc <test_5>
800000d4:	fe20fee3          	bgeu	x1,x2,800000d0 <test_4+0x14>
800000d8:	2e301c63          	bne	x0,x3,800003d0 <fail>

800000dc <test_5>:
800000dc:	00500193          	addi	x3,x0,5
800000e0:	00100093          	addi	x1,x0,1
800000e4:	00000113          	addi	x2,x0,0
800000e8:	0020f663          	bgeu	x1,x2,800000f4 <test_5+0x18>
800000ec:	2e301263          	bne	x0,x3,800003d0 <fail>
800000f0:	00301663          	bne	x0,x3,800000fc <test_6>
800000f4:	fe20fee3          	bgeu	x1,x2,800000f0 <test_5+0x14>
800000f8:	2c301c63          	bne	x0,x3,800003d0 <fail>

800000fc <test_6>:
800000fc:	00600193          	addi	x3,x0,6
80000100:	fff00093          	addi	x1,x0,-1
80000104:	ffe00113          	addi	x2,x0,-2
80000108:	0020f663          	bgeu	x1,x2,80000114 <test_6+0x18>
8000010c:	2c301263          	bne	x0,x3,800003d0 <fail>
80000110:	00301663          	bne	x0,x3,8000011c <test_7>
80000114:	fe20fee3          	bgeu	x1,x2,80000110 <test_6+0x14>
80000118:	2a301c63          	bne	x0,x3,800003d0 <fail>

8000011c <test_7>:
8000011c:	00700193          	addi	x3,x0,7
80000120:	fff00093          	addi	x1,x0,-1
80000124:	00000113          	addi	x2,x0,0
80000128:	0020f663          	bgeu	x1,x2,80000134 <test_7+0x18>
8000012c:	2a301263          	bne	x0,x3,800003d0 <fail>
80000130:	00301663          	bne	x0,x3,8000013c <test_8>
80000134:	fe20fee3          	bgeu	x1,x2,80000130 <test_7+0x14>
80000138:	28301c63          	bne	x0,x3,800003d0 <fail>

8000013c <test_8>:
8000013c:	00800193          	addi	x3,x0,8
80000140:	00000093          	addi	x1,x0,0
80000144:	00100113          	addi	x2,x0,1
80000148:	0020f463          	bgeu	x1,x2,80000150 <test_8+0x14>
8000014c:	00301463          	bne	x0,x3,80000154 <test_8+0x18>
80000150:	28301063          	bne	x0,x3,800003d0 <fail>
80000154:	fe20fee3          	bgeu	x1,x2,80000150 <test_8+0x14>

80000158 <test_9>:
80000158:	00900193          	addi	x3,x0,9
8000015c:	ffe00093          	addi	x1,x0,-2
80000160:	fff00113          	addi	x2,x0,-1
80000164:	0020f463          	bgeu	x1,x2,8000016c <test_9+0x14>
80000168:	00301463          	bne	x0,x3,80000170 <test_9+0x18>
8000016c:	26301263          	bne	x0,x3,800003d0 <fail>
80000170:	fe20fee3          	bgeu	x1,x2,8000016c <test_9+0x14>

80000174 <test_10>:
80000174:	00a00193          	addi	x3,x0,10
80000178:	00000093          	addi	x1,x0,0
8000017c:	fff00113          	addi	x2,x0,-1
80000180:	0020f463          	bgeu	x1,x2,80000188 <test_10+0x14>
80000184:	00301463          	bne	x0,x3,8000018c <test_10+0x18>
80000188:	24301463          	bne	x0,x3,800003d0 <fail>
8000018c:	fe20fee3          	bgeu	x1,x2,80000188 <test_10+0x14>

80000190 <test_11>:
80000190:	00b00193          	addi	x3,x0,11
80000194:	800000b7          	lui	x1,0x80000
80000198:	fff08093          	addi	x1,x1,-1 # 7fffffff <_start-0x1>
8000019c:	80000137          	lui	x2,0x80000
800001a0:	0020f463          	bgeu	x1,x2,800001a8 <test_11+0x18>
800001a4:	00301463          	bne	x0,x3,800001ac <test_11+0x1c>
800001a8:	22301463          	bne	x0,x3,800003d0 <fail>
800001ac:	fe20fee3          	bgeu	x1,x2,800001a8 <test_11+0x18>

800001b0 <test_12>:
800001b0:	00c00193          	addi	x3,x0,12
800001b4:	00000213          	addi	x4,x0,0
800001b8:	f00000b7          	lui	x1,0xf0000
800001bc:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
800001c0:	f0000137          	lui	x2,0xf0000
800001c4:	2020f663          	bgeu	x1,x2,800003d0 <fail>
800001c8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001cc:	00200293          	addi	x5,x0,2
800001d0:	fe5214e3          	bne	x4,x5,800001b8 <test_12+0x8>

800001d4 <test_13>:
800001d4:	00d00193          	addi	x3,x0,13
800001d8:	00000213          	addi	x4,x0,0
800001dc:	f00000b7          	lui	x1,0xf0000
800001e0:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
800001e4:	f0000137          	lui	x2,0xf0000
800001e8:	00000013          	addi	x0,x0,0
800001ec:	1e20f263          	bgeu	x1,x2,800003d0 <fail>
800001f0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001f4:	00200293          	addi	x5,x0,2
800001f8:	fe5212e3          	bne	x4,x5,800001dc <test_13+0x8>

800001fc <test_14>:
800001fc:	00e00193          	addi	x3,x0,14
80000200:	00000213          	addi	x4,x0,0
80000204:	f00000b7          	lui	x1,0xf0000
80000208:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
8000020c:	f0000137          	lui	x2,0xf0000
80000210:	00000013          	addi	x0,x0,0
80000214:	00000013          	addi	x0,x0,0
80000218:	1a20fc63          	bgeu	x1,x2,800003d0 <fail>
8000021c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000220:	00200293          	addi	x5,x0,2
80000224:	fe5210e3          	bne	x4,x5,80000204 <test_14+0x8>

80000228 <test_15>:
80000228:	00f00193          	addi	x3,x0,15
8000022c:	00000213          	addi	x4,x0,0
80000230:	f00000b7          	lui	x1,0xf0000
80000234:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000238:	00000013          	addi	x0,x0,0
8000023c:	f0000137          	lui	x2,0xf0000
80000240:	1820f863          	bgeu	x1,x2,800003d0 <fail>
80000244:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000248:	00200293          	addi	x5,x0,2
8000024c:	fe5212e3          	bne	x4,x5,80000230 <test_15+0x8>

80000250 <test_16>:
80000250:	01000193          	addi	x3,x0,16
80000254:	00000213          	addi	x4,x0,0
80000258:	f00000b7          	lui	x1,0xf0000
8000025c:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000260:	00000013          	addi	x0,x0,0
80000264:	f0000137          	lui	x2,0xf0000
80000268:	00000013          	addi	x0,x0,0
8000026c:	1620f263          	bgeu	x1,x2,800003d0 <fail>
80000270:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000274:	00200293          	addi	x5,x0,2
80000278:	fe5210e3          	bne	x4,x5,80000258 <test_16+0x8>

8000027c <test_17>:
8000027c:	01100193          	addi	x3,x0,17
80000280:	00000213          	addi	x4,x0,0
80000284:	f00000b7          	lui	x1,0xf0000
80000288:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
8000028c:	00000013          	addi	x0,x0,0
80000290:	00000013          	addi	x0,x0,0
80000294:	f0000137          	lui	x2,0xf0000
80000298:	1220fc63          	bgeu	x1,x2,800003d0 <fail>
8000029c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002a0:	00200293          	addi	x5,x0,2
800002a4:	fe5210e3          	bne	x4,x5,80000284 <test_17+0x8>

800002a8 <test_18>:
800002a8:	01200193          	addi	x3,x0,18
800002ac:	00000213          	addi	x4,x0,0
800002b0:	f00000b7          	lui	x1,0xf0000
800002b4:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
800002b8:	f0000137          	lui	x2,0xf0000
800002bc:	1020fa63          	bgeu	x1,x2,800003d0 <fail>
800002c0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002c4:	00200293          	addi	x5,x0,2
800002c8:	fe5214e3          	bne	x4,x5,800002b0 <test_18+0x8>

800002cc <test_19>:
800002cc:	01300193          	addi	x3,x0,19
800002d0:	00000213          	addi	x4,x0,0
800002d4:	f00000b7          	lui	x1,0xf0000
800002d8:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
800002dc:	f0000137          	lui	x2,0xf0000
800002e0:	00000013          	addi	x0,x0,0
800002e4:	0e20f663          	bgeu	x1,x2,800003d0 <fail>
800002e8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800002ec:	00200293          	addi	x5,x0,2
800002f0:	fe5212e3          	bne	x4,x5,800002d4 <test_19+0x8>

800002f4 <test_20>:
800002f4:	01400193          	addi	x3,x0,20
800002f8:	00000213          	addi	x4,x0,0
800002fc:	f00000b7          	lui	x1,0xf0000
80000300:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000304:	f0000137          	lui	x2,0xf0000
80000308:	00000013          	addi	x0,x0,0
8000030c:	00000013          	addi	x0,x0,0
80000310:	0c20f063          	bgeu	x1,x2,800003d0 <fail>
80000314:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000318:	00200293          	addi	x5,x0,2
8000031c:	fe5210e3          	bne	x4,x5,800002fc <test_20+0x8>

80000320 <test_21>:
80000320:	01500193          	addi	x3,x0,21
80000324:	00000213          	addi	x4,x0,0
80000328:	f00000b7          	lui	x1,0xf0000
8000032c:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000330:	00000013          	addi	x0,x0,0
80000334:	f0000137          	lui	x2,0xf0000
80000338:	0820fc63          	bgeu	x1,x2,800003d0 <fail>
8000033c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000340:	00200293          	addi	x5,x0,2
80000344:	fe5212e3          	bne	x4,x5,80000328 <test_21+0x8>

80000348 <test_22>:
80000348:	01600193          	addi	x3,x0,22
8000034c:	00000213          	addi	x4,x0,0
80000350:	f00000b7          	lui	x1,0xf0000
80000354:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000358:	00000013          	addi	x0,x0,0
8000035c:	f0000137          	lui	x2,0xf0000
80000360:	00000013          	addi	x0,x0,0
80000364:	0620f663          	bgeu	x1,x2,800003d0 <fail>
80000368:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000036c:	00200293          	addi	x5,x0,2
80000370:	fe5210e3          	bne	x4,x5,80000350 <test_22+0x8>

80000374 <test_23>:
80000374:	01700193          	addi	x3,x0,23
80000378:	00000213          	addi	x4,x0,0
8000037c:	f00000b7          	lui	x1,0xf0000
80000380:	fff08093          	addi	x1,x1,-1 # efffffff <_end+0x6fffdfff>
80000384:	00000013          	addi	x0,x0,0
80000388:	00000013          	addi	x0,x0,0
8000038c:	f0000137          	lui	x2,0xf0000
80000390:	0420f063          	bgeu	x1,x2,800003d0 <fail>
80000394:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000398:	00200293          	addi	x5,x0,2
8000039c:	fe5210e3          	bne	x4,x5,8000037c <test_23+0x8>

800003a0 <test_24>:
800003a0:	01800193          	addi	x3,x0,24
800003a4:	00100093          	addi	x1,x0,1
800003a8:	0000fa63          	bgeu	x1,x0,800003bc <test_24+0x1c>
800003ac:	00108093          	addi	x1,x1,1
800003b0:	00108093          	addi	x1,x1,1
800003b4:	00108093          	addi	x1,x1,1
800003b8:	00108093          	addi	x1,x1,1
800003bc:	00108093          	addi	x1,x1,1
800003c0:	00108093          	addi	x1,x1,1
800003c4:	00300393          	addi	x7,x0,3
800003c8:	00709463          	bne	x1,x7,800003d0 <fail>
800003cc:	02301063          	bne	x0,x3,800003ec <pass>

800003d0 <fail>:
800003d0:	00018063          	beq	x3,x0,800003d0 <fail>
800003d4:	00119193          	slli	x3,x3,0x1
800003d8:	0011e193          	ori	x3,x3,1
800003dc:	00001297          	auipc	x5,0x1
800003e0:	c2428293          	addi	x5,x5,-988 # 80001000 <tohost>
800003e4:	0032a023          	sw	x3,0(x5)
800003e8:	0000006f          	jal	x0,800003e8 <fail+0x18>

800003ec <pass>:
800003ec:	00001297          	auipc	x5,0x1
800003f0:	c1428293          	addi	x5,x5,-1004 # 80001000 <tohost>
800003f4:	00100313          	addi	x6,x0,1
800003f8:	0062a023          	sw	x6,0(x5)
800003fc:	0000006f          	jal	x0,800003fc <pass+0x10>
80000400:	c0001073          	unimp
