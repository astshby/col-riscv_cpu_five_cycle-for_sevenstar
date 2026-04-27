
/home/hbyasts/riscv-tool/self/riscv-tests/elf/ori.elf:     file format elf32-littleriscv


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
80000080:	ff0106b7          	lui	x13,0xff010
80000084:	f0068693          	addi	x13,x13,-256 # ff00ff00 <_end+0x7f00df00>
80000088:	f0f6e713          	ori	x14,x13,-241
8000008c:	f0f00393          	addi	x7,x0,-241
80000090:	1c771463          	bne	x14,x7,80000258 <fail>

80000094 <test_3>:
80000094:	00300193          	addi	x3,x0,3
80000098:	0ff016b7          	lui	x13,0xff01
8000009c:	ff068693          	addi	x13,x13,-16 # ff00ff0 <_start-0x700ff010>
800000a0:	0f06e713          	ori	x14,x13,240
800000a4:	0ff013b7          	lui	x7,0xff01
800000a8:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
800000ac:	1a771663          	bne	x14,x7,80000258 <fail>

800000b0 <test_4>:
800000b0:	00400193          	addi	x3,x0,4
800000b4:	00ff06b7          	lui	x13,0xff0
800000b8:	0ff68693          	addi	x13,x13,255 # ff00ff <_start-0x7f00ff01>
800000bc:	70f6e713          	ori	x14,x13,1807
800000c0:	00ff03b7          	lui	x7,0xff0
800000c4:	7ff38393          	addi	x7,x7,2047 # ff07ff <_start-0x7f00f801>
800000c8:	18771863          	bne	x14,x7,80000258 <fail>

800000cc <test_5>:
800000cc:	00500193          	addi	x3,x0,5
800000d0:	f00ff6b7          	lui	x13,0xf00ff
800000d4:	00f68693          	addi	x13,x13,15 # f00ff00f <_end+0x700fd00f>
800000d8:	0f06e713          	ori	x14,x13,240
800000dc:	f00ff3b7          	lui	x7,0xf00ff
800000e0:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
800000e4:	16771a63          	bne	x14,x7,80000258 <fail>

800000e8 <test_6>:
800000e8:	00600193          	addi	x3,x0,6
800000ec:	ff0105b7          	lui	x11,0xff010
800000f0:	f0058593          	addi	x11,x11,-256 # ff00ff00 <_end+0x7f00df00>
800000f4:	0f05e593          	ori	x11,x11,240
800000f8:	ff0103b7          	lui	x7,0xff010
800000fc:	ff038393          	addi	x7,x7,-16 # ff00fff0 <_end+0x7f00dff0>
80000100:	14759c63          	bne	x11,x7,80000258 <fail>

80000104 <test_7>:
80000104:	00700193          	addi	x3,x0,7
80000108:	00000213          	addi	x4,x0,0
8000010c:	0ff010b7          	lui	x1,0xff01
80000110:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
80000114:	0f00e713          	ori	x14,x1,240
80000118:	00070313          	addi	x6,x14,0
8000011c:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000120:	00200293          	addi	x5,x0,2
80000124:	fe5214e3          	bne	x4,x5,8000010c <test_7+0x8>
80000128:	0ff013b7          	lui	x7,0xff01
8000012c:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
80000130:	12731463          	bne	x6,x7,80000258 <fail>

80000134 <test_8>:
80000134:	00800193          	addi	x3,x0,8
80000138:	00000213          	addi	x4,x0,0
8000013c:	00ff00b7          	lui	x1,0xff0
80000140:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
80000144:	70f0e713          	ori	x14,x1,1807
80000148:	00000013          	addi	x0,x0,0
8000014c:	00070313          	addi	x6,x14,0
80000150:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000154:	00200293          	addi	x5,x0,2
80000158:	fe5212e3          	bne	x4,x5,8000013c <test_8+0x8>
8000015c:	00ff03b7          	lui	x7,0xff0
80000160:	7ff38393          	addi	x7,x7,2047 # ff07ff <_start-0x7f00f801>
80000164:	0e731a63          	bne	x6,x7,80000258 <fail>

80000168 <test_9>:
80000168:	00900193          	addi	x3,x0,9
8000016c:	00000213          	addi	x4,x0,0
80000170:	f00ff0b7          	lui	x1,0xf00ff
80000174:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0x700fd00f>
80000178:	0f00e713          	ori	x14,x1,240
8000017c:	00000013          	addi	x0,x0,0
80000180:	00000013          	addi	x0,x0,0
80000184:	00070313          	addi	x6,x14,0
80000188:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
8000018c:	00200293          	addi	x5,x0,2
80000190:	fe5210e3          	bne	x4,x5,80000170 <test_9+0x8>
80000194:	f00ff3b7          	lui	x7,0xf00ff
80000198:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
8000019c:	0a731e63          	bne	x6,x7,80000258 <fail>

800001a0 <test_10>:
800001a0:	00a00193          	addi	x3,x0,10
800001a4:	00000213          	addi	x4,x0,0
800001a8:	0ff010b7          	lui	x1,0xff01
800001ac:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_start-0x700ff010>
800001b0:	0f00e713          	ori	x14,x1,240
800001b4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001b8:	00200293          	addi	x5,x0,2
800001bc:	fe5216e3          	bne	x4,x5,800001a8 <test_10+0x8>
800001c0:	0ff013b7          	lui	x7,0xff01
800001c4:	ff038393          	addi	x7,x7,-16 # ff00ff0 <_start-0x700ff010>
800001c8:	08771863          	bne	x14,x7,80000258 <fail>

800001cc <test_11>:
800001cc:	00b00193          	addi	x3,x0,11
800001d0:	00000213          	addi	x4,x0,0
800001d4:	00ff00b7          	lui	x1,0xff0
800001d8:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
800001dc:	00000013          	addi	x0,x0,0
800001e0:	f0f0e713          	ori	x14,x1,-241
800001e4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
800001e8:	00200293          	addi	x5,x0,2
800001ec:	fe5214e3          	bne	x4,x5,800001d4 <test_11+0x8>
800001f0:	fff00393          	addi	x7,x0,-1
800001f4:	06771263          	bne	x14,x7,80000258 <fail>

800001f8 <test_12>:
800001f8:	00c00193          	addi	x3,x0,12
800001fc:	00000213          	addi	x4,x0,0
80000200:	f00ff0b7          	lui	x1,0xf00ff
80000204:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0x700fd00f>
80000208:	00000013          	addi	x0,x0,0
8000020c:	00000013          	addi	x0,x0,0
80000210:	0f00e713          	ori	x14,x1,240
80000214:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
80000218:	00200293          	addi	x5,x0,2
8000021c:	fe5212e3          	bne	x4,x5,80000200 <test_12+0x8>
80000220:	f00ff3b7          	lui	x7,0xf00ff
80000224:	0ff38393          	addi	x7,x7,255 # f00ff0ff <_end+0x700fd0ff>
80000228:	02771863          	bne	x14,x7,80000258 <fail>

8000022c <test_13>:
8000022c:	00d00193          	addi	x3,x0,13
80000230:	0f006093          	ori	x1,x0,240
80000234:	0f000393          	addi	x7,x0,240
80000238:	02709063          	bne	x1,x7,80000258 <fail>

8000023c <test_14>:
8000023c:	00e00193          	addi	x3,x0,14
80000240:	00ff00b7          	lui	x1,0xff0
80000244:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0x7f00ff01>
80000248:	70f0e013          	ori	x0,x1,1807
8000024c:	00000393          	addi	x7,x0,0
80000250:	00701463          	bne	x0,x7,80000258 <fail>
80000254:	02301063          	bne	x0,x3,80000274 <pass>

80000258 <fail>:
80000258:	00018063          	beq	x3,x0,80000258 <fail>
8000025c:	00119193          	slli	x3,x3,0x1
80000260:	0011e193          	ori	x3,x3,1
80000264:	00001297          	auipc	x5,0x1
80000268:	d9c28293          	addi	x5,x5,-612 # 80001000 <tohost>
8000026c:	0032a023          	sw	x3,0(x5)
80000270:	0000006f          	jal	x0,80000270 <fail+0x18>

80000274 <pass>:
80000274:	00001297          	auipc	x5,0x1
80000278:	d8c28293          	addi	x5,x5,-628 # 80001000 <tohost>
8000027c:	00100313          	addi	x6,x0,1
80000280:	0062a023          	sw	x6,0(x5)
80000284:	0000006f          	jal	x0,80000284 <pass+0x10>
80000288:	c0001073          	unimp
8000028c:	00000013          	addi	x0,x0,0
80000290:	00000013          	addi	x0,x0,0
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
