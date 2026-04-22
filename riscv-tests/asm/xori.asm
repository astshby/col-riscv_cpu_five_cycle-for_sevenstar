
/home/hbyasts/riscv-tool/self/riscv-tests/elf/xori.elf:     file format elf32-littleriscv


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
80000080:	00ff16b7          	lui	x13,0xff1
80000084:	f0068693          	addi	x13,x13,-256 # ff0f00 <_start-0x7f00f100>
80000088:	f0f6c713          	xori	x14,x13,-241
8000008c:	ff00f3b7          	lui	x7,0xff00f
80000090:	00f38393          	addi	x7,x7,15 # ff00f00f <_end+0x7f00d00f>
80000094:	1c771663          	bne	x14,x7,80000260 <fail>

80000098 <test_3>:
80000098:	00300193          	addi	x3,x0,3
8000009c:	0ff016b7          	lui	x13,0xff01
800000a0:	ff068693          	addi	x13,x13,-16 # ff00ff0 <_start-0x700ff010>
800000a4:	0f06c713          	xori	x14,x13,240
800000a8:	0ff013b7          	lui	x7,0xff01
800000ac:	f0038393          	addi	x7,x7,-256 # ff00f00 <_start-0x700ff100>
800000b0:	1a771863          	bne	x14,x7,80000260 <fail>

800000b4 <test_4>:
800000b4:	00400193          	addi	x3,x0,4
800000b8:	00ff16b7          	lui	x13,0xff1
800000bc:	8ff68693          	addi	x13,x13,-1793 # ff08ff <_start-0x7f00f701>
800000c0:	70f6c713          	xori	x14,x13,1807
800000c4:	00ff13b7          	lui	x7,0xff1
800000c8:	ff038393          	addi	x7,x7,-16 # ff0ff0 <_start-0x7f00f010>
800000cc:	18771a63          	bne	x14,x7,80000260 <fail>

800000d0 <test_5>:
800000d0:	00500193          	addi	x3,x0,5
800000d4:	f00ff6b7          	lui	x13,0xf00ff
800000d8:	00f68693          	addi	x13,x13,15 # f00ff00f <_end+0x700fd00f>
800000dc:	0f06c713          	xori	x14,x13,240
800000e0:	f00ff3b7          	lui	x7,0xf00ff
800000e4:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
800000e8:	16771c63          	bne	x14,x7,80000260 <fail>

800000ec <test_6>:
800000ec:	00600193          	addi	x3,x0,6
800000f0:	ff00f5b7          	lui	x11,0xff00f
800000f4:	70058593          	addi	x11,x11,1792 # ff00f700 <_end+0x7f00d700>
800000f8:	70f5c593          	xori	x11,x11,1807
800000fc:	ff00f3b7          	lui	x7,0xff00f
80000100:	00f38393          	addi	x7,x7,15 # ff00f00f <_end+0x7f00d00f>
80000104:	14759e63          	bne	x11,x7,80000260 <fail>

80000108 <test_7>:
80000108:	00700193          	addi	x3,x0,7
8000010c:	00000213          	addi	x4,x0,0
80000110:	0ff010b7          	lui	x1,0xff01
80000114:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000118:	0f00c713          	xori	x14,x1,240
8000011c:	00070313          	addi	x6,x14,0
80000120:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000124:	00200293          	addi	x5,x0,2
80000128:	fe5214e3          	bne	x4,x5,80000110 <test_7+0x8>
8000012c:	0ff013b7          	lui	x7,0xff01
80000130:	f0038393          	addi	x7,x7,-256 # ff00f00 <_start-0x700ff100>
80000134:	12731663          	bne	x6,x7,80000260 <fail>

80000138 <test_8>:
80000138:	00800193          	addi	x3,x0,8
8000013c:	00000213          	addi	x4,x0,0
80000140:	00ff10b7          	lui	x1,0xff1
80000144:	8ff08093          	addi	x1,x1,-1793 # ff08ff <_start-0x7f00f701>
80000148:	70f0c713          	xori	x14,x1,1807
8000014c:	00000013          	addi	x0,x0,0
80000150:	00070313          	addi	x6,x14,0
80000154:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000158:	00200293          	addi	x5,x0,2
8000015c:	fe5212e3          	bne	x4,x5,80000140 <test_8+0x8>
80000160:	00ff13b7          	lui	x7,0xff1
80000164:	ff038393          	addi	x7,x7,-16 # ff0ff0 <_start-0x7f00f010>
80000168:	0e731c63          	bne	x6,x7,80000260 <fail>

8000016c <test_9>:
8000016c:	00900193          	addi	x3,x0,9
80000170:	00000213          	addi	x4,x0,0
80000174:	f00ff0b7          	lui	x1,0xf00ff
80000178:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0x700fd00f>
8000017c:	0f00c713          	xori	x14,x1,240
80000180:	00000013          	addi	x0,x0,0
80000184:	00000013          	addi	x0,x0,0
80000188:	00070313          	addi	x6,x14,0
8000018c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000190:	00200293          	addi	x5,x0,2
80000194:	fe5210e3          	bne	x4,x5,80000174 <test_9+0x8>
80000198:	f00ff3b7          	lui	x7,0xf00ff
8000019c:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
800001a0:	0c731063          	bne	x6,x7,80000260 <fail>

800001a4 <test_10>:
800001a4:	00a00193          	addi	x3,x0,10
800001a8:	00000213          	addi	x4,x0,0
800001ac:	0ff010b7          	lui	x1,0xff01
800001b0:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800001b4:	0f00c713          	xori	x14,x1,240
800001b8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001bc:	00200293          	addi	x5,x0,2
800001c0:	fe5216e3          	bne	x4,x5,800001ac <test_10+0x8>
800001c4:	0ff013b7          	lui	x7,0xff01
800001c8:	f0038393          	addi	x7,x7,-256 # ff00f00 <_start-0x700ff100>
800001cc:	08771a63          	bne	x14,x7,80000260 <fail>

800001d0 <test_11>:
800001d0:	00b00193          	addi	x3,x0,11
800001d4:	00000213          	addi	x4,x0,0
800001d8:	00ff10b7          	lui	x1,0xff1
800001dc:	fff08093          	addi	x1,x1,-1 # ff0fff <_start-0x7f00f001>
800001e0:	00000013          	addi	x0,x0,0
800001e4:	00f0c713          	xori	x14,x1,15
800001e8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001ec:	00200293          	addi	x5,x0,2
800001f0:	fe5214e3          	bne	x4,x5,800001d8 <test_11+0x8>
800001f4:	00ff13b7          	lui	x7,0xff1
800001f8:	ff038393          	addi	x7,x7,-16 # ff0ff0 <_start-0x7f00f010>
800001fc:	06771263          	bne	x14,x7,80000260 <fail>

80000200 <test_12>:
80000200:	00c00193          	addi	x3,x0,12
80000204:	00000213          	addi	x4,x0,0
80000208:	f00ff0b7          	lui	x1,0xf00ff
8000020c:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0x700fd00f>
80000210:	00000013          	addi	x0,x0,0
80000214:	00000013          	addi	x0,x0,0
80000218:	0f00c713          	xori	x14,x1,240
8000021c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000220:	00200293          	addi	x5,x0,2
80000224:	fe5212e3          	bne	x4,x5,80000208 <test_12+0x8>
80000228:	f00ff3b7          	lui	x7,0xf00ff
8000022c:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
80000230:	02771863          	bne	x14,x7,80000260 <fail>

80000234 <test_13>:
80000234:	00d00193          	addi	x3,x0,13
80000238:	0f004093          	xori	x1,x0,240
8000023c:	0f000393          	addi	x7,x0,240
80000240:	02709063          	bne	x1,x7,80000260 <fail>

80000244 <test_14>:
80000244:	00e00193          	addi	x3,x0,14
80000248:	00ff00b7          	lui	x1,0xff0
8000024c:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
80000250:	70f0c013          	xori	x0,x1,1807
80000254:	00000393          	addi	x7,x0,0
80000258:	00701463          	bne	x0,x7,80000260 <fail>
8000025c:	02301063          	bne	x0,x3,8000027c <pass>

80000260 <fail>:
80000260:	00018063          	beq	x3,x0,80000260 <fail>
80000264:	00119193          	slli	x3,x3,0x1
80000268:	0011e193          	ori	x3,x3,1
8000026c:	00001297          	auipc	x5,0x1
80000270:	d9428293          	addi	x5,x5,-620 # 80001000 <tohost>
80000274:	0032a023          	sw	x3,0(x5)
80000278:	0000006f          	jal	x0,80000278 <fail+0x18>

8000027c <pass>:
8000027c:	00001297          	auipc	x5,0x1
80000280:	d8428293          	addi	x5,x5,-636 # 80001000 <tohost>
80000284:	00100313          	addi	x6,x0,1
80000288:	0062a023          	sw	x6,0(x5)
8000028c:	0000006f          	jal	x0,8000028c <pass+0x10>
80000290:	c0001073          	unimp
80000294:	00000013          	addi	x0,x0,0
80000298:	00000013          	addi	x0,x0,0
8000029c:	00000013          	addi	x0,x0,0
800002a0:	00000013          	addi	x0,x0,0
800002a4:	00000013          	addi	x0,x0,0
800002a8:	00000013          	addi	x0,x0,0
800002ac:	00000013          	addi	x0,x0,0
800002b0:	00000013          	addi	x0,x0,0
800002b4:	00000013          	addi	x0,x0,0
800002b8:	00000013          	addi	x0,x0,0
800002bc:	00000013          	addi	x0,x0,0
800002c0:	00000013          	addi	x0,x0,0
