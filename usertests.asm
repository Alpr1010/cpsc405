
_usertests:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
    1011:	68 6b 5c 00 00       	push   $0x5c6b
    1016:	6a 01                	push   $0x1
    1018:	e8 63 39 00 00       	call   4980 <printf>

  if(open("usertests.ran", 0) >= 0){
    101d:	5a                   	pop    %edx
    101e:	59                   	pop    %ecx
    101f:	6a 00                	push   $0x0
    1021:	68 7f 5c 00 00       	push   $0x5c7f
    1026:	e8 37 38 00 00       	call   4862 <open>
    102b:	83 c4 10             	add    $0x10,%esp
    102e:	85 c0                	test   %eax,%eax
    1030:	78 14                	js     1046 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    1032:	83 ec 08             	sub    $0x8,%esp
    1035:	68 e8 63 00 00       	push   $0x63e8
    103a:	6a 01                	push   $0x1
    103c:	e8 3f 39 00 00       	call   4980 <printf>
    exit();
    1041:	e8 dc 37 00 00       	call   4822 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    1046:	50                   	push   %eax
    1047:	50                   	push   %eax
    1048:	68 00 02 00 00       	push   $0x200
    104d:	68 7f 5c 00 00       	push   $0x5c7f
    1052:	e8 0b 38 00 00       	call   4862 <open>
    1057:	89 04 24             	mov    %eax,(%esp)
    105a:	e8 eb 37 00 00       	call   484a <close>

  createdelete();
    105f:	e8 7c 11 00 00       	call   21e0 <createdelete>
  linkunlink();
    1064:	e8 37 1a 00 00       	call   2aa0 <linkunlink>
  concreate();
    1069:	e8 22 17 00 00       	call   2790 <concreate>
  fourfiles();
    106e:	e8 7d 0f 00 00       	call   1ff0 <fourfiles>
  sharedfd();
    1073:	e8 b8 0d 00 00       	call   1e30 <sharedfd>

  bigargtest();
    1078:	e8 e3 31 00 00       	call   4260 <bigargtest>
  bigwrite();
    107d:	e8 3e 23 00 00       	call   33c0 <bigwrite>
  bigargtest();
    1082:	e8 d9 31 00 00       	call   4260 <bigargtest>
  bsstest();
    1087:	e8 64 31 00 00       	call   41f0 <bsstest>
  sbrktest();
    108c:	e8 7f 2c 00 00       	call   3d10 <sbrktest>
  validatetest();
    1091:	e8 aa 30 00 00       	call   4140 <validatetest>

  opentest();
    1096:	e8 45 03 00 00       	call   13e0 <opentest>
  writetest();
    109b:	e8 d0 03 00 00       	call   1470 <writetest>
  writetest1();
    10a0:	e8 ab 05 00 00       	call   1650 <writetest1>
  createtest();
    10a5:	e8 76 07 00 00       	call   1820 <createtest>

  openiputtest();
    10aa:	e8 31 02 00 00       	call   12e0 <openiputtest>
  exitiputtest();
    10af:	e8 3c 01 00 00       	call   11f0 <exitiputtest>
  iputtest();
    10b4:	e8 57 00 00 00       	call   1110 <iputtest>

  mem();
    10b9:	e8 a2 0c 00 00       	call   1d60 <mem>
  pipe1();
    10be:	e8 3d 09 00 00       	call   1a00 <pipe1>
  preempt();
    10c3:	e8 c8 0a 00 00       	call   1b90 <preempt>
  exitwait();
    10c8:	e8 03 0c 00 00       	call   1cd0 <exitwait>

  rmdot();
    10cd:	e8 de 26 00 00       	call   37b0 <rmdot>
  fourteen();
    10d2:	e8 99 25 00 00       	call   3670 <fourteen>
  bigfile();
    10d7:	e8 c4 23 00 00       	call   34a0 <bigfile>
  subdir();
    10dc:	e8 ff 1b 00 00       	call   2ce0 <subdir>
  linktest();
    10e1:	e8 9a 14 00 00       	call   2580 <linktest>
  unlinkread();
    10e6:	e8 05 13 00 00       	call   23f0 <unlinkread>
  dirfile();
    10eb:	e8 40 28 00 00       	call   3930 <dirfile>
  iref();
    10f0:	e8 3b 2a 00 00       	call   3b30 <iref>
  forktest();
    10f5:	e8 56 2b 00 00       	call   3c50 <forktest>
  bigdir(); // slow
    10fa:	e8 b1 1a 00 00       	call   2bb0 <bigdir>

  uio();
    10ff:	e8 4c 34 00 00       	call   4550 <uio>

  exectest();
    1104:	e8 a7 08 00 00       	call   19b0 <exectest>

  exit();
    1109:	e8 14 37 00 00       	call   4822 <exit>
    110e:	66 90                	xchg   %ax,%ax

00001110 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
    1116:	68 34 4d 00 00       	push   $0x4d34
    111b:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1121:	e8 5a 38 00 00       	call   4980 <printf>

  if(mkdir("iputdir") < 0){
    1126:	c7 04 24 c7 4c 00 00 	movl   $0x4cc7,(%esp)
    112d:	e8 58 37 00 00       	call   488a <mkdir>
    1132:	83 c4 10             	add    $0x10,%esp
    1135:	85 c0                	test   %eax,%eax
    1137:	78 58                	js     1191 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    1139:	83 ec 0c             	sub    $0xc,%esp
    113c:	68 c7 4c 00 00       	push   $0x4cc7
    1141:	e8 4c 37 00 00       	call   4892 <chdir>
    1146:	83 c4 10             	add    $0x10,%esp
    1149:	85 c0                	test   %eax,%eax
    114b:	0f 88 85 00 00 00    	js     11d6 <iputtest+0xc6>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    1151:	83 ec 0c             	sub    $0xc,%esp
    1154:	68 c4 4c 00 00       	push   $0x4cc4
    1159:	e8 14 37 00 00       	call   4872 <unlink>
    115e:	83 c4 10             	add    $0x10,%esp
    1161:	85 c0                	test   %eax,%eax
    1163:	78 5a                	js     11bf <iputtest+0xaf>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    1165:	83 ec 0c             	sub    $0xc,%esp
    1168:	68 e9 4c 00 00       	push   $0x4ce9
    116d:	e8 20 37 00 00       	call   4892 <chdir>
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	85 c0                	test   %eax,%eax
    1177:	78 2f                	js     11a8 <iputtest+0x98>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
    1179:	83 ec 08             	sub    $0x8,%esp
    117c:	68 6c 4d 00 00       	push   $0x4d6c
    1181:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1187:	e8 f4 37 00 00       	call   4980 <printf>
}
    118c:	83 c4 10             	add    $0x10,%esp
    118f:	c9                   	leave  
    1190:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    1191:	50                   	push   %eax
    1192:	50                   	push   %eax
    1193:	68 a0 4c 00 00       	push   $0x4ca0
    1198:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    119e:	e8 dd 37 00 00       	call   4980 <printf>
    exit();
    11a3:	e8 7a 36 00 00       	call   4822 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
    11a8:	50                   	push   %eax
    11a9:	50                   	push   %eax
    11aa:	68 eb 4c 00 00       	push   $0x4ceb
    11af:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    11b5:	e8 c6 37 00 00       	call   4980 <printf>
    exit();
    11ba:	e8 63 36 00 00       	call   4822 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    11bf:	52                   	push   %edx
    11c0:	52                   	push   %edx
    11c1:	68 cf 4c 00 00       	push   $0x4ccf
    11c6:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    11cc:	e8 af 37 00 00       	call   4980 <printf>
    exit();
    11d1:	e8 4c 36 00 00       	call   4822 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    11d6:	51                   	push   %ecx
    11d7:	51                   	push   %ecx
    11d8:	68 ae 4c 00 00       	push   $0x4cae
    11dd:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    11e3:	e8 98 37 00 00       	call   4980 <printf>
    exit();
    11e8:	e8 35 36 00 00       	call   4822 <exit>
    11ed:	8d 76 00             	lea    0x0(%esi),%esi

000011f0 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
    11f6:	68 fb 4c 00 00       	push   $0x4cfb
    11fb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1201:	e8 7a 37 00 00       	call   4980 <printf>

  pid = fork();
    1206:	e8 0f 36 00 00       	call   481a <fork>
  if(pid < 0){
    120b:	83 c4 10             	add    $0x10,%esp
    120e:	85 c0                	test   %eax,%eax
    1210:	0f 88 82 00 00 00    	js     1298 <exitiputtest+0xa8>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    1216:	75 48                	jne    1260 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
    1218:	83 ec 0c             	sub    $0xc,%esp
    121b:	68 c7 4c 00 00       	push   $0x4cc7
    1220:	e8 65 36 00 00       	call   488a <mkdir>
    1225:	83 c4 10             	add    $0x10,%esp
    1228:	85 c0                	test   %eax,%eax
    122a:	0f 88 96 00 00 00    	js     12c6 <exitiputtest+0xd6>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
    1230:	83 ec 0c             	sub    $0xc,%esp
    1233:	68 c7 4c 00 00       	push   $0x4cc7
    1238:	e8 55 36 00 00       	call   4892 <chdir>
    123d:	83 c4 10             	add    $0x10,%esp
    1240:	85 c0                	test   %eax,%eax
    1242:	78 6b                	js     12af <exitiputtest+0xbf>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
    1244:	83 ec 0c             	sub    $0xc,%esp
    1247:	68 c4 4c 00 00       	push   $0x4cc4
    124c:	e8 21 36 00 00       	call   4872 <unlink>
    1251:	83 c4 10             	add    $0x10,%esp
    1254:	85 c0                	test   %eax,%eax
    1256:	78 28                	js     1280 <exitiputtest+0x90>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
    1258:	e8 c5 35 00 00       	call   4822 <exit>
    125d:	8d 76 00             	lea    0x0(%esi),%esi
  }
  wait();
    1260:	e8 c5 35 00 00       	call   482a <wait>
  printf(stdout, "exitiput test ok\n");
    1265:	83 ec 08             	sub    $0x8,%esp
    1268:	68 1e 4d 00 00       	push   $0x4d1e
    126d:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1273:	e8 08 37 00 00       	call   4980 <printf>
}
    1278:	83 c4 10             	add    $0x10,%esp
    127b:	c9                   	leave  
    127c:	c3                   	ret    
    127d:	8d 76 00             	lea    0x0(%esi),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
    1280:	83 ec 08             	sub    $0x8,%esp
    1283:	68 cf 4c 00 00       	push   $0x4ccf
    1288:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    128e:	e8 ed 36 00 00       	call   4980 <printf>
      exit();
    1293:	e8 8a 35 00 00       	call   4822 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    1298:	51                   	push   %ecx
    1299:	51                   	push   %ecx
    129a:	68 e1 5b 00 00       	push   $0x5be1
    129f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    12a5:	e8 d6 36 00 00       	call   4980 <printf>
    exit();
    12aa:	e8 73 35 00 00       	call   4822 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
    12af:	50                   	push   %eax
    12b0:	50                   	push   %eax
    12b1:	68 0a 4d 00 00       	push   $0x4d0a
    12b6:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    12bc:	e8 bf 36 00 00       	call   4980 <printf>
      exit();
    12c1:	e8 5c 35 00 00       	call   4822 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
    12c6:	52                   	push   %edx
    12c7:	52                   	push   %edx
    12c8:	68 a0 4c 00 00       	push   $0x4ca0
    12cd:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    12d3:	e8 a8 36 00 00       	call   4980 <printf>
      exit();
    12d8:	e8 45 35 00 00       	call   4822 <exit>
    12dd:	8d 76 00             	lea    0x0(%esi),%esi

000012e0 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
    12e6:	68 30 4d 00 00       	push   $0x4d30
    12eb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    12f1:	e8 8a 36 00 00       	call   4980 <printf>
  if(mkdir("oidir") < 0){
    12f6:	c7 04 24 3f 4d 00 00 	movl   $0x4d3f,(%esp)
    12fd:	e8 88 35 00 00       	call   488a <mkdir>
    1302:	83 c4 10             	add    $0x10,%esp
    1305:	85 c0                	test   %eax,%eax
    1307:	0f 88 88 00 00 00    	js     1395 <openiputtest+0xb5>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
    130d:	e8 08 35 00 00       	call   481a <fork>
  if(pid < 0){
    1312:	85 c0                	test   %eax,%eax
    1314:	0f 88 92 00 00 00    	js     13ac <openiputtest+0xcc>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    131a:	75 34                	jne    1350 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
    131c:	83 ec 08             	sub    $0x8,%esp
    131f:	6a 02                	push   $0x2
    1321:	68 3f 4d 00 00       	push   $0x4d3f
    1326:	e8 37 35 00 00       	call   4862 <open>
    if(fd >= 0){
    132b:	83 c4 10             	add    $0x10,%esp
    132e:	85 c0                	test   %eax,%eax
    1330:	78 5e                	js     1390 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
    1332:	83 ec 08             	sub    $0x8,%esp
    1335:	68 a0 5c 00 00       	push   $0x5ca0
    133a:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1340:	e8 3b 36 00 00       	call   4980 <printf>
      exit();
    1345:	e8 d8 34 00 00       	call   4822 <exit>
    134a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
    exit();
  }
  sleep(1);
    1350:	83 ec 0c             	sub    $0xc,%esp
    1353:	6a 01                	push   $0x1
    1355:	e8 58 35 00 00       	call   48b2 <sleep>
  if(unlink("oidir") != 0){
    135a:	c7 04 24 3f 4d 00 00 	movl   $0x4d3f,(%esp)
    1361:	e8 0c 35 00 00       	call   4872 <unlink>
    1366:	83 c4 10             	add    $0x10,%esp
    1369:	85 c0                	test   %eax,%eax
    136b:	75 56                	jne    13c3 <openiputtest+0xe3>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
    136d:	e8 b8 34 00 00       	call   482a <wait>
  printf(stdout, "openiput test ok\n");
    1372:	83 ec 08             	sub    $0x8,%esp
    1375:	68 68 4d 00 00       	push   $0x4d68
    137a:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1380:	e8 fb 35 00 00       	call   4980 <printf>
    1385:	83 c4 10             	add    $0x10,%esp
}
    1388:	c9                   	leave  
    1389:	c3                   	ret    
    138a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit();
    }
    exit();
    1390:	e8 8d 34 00 00       	call   4822 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
    1395:	51                   	push   %ecx
    1396:	51                   	push   %ecx
    1397:	68 45 4d 00 00       	push   $0x4d45
    139c:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    13a2:	e8 d9 35 00 00       	call   4980 <printf>
    exit();
    13a7:	e8 76 34 00 00       	call   4822 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    13ac:	52                   	push   %edx
    13ad:	52                   	push   %edx
    13ae:	68 e1 5b 00 00       	push   $0x5be1
    13b3:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    13b9:	e8 c2 35 00 00       	call   4980 <printf>
    exit();
    13be:	e8 5f 34 00 00       	call   4822 <exit>
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
    13c3:	50                   	push   %eax
    13c4:	50                   	push   %eax
    13c5:	68 59 4d 00 00       	push   $0x4d59
    13ca:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    13d0:	e8 ab 35 00 00       	call   4980 <printf>
    exit();
    13d5:	e8 48 34 00 00       	call   4822 <exit>
    13da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000013e0 <opentest>:

// simple file system tests

void
opentest(void)
{
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
    13e6:	68 7a 4d 00 00       	push   $0x4d7a
    13eb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    13f1:	e8 8a 35 00 00       	call   4980 <printf>
  fd = open("echo", 0);
    13f6:	58                   	pop    %eax
    13f7:	5a                   	pop    %edx
    13f8:	6a 00                	push   $0x0
    13fa:	68 85 4d 00 00       	push   $0x4d85
    13ff:	e8 5e 34 00 00       	call   4862 <open>
  if(fd < 0){
    1404:	83 c4 10             	add    $0x10,%esp
    1407:	85 c0                	test   %eax,%eax
    1409:	78 36                	js     1441 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
    140b:	83 ec 0c             	sub    $0xc,%esp
    140e:	50                   	push   %eax
    140f:	e8 36 34 00 00       	call   484a <close>
  fd = open("doesnotexist", 0);
    1414:	5a                   	pop    %edx
    1415:	59                   	pop    %ecx
    1416:	6a 00                	push   $0x0
    1418:	68 9d 4d 00 00       	push   $0x4d9d
    141d:	e8 40 34 00 00       	call   4862 <open>
  if(fd >= 0){
    1422:	83 c4 10             	add    $0x10,%esp
    1425:	85 c0                	test   %eax,%eax
    1427:	79 2f                	jns    1458 <opentest+0x78>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
    1429:	83 ec 08             	sub    $0x8,%esp
    142c:	68 c8 4d 00 00       	push   $0x4dc8
    1431:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1437:	e8 44 35 00 00       	call   4980 <printf>
}
    143c:	83 c4 10             	add    $0x10,%esp
    143f:	c9                   	leave  
    1440:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
    1441:	50                   	push   %eax
    1442:	50                   	push   %eax
    1443:	68 8a 4d 00 00       	push   $0x4d8a
    1448:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    144e:	e8 2d 35 00 00       	call   4980 <printf>
    exit();
    1453:	e8 ca 33 00 00       	call   4822 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
    1458:	50                   	push   %eax
    1459:	50                   	push   %eax
    145a:	68 aa 4d 00 00       	push   $0x4daa
    145f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1465:	e8 16 35 00 00       	call   4980 <printf>
    exit();
    146a:	e8 b3 33 00 00       	call   4822 <exit>
    146f:	90                   	nop

00001470 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	56                   	push   %esi
    1474:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
    1475:	83 ec 08             	sub    $0x8,%esp
    1478:	68 d6 4d 00 00       	push   $0x4dd6
    147d:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1483:	e8 f8 34 00 00       	call   4980 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    1488:	59                   	pop    %ecx
    1489:	5b                   	pop    %ebx
    148a:	68 02 02 00 00       	push   $0x202
    148f:	68 e7 4d 00 00       	push   $0x4de7
    1494:	e8 c9 33 00 00       	call   4862 <open>
  if(fd >= 0){
    1499:	83 c4 10             	add    $0x10,%esp
    149c:	85 c0                	test   %eax,%eax
    149e:	0f 88 8b 01 00 00    	js     162f <writetest+0x1bf>
    printf(stdout, "creat small succeeded; ok\n");
    14a4:	83 ec 08             	sub    $0x8,%esp
    14a7:	89 c6                	mov    %eax,%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    14a9:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
    14ab:	68 ed 4d 00 00       	push   $0x4ded
    14b0:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    14b6:	e8 c5 34 00 00       	call   4980 <printf>
    14bb:	83 c4 10             	add    $0x10,%esp
    14be:	66 90                	xchg   %ax,%ax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    14c0:	83 ec 04             	sub    $0x4,%esp
    14c3:	6a 0a                	push   $0xa
    14c5:	68 24 4e 00 00       	push   $0x4e24
    14ca:	56                   	push   %esi
    14cb:	e8 72 33 00 00       	call   4842 <write>
    14d0:	83 c4 10             	add    $0x10,%esp
    14d3:	83 f8 0a             	cmp    $0xa,%eax
    14d6:	0f 85 d9 00 00 00    	jne    15b5 <writetest+0x145>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    14dc:	83 ec 04             	sub    $0x4,%esp
    14df:	6a 0a                	push   $0xa
    14e1:	68 2f 4e 00 00       	push   $0x4e2f
    14e6:	56                   	push   %esi
    14e7:	e8 56 33 00 00       	call   4842 <write>
    14ec:	83 c4 10             	add    $0x10,%esp
    14ef:	83 f8 0a             	cmp    $0xa,%eax
    14f2:	0f 85 d6 00 00 00    	jne    15ce <writetest+0x15e>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    14f8:	83 c3 01             	add    $0x1,%ebx
    14fb:	83 fb 64             	cmp    $0x64,%ebx
    14fe:	75 c0                	jne    14c0 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
    1500:	83 ec 08             	sub    $0x8,%esp
    1503:	68 3a 4e 00 00       	push   $0x4e3a
    1508:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    150e:	e8 6d 34 00 00       	call   4980 <printf>
  close(fd);
    1513:	89 34 24             	mov    %esi,(%esp)
    1516:	e8 2f 33 00 00       	call   484a <close>
  fd = open("small", O_RDONLY);
    151b:	58                   	pop    %eax
    151c:	5a                   	pop    %edx
    151d:	6a 00                	push   $0x0
    151f:	68 e7 4d 00 00       	push   $0x4de7
    1524:	e8 39 33 00 00       	call   4862 <open>
  if(fd >= 0){
    1529:	83 c4 10             	add    $0x10,%esp
    152c:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    152e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    1530:	0f 88 b1 00 00 00    	js     15e7 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
    1536:	83 ec 08             	sub    $0x8,%esp
    1539:	68 45 4e 00 00       	push   $0x4e45
    153e:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1544:	e8 37 34 00 00       	call   4980 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    1549:	83 c4 0c             	add    $0xc,%esp
    154c:	68 d0 07 00 00       	push   $0x7d0
    1551:	68 c0 94 00 00       	push   $0x94c0
    1556:	53                   	push   %ebx
    1557:	e8 de 32 00 00       	call   483a <read>
  if(i == 2000){
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    1564:	0f 85 95 00 00 00    	jne    15ff <writetest+0x18f>
    printf(stdout, "read succeeded ok\n");
    156a:	83 ec 08             	sub    $0x8,%esp
    156d:	68 79 4e 00 00       	push   $0x4e79
    1572:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1578:	e8 03 34 00 00       	call   4980 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    157d:	89 1c 24             	mov    %ebx,(%esp)
    1580:	e8 c5 32 00 00       	call   484a <close>

  if(unlink("small") < 0){
    1585:	c7 04 24 e7 4d 00 00 	movl   $0x4de7,(%esp)
    158c:	e8 e1 32 00 00       	call   4872 <unlink>
    1591:	83 c4 10             	add    $0x10,%esp
    1594:	85 c0                	test   %eax,%eax
    1596:	78 7f                	js     1617 <writetest+0x1a7>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    1598:	83 ec 08             	sub    $0x8,%esp
    159b:	68 a1 4e 00 00       	push   $0x4ea1
    15a0:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    15a6:	e8 d5 33 00 00       	call   4980 <printf>
}
    15ab:	83 c4 10             	add    $0x10,%esp
    15ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15b1:	5b                   	pop    %ebx
    15b2:	5e                   	pop    %esi
    15b3:	5d                   	pop    %ebp
    15b4:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
    15b5:	83 ec 04             	sub    $0x4,%esp
    15b8:	53                   	push   %ebx
    15b9:	68 c4 5c 00 00       	push   $0x5cc4
    15be:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    15c4:	e8 b7 33 00 00       	call   4980 <printf>
      exit();
    15c9:	e8 54 32 00 00       	call   4822 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
    15ce:	83 ec 04             	sub    $0x4,%esp
    15d1:	53                   	push   %ebx
    15d2:	68 e8 5c 00 00       	push   $0x5ce8
    15d7:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    15dd:	e8 9e 33 00 00       	call   4980 <printf>
      exit();
    15e2:	e8 3b 32 00 00       	call   4822 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    15e7:	83 ec 08             	sub    $0x8,%esp
    15ea:	68 5e 4e 00 00       	push   $0x4e5e
    15ef:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    15f5:	e8 86 33 00 00       	call   4980 <printf>
    exit();
    15fa:	e8 23 32 00 00       	call   4822 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    15ff:	83 ec 08             	sub    $0x8,%esp
    1602:	68 a5 51 00 00       	push   $0x51a5
    1607:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    160d:	e8 6e 33 00 00       	call   4980 <printf>
    exit();
    1612:	e8 0b 32 00 00       	call   4822 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
    1617:	83 ec 08             	sub    $0x8,%esp
    161a:	68 8c 4e 00 00       	push   $0x4e8c
    161f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1625:	e8 56 33 00 00       	call   4980 <printf>
    exit();
    162a:	e8 f3 31 00 00       	call   4822 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    162f:	83 ec 08             	sub    $0x8,%esp
    1632:	68 08 4e 00 00       	push   $0x4e08
    1637:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    163d:	e8 3e 33 00 00       	call   4980 <printf>
    exit();
    1642:	e8 db 31 00 00       	call   4822 <exit>
    1647:	89 f6                	mov    %esi,%esi
    1649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001650 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	56                   	push   %esi
    1654:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
    1655:	83 ec 08             	sub    $0x8,%esp
    1658:	68 b5 4e 00 00       	push   $0x4eb5
    165d:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1663:	e8 18 33 00 00       	call   4980 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    1668:	59                   	pop    %ecx
    1669:	5b                   	pop    %ebx
    166a:	68 02 02 00 00       	push   $0x202
    166f:	68 2f 4f 00 00       	push   $0x4f2f
    1674:	e8 e9 31 00 00       	call   4862 <open>
  if(fd < 0){
    1679:	83 c4 10             	add    $0x10,%esp
    167c:	85 c0                	test   %eax,%eax
    167e:	0f 88 64 01 00 00    	js     17e8 <writetest1+0x198>
    1684:	89 c6                	mov    %eax,%esi
    1686:	31 db                	xor    %ebx,%ebx
    1688:	90                   	nop
    1689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
    1690:	83 ec 04             	sub    $0x4,%esp
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    1693:	89 1d c0 94 00 00    	mov    %ebx,0x94c0
    if(write(fd, buf, 512) != 512){
    1699:	68 00 02 00 00       	push   $0x200
    169e:	68 c0 94 00 00       	push   $0x94c0
    16a3:	56                   	push   %esi
    16a4:	e8 99 31 00 00       	call   4842 <write>
    16a9:	83 c4 10             	add    $0x10,%esp
    16ac:	3d 00 02 00 00       	cmp    $0x200,%eax
    16b1:	0f 85 b3 00 00 00    	jne    176a <writetest1+0x11a>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    16b7:	83 c3 01             	add    $0x1,%ebx
    16ba:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    16c0:	75 ce                	jne    1690 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
    16c2:	83 ec 0c             	sub    $0xc,%esp
    16c5:	56                   	push   %esi
    16c6:	e8 7f 31 00 00       	call   484a <close>

  fd = open("big", O_RDONLY);
    16cb:	58                   	pop    %eax
    16cc:	5a                   	pop    %edx
    16cd:	6a 00                	push   $0x0
    16cf:	68 2f 4f 00 00       	push   $0x4f2f
    16d4:	e8 89 31 00 00       	call   4862 <open>
  if(fd < 0){
    16d9:	83 c4 10             	add    $0x10,%esp
    16dc:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    16de:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    16e0:	0f 88 ea 00 00 00    	js     17d0 <writetest1+0x180>
    16e6:	31 db                	xor    %ebx,%ebx
    16e8:	eb 1d                	jmp    1707 <writetest1+0xb7>
    16ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
    16f0:	3d 00 02 00 00       	cmp    $0x200,%eax
    16f5:	0f 85 9f 00 00 00    	jne    179a <writetest1+0x14a>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
    16fb:	a1 c0 94 00 00       	mov    0x94c0,%eax
    1700:	39 c3                	cmp    %eax,%ebx
    1702:	75 7f                	jne    1783 <writetest1+0x133>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    1704:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    1707:	83 ec 04             	sub    $0x4,%esp
    170a:	68 00 02 00 00       	push   $0x200
    170f:	68 c0 94 00 00       	push   $0x94c0
    1714:	56                   	push   %esi
    1715:	e8 20 31 00 00       	call   483a <read>
    if(i == 0){
    171a:	83 c4 10             	add    $0x10,%esp
    171d:	85 c0                	test   %eax,%eax
    171f:	75 cf                	jne    16f0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
    1721:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    1727:	0f 84 86 00 00 00    	je     17b3 <writetest1+0x163>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
    172d:	83 ec 0c             	sub    $0xc,%esp
    1730:	56                   	push   %esi
    1731:	e8 14 31 00 00       	call   484a <close>
  if(unlink("big") < 0){
    1736:	c7 04 24 2f 4f 00 00 	movl   $0x4f2f,(%esp)
    173d:	e8 30 31 00 00       	call   4872 <unlink>
    1742:	83 c4 10             	add    $0x10,%esp
    1745:	85 c0                	test   %eax,%eax
    1747:	0f 88 b3 00 00 00    	js     1800 <writetest1+0x1b0>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    174d:	83 ec 08             	sub    $0x8,%esp
    1750:	68 56 4f 00 00       	push   $0x4f56
    1755:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    175b:	e8 20 32 00 00       	call   4980 <printf>
}
    1760:	83 c4 10             	add    $0x10,%esp
    1763:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1766:	5b                   	pop    %ebx
    1767:	5e                   	pop    %esi
    1768:	5d                   	pop    %ebp
    1769:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
    176a:	83 ec 04             	sub    $0x4,%esp
    176d:	53                   	push   %ebx
    176e:	68 df 4e 00 00       	push   $0x4edf
    1773:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1779:	e8 02 32 00 00       	call   4980 <printf>
      exit();
    177e:	e8 9f 30 00 00       	call   4822 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
    1783:	50                   	push   %eax
    1784:	53                   	push   %ebx
    1785:	68 0c 5d 00 00       	push   $0x5d0c
    178a:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1790:	e8 eb 31 00 00       	call   4980 <printf>
             n, ((int*)buf)[0]);
      exit();
    1795:	e8 88 30 00 00       	call   4822 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
    179a:	83 ec 04             	sub    $0x4,%esp
    179d:	50                   	push   %eax
    179e:	68 33 4f 00 00       	push   $0x4f33
    17a3:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    17a9:	e8 d2 31 00 00       	call   4980 <printf>
      exit();
    17ae:	e8 6f 30 00 00       	call   4822 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
    17b3:	83 ec 04             	sub    $0x4,%esp
    17b6:	68 8b 00 00 00       	push   $0x8b
    17bb:	68 16 4f 00 00       	push   $0x4f16
    17c0:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    17c6:	e8 b5 31 00 00       	call   4980 <printf>
        exit();
    17cb:	e8 52 30 00 00       	call   4822 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    17d0:	83 ec 08             	sub    $0x8,%esp
    17d3:	68 fd 4e 00 00       	push   $0x4efd
    17d8:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    17de:	e8 9d 31 00 00       	call   4980 <printf>
    exit();
    17e3:	e8 3a 30 00 00       	call   4822 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	68 c5 4e 00 00       	push   $0x4ec5
    17f0:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    17f6:	e8 85 31 00 00       	call   4980 <printf>
    exit();
    17fb:	e8 22 30 00 00       	call   4822 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
    1800:	83 ec 08             	sub    $0x8,%esp
    1803:	68 43 4f 00 00       	push   $0x4f43
    1808:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    180e:	e8 6d 31 00 00       	call   4980 <printf>
    exit();
    1813:	e8 0a 30 00 00       	call   4822 <exit>
    1818:	90                   	nop
    1819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001820 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
    1824:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    1829:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    182c:	68 2c 5d 00 00       	push   $0x5d2c
    1831:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1837:	e8 44 31 00 00       	call   4980 <printf>

  name[0] = 'a';
    183c:	c6 05 c0 b4 00 00 61 	movb   $0x61,0xb4c0
  name[2] = '\0';
    1843:	c6 05 c2 b4 00 00 00 	movb   $0x0,0xb4c2
    184a:	83 c4 10             	add    $0x10,%esp
    184d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    1850:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    1853:	88 1d c1 b4 00 00    	mov    %bl,0xb4c1
    1859:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
    185c:	68 02 02 00 00       	push   $0x202
    1861:	68 c0 b4 00 00       	push   $0xb4c0
    1866:	e8 f7 2f 00 00       	call   4862 <open>
    close(fd);
    186b:	89 04 24             	mov    %eax,(%esp)
    186e:	e8 d7 2f 00 00       	call   484a <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    1873:	83 c4 10             	add    $0x10,%esp
    1876:	80 fb 64             	cmp    $0x64,%bl
    1879:	75 d5                	jne    1850 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
    187b:	c6 05 c0 b4 00 00 61 	movb   $0x61,0xb4c0
  name[2] = '\0';
    1882:	c6 05 c2 b4 00 00 00 	movb   $0x0,0xb4c2
    1889:	bb 30 00 00 00       	mov    $0x30,%ebx
    188e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    unlink(name);
    1890:	83 ec 0c             	sub    $0xc,%esp
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    1893:	88 1d c1 b4 00 00    	mov    %bl,0xb4c1
    1899:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
    189c:	68 c0 b4 00 00       	push   $0xb4c0
    18a1:	e8 cc 2f 00 00       	call   4872 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    18a6:	83 c4 10             	add    $0x10,%esp
    18a9:	80 fb 64             	cmp    $0x64,%bl
    18ac:	75 e2                	jne    1890 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    18ae:	83 ec 08             	sub    $0x8,%esp
    18b1:	68 54 5d 00 00       	push   $0x5d54
    18b6:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    18bc:	e8 bf 30 00 00       	call   4980 <printf>
}
    18c1:	83 c4 10             	add    $0x10,%esp
    18c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    18c7:	c9                   	leave  
    18c8:	c3                   	ret    
    18c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000018d0 <dirtest>:

void dirtest(void)
{
    18d0:	55                   	push   %ebp
    18d1:	89 e5                	mov    %esp,%ebp
    18d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
    18d6:	68 64 4f 00 00       	push   $0x4f64
    18db:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    18e1:	e8 9a 30 00 00       	call   4980 <printf>

  if(mkdir("dir0") < 0){
    18e6:	c7 04 24 70 4f 00 00 	movl   $0x4f70,(%esp)
    18ed:	e8 98 2f 00 00       	call   488a <mkdir>
    18f2:	83 c4 10             	add    $0x10,%esp
    18f5:	85 c0                	test   %eax,%eax
    18f7:	78 58                	js     1951 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    18f9:	83 ec 0c             	sub    $0xc,%esp
    18fc:	68 70 4f 00 00       	push   $0x4f70
    1901:	e8 8c 2f 00 00       	call   4892 <chdir>
    1906:	83 c4 10             	add    $0x10,%esp
    1909:	85 c0                	test   %eax,%eax
    190b:	0f 88 85 00 00 00    	js     1996 <dirtest+0xc6>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    1911:	83 ec 0c             	sub    $0xc,%esp
    1914:	68 15 55 00 00       	push   $0x5515
    1919:	e8 74 2f 00 00       	call   4892 <chdir>
    191e:	83 c4 10             	add    $0x10,%esp
    1921:	85 c0                	test   %eax,%eax
    1923:	78 5a                	js     197f <dirtest+0xaf>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    1925:	83 ec 0c             	sub    $0xc,%esp
    1928:	68 70 4f 00 00       	push   $0x4f70
    192d:	e8 40 2f 00 00       	call   4872 <unlink>
    1932:	83 c4 10             	add    $0x10,%esp
    1935:	85 c0                	test   %eax,%eax
    1937:	78 2f                	js     1968 <dirtest+0x98>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
    1939:	83 ec 08             	sub    $0x8,%esp
    193c:	68 ad 4f 00 00       	push   $0x4fad
    1941:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1947:	e8 34 30 00 00       	call   4980 <printf>
}
    194c:	83 c4 10             	add    $0x10,%esp
    194f:	c9                   	leave  
    1950:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
    1951:	50                   	push   %eax
    1952:	50                   	push   %eax
    1953:	68 a0 4c 00 00       	push   $0x4ca0
    1958:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    195e:	e8 1d 30 00 00       	call   4980 <printf>
    exit();
    1963:	e8 ba 2e 00 00       	call   4822 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
    1968:	50                   	push   %eax
    1969:	50                   	push   %eax
    196a:	68 99 4f 00 00       	push   $0x4f99
    196f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    1975:	e8 06 30 00 00       	call   4980 <printf>
    exit();
    197a:	e8 a3 2e 00 00       	call   4822 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
    197f:	52                   	push   %edx
    1980:	52                   	push   %edx
    1981:	68 88 4f 00 00       	push   $0x4f88
    1986:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    198c:	e8 ef 2f 00 00       	call   4980 <printf>
    exit();
    1991:	e8 8c 2e 00 00       	call   4822 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
    1996:	51                   	push   %ecx
    1997:	51                   	push   %ecx
    1998:	68 75 4f 00 00       	push   $0x4f75
    199d:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    19a3:	e8 d8 2f 00 00       	call   4980 <printf>
    exit();
    19a8:	e8 75 2e 00 00       	call   4822 <exit>
    19ad:	8d 76 00             	lea    0x0(%esi),%esi

000019b0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
    19b6:	68 bc 4f 00 00       	push   $0x4fbc
    19bb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    19c1:	e8 ba 2f 00 00       	call   4980 <printf>
  if(exec("echo", echoargv) < 0){
    19c6:	5a                   	pop    %edx
    19c7:	59                   	pop    %ecx
    19c8:	68 ec 6c 00 00       	push   $0x6cec
    19cd:	68 85 4d 00 00       	push   $0x4d85
    19d2:	e8 83 2e 00 00       	call   485a <exec>
    19d7:	83 c4 10             	add    $0x10,%esp
    19da:	85 c0                	test   %eax,%eax
    19dc:	78 02                	js     19e0 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    19de:	c9                   	leave  
    19df:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
    19e0:	50                   	push   %eax
    19e1:	50                   	push   %eax
    19e2:	68 c7 4f 00 00       	push   $0x4fc7
    19e7:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    19ed:	e8 8e 2f 00 00       	call   4980 <printf>
    exit();
    19f2:	e8 2b 2e 00 00       	call   4822 <exit>
    19f7:	89 f6                	mov    %esi,%esi
    19f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001a00 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    1a00:	55                   	push   %ebp
    1a01:	89 e5                	mov    %esp,%ebp
    1a03:	57                   	push   %edi
    1a04:	56                   	push   %esi
    1a05:	53                   	push   %ebx
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1a06:	8d 45 e0             	lea    -0x20(%ebp),%eax

// simple fork and pipe read/write

void
pipe1(void)
{
    1a09:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1a0c:	50                   	push   %eax
    1a0d:	e8 20 2e 00 00       	call   4832 <pipe>
    1a12:	83 c4 10             	add    $0x10,%esp
    1a15:	85 c0                	test   %eax,%eax
    1a17:	0f 85 35 01 00 00    	jne    1b52 <pipe1+0x152>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
    1a1d:	e8 f8 2d 00 00       	call   481a <fork>
  seq = 0;
  if(pid == 0){
    1a22:	83 f8 00             	cmp    $0x0,%eax
    1a25:	0f 84 86 00 00 00    	je     1ab1 <pipe1+0xb1>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    1a2b:	0f 8e 35 01 00 00    	jle    1b66 <pipe1+0x166>
    close(fds[1]);
    1a31:	83 ec 0c             	sub    $0xc,%esp
    1a34:	ff 75 e4             	pushl  -0x1c(%ebp)
    total = 0;
    cc = 1;
    1a37:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
    1a3c:	31 db                	xor    %ebx,%ebx
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    1a3e:	e8 07 2e 00 00       	call   484a <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    1a43:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    1a46:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    1a4d:	83 ec 04             	sub    $0x4,%esp
    1a50:	57                   	push   %edi
    1a51:	68 c0 94 00 00       	push   $0x94c0
    1a56:	ff 75 e0             	pushl  -0x20(%ebp)
    1a59:	e8 dc 2d 00 00       	call   483a <read>
    1a5e:	83 c4 10             	add    $0x10,%esp
    1a61:	85 c0                	test   %eax,%eax
    1a63:	0f 8e a3 00 00 00    	jle    1b0c <pipe1+0x10c>
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1a69:	89 d9                	mov    %ebx,%ecx
    1a6b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
    1a6e:	f7 d9                	neg    %ecx
    1a70:	38 9c 0b c0 94 00 00 	cmp    %bl,0x94c0(%ebx,%ecx,1)
    1a77:	8d 53 01             	lea    0x1(%ebx),%edx
    1a7a:	75 1b                	jne    1a97 <pipe1+0x97>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    1a7c:	39 f2                	cmp    %esi,%edx
    1a7e:	89 d3                	mov    %edx,%ebx
    1a80:	75 ee                	jne    1a70 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
    1a82:	01 ff                	add    %edi,%edi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
    1a84:	01 45 d4             	add    %eax,-0x2c(%ebp)
    1a87:	b8 00 20 00 00       	mov    $0x2000,%eax
    1a8c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
    1a92:	0f 4f f8             	cmovg  %eax,%edi
    1a95:	eb b6                	jmp    1a4d <pipe1+0x4d>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
    1a97:	83 ec 08             	sub    $0x8,%esp
    1a9a:	68 f6 4f 00 00       	push   $0x4ff6
    1a9f:	6a 01                	push   $0x1
    1aa1:	e8 da 2e 00 00       	call   4980 <printf>
          return;
    1aa6:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
    1aa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1aac:	5b                   	pop    %ebx
    1aad:	5e                   	pop    %esi
    1aae:	5f                   	pop    %edi
    1aaf:	5d                   	pop    %ebp
    1ab0:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    1ab1:	83 ec 0c             	sub    $0xc,%esp
    1ab4:	ff 75 e0             	pushl  -0x20(%ebp)
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
    1ab7:	31 f6                	xor    %esi,%esi
  if(pid == 0){
    close(fds[0]);
    1ab9:	e8 8c 2d 00 00       	call   484a <close>
    1abe:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
    1ac1:	89 f0                	mov    %esi,%eax
    1ac3:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
    1ac9:	89 f3                	mov    %esi,%ebx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
    1acb:	f7 d8                	neg    %eax
    1acd:	8d 76 00             	lea    0x0(%esi),%esi
    1ad0:	88 9c 18 c0 94 00 00 	mov    %bl,0x94c0(%eax,%ebx,1)
    1ad7:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    1ada:	39 d3                	cmp    %edx,%ebx
    1adc:	75 f2                	jne    1ad0 <pipe1+0xd0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    1ade:	83 ec 04             	sub    $0x4,%esp
    1ae1:	89 de                	mov    %ebx,%esi
    1ae3:	68 09 04 00 00       	push   $0x409
    1ae8:	68 c0 94 00 00       	push   $0x94c0
    1aed:	ff 75 e4             	pushl  -0x1c(%ebp)
    1af0:	e8 4d 2d 00 00       	call   4842 <write>
    1af5:	83 c4 10             	add    $0x10,%esp
    1af8:	3d 09 04 00 00       	cmp    $0x409,%eax
    1afd:	75 7b                	jne    1b7a <pipe1+0x17a>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
    1aff:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    1b05:	75 ba                	jne    1ac1 <pipe1+0xc1>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
    1b07:	e8 16 2d 00 00       	call   4822 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
    1b0c:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
    1b13:	75 26                	jne    1b3b <pipe1+0x13b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
    1b15:	83 ec 0c             	sub    $0xc,%esp
    1b18:	ff 75 e0             	pushl  -0x20(%ebp)
    1b1b:	e8 2a 2d 00 00       	call   484a <close>
    wait();
    1b20:	e8 05 2d 00 00       	call   482a <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
    1b25:	58                   	pop    %eax
    1b26:	5a                   	pop    %edx
    1b27:	68 1b 50 00 00       	push   $0x501b
    1b2c:	6a 01                	push   $0x1
    1b2e:	e8 4d 2e 00 00       	call   4980 <printf>
    1b33:	83 c4 10             	add    $0x10,%esp
    1b36:	e9 6e ff ff ff       	jmp    1aa9 <pipe1+0xa9>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
    1b3b:	83 ec 04             	sub    $0x4,%esp
    1b3e:	ff 75 d4             	pushl  -0x2c(%ebp)
    1b41:	68 04 50 00 00       	push   $0x5004
    1b46:	6a 01                	push   $0x1
    1b48:	e8 33 2e 00 00       	call   4980 <printf>
      exit();
    1b4d:	e8 d0 2c 00 00       	call   4822 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    1b52:	83 ec 08             	sub    $0x8,%esp
    1b55:	68 d9 4f 00 00       	push   $0x4fd9
    1b5a:	6a 01                	push   $0x1
    1b5c:	e8 1f 2e 00 00       	call   4980 <printf>
    exit();
    1b61:	e8 bc 2c 00 00       	call   4822 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    1b66:	83 ec 08             	sub    $0x8,%esp
    1b69:	68 25 50 00 00       	push   $0x5025
    1b6e:	6a 01                	push   $0x1
    1b70:	e8 0b 2e 00 00       	call   4980 <printf>
    exit();
    1b75:	e8 a8 2c 00 00       	call   4822 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
    1b7a:	83 ec 08             	sub    $0x8,%esp
    1b7d:	68 e8 4f 00 00       	push   $0x4fe8
    1b82:	6a 01                	push   $0x1
    1b84:	e8 f7 2d 00 00       	call   4980 <printf>
        exit();
    1b89:	e8 94 2c 00 00       	call   4822 <exit>
    1b8e:	66 90                	xchg   %ax,%ax

00001b90 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    1b90:	55                   	push   %ebp
    1b91:	89 e5                	mov    %esp,%ebp
    1b93:	57                   	push   %edi
    1b94:	56                   	push   %esi
    1b95:	53                   	push   %ebx
    1b96:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    1b99:	68 34 50 00 00       	push   $0x5034
    1b9e:	6a 01                	push   $0x1
    1ba0:	e8 db 2d 00 00       	call   4980 <printf>
  pid1 = fork();
    1ba5:	e8 70 2c 00 00       	call   481a <fork>
  if(pid1 == 0)
    1baa:	83 c4 10             	add    $0x10,%esp
    1bad:	85 c0                	test   %eax,%eax
    1baf:	75 02                	jne    1bb3 <preempt+0x23>
    1bb1:	eb fe                	jmp    1bb1 <preempt+0x21>
    1bb3:	89 c7                	mov    %eax,%edi
    for(;;)
      ;

  pid2 = fork();
    1bb5:	e8 60 2c 00 00       	call   481a <fork>
  if(pid2 == 0)
    1bba:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
    1bbc:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    1bbe:	75 02                	jne    1bc2 <preempt+0x32>
    1bc0:	eb fe                	jmp    1bc0 <preempt+0x30>
    for(;;)
      ;

  pipe(pfds);
    1bc2:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1bc5:	83 ec 0c             	sub    $0xc,%esp
    1bc8:	50                   	push   %eax
    1bc9:	e8 64 2c 00 00       	call   4832 <pipe>
  pid3 = fork();
    1bce:	e8 47 2c 00 00       	call   481a <fork>
  if(pid3 == 0){
    1bd3:	83 c4 10             	add    $0x10,%esp
    1bd6:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
    1bd8:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
    1bda:	75 47                	jne    1c23 <preempt+0x93>
    close(pfds[0]);
    1bdc:	83 ec 0c             	sub    $0xc,%esp
    1bdf:	ff 75 e0             	pushl  -0x20(%ebp)
    1be2:	e8 63 2c 00 00       	call   484a <close>
    if(write(pfds[1], "x", 1) != 1)
    1be7:	83 c4 0c             	add    $0xc,%esp
    1bea:	6a 01                	push   $0x1
    1bec:	68 f9 55 00 00       	push   $0x55f9
    1bf1:	ff 75 e4             	pushl  -0x1c(%ebp)
    1bf4:	e8 49 2c 00 00       	call   4842 <write>
    1bf9:	83 c4 10             	add    $0x10,%esp
    1bfc:	83 f8 01             	cmp    $0x1,%eax
    1bff:	74 12                	je     1c13 <preempt+0x83>
      printf(1, "preempt write error");
    1c01:	83 ec 08             	sub    $0x8,%esp
    1c04:	68 3e 50 00 00       	push   $0x503e
    1c09:	6a 01                	push   $0x1
    1c0b:	e8 70 2d 00 00       	call   4980 <printf>
    1c10:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
    1c13:	83 ec 0c             	sub    $0xc,%esp
    1c16:	ff 75 e4             	pushl  -0x1c(%ebp)
    1c19:	e8 2c 2c 00 00       	call   484a <close>
    1c1e:	83 c4 10             	add    $0x10,%esp
    1c21:	eb fe                	jmp    1c21 <preempt+0x91>
    for(;;)
      ;
  }

  close(pfds[1]);
    1c23:	83 ec 0c             	sub    $0xc,%esp
    1c26:	ff 75 e4             	pushl  -0x1c(%ebp)
    1c29:	e8 1c 2c 00 00       	call   484a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1c2e:	83 c4 0c             	add    $0xc,%esp
    1c31:	68 00 20 00 00       	push   $0x2000
    1c36:	68 c0 94 00 00       	push   $0x94c0
    1c3b:	ff 75 e0             	pushl  -0x20(%ebp)
    1c3e:	e8 f7 2b 00 00       	call   483a <read>
    1c43:	83 c4 10             	add    $0x10,%esp
    1c46:	83 f8 01             	cmp    $0x1,%eax
    1c49:	74 1a                	je     1c65 <preempt+0xd5>
    printf(1, "preempt read error");
    1c4b:	83 ec 08             	sub    $0x8,%esp
    1c4e:	68 52 50 00 00       	push   $0x5052
    1c53:	6a 01                	push   $0x1
    1c55:	e8 26 2d 00 00       	call   4980 <printf>
    return;
    1c5a:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
    1c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c60:	5b                   	pop    %ebx
    1c61:	5e                   	pop    %esi
    1c62:	5f                   	pop    %edi
    1c63:	5d                   	pop    %ebp
    1c64:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
    1c65:	83 ec 0c             	sub    $0xc,%esp
    1c68:	ff 75 e0             	pushl  -0x20(%ebp)
    1c6b:	e8 da 2b 00 00       	call   484a <close>
  printf(1, "kill... ");
    1c70:	58                   	pop    %eax
    1c71:	5a                   	pop    %edx
    1c72:	68 65 50 00 00       	push   $0x5065
    1c77:	6a 01                	push   $0x1
    1c79:	e8 02 2d 00 00       	call   4980 <printf>
  kill(pid1);
    1c7e:	89 3c 24             	mov    %edi,(%esp)
    1c81:	e8 cc 2b 00 00       	call   4852 <kill>
  kill(pid2);
    1c86:	89 34 24             	mov    %esi,(%esp)
    1c89:	e8 c4 2b 00 00       	call   4852 <kill>
  kill(pid3);
    1c8e:	89 1c 24             	mov    %ebx,(%esp)
    1c91:	e8 bc 2b 00 00       	call   4852 <kill>
  printf(1, "wait... ");
    1c96:	59                   	pop    %ecx
    1c97:	5b                   	pop    %ebx
    1c98:	68 6e 50 00 00       	push   $0x506e
    1c9d:	6a 01                	push   $0x1
    1c9f:	e8 dc 2c 00 00       	call   4980 <printf>
  wait();
    1ca4:	e8 81 2b 00 00       	call   482a <wait>
  wait();
    1ca9:	e8 7c 2b 00 00       	call   482a <wait>
  wait();
    1cae:	e8 77 2b 00 00       	call   482a <wait>
  printf(1, "preempt ok\n");
    1cb3:	5e                   	pop    %esi
    1cb4:	5f                   	pop    %edi
    1cb5:	68 77 50 00 00       	push   $0x5077
    1cba:	6a 01                	push   $0x1
    1cbc:	e8 bf 2c 00 00       	call   4980 <printf>
    1cc1:	83 c4 10             	add    $0x10,%esp
    1cc4:	eb 97                	jmp    1c5d <preempt+0xcd>
    1cc6:	8d 76 00             	lea    0x0(%esi),%esi
    1cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001cd0 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
    1cd0:	55                   	push   %ebp
    1cd1:	89 e5                	mov    %esp,%ebp
    1cd3:	56                   	push   %esi
    1cd4:	be 64 00 00 00       	mov    $0x64,%esi
    1cd9:	53                   	push   %ebx
    1cda:	eb 14                	jmp    1cf0 <exitwait+0x20>
    1cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
    1ce0:	74 6f                	je     1d51 <exitwait+0x81>
      if(wait() != pid){
    1ce2:	e8 43 2b 00 00       	call   482a <wait>
    1ce7:	39 c3                	cmp    %eax,%ebx
    1ce9:	75 2d                	jne    1d18 <exitwait+0x48>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    1ceb:	83 ee 01             	sub    $0x1,%esi
    1cee:	74 48                	je     1d38 <exitwait+0x68>
    pid = fork();
    1cf0:	e8 25 2b 00 00       	call   481a <fork>
    if(pid < 0){
    1cf5:	85 c0                	test   %eax,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
    1cf7:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1cf9:	79 e5                	jns    1ce0 <exitwait+0x10>
      printf(1, "fork failed\n");
    1cfb:	83 ec 08             	sub    $0x8,%esp
    1cfe:	68 e1 5b 00 00       	push   $0x5be1
    1d03:	6a 01                	push   $0x1
    1d05:	e8 76 2c 00 00       	call   4980 <printf>
      return;
    1d0a:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
    1d0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1d10:	5b                   	pop    %ebx
    1d11:	5e                   	pop    %esi
    1d12:	5d                   	pop    %ebp
    1d13:	c3                   	ret    
    1d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
    1d18:	83 ec 08             	sub    $0x8,%esp
    1d1b:	68 83 50 00 00       	push   $0x5083
    1d20:	6a 01                	push   $0x1
    1d22:	e8 59 2c 00 00       	call   4980 <printf>
        return;
    1d27:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
    1d2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1d2d:	5b                   	pop    %ebx
    1d2e:	5e                   	pop    %esi
    1d2f:	5d                   	pop    %ebp
    1d30:	c3                   	ret    
    1d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
    1d38:	83 ec 08             	sub    $0x8,%esp
    1d3b:	68 93 50 00 00       	push   $0x5093
    1d40:	6a 01                	push   $0x1
    1d42:	e8 39 2c 00 00       	call   4980 <printf>
    1d47:	83 c4 10             	add    $0x10,%esp
}
    1d4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1d4d:	5b                   	pop    %ebx
    1d4e:	5e                   	pop    %esi
    1d4f:	5d                   	pop    %ebp
    1d50:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
    1d51:	e8 cc 2a 00 00       	call   4822 <exit>
    1d56:	8d 76 00             	lea    0x0(%esi),%esi
    1d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001d60 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    1d60:	55                   	push   %ebp
    1d61:	89 e5                	mov    %esp,%ebp
    1d63:	57                   	push   %edi
    1d64:	56                   	push   %esi
    1d65:	53                   	push   %ebx
    1d66:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    1d69:	68 a0 50 00 00       	push   $0x50a0
    1d6e:	6a 01                	push   $0x1
    1d70:	e8 0b 2c 00 00       	call   4980 <printf>
  ppid = getpid();
    1d75:	e8 28 2b 00 00       	call   48a2 <getpid>
    1d7a:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    1d7c:	e8 99 2a 00 00       	call   481a <fork>
    1d81:	83 c4 10             	add    $0x10,%esp
    1d84:	85 c0                	test   %eax,%eax
    1d86:	75 70                	jne    1df8 <mem+0x98>
    1d88:	31 db                	xor    %ebx,%ebx
    1d8a:	eb 08                	jmp    1d94 <mem+0x34>
    1d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
    1d90:	89 18                	mov    %ebx,(%eax)
    1d92:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
    1d94:	83 ec 0c             	sub    $0xc,%esp
    1d97:	68 11 27 00 00       	push   $0x2711
    1d9c:	e8 0f 2e 00 00       	call   4bb0 <malloc>
    1da1:	83 c4 10             	add    $0x10,%esp
    1da4:	85 c0                	test   %eax,%eax
    1da6:	75 e8                	jne    1d90 <mem+0x30>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    1da8:	85 db                	test   %ebx,%ebx
    1daa:	74 18                	je     1dc4 <mem+0x64>
    1dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
    1db0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    1db2:	83 ec 0c             	sub    $0xc,%esp
    1db5:	53                   	push   %ebx
    1db6:	89 fb                	mov    %edi,%ebx
    1db8:	e8 63 2d 00 00       	call   4b20 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    1dbd:	83 c4 10             	add    $0x10,%esp
    1dc0:	85 db                	test   %ebx,%ebx
    1dc2:	75 ec                	jne    1db0 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    1dc4:	83 ec 0c             	sub    $0xc,%esp
    1dc7:	68 00 50 00 00       	push   $0x5000
    1dcc:	e8 df 2d 00 00       	call   4bb0 <malloc>
    if(m1 == 0){
    1dd1:	83 c4 10             	add    $0x10,%esp
    1dd4:	85 c0                	test   %eax,%eax
    1dd6:	74 30                	je     1e08 <mem+0xa8>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
    1dd8:	83 ec 0c             	sub    $0xc,%esp
    1ddb:	50                   	push   %eax
    1ddc:	e8 3f 2d 00 00       	call   4b20 <free>
    printf(1, "mem ok\n");
    1de1:	58                   	pop    %eax
    1de2:	5a                   	pop    %edx
    1de3:	68 c4 50 00 00       	push   $0x50c4
    1de8:	6a 01                	push   $0x1
    1dea:	e8 91 2b 00 00       	call   4980 <printf>
    exit();
    1def:	e8 2e 2a 00 00       	call   4822 <exit>
    1df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    wait();
  }
}
    1df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1dfb:	5b                   	pop    %ebx
    1dfc:	5e                   	pop    %esi
    1dfd:	5f                   	pop    %edi
    1dfe:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
    1dff:	e9 26 2a 00 00       	jmp    482a <wait>
    1e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
    1e08:	83 ec 08             	sub    $0x8,%esp
    1e0b:	68 aa 50 00 00       	push   $0x50aa
    1e10:	6a 01                	push   $0x1
    1e12:	e8 69 2b 00 00       	call   4980 <printf>
      kill(ppid);
    1e17:	89 34 24             	mov    %esi,(%esp)
    1e1a:	e8 33 2a 00 00       	call   4852 <kill>
      exit();
    1e1f:	e8 fe 29 00 00       	call   4822 <exit>
    1e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001e30 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    1e30:	55                   	push   %ebp
    1e31:	89 e5                	mov    %esp,%ebp
    1e33:	57                   	push   %edi
    1e34:	56                   	push   %esi
    1e35:	53                   	push   %ebx
    1e36:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    1e39:	68 cc 50 00 00       	push   $0x50cc
    1e3e:	6a 01                	push   $0x1
    1e40:	e8 3b 2b 00 00       	call   4980 <printf>

  unlink("sharedfd");
    1e45:	c7 04 24 db 50 00 00 	movl   $0x50db,(%esp)
    1e4c:	e8 21 2a 00 00       	call   4872 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    1e51:	5b                   	pop    %ebx
    1e52:	5e                   	pop    %esi
    1e53:	68 02 02 00 00       	push   $0x202
    1e58:	68 db 50 00 00       	push   $0x50db
    1e5d:	e8 00 2a 00 00       	call   4862 <open>
  if(fd < 0){
    1e62:	83 c4 10             	add    $0x10,%esp
    1e65:	85 c0                	test   %eax,%eax
    1e67:	0f 88 29 01 00 00    	js     1f96 <sharedfd+0x166>
    1e6d:	89 c7                	mov    %eax,%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1e6f:	8d 75 de             	lea    -0x22(%ebp),%esi
    1e72:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    1e77:	e8 9e 29 00 00       	call   481a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1e7c:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    1e7f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1e82:	19 c0                	sbb    %eax,%eax
    1e84:	83 ec 04             	sub    $0x4,%esp
    1e87:	83 e0 f3             	and    $0xfffffff3,%eax
    1e8a:	6a 0a                	push   $0xa
    1e8c:	83 c0 70             	add    $0x70,%eax
    1e8f:	50                   	push   %eax
    1e90:	56                   	push   %esi
    1e91:	e8 fa 27 00 00       	call   4690 <memset>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	eb 0a                	jmp    1ea5 <sharedfd+0x75>
    1e9b:	90                   	nop
    1e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    1ea0:	83 eb 01             	sub    $0x1,%ebx
    1ea3:	74 26                	je     1ecb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1ea5:	83 ec 04             	sub    $0x4,%esp
    1ea8:	6a 0a                	push   $0xa
    1eaa:	56                   	push   %esi
    1eab:	57                   	push   %edi
    1eac:	e8 91 29 00 00       	call   4842 <write>
    1eb1:	83 c4 10             	add    $0x10,%esp
    1eb4:	83 f8 0a             	cmp    $0xa,%eax
    1eb7:	74 e7                	je     1ea0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
    1eb9:	83 ec 08             	sub    $0x8,%esp
    1ebc:	68 a8 5d 00 00       	push   $0x5da8
    1ec1:	6a 01                	push   $0x1
    1ec3:	e8 b8 2a 00 00       	call   4980 <printf>
      break;
    1ec8:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
    1ecb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1ece:	85 c9                	test   %ecx,%ecx
    1ed0:	0f 84 f4 00 00 00    	je     1fca <sharedfd+0x19a>
    exit();
  else
    wait();
    1ed6:	e8 4f 29 00 00       	call   482a <wait>
  close(fd);
    1edb:	83 ec 0c             	sub    $0xc,%esp
    1ede:	31 db                	xor    %ebx,%ebx
    1ee0:	57                   	push   %edi
    1ee1:	8d 7d e8             	lea    -0x18(%ebp),%edi
    1ee4:	e8 61 29 00 00       	call   484a <close>
  fd = open("sharedfd", 0);
    1ee9:	58                   	pop    %eax
    1eea:	5a                   	pop    %edx
    1eeb:	6a 00                	push   $0x0
    1eed:	68 db 50 00 00       	push   $0x50db
    1ef2:	e8 6b 29 00 00       	call   4862 <open>
  if(fd < 0){
    1ef7:	83 c4 10             	add    $0x10,%esp
    1efa:	31 d2                	xor    %edx,%edx
    1efc:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
    1efe:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
    1f01:	0f 88 a9 00 00 00    	js     1fb0 <sharedfd+0x180>
    1f07:	89 f6                	mov    %esi,%esi
    1f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1f10:	83 ec 04             	sub    $0x4,%esp
    1f13:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1f16:	6a 0a                	push   $0xa
    1f18:	56                   	push   %esi
    1f19:	ff 75 d0             	pushl  -0x30(%ebp)
    1f1c:	e8 19 29 00 00       	call   483a <read>
    1f21:	83 c4 10             	add    $0x10,%esp
    1f24:	85 c0                	test   %eax,%eax
    1f26:	7e 27                	jle    1f4f <sharedfd+0x11f>
    1f28:	89 f0                	mov    %esi,%eax
    1f2a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1f2d:	eb 13                	jmp    1f42 <sharedfd+0x112>
    1f2f:	90                   	nop
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    1f30:	80 f9 70             	cmp    $0x70,%cl
    1f33:	0f 94 c1             	sete   %cl
    1f36:	0f b6 c9             	movzbl %cl,%ecx
    1f39:	01 cb                	add    %ecx,%ebx
    1f3b:	83 c0 01             	add    $0x1,%eax
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    1f3e:	39 c7                	cmp    %eax,%edi
    1f40:	74 ce                	je     1f10 <sharedfd+0xe0>
      if(buf[i] == 'c')
    1f42:	0f b6 08             	movzbl (%eax),%ecx
    1f45:	80 f9 63             	cmp    $0x63,%cl
    1f48:	75 e6                	jne    1f30 <sharedfd+0x100>
        nc++;
    1f4a:	83 c2 01             	add    $0x1,%edx
    1f4d:	eb ec                	jmp    1f3b <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    1f4f:	83 ec 0c             	sub    $0xc,%esp
    1f52:	ff 75 d0             	pushl  -0x30(%ebp)
    1f55:	e8 f0 28 00 00       	call   484a <close>
  unlink("sharedfd");
    1f5a:	c7 04 24 db 50 00 00 	movl   $0x50db,(%esp)
    1f61:	e8 0c 29 00 00       	call   4872 <unlink>
  if(nc == 10000 && np == 10000){
    1f66:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1f69:	83 c4 10             	add    $0x10,%esp
    1f6c:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
    1f72:	75 5b                	jne    1fcf <sharedfd+0x19f>
    1f74:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    1f7a:	75 53                	jne    1fcf <sharedfd+0x19f>
    printf(1, "sharedfd ok\n");
    1f7c:	83 ec 08             	sub    $0x8,%esp
    1f7f:	68 e4 50 00 00       	push   $0x50e4
    1f84:	6a 01                	push   $0x1
    1f86:	e8 f5 29 00 00       	call   4980 <printf>
    1f8b:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f91:	5b                   	pop    %ebx
    1f92:	5e                   	pop    %esi
    1f93:	5f                   	pop    %edi
    1f94:	5d                   	pop    %ebp
    1f95:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    1f96:	83 ec 08             	sub    $0x8,%esp
    1f99:	68 7c 5d 00 00       	push   $0x5d7c
    1f9e:	6a 01                	push   $0x1
    1fa0:	e8 db 29 00 00       	call   4980 <printf>
    return;
    1fa5:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1fab:	5b                   	pop    %ebx
    1fac:	5e                   	pop    %esi
    1fad:	5f                   	pop    %edi
    1fae:	5d                   	pop    %ebp
    1faf:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1fb0:	83 ec 08             	sub    $0x8,%esp
    1fb3:	68 c8 5d 00 00       	push   $0x5dc8
    1fb8:	6a 01                	push   $0x1
    1fba:	e8 c1 29 00 00       	call   4980 <printf>
    return;
    1fbf:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1fc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1fc5:	5b                   	pop    %ebx
    1fc6:	5e                   	pop    %esi
    1fc7:	5f                   	pop    %edi
    1fc8:	5d                   	pop    %ebp
    1fc9:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    1fca:	e8 53 28 00 00       	call   4822 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1fcf:	53                   	push   %ebx
    1fd0:	52                   	push   %edx
    1fd1:	68 f1 50 00 00       	push   $0x50f1
    1fd6:	6a 01                	push   $0x1
    1fd8:	e8 a3 29 00 00       	call   4980 <printf>
    exit();
    1fdd:	e8 40 28 00 00       	call   4822 <exit>
    1fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001ff0 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1ff0:	55                   	push   %ebp
    1ff1:	89 e5                	mov    %esp,%ebp
    1ff3:	57                   	push   %edi
    1ff4:	56                   	push   %esi
    1ff5:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    1ff6:	be 06 51 00 00       	mov    $0x5106,%esi

  for(pi = 0; pi < 4; pi++){
    1ffb:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1ffd:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2000:	c7 45 d8 06 51 00 00 	movl   $0x5106,-0x28(%ebp)
    2007:	c7 45 dc 4f 52 00 00 	movl   $0x524f,-0x24(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    200e:	68 0c 51 00 00       	push   $0x510c
    2013:	6a 01                	push   $0x1
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2015:	c7 45 e0 53 52 00 00 	movl   $0x5253,-0x20(%ebp)
    201c:	c7 45 e4 09 51 00 00 	movl   $0x5109,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    2023:	e8 58 29 00 00       	call   4980 <printf>
    2028:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    202b:	83 ec 0c             	sub    $0xc,%esp
    202e:	56                   	push   %esi
    202f:	e8 3e 28 00 00       	call   4872 <unlink>

    pid = fork();
    2034:	e8 e1 27 00 00       	call   481a <fork>
    if(pid < 0){
    2039:	83 c4 10             	add    $0x10,%esp
    203c:	85 c0                	test   %eax,%eax
    203e:	0f 88 83 01 00 00    	js     21c7 <fourfiles+0x1d7>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    2044:	0f 84 e3 00 00 00    	je     212d <fourfiles+0x13d>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    204a:	83 c3 01             	add    $0x1,%ebx
    204d:	83 fb 04             	cmp    $0x4,%ebx
    2050:	74 06                	je     2058 <fourfiles+0x68>
    2052:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    2056:	eb d3                	jmp    202b <fourfiles+0x3b>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    2058:	e8 cd 27 00 00       	call   482a <wait>
    205d:	bf 30 00 00 00       	mov    $0x30,%edi
    2062:	e8 c3 27 00 00       	call   482a <wait>
    2067:	e8 be 27 00 00       	call   482a <wait>
    206c:	e8 b9 27 00 00       	call   482a <wait>
    2071:	c7 45 d4 06 51 00 00 	movl   $0x5106,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    2078:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    207b:	31 db                	xor    %ebx,%ebx
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    207d:	6a 00                	push   $0x0
    207f:	ff 75 d4             	pushl  -0x2c(%ebp)
    2082:	e8 db 27 00 00       	call   4862 <open>
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2087:	83 c4 10             	add    $0x10,%esp
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    208a:	89 c6                	mov    %eax,%esi
    208c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2090:	83 ec 04             	sub    $0x4,%esp
    2093:	68 00 20 00 00       	push   $0x2000
    2098:	68 c0 94 00 00       	push   $0x94c0
    209d:	56                   	push   %esi
    209e:	e8 97 27 00 00       	call   483a <read>
    20a3:	83 c4 10             	add    $0x10,%esp
    20a6:	85 c0                	test   %eax,%eax
    20a8:	7e 1c                	jle    20c6 <fourfiles+0xd6>
    20aa:	31 d2                	xor    %edx,%edx
    20ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    20b0:	0f be 8a c0 94 00 00 	movsbl 0x94c0(%edx),%ecx
    20b7:	39 cf                	cmp    %ecx,%edi
    20b9:	75 5e                	jne    2119 <fourfiles+0x129>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    20bb:	83 c2 01             	add    $0x1,%edx
    20be:	39 d0                	cmp    %edx,%eax
    20c0:	75 ee                	jne    20b0 <fourfiles+0xc0>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    20c2:	01 c3                	add    %eax,%ebx
    20c4:	eb ca                	jmp    2090 <fourfiles+0xa0>
    }
    close(fd);
    20c6:	83 ec 0c             	sub    $0xc,%esp
    20c9:	56                   	push   %esi
    20ca:	e8 7b 27 00 00       	call   484a <close>
    if(total != 12*500){
    20cf:	83 c4 10             	add    $0x10,%esp
    20d2:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    20d8:	0f 85 d4 00 00 00    	jne    21b2 <fourfiles+0x1c2>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    20de:	83 ec 0c             	sub    $0xc,%esp
    20e1:	ff 75 d4             	pushl  -0x2c(%ebp)
    20e4:	83 c7 01             	add    $0x1,%edi
    20e7:	e8 86 27 00 00       	call   4872 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    20ec:	83 c4 10             	add    $0x10,%esp
    20ef:	83 ff 32             	cmp    $0x32,%edi
    20f2:	75 1a                	jne    210e <fourfiles+0x11e>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    20f4:	83 ec 08             	sub    $0x8,%esp
    20f7:	68 4a 51 00 00       	push   $0x514a
    20fc:	6a 01                	push   $0x1
    20fe:	e8 7d 28 00 00       	call   4980 <printf>
}
    2103:	83 c4 10             	add    $0x10,%esp
    2106:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2109:	5b                   	pop    %ebx
    210a:	5e                   	pop    %esi
    210b:	5f                   	pop    %edi
    210c:	5d                   	pop    %ebp
    210d:	c3                   	ret    
    210e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2111:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    2114:	e9 5f ff ff ff       	jmp    2078 <fourfiles+0x88>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    2119:	83 ec 08             	sub    $0x8,%esp
    211c:	68 2d 51 00 00       	push   $0x512d
    2121:	6a 01                	push   $0x1
    2123:	e8 58 28 00 00       	call   4980 <printf>
          exit();
    2128:	e8 f5 26 00 00       	call   4822 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    212d:	83 ec 08             	sub    $0x8,%esp
    2130:	68 02 02 00 00       	push   $0x202
    2135:	56                   	push   %esi
    2136:	e8 27 27 00 00       	call   4862 <open>
      if(fd < 0){
    213b:	83 c4 10             	add    $0x10,%esp
    213e:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    2140:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    2142:	78 5a                	js     219e <fourfiles+0x1ae>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    2144:	83 ec 04             	sub    $0x4,%esp
    2147:	83 c3 30             	add    $0x30,%ebx
    214a:	68 00 02 00 00       	push   $0x200
    214f:	53                   	push   %ebx
    2150:	bb 0c 00 00 00       	mov    $0xc,%ebx
    2155:	68 c0 94 00 00       	push   $0x94c0
    215a:	e8 31 25 00 00       	call   4690 <memset>
    215f:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    2162:	83 ec 04             	sub    $0x4,%esp
    2165:	68 f4 01 00 00       	push   $0x1f4
    216a:	68 c0 94 00 00       	push   $0x94c0
    216f:	56                   	push   %esi
    2170:	e8 cd 26 00 00       	call   4842 <write>
    2175:	83 c4 10             	add    $0x10,%esp
    2178:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    217d:	75 0a                	jne    2189 <fourfiles+0x199>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    217f:	83 eb 01             	sub    $0x1,%ebx
    2182:	75 de                	jne    2162 <fourfiles+0x172>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    2184:	e8 99 26 00 00       	call   4822 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    2189:	83 ec 04             	sub    $0x4,%esp
    218c:	50                   	push   %eax
    218d:	68 1c 51 00 00       	push   $0x511c
    2192:	6a 01                	push   $0x1
    2194:	e8 e7 27 00 00       	call   4980 <printf>
          exit();
    2199:	e8 84 26 00 00       	call   4822 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    219e:	83 ec 08             	sub    $0x8,%esp
    21a1:	68 a7 53 00 00       	push   $0x53a7
    21a6:	6a 01                	push   $0x1
    21a8:	e8 d3 27 00 00       	call   4980 <printf>
        exit();
    21ad:	e8 70 26 00 00       	call   4822 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    21b2:	83 ec 04             	sub    $0x4,%esp
    21b5:	53                   	push   %ebx
    21b6:	68 39 51 00 00       	push   $0x5139
    21bb:	6a 01                	push   $0x1
    21bd:	e8 be 27 00 00       	call   4980 <printf>
      exit();
    21c2:	e8 5b 26 00 00       	call   4822 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    21c7:	83 ec 08             	sub    $0x8,%esp
    21ca:	68 e1 5b 00 00       	push   $0x5be1
    21cf:	6a 01                	push   $0x1
    21d1:	e8 aa 27 00 00       	call   4980 <printf>
      exit();
    21d6:	e8 47 26 00 00       	call   4822 <exit>
    21db:	90                   	nop
    21dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000021e0 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    21e0:	55                   	push   %ebp
    21e1:	89 e5                	mov    %esp,%ebp
    21e3:	57                   	push   %edi
    21e4:	56                   	push   %esi
    21e5:	53                   	push   %ebx
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    21e6:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    21e8:	83 ec 44             	sub    $0x44,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    21eb:	68 58 51 00 00       	push   $0x5158
    21f0:	6a 01                	push   $0x1
    21f2:	e8 89 27 00 00       	call   4980 <printf>
    21f7:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    21fa:	e8 1b 26 00 00       	call   481a <fork>
    if(pid < 0){
    21ff:	85 c0                	test   %eax,%eax
    2201:	0f 88 b7 01 00 00    	js     23be <createdelete+0x1de>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    2207:	0f 84 f6 00 00 00    	je     2303 <createdelete+0x123>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    220d:	83 c3 01             	add    $0x1,%ebx
    2210:	83 fb 04             	cmp    $0x4,%ebx
    2213:	75 e5                	jne    21fa <createdelete+0x1a>
    2215:	8d 7d c8             	lea    -0x38(%ebp),%edi
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    2218:	31 f6                	xor    %esi,%esi
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    221a:	e8 0b 26 00 00       	call   482a <wait>
    221f:	e8 06 26 00 00       	call   482a <wait>
    2224:	e8 01 26 00 00       	call   482a <wait>
    2229:	e8 fc 25 00 00       	call   482a <wait>
  }

  name[0] = name[1] = name[2] = 0;
    222e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    2232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2238:	8d 46 30             	lea    0x30(%esi),%eax
    223b:	83 fe 09             	cmp    $0x9,%esi
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    223e:	bb 70 00 00 00       	mov    $0x70,%ebx
    2243:	0f 9f c2             	setg   %dl
    2246:	85 f6                	test   %esi,%esi
    2248:	88 45 c7             	mov    %al,-0x39(%ebp)
    224b:	0f 94 c0             	sete   %al
    224e:	09 c2                	or     %eax,%edx
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2250:	8d 46 ff             	lea    -0x1(%esi),%eax
    2253:	88 55 c6             	mov    %dl,-0x3a(%ebp)
    2256:	89 45 c0             	mov    %eax,-0x40(%ebp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    2259:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    225d:	83 ec 08             	sub    $0x8,%esp
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    2260:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
    2263:	6a 00                	push   $0x0
    2265:	57                   	push   %edi

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    2266:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    2269:	e8 f4 25 00 00       	call   4862 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    226e:	89 c1                	mov    %eax,%ecx
    2270:	83 c4 10             	add    $0x10,%esp
    2273:	c1 e9 1f             	shr    $0x1f,%ecx
    2276:	84 c9                	test   %cl,%cl
    2278:	74 0a                	je     2284 <createdelete+0xa4>
    227a:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    227e:	0f 85 11 01 00 00    	jne    2395 <createdelete+0x1b5>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2284:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    2288:	0f 86 44 01 00 00    	jbe    23d2 <createdelete+0x1f2>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
    228e:	85 c0                	test   %eax,%eax
    2290:	78 0c                	js     229e <createdelete+0xbe>
        close(fd);
    2292:	83 ec 0c             	sub    $0xc,%esp
    2295:	50                   	push   %eax
    2296:	e8 af 25 00 00       	call   484a <close>
    229b:	83 c4 10             	add    $0x10,%esp
    229e:	83 c3 01             	add    $0x1,%ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    22a1:	80 fb 74             	cmp    $0x74,%bl
    22a4:	75 b3                	jne    2259 <createdelete+0x79>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    22a6:	83 c6 01             	add    $0x1,%esi
    22a9:	83 fe 14             	cmp    $0x14,%esi
    22ac:	75 8a                	jne    2238 <createdelete+0x58>
    22ae:	be 70 00 00 00       	mov    $0x70,%esi
    22b3:	90                   	nop
    22b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    22b8:	8d 46 c0             	lea    -0x40(%esi),%eax
    22bb:	bb 04 00 00 00       	mov    $0x4,%ebx
    22c0:	88 45 c7             	mov    %al,-0x39(%ebp)
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    22c3:	89 f0                	mov    %esi,%eax
      name[1] = '0' + i;
      unlink(name);
    22c5:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    22c8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    22cb:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    22cf:	57                   	push   %edi
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
      name[1] = '0' + i;
    22d0:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    22d3:	e8 9a 25 00 00       	call   4872 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    22d8:	83 c4 10             	add    $0x10,%esp
    22db:	83 eb 01             	sub    $0x1,%ebx
    22de:	75 e3                	jne    22c3 <createdelete+0xe3>
    22e0:	83 c6 01             	add    $0x1,%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    22e3:	89 f0                	mov    %esi,%eax
    22e5:	3c 84                	cmp    $0x84,%al
    22e7:	75 cf                	jne    22b8 <createdelete+0xd8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    22e9:	83 ec 08             	sub    $0x8,%esp
    22ec:	68 6b 51 00 00       	push   $0x516b
    22f1:	6a 01                	push   $0x1
    22f3:	e8 88 26 00 00       	call   4980 <printf>
}
    22f8:	83 c4 10             	add    $0x10,%esp
    22fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    22fe:	5b                   	pop    %ebx
    22ff:	5e                   	pop    %esi
    2300:	5f                   	pop    %edi
    2301:	5d                   	pop    %ebp
    2302:	c3                   	ret    
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    2303:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    2306:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    230a:	be 01 00 00 00       	mov    $0x1,%esi
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    230f:	88 5d c8             	mov    %bl,-0x38(%ebp)
    2312:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[2] = '\0';
    2315:	31 db                	xor    %ebx,%ebx
    2317:	eb 12                	jmp    232b <createdelete+0x14b>
    2319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    2320:	83 fe 14             	cmp    $0x14,%esi
    2323:	74 6b                	je     2390 <createdelete+0x1b0>
    2325:	83 c3 01             	add    $0x1,%ebx
    2328:	83 c6 01             	add    $0x1,%esi
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    232b:	83 ec 08             	sub    $0x8,%esp

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    232e:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    2331:	68 02 02 00 00       	push   $0x202
    2336:	57                   	push   %edi

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    2337:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    233a:	e8 23 25 00 00       	call   4862 <open>
        if(fd < 0){
    233f:	83 c4 10             	add    $0x10,%esp
    2342:	85 c0                	test   %eax,%eax
    2344:	78 64                	js     23aa <createdelete+0x1ca>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    2346:	83 ec 0c             	sub    $0xc,%esp
    2349:	50                   	push   %eax
    234a:	e8 fb 24 00 00       	call   484a <close>
        if(i > 0 && (i % 2 ) == 0){
    234f:	83 c4 10             	add    $0x10,%esp
    2352:	85 db                	test   %ebx,%ebx
    2354:	74 cf                	je     2325 <createdelete+0x145>
    2356:	f6 c3 01             	test   $0x1,%bl
    2359:	75 c5                	jne    2320 <createdelete+0x140>
          name[1] = '0' + (i / 2);
          if(unlink(name) < 0){
    235b:	83 ec 0c             	sub    $0xc,%esp
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    235e:	89 d8                	mov    %ebx,%eax
    2360:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    2362:	57                   	push   %edi
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    2363:	83 c0 30             	add    $0x30,%eax
    2366:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    2369:	e8 04 25 00 00       	call   4872 <unlink>
    236e:	83 c4 10             	add    $0x10,%esp
    2371:	85 c0                	test   %eax,%eax
    2373:	79 ab                	jns    2320 <createdelete+0x140>
            printf(1, "unlink failed\n");
    2375:	83 ec 08             	sub    $0x8,%esp
    2378:	68 59 4d 00 00       	push   $0x4d59
    237d:	6a 01                	push   $0x1
    237f:	e8 fc 25 00 00       	call   4980 <printf>
            exit();
    2384:	e8 99 24 00 00       	call   4822 <exit>
    2389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          }
        }
      }
      exit();
    2390:	e8 8d 24 00 00       	call   4822 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    2395:	83 ec 04             	sub    $0x4,%esp
    2398:	57                   	push   %edi
    2399:	68 f4 5d 00 00       	push   $0x5df4
    239e:	6a 01                	push   $0x1
    23a0:	e8 db 25 00 00       	call   4980 <printf>
        exit();
    23a5:	e8 78 24 00 00       	call   4822 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    23aa:	83 ec 08             	sub    $0x8,%esp
    23ad:	68 a7 53 00 00       	push   $0x53a7
    23b2:	6a 01                	push   $0x1
    23b4:	e8 c7 25 00 00       	call   4980 <printf>
          exit();
    23b9:	e8 64 24 00 00       	call   4822 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    23be:	83 ec 08             	sub    $0x8,%esp
    23c1:	68 e1 5b 00 00       	push   $0x5be1
    23c6:	6a 01                	push   $0x1
    23c8:	e8 b3 25 00 00       	call   4980 <printf>
      exit();
    23cd:	e8 50 24 00 00       	call   4822 <exit>
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    23d2:	85 c0                	test   %eax,%eax
    23d4:	0f 88 c4 fe ff ff    	js     229e <createdelete+0xbe>
        printf(1, "oops createdelete %s did exist\n", name);
    23da:	83 ec 04             	sub    $0x4,%esp
    23dd:	57                   	push   %edi
    23de:	68 18 5e 00 00       	push   $0x5e18
    23e3:	6a 01                	push   $0x1
    23e5:	e8 96 25 00 00       	call   4980 <printf>
        exit();
    23ea:	e8 33 24 00 00       	call   4822 <exit>
    23ef:	90                   	nop

000023f0 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    23f0:	55                   	push   %ebp
    23f1:	89 e5                	mov    %esp,%ebp
    23f3:	56                   	push   %esi
    23f4:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    23f5:	83 ec 08             	sub    $0x8,%esp
    23f8:	68 7c 51 00 00       	push   $0x517c
    23fd:	6a 01                	push   $0x1
    23ff:	e8 7c 25 00 00       	call   4980 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    2404:	5b                   	pop    %ebx
    2405:	5e                   	pop    %esi
    2406:	68 02 02 00 00       	push   $0x202
    240b:	68 8d 51 00 00       	push   $0x518d
    2410:	e8 4d 24 00 00       	call   4862 <open>
  if(fd < 0){
    2415:	83 c4 10             	add    $0x10,%esp
    2418:	85 c0                	test   %eax,%eax
    241a:	0f 88 e6 00 00 00    	js     2506 <unlinkread+0x116>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    2420:	83 ec 04             	sub    $0x4,%esp
    2423:	89 c3                	mov    %eax,%ebx
    2425:	6a 05                	push   $0x5
    2427:	68 b2 51 00 00       	push   $0x51b2
    242c:	50                   	push   %eax
    242d:	e8 10 24 00 00       	call   4842 <write>
  close(fd);
    2432:	89 1c 24             	mov    %ebx,(%esp)
    2435:	e8 10 24 00 00       	call   484a <close>

  fd = open("unlinkread", O_RDWR);
    243a:	58                   	pop    %eax
    243b:	5a                   	pop    %edx
    243c:	6a 02                	push   $0x2
    243e:	68 8d 51 00 00       	push   $0x518d
    2443:	e8 1a 24 00 00       	call   4862 <open>
  if(fd < 0){
    2448:	83 c4 10             	add    $0x10,%esp
    244b:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    244d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    244f:	0f 88 10 01 00 00    	js     2565 <unlinkread+0x175>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    2455:	83 ec 0c             	sub    $0xc,%esp
    2458:	68 8d 51 00 00       	push   $0x518d
    245d:	e8 10 24 00 00       	call   4872 <unlink>
    2462:	83 c4 10             	add    $0x10,%esp
    2465:	85 c0                	test   %eax,%eax
    2467:	0f 85 e5 00 00 00    	jne    2552 <unlinkread+0x162>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    246d:	83 ec 08             	sub    $0x8,%esp
    2470:	68 02 02 00 00       	push   $0x202
    2475:	68 8d 51 00 00       	push   $0x518d
    247a:	e8 e3 23 00 00       	call   4862 <open>
  write(fd1, "yyy", 3);
    247f:	83 c4 0c             	add    $0xc,%esp
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    2482:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    2484:	6a 03                	push   $0x3
    2486:	68 ea 51 00 00       	push   $0x51ea
    248b:	50                   	push   %eax
    248c:	e8 b1 23 00 00       	call   4842 <write>
  close(fd1);
    2491:	89 34 24             	mov    %esi,(%esp)
    2494:	e8 b1 23 00 00       	call   484a <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    2499:	83 c4 0c             	add    $0xc,%esp
    249c:	68 00 20 00 00       	push   $0x2000
    24a1:	68 c0 94 00 00       	push   $0x94c0
    24a6:	53                   	push   %ebx
    24a7:	e8 8e 23 00 00       	call   483a <read>
    24ac:	83 c4 10             	add    $0x10,%esp
    24af:	83 f8 05             	cmp    $0x5,%eax
    24b2:	0f 85 87 00 00 00    	jne    253f <unlinkread+0x14f>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    24b8:	80 3d c0 94 00 00 68 	cmpb   $0x68,0x94c0
    24bf:	75 6b                	jne    252c <unlinkread+0x13c>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    24c1:	83 ec 04             	sub    $0x4,%esp
    24c4:	6a 0a                	push   $0xa
    24c6:	68 c0 94 00 00       	push   $0x94c0
    24cb:	53                   	push   %ebx
    24cc:	e8 71 23 00 00       	call   4842 <write>
    24d1:	83 c4 10             	add    $0x10,%esp
    24d4:	83 f8 0a             	cmp    $0xa,%eax
    24d7:	75 40                	jne    2519 <unlinkread+0x129>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    24d9:	83 ec 0c             	sub    $0xc,%esp
    24dc:	53                   	push   %ebx
    24dd:	e8 68 23 00 00       	call   484a <close>
  unlink("unlinkread");
    24e2:	c7 04 24 8d 51 00 00 	movl   $0x518d,(%esp)
    24e9:	e8 84 23 00 00       	call   4872 <unlink>
  printf(1, "unlinkread ok\n");
    24ee:	58                   	pop    %eax
    24ef:	5a                   	pop    %edx
    24f0:	68 35 52 00 00       	push   $0x5235
    24f5:	6a 01                	push   $0x1
    24f7:	e8 84 24 00 00       	call   4980 <printf>
}
    24fc:	83 c4 10             	add    $0x10,%esp
    24ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2502:	5b                   	pop    %ebx
    2503:	5e                   	pop    %esi
    2504:	5d                   	pop    %ebp
    2505:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    2506:	51                   	push   %ecx
    2507:	51                   	push   %ecx
    2508:	68 98 51 00 00       	push   $0x5198
    250d:	6a 01                	push   $0x1
    250f:	e8 6c 24 00 00       	call   4980 <printf>
    exit();
    2514:	e8 09 23 00 00       	call   4822 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    2519:	51                   	push   %ecx
    251a:	51                   	push   %ecx
    251b:	68 1c 52 00 00       	push   $0x521c
    2520:	6a 01                	push   $0x1
    2522:	e8 59 24 00 00       	call   4980 <printf>
    exit();
    2527:	e8 f6 22 00 00       	call   4822 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    252c:	53                   	push   %ebx
    252d:	53                   	push   %ebx
    252e:	68 05 52 00 00       	push   $0x5205
    2533:	6a 01                	push   $0x1
    2535:	e8 46 24 00 00       	call   4980 <printf>
    exit();
    253a:	e8 e3 22 00 00       	call   4822 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    253f:	56                   	push   %esi
    2540:	56                   	push   %esi
    2541:	68 ee 51 00 00       	push   $0x51ee
    2546:	6a 01                	push   $0x1
    2548:	e8 33 24 00 00       	call   4980 <printf>
    exit();
    254d:	e8 d0 22 00 00       	call   4822 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    2552:	50                   	push   %eax
    2553:	50                   	push   %eax
    2554:	68 d0 51 00 00       	push   $0x51d0
    2559:	6a 01                	push   $0x1
    255b:	e8 20 24 00 00       	call   4980 <printf>
    exit();
    2560:	e8 bd 22 00 00       	call   4822 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    2565:	50                   	push   %eax
    2566:	50                   	push   %eax
    2567:	68 b8 51 00 00       	push   $0x51b8
    256c:	6a 01                	push   $0x1
    256e:	e8 0d 24 00 00       	call   4980 <printf>
    exit();
    2573:	e8 aa 22 00 00       	call   4822 <exit>
    2578:	90                   	nop
    2579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002580 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    2580:	55                   	push   %ebp
    2581:	89 e5                	mov    %esp,%ebp
    2583:	53                   	push   %ebx
    2584:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    2587:	68 44 52 00 00       	push   $0x5244
    258c:	6a 01                	push   $0x1
    258e:	e8 ed 23 00 00       	call   4980 <printf>

  unlink("lf1");
    2593:	c7 04 24 4e 52 00 00 	movl   $0x524e,(%esp)
    259a:	e8 d3 22 00 00       	call   4872 <unlink>
  unlink("lf2");
    259f:	c7 04 24 52 52 00 00 	movl   $0x5252,(%esp)
    25a6:	e8 c7 22 00 00       	call   4872 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    25ab:	58                   	pop    %eax
    25ac:	5a                   	pop    %edx
    25ad:	68 02 02 00 00       	push   $0x202
    25b2:	68 4e 52 00 00       	push   $0x524e
    25b7:	e8 a6 22 00 00       	call   4862 <open>
  if(fd < 0){
    25bc:	83 c4 10             	add    $0x10,%esp
    25bf:	85 c0                	test   %eax,%eax
    25c1:	0f 88 1e 01 00 00    	js     26e5 <linktest+0x165>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    25c7:	83 ec 04             	sub    $0x4,%esp
    25ca:	89 c3                	mov    %eax,%ebx
    25cc:	6a 05                	push   $0x5
    25ce:	68 b2 51 00 00       	push   $0x51b2
    25d3:	50                   	push   %eax
    25d4:	e8 69 22 00 00       	call   4842 <write>
    25d9:	83 c4 10             	add    $0x10,%esp
    25dc:	83 f8 05             	cmp    $0x5,%eax
    25df:	0f 85 98 01 00 00    	jne    277d <linktest+0x1fd>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    25e5:	83 ec 0c             	sub    $0xc,%esp
    25e8:	53                   	push   %ebx
    25e9:	e8 5c 22 00 00       	call   484a <close>

  if(link("lf1", "lf2") < 0){
    25ee:	5b                   	pop    %ebx
    25ef:	58                   	pop    %eax
    25f0:	68 52 52 00 00       	push   $0x5252
    25f5:	68 4e 52 00 00       	push   $0x524e
    25fa:	e8 83 22 00 00       	call   4882 <link>
    25ff:	83 c4 10             	add    $0x10,%esp
    2602:	85 c0                	test   %eax,%eax
    2604:	0f 88 60 01 00 00    	js     276a <linktest+0x1ea>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    260a:	83 ec 0c             	sub    $0xc,%esp
    260d:	68 4e 52 00 00       	push   $0x524e
    2612:	e8 5b 22 00 00       	call   4872 <unlink>

  if(open("lf1", 0) >= 0){
    2617:	58                   	pop    %eax
    2618:	5a                   	pop    %edx
    2619:	6a 00                	push   $0x0
    261b:	68 4e 52 00 00       	push   $0x524e
    2620:	e8 3d 22 00 00       	call   4862 <open>
    2625:	83 c4 10             	add    $0x10,%esp
    2628:	85 c0                	test   %eax,%eax
    262a:	0f 89 27 01 00 00    	jns    2757 <linktest+0x1d7>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	6a 00                	push   $0x0
    2635:	68 52 52 00 00       	push   $0x5252
    263a:	e8 23 22 00 00       	call   4862 <open>
  if(fd < 0){
    263f:	83 c4 10             	add    $0x10,%esp
    2642:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    2644:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2646:	0f 88 f8 00 00 00    	js     2744 <linktest+0x1c4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    264c:	83 ec 04             	sub    $0x4,%esp
    264f:	68 00 20 00 00       	push   $0x2000
    2654:	68 c0 94 00 00       	push   $0x94c0
    2659:	50                   	push   %eax
    265a:	e8 db 21 00 00       	call   483a <read>
    265f:	83 c4 10             	add    $0x10,%esp
    2662:	83 f8 05             	cmp    $0x5,%eax
    2665:	0f 85 c6 00 00 00    	jne    2731 <linktest+0x1b1>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    266b:	83 ec 0c             	sub    $0xc,%esp
    266e:	53                   	push   %ebx
    266f:	e8 d6 21 00 00       	call   484a <close>

  if(link("lf2", "lf2") >= 0){
    2674:	58                   	pop    %eax
    2675:	5a                   	pop    %edx
    2676:	68 52 52 00 00       	push   $0x5252
    267b:	68 52 52 00 00       	push   $0x5252
    2680:	e8 fd 21 00 00       	call   4882 <link>
    2685:	83 c4 10             	add    $0x10,%esp
    2688:	85 c0                	test   %eax,%eax
    268a:	0f 89 8e 00 00 00    	jns    271e <linktest+0x19e>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    2690:	83 ec 0c             	sub    $0xc,%esp
    2693:	68 52 52 00 00       	push   $0x5252
    2698:	e8 d5 21 00 00       	call   4872 <unlink>
  if(link("lf2", "lf1") >= 0){
    269d:	59                   	pop    %ecx
    269e:	5b                   	pop    %ebx
    269f:	68 4e 52 00 00       	push   $0x524e
    26a4:	68 52 52 00 00       	push   $0x5252
    26a9:	e8 d4 21 00 00       	call   4882 <link>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	79 56                	jns    270b <linktest+0x18b>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    26b5:	83 ec 08             	sub    $0x8,%esp
    26b8:	68 4e 52 00 00       	push   $0x524e
    26bd:	68 16 55 00 00       	push   $0x5516
    26c2:	e8 bb 21 00 00       	call   4882 <link>
    26c7:	83 c4 10             	add    $0x10,%esp
    26ca:	85 c0                	test   %eax,%eax
    26cc:	79 2a                	jns    26f8 <linktest+0x178>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    26ce:	83 ec 08             	sub    $0x8,%esp
    26d1:	68 ec 52 00 00       	push   $0x52ec
    26d6:	6a 01                	push   $0x1
    26d8:	e8 a3 22 00 00       	call   4980 <printf>
}
    26dd:	83 c4 10             	add    $0x10,%esp
    26e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    26e3:	c9                   	leave  
    26e4:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    26e5:	50                   	push   %eax
    26e6:	50                   	push   %eax
    26e7:	68 56 52 00 00       	push   $0x5256
    26ec:	6a 01                	push   $0x1
    26ee:	e8 8d 22 00 00       	call   4980 <printf>
    exit();
    26f3:	e8 2a 21 00 00       	call   4822 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    26f8:	50                   	push   %eax
    26f9:	50                   	push   %eax
    26fa:	68 d0 52 00 00       	push   $0x52d0
    26ff:	6a 01                	push   $0x1
    2701:	e8 7a 22 00 00       	call   4980 <printf>
    exit();
    2706:	e8 17 21 00 00       	call   4822 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    270b:	52                   	push   %edx
    270c:	52                   	push   %edx
    270d:	68 60 5e 00 00       	push   $0x5e60
    2712:	6a 01                	push   $0x1
    2714:	e8 67 22 00 00       	call   4980 <printf>
    exit();
    2719:	e8 04 21 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    271e:	50                   	push   %eax
    271f:	50                   	push   %eax
    2720:	68 b2 52 00 00       	push   $0x52b2
    2725:	6a 01                	push   $0x1
    2727:	e8 54 22 00 00       	call   4980 <printf>
    exit();
    272c:	e8 f1 20 00 00       	call   4822 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    2731:	51                   	push   %ecx
    2732:	51                   	push   %ecx
    2733:	68 a1 52 00 00       	push   $0x52a1
    2738:	6a 01                	push   $0x1
    273a:	e8 41 22 00 00       	call   4980 <printf>
    exit();
    273f:	e8 de 20 00 00       	call   4822 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    2744:	53                   	push   %ebx
    2745:	53                   	push   %ebx
    2746:	68 90 52 00 00       	push   $0x5290
    274b:	6a 01                	push   $0x1
    274d:	e8 2e 22 00 00       	call   4980 <printf>
    exit();
    2752:	e8 cb 20 00 00       	call   4822 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    2757:	50                   	push   %eax
    2758:	50                   	push   %eax
    2759:	68 38 5e 00 00       	push   $0x5e38
    275e:	6a 01                	push   $0x1
    2760:	e8 1b 22 00 00       	call   4980 <printf>
    exit();
    2765:	e8 b8 20 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    276a:	51                   	push   %ecx
    276b:	51                   	push   %ecx
    276c:	68 7b 52 00 00       	push   $0x527b
    2771:	6a 01                	push   $0x1
    2773:	e8 08 22 00 00       	call   4980 <printf>
    exit();
    2778:	e8 a5 20 00 00       	call   4822 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    277d:	50                   	push   %eax
    277e:	50                   	push   %eax
    277f:	68 69 52 00 00       	push   $0x5269
    2784:	6a 01                	push   $0x1
    2786:	e8 f5 21 00 00       	call   4980 <printf>
    exit();
    278b:	e8 92 20 00 00       	call   4822 <exit>

00002790 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    2790:	55                   	push   %ebp
    2791:	89 e5                	mov    %esp,%ebp
    2793:	57                   	push   %edi
    2794:	56                   	push   %esi
    2795:	53                   	push   %ebx
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2796:	31 f6                	xor    %esi,%esi
    2798:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    279b:	bf 56 55 55 55       	mov    $0x55555556,%edi
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    27a0:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    27a3:	68 f9 52 00 00       	push   $0x52f9
    27a8:	6a 01                	push   $0x1
    27aa:	e8 d1 21 00 00       	call   4980 <printf>
  file[0] = 'C';
    27af:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    27b3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    27b7:	83 c4 10             	add    $0x10,%esp
    27ba:	eb 51                	jmp    280d <concreate+0x7d>
    27bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    27c0:	89 f0                	mov    %esi,%eax
    27c2:	89 f1                	mov    %esi,%ecx
    27c4:	f7 ef                	imul   %edi
    27c6:	89 f0                	mov    %esi,%eax
    27c8:	c1 f8 1f             	sar    $0x1f,%eax
    27cb:	29 c2                	sub    %eax,%edx
    27cd:	8d 04 52             	lea    (%edx,%edx,2),%eax
    27d0:	29 c1                	sub    %eax,%ecx
    27d2:	83 f9 01             	cmp    $0x1,%ecx
    27d5:	0f 84 b5 00 00 00    	je     2890 <concreate+0x100>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    27db:	83 ec 08             	sub    $0x8,%esp
    27de:	68 02 02 00 00       	push   $0x202
    27e3:	53                   	push   %ebx
    27e4:	e8 79 20 00 00       	call   4862 <open>
      if(fd < 0){
    27e9:	83 c4 10             	add    $0x10,%esp
    27ec:	85 c0                	test   %eax,%eax
    27ee:	78 6d                	js     285d <concreate+0xcd>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    27f0:	83 ec 0c             	sub    $0xc,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    27f3:	83 c6 01             	add    $0x1,%esi
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    27f6:	50                   	push   %eax
    27f7:	e8 4e 20 00 00       	call   484a <close>
    27fc:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit();
    else
      wait();
    27ff:	e8 26 20 00 00       	call   482a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2804:	83 fe 28             	cmp    $0x28,%esi
    2807:	0f 84 ab 00 00 00    	je     28b8 <concreate+0x128>
    file[1] = '0' + i;
    unlink(file);
    280d:	83 ec 0c             	sub    $0xc,%esp

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    2810:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    2813:	53                   	push   %ebx

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    2814:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    2817:	e8 56 20 00 00       	call   4872 <unlink>
    pid = fork();
    281c:	e8 f9 1f 00 00       	call   481a <fork>
    if(pid && (i % 3) == 1){
    2821:	83 c4 10             	add    $0x10,%esp
    2824:	85 c0                	test   %eax,%eax
    2826:	75 98                	jne    27c0 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    2828:	89 f0                	mov    %esi,%eax
    282a:	ba 67 66 66 66       	mov    $0x66666667,%edx
    282f:	f7 ea                	imul   %edx
    2831:	89 f0                	mov    %esi,%eax
    2833:	c1 f8 1f             	sar    $0x1f,%eax
    2836:	d1 fa                	sar    %edx
    2838:	29 c2                	sub    %eax,%edx
    283a:	8d 04 92             	lea    (%edx,%edx,4),%eax
    283d:	29 c6                	sub    %eax,%esi
    283f:	83 fe 01             	cmp    $0x1,%esi
    2842:	74 34                	je     2878 <concreate+0xe8>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    2844:	83 ec 08             	sub    $0x8,%esp
    2847:	68 02 02 00 00       	push   $0x202
    284c:	53                   	push   %ebx
    284d:	e8 10 20 00 00       	call   4862 <open>
      if(fd < 0){
    2852:	83 c4 10             	add    $0x10,%esp
    2855:	85 c0                	test   %eax,%eax
    2857:	0f 89 32 02 00 00    	jns    2a8f <concreate+0x2ff>
        printf(1, "concreate create %s failed\n", file);
    285d:	83 ec 04             	sub    $0x4,%esp
    2860:	53                   	push   %ebx
    2861:	68 0c 53 00 00       	push   $0x530c
    2866:	6a 01                	push   $0x1
    2868:	e8 13 21 00 00       	call   4980 <printf>
        exit();
    286d:	e8 b0 1f 00 00       	call   4822 <exit>
    2872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    2878:	83 ec 08             	sub    $0x8,%esp
    287b:	53                   	push   %ebx
    287c:	68 09 53 00 00       	push   $0x5309
    2881:	e8 fc 1f 00 00       	call   4882 <link>
    2886:	83 c4 10             	add    $0x10,%esp
        exit();
      }
      close(fd);
    }
    if(pid == 0)
      exit();
    2889:	e8 94 1f 00 00       	call   4822 <exit>
    288e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    2890:	83 ec 08             	sub    $0x8,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    2893:	83 c6 01             	add    $0x1,%esi
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    2896:	53                   	push   %ebx
    2897:	68 09 53 00 00       	push   $0x5309
    289c:	e8 e1 1f 00 00       	call   4882 <link>
    28a1:	83 c4 10             	add    $0x10,%esp
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    28a4:	e8 81 1f 00 00       	call   482a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    28a9:	83 fe 28             	cmp    $0x28,%esi
    28ac:	0f 85 5b ff ff ff    	jne    280d <concreate+0x7d>
    28b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    28b8:	8d 45 c0             	lea    -0x40(%ebp),%eax
    28bb:	83 ec 04             	sub    $0x4,%esp
    28be:	8d 7d b0             	lea    -0x50(%ebp),%edi
    28c1:	6a 28                	push   $0x28
    28c3:	6a 00                	push   $0x0
    28c5:	50                   	push   %eax
    28c6:	e8 c5 1d 00 00       	call   4690 <memset>
  fd = open(".", 0);
    28cb:	59                   	pop    %ecx
    28cc:	5e                   	pop    %esi
    28cd:	6a 00                	push   $0x0
    28cf:	68 16 55 00 00       	push   $0x5516
    28d4:	e8 89 1f 00 00       	call   4862 <open>
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    28d9:	83 c4 10             	add    $0x10,%esp
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    28dc:	89 c6                	mov    %eax,%esi
  n = 0;
    28de:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    28e5:	8d 76 00             	lea    0x0(%esi),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    28e8:	83 ec 04             	sub    $0x4,%esp
    28eb:	6a 10                	push   $0x10
    28ed:	57                   	push   %edi
    28ee:	56                   	push   %esi
    28ef:	e8 46 1f 00 00       	call   483a <read>
    28f4:	83 c4 10             	add    $0x10,%esp
    28f7:	85 c0                	test   %eax,%eax
    28f9:	7e 3d                	jle    2938 <concreate+0x1a8>
    if(de.inum == 0)
    28fb:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    2900:	74 e6                	je     28e8 <concreate+0x158>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    2902:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    2906:	75 e0                	jne    28e8 <concreate+0x158>
    2908:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    290c:	75 da                	jne    28e8 <concreate+0x158>
      i = de.name[1] - '0';
    290e:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    2912:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    2915:	83 f8 27             	cmp    $0x27,%eax
    2918:	0f 87 59 01 00 00    	ja     2a77 <concreate+0x2e7>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    291e:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    2923:	0f 85 36 01 00 00    	jne    2a5f <concreate+0x2cf>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    2929:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    292e:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    2932:	eb b4                	jmp    28e8 <concreate+0x158>
    2934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    2938:	83 ec 0c             	sub    $0xc,%esp
    293b:	56                   	push   %esi
    293c:	e8 09 1f 00 00       	call   484a <close>

  if(n != 40){
    2941:	83 c4 10             	add    $0x10,%esp
    2944:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    2948:	0f 85 fd 00 00 00    	jne    2a4b <concreate+0x2bb>
    294e:	31 f6                	xor    %esi,%esi
    2950:	eb 70                	jmp    29c2 <concreate+0x232>
    2952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
    2958:	83 fa 01             	cmp    $0x1,%edx
    295b:	0f 85 99 00 00 00    	jne    29fa <concreate+0x26a>
      close(open(file, 0));
    2961:	83 ec 08             	sub    $0x8,%esp
    2964:	6a 00                	push   $0x0
    2966:	53                   	push   %ebx
    2967:	e8 f6 1e 00 00       	call   4862 <open>
    296c:	89 04 24             	mov    %eax,(%esp)
    296f:	e8 d6 1e 00 00       	call   484a <close>
      close(open(file, 0));
    2974:	58                   	pop    %eax
    2975:	5a                   	pop    %edx
    2976:	6a 00                	push   $0x0
    2978:	53                   	push   %ebx
    2979:	e8 e4 1e 00 00       	call   4862 <open>
    297e:	89 04 24             	mov    %eax,(%esp)
    2981:	e8 c4 1e 00 00       	call   484a <close>
      close(open(file, 0));
    2986:	59                   	pop    %ecx
    2987:	58                   	pop    %eax
    2988:	6a 00                	push   $0x0
    298a:	53                   	push   %ebx
    298b:	e8 d2 1e 00 00       	call   4862 <open>
    2990:	89 04 24             	mov    %eax,(%esp)
    2993:	e8 b2 1e 00 00       	call   484a <close>
      close(open(file, 0));
    2998:	58                   	pop    %eax
    2999:	5a                   	pop    %edx
    299a:	6a 00                	push   $0x0
    299c:	53                   	push   %ebx
    299d:	e8 c0 1e 00 00       	call   4862 <open>
    29a2:	89 04 24             	mov    %eax,(%esp)
    29a5:	e8 a0 1e 00 00       	call   484a <close>
    29aa:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    29ad:	85 ff                	test   %edi,%edi
    29af:	0f 84 d4 fe ff ff    	je     2889 <concreate+0xf9>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    29b5:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    29b8:	e8 6d 1e 00 00       	call   482a <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    29bd:	83 fe 28             	cmp    $0x28,%esi
    29c0:	74 5e                	je     2a20 <concreate+0x290>
    file[1] = '0' + i;
    29c2:	8d 46 30             	lea    0x30(%esi),%eax
    29c5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    29c8:	e8 4d 1e 00 00       	call   481a <fork>
    if(pid < 0){
    29cd:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    29cf:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    29d1:	78 64                	js     2a37 <concreate+0x2a7>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    29d3:	b8 56 55 55 55       	mov    $0x55555556,%eax
    29d8:	f7 ee                	imul   %esi
    29da:	89 f0                	mov    %esi,%eax
    29dc:	c1 f8 1f             	sar    $0x1f,%eax
    29df:	29 c2                	sub    %eax,%edx
    29e1:	8d 04 52             	lea    (%edx,%edx,2),%eax
    29e4:	89 f2                	mov    %esi,%edx
    29e6:	29 c2                	sub    %eax,%edx
    29e8:	89 f8                	mov    %edi,%eax
    29ea:	09 d0                	or     %edx,%eax
    29ec:	0f 84 6f ff ff ff    	je     2961 <concreate+0x1d1>
       ((i % 3) == 1 && pid != 0)){
    29f2:	85 ff                	test   %edi,%edi
    29f4:	0f 85 5e ff ff ff    	jne    2958 <concreate+0x1c8>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    29fa:	83 ec 0c             	sub    $0xc,%esp
    29fd:	53                   	push   %ebx
    29fe:	e8 6f 1e 00 00       	call   4872 <unlink>
      unlink(file);
    2a03:	89 1c 24             	mov    %ebx,(%esp)
    2a06:	e8 67 1e 00 00       	call   4872 <unlink>
      unlink(file);
    2a0b:	89 1c 24             	mov    %ebx,(%esp)
    2a0e:	e8 5f 1e 00 00       	call   4872 <unlink>
      unlink(file);
    2a13:	89 1c 24             	mov    %ebx,(%esp)
    2a16:	e8 57 1e 00 00       	call   4872 <unlink>
    2a1b:	83 c4 10             	add    $0x10,%esp
    2a1e:	eb 8d                	jmp    29ad <concreate+0x21d>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    2a20:	83 ec 08             	sub    $0x8,%esp
    2a23:	68 5e 53 00 00       	push   $0x535e
    2a28:	6a 01                	push   $0x1
    2a2a:	e8 51 1f 00 00       	call   4980 <printf>
}
    2a2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2a32:	5b                   	pop    %ebx
    2a33:	5e                   	pop    %esi
    2a34:	5f                   	pop    %edi
    2a35:	5d                   	pop    %ebp
    2a36:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    2a37:	83 ec 08             	sub    $0x8,%esp
    2a3a:	68 e1 5b 00 00       	push   $0x5be1
    2a3f:	6a 01                	push   $0x1
    2a41:	e8 3a 1f 00 00       	call   4980 <printf>
      exit();
    2a46:	e8 d7 1d 00 00       	call   4822 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    2a4b:	83 ec 08             	sub    $0x8,%esp
    2a4e:	68 84 5e 00 00       	push   $0x5e84
    2a53:	6a 01                	push   $0x1
    2a55:	e8 26 1f 00 00       	call   4980 <printf>
    exit();
    2a5a:	e8 c3 1d 00 00       	call   4822 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    2a5f:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    2a62:	83 ec 04             	sub    $0x4,%esp
    2a65:	50                   	push   %eax
    2a66:	68 41 53 00 00       	push   $0x5341
    2a6b:	6a 01                	push   $0x1
    2a6d:	e8 0e 1f 00 00       	call   4980 <printf>
        exit();
    2a72:	e8 ab 1d 00 00       	call   4822 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    2a77:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    2a7a:	83 ec 04             	sub    $0x4,%esp
    2a7d:	50                   	push   %eax
    2a7e:	68 28 53 00 00       	push   $0x5328
    2a83:	6a 01                	push   $0x1
    2a85:	e8 f6 1e 00 00       	call   4980 <printf>
        exit();
    2a8a:	e8 93 1d 00 00       	call   4822 <exit>
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    2a8f:	83 ec 0c             	sub    $0xc,%esp
    2a92:	50                   	push   %eax
    2a93:	e8 b2 1d 00 00       	call   484a <close>
    2a98:	83 c4 10             	add    $0x10,%esp
    2a9b:	e9 e9 fd ff ff       	jmp    2889 <concreate+0xf9>

00002aa0 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    2aa0:	55                   	push   %ebp
    2aa1:	89 e5                	mov    %esp,%ebp
    2aa3:	57                   	push   %edi
    2aa4:	56                   	push   %esi
    2aa5:	53                   	push   %ebx
    2aa6:	83 ec 24             	sub    $0x24,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    2aa9:	68 6c 53 00 00       	push   $0x536c
    2aae:	6a 01                	push   $0x1
    2ab0:	e8 cb 1e 00 00       	call   4980 <printf>

  unlink("x");
    2ab5:	c7 04 24 f9 55 00 00 	movl   $0x55f9,(%esp)
    2abc:	e8 b1 1d 00 00       	call   4872 <unlink>
  pid = fork();
    2ac1:	e8 54 1d 00 00       	call   481a <fork>
  if(pid < 0){
    2ac6:	83 c4 10             	add    $0x10,%esp
    2ac9:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    2acb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    2ace:	0f 88 b6 00 00 00    	js     2b8a <linkunlink+0xea>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    2ad4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    2ad8:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    2add:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    2ae2:	19 ff                	sbb    %edi,%edi
    2ae4:	83 e7 60             	and    $0x60,%edi
    2ae7:	83 c7 01             	add    $0x1,%edi
    2aea:	eb 1e                	jmp    2b0a <linkunlink+0x6a>
    2aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    2af0:	83 fa 01             	cmp    $0x1,%edx
    2af3:	74 7b                	je     2b70 <linkunlink+0xd0>
      link("cat", "x");
    } else {
      unlink("x");
    2af5:	83 ec 0c             	sub    $0xc,%esp
    2af8:	68 f9 55 00 00       	push   $0x55f9
    2afd:	e8 70 1d 00 00       	call   4872 <unlink>
    2b02:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    2b05:	83 eb 01             	sub    $0x1,%ebx
    2b08:	74 3d                	je     2b47 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    2b0a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    2b10:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    2b16:	89 f8                	mov    %edi,%eax
    2b18:	f7 e6                	mul    %esi
    2b1a:	d1 ea                	shr    %edx
    2b1c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    2b1f:	89 fa                	mov    %edi,%edx
    2b21:	29 c2                	sub    %eax,%edx
    2b23:	75 cb                	jne    2af0 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    2b25:	83 ec 08             	sub    $0x8,%esp
    2b28:	68 02 02 00 00       	push   $0x202
    2b2d:	68 f9 55 00 00       	push   $0x55f9
    2b32:	e8 2b 1d 00 00       	call   4862 <open>
    2b37:	89 04 24             	mov    %eax,(%esp)
    2b3a:	e8 0b 1d 00 00       	call   484a <close>
    2b3f:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    2b42:	83 eb 01             	sub    $0x1,%ebx
    2b45:	75 c3                	jne    2b0a <linkunlink+0x6a>
    } else {
      unlink("x");
    }
  }

  if(pid)
    2b47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b4a:	85 c0                	test   %eax,%eax
    2b4c:	74 50                	je     2b9e <linkunlink+0xfe>
    wait();
    2b4e:	e8 d7 1c 00 00       	call   482a <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    2b53:	83 ec 08             	sub    $0x8,%esp
    2b56:	68 81 53 00 00       	push   $0x5381
    2b5b:	6a 01                	push   $0x1
    2b5d:	e8 1e 1e 00 00       	call   4980 <printf>
}
    2b62:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2b65:	5b                   	pop    %ebx
    2b66:	5e                   	pop    %esi
    2b67:	5f                   	pop    %edi
    2b68:	5d                   	pop    %ebp
    2b69:	c3                   	ret    
    2b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    2b70:	83 ec 08             	sub    $0x8,%esp
    2b73:	68 f9 55 00 00       	push   $0x55f9
    2b78:	68 7d 53 00 00       	push   $0x537d
    2b7d:	e8 00 1d 00 00       	call   4882 <link>
    2b82:	83 c4 10             	add    $0x10,%esp
    2b85:	e9 7b ff ff ff       	jmp    2b05 <linkunlink+0x65>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2b8a:	83 ec 08             	sub    $0x8,%esp
    2b8d:	68 e1 5b 00 00       	push   $0x5be1
    2b92:	6a 01                	push   $0x1
    2b94:	e8 e7 1d 00 00       	call   4980 <printf>
    exit();
    2b99:	e8 84 1c 00 00       	call   4822 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    2b9e:	e8 7f 1c 00 00       	call   4822 <exit>
    2ba3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002bb0 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    2bb0:	55                   	push   %ebp
    2bb1:	89 e5                	mov    %esp,%ebp
    2bb3:	56                   	push   %esi
    2bb4:	53                   	push   %ebx
    2bb5:	83 ec 18             	sub    $0x18,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    2bb8:	68 90 53 00 00       	push   $0x5390
    2bbd:	6a 01                	push   $0x1
    2bbf:	e8 bc 1d 00 00       	call   4980 <printf>
  unlink("bd");
    2bc4:	c7 04 24 9d 53 00 00 	movl   $0x539d,(%esp)
    2bcb:	e8 a2 1c 00 00       	call   4872 <unlink>

  fd = open("bd", O_CREATE);
    2bd0:	58                   	pop    %eax
    2bd1:	5a                   	pop    %edx
    2bd2:	68 00 02 00 00       	push   $0x200
    2bd7:	68 9d 53 00 00       	push   $0x539d
    2bdc:	e8 81 1c 00 00       	call   4862 <open>
  if(fd < 0){
    2be1:	83 c4 10             	add    $0x10,%esp
    2be4:	85 c0                	test   %eax,%eax
    2be6:	0f 88 de 00 00 00    	js     2cca <bigdir+0x11a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    2bec:	83 ec 0c             	sub    $0xc,%esp
    2bef:	8d 75 ee             	lea    -0x12(%ebp),%esi

  for(i = 0; i < 500; i++){
    2bf2:	31 db                	xor    %ebx,%ebx
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    2bf4:	50                   	push   %eax
    2bf5:	e8 50 1c 00 00       	call   484a <close>
    2bfa:	83 c4 10             	add    $0x10,%esp
    2bfd:	8d 76 00             	lea    0x0(%esi),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2c00:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    2c02:	83 ec 08             	sub    $0x8,%esp
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    2c05:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    2c09:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    2c0c:	56                   	push   %esi
    2c0d:	68 9d 53 00 00       	push   $0x539d
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2c12:	83 c0 30             	add    $0x30,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    2c15:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2c19:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    2c1c:	89 d8                	mov    %ebx,%eax
    2c1e:	83 e0 3f             	and    $0x3f,%eax
    2c21:	83 c0 30             	add    $0x30,%eax
    2c24:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(link("bd", name) != 0){
    2c27:	e8 56 1c 00 00       	call   4882 <link>
    2c2c:	83 c4 10             	add    $0x10,%esp
    2c2f:	85 c0                	test   %eax,%eax
    2c31:	75 6f                	jne    2ca2 <bigdir+0xf2>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    2c33:	83 c3 01             	add    $0x1,%ebx
    2c36:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    2c3c:	75 c2                	jne    2c00 <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    2c3e:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    2c41:	31 db                	xor    %ebx,%ebx
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    2c43:	68 9d 53 00 00       	push   $0x539d
    2c48:	e8 25 1c 00 00       	call   4872 <unlink>
    2c4d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2c50:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    2c52:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    2c55:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    2c59:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    2c5c:	56                   	push   %esi
  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    2c5d:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2c61:	83 c0 30             	add    $0x30,%eax
    2c64:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    2c67:	89 d8                	mov    %ebx,%eax
    2c69:	83 e0 3f             	and    $0x3f,%eax
    2c6c:	83 c0 30             	add    $0x30,%eax
    2c6f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(unlink(name) != 0){
    2c72:	e8 fb 1b 00 00       	call   4872 <unlink>
    2c77:	83 c4 10             	add    $0x10,%esp
    2c7a:	85 c0                	test   %eax,%eax
    2c7c:	75 38                	jne    2cb6 <bigdir+0x106>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    2c7e:	83 c3 01             	add    $0x1,%ebx
    2c81:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    2c87:	75 c7                	jne    2c50 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    2c89:	83 ec 08             	sub    $0x8,%esp
    2c8c:	68 df 53 00 00       	push   $0x53df
    2c91:	6a 01                	push   $0x1
    2c93:	e8 e8 1c 00 00       	call   4980 <printf>
}
    2c98:	83 c4 10             	add    $0x10,%esp
    2c9b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2c9e:	5b                   	pop    %ebx
    2c9f:	5e                   	pop    %esi
    2ca0:	5d                   	pop    %ebp
    2ca1:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    2ca2:	83 ec 08             	sub    $0x8,%esp
    2ca5:	68 b6 53 00 00       	push   $0x53b6
    2caa:	6a 01                	push   $0x1
    2cac:	e8 cf 1c 00 00       	call   4980 <printf>
      exit();
    2cb1:	e8 6c 1b 00 00       	call   4822 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    2cb6:	83 ec 08             	sub    $0x8,%esp
    2cb9:	68 ca 53 00 00       	push   $0x53ca
    2cbe:	6a 01                	push   $0x1
    2cc0:	e8 bb 1c 00 00       	call   4980 <printf>
      exit();
    2cc5:	e8 58 1b 00 00       	call   4822 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    2cca:	83 ec 08             	sub    $0x8,%esp
    2ccd:	68 a0 53 00 00       	push   $0x53a0
    2cd2:	6a 01                	push   $0x1
    2cd4:	e8 a7 1c 00 00       	call   4980 <printf>
    exit();
    2cd9:	e8 44 1b 00 00       	call   4822 <exit>
    2cde:	66 90                	xchg   %ax,%ax

00002ce0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    2ce0:	55                   	push   %ebp
    2ce1:	89 e5                	mov    %esp,%ebp
    2ce3:	53                   	push   %ebx
    2ce4:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    2ce7:	68 ea 53 00 00       	push   $0x53ea
    2cec:	6a 01                	push   $0x1
    2cee:	e8 8d 1c 00 00       	call   4980 <printf>

  unlink("ff");
    2cf3:	c7 04 24 73 54 00 00 	movl   $0x5473,(%esp)
    2cfa:	e8 73 1b 00 00       	call   4872 <unlink>
  if(mkdir("dd") != 0){
    2cff:	c7 04 24 10 55 00 00 	movl   $0x5510,(%esp)
    2d06:	e8 7f 1b 00 00       	call   488a <mkdir>
    2d0b:	83 c4 10             	add    $0x10,%esp
    2d0e:	85 c0                	test   %eax,%eax
    2d10:	0f 85 b3 05 00 00    	jne    32c9 <subdir+0x5e9>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d16:	83 ec 08             	sub    $0x8,%esp
    2d19:	68 02 02 00 00       	push   $0x202
    2d1e:	68 49 54 00 00       	push   $0x5449
    2d23:	e8 3a 1b 00 00       	call   4862 <open>
  if(fd < 0){
    2d28:	83 c4 10             	add    $0x10,%esp
    2d2b:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d2d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2d2f:	0f 88 81 05 00 00    	js     32b6 <subdir+0x5d6>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    2d35:	83 ec 04             	sub    $0x4,%esp
    2d38:	6a 02                	push   $0x2
    2d3a:	68 73 54 00 00       	push   $0x5473
    2d3f:	50                   	push   %eax
    2d40:	e8 fd 1a 00 00       	call   4842 <write>
  close(fd);
    2d45:	89 1c 24             	mov    %ebx,(%esp)
    2d48:	e8 fd 1a 00 00       	call   484a <close>

  if(unlink("dd") >= 0){
    2d4d:	c7 04 24 10 55 00 00 	movl   $0x5510,(%esp)
    2d54:	e8 19 1b 00 00       	call   4872 <unlink>
    2d59:	83 c4 10             	add    $0x10,%esp
    2d5c:	85 c0                	test   %eax,%eax
    2d5e:	0f 89 3f 05 00 00    	jns    32a3 <subdir+0x5c3>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    2d64:	83 ec 0c             	sub    $0xc,%esp
    2d67:	68 24 54 00 00       	push   $0x5424
    2d6c:	e8 19 1b 00 00       	call   488a <mkdir>
    2d71:	83 c4 10             	add    $0x10,%esp
    2d74:	85 c0                	test   %eax,%eax
    2d76:	0f 85 14 05 00 00    	jne    3290 <subdir+0x5b0>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d7c:	83 ec 08             	sub    $0x8,%esp
    2d7f:	68 02 02 00 00       	push   $0x202
    2d84:	68 46 54 00 00       	push   $0x5446
    2d89:	e8 d4 1a 00 00       	call   4862 <open>
  if(fd < 0){
    2d8e:	83 c4 10             	add    $0x10,%esp
    2d91:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d93:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2d95:	0f 88 24 04 00 00    	js     31bf <subdir+0x4df>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    2d9b:	83 ec 04             	sub    $0x4,%esp
    2d9e:	6a 02                	push   $0x2
    2da0:	68 67 54 00 00       	push   $0x5467
    2da5:	50                   	push   %eax
    2da6:	e8 97 1a 00 00       	call   4842 <write>
  close(fd);
    2dab:	89 1c 24             	mov    %ebx,(%esp)
    2dae:	e8 97 1a 00 00       	call   484a <close>

  fd = open("dd/dd/../ff", 0);
    2db3:	58                   	pop    %eax
    2db4:	5a                   	pop    %edx
    2db5:	6a 00                	push   $0x0
    2db7:	68 6a 54 00 00       	push   $0x546a
    2dbc:	e8 a1 1a 00 00       	call   4862 <open>
  if(fd < 0){
    2dc1:	83 c4 10             	add    $0x10,%esp
    2dc4:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    2dc6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2dc8:	0f 88 de 03 00 00    	js     31ac <subdir+0x4cc>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    2dce:	83 ec 04             	sub    $0x4,%esp
    2dd1:	68 00 20 00 00       	push   $0x2000
    2dd6:	68 c0 94 00 00       	push   $0x94c0
    2ddb:	50                   	push   %eax
    2ddc:	e8 59 1a 00 00       	call   483a <read>
  if(cc != 2 || buf[0] != 'f'){
    2de1:	83 c4 10             	add    $0x10,%esp
    2de4:	83 f8 02             	cmp    $0x2,%eax
    2de7:	0f 85 3a 03 00 00    	jne    3127 <subdir+0x447>
    2ded:	80 3d c0 94 00 00 66 	cmpb   $0x66,0x94c0
    2df4:	0f 85 2d 03 00 00    	jne    3127 <subdir+0x447>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    2dfa:	83 ec 0c             	sub    $0xc,%esp
    2dfd:	53                   	push   %ebx
    2dfe:	e8 47 1a 00 00       	call   484a <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2e03:	5b                   	pop    %ebx
    2e04:	58                   	pop    %eax
    2e05:	68 aa 54 00 00       	push   $0x54aa
    2e0a:	68 46 54 00 00       	push   $0x5446
    2e0f:	e8 6e 1a 00 00       	call   4882 <link>
    2e14:	83 c4 10             	add    $0x10,%esp
    2e17:	85 c0                	test   %eax,%eax
    2e19:	0f 85 c6 03 00 00    	jne    31e5 <subdir+0x505>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    2e1f:	83 ec 0c             	sub    $0xc,%esp
    2e22:	68 46 54 00 00       	push   $0x5446
    2e27:	e8 46 1a 00 00       	call   4872 <unlink>
    2e2c:	83 c4 10             	add    $0x10,%esp
    2e2f:	85 c0                	test   %eax,%eax
    2e31:	0f 85 16 03 00 00    	jne    314d <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e37:	83 ec 08             	sub    $0x8,%esp
    2e3a:	6a 00                	push   $0x0
    2e3c:	68 46 54 00 00       	push   $0x5446
    2e41:	e8 1c 1a 00 00       	call   4862 <open>
    2e46:	83 c4 10             	add    $0x10,%esp
    2e49:	85 c0                	test   %eax,%eax
    2e4b:	0f 89 2c 04 00 00    	jns    327d <subdir+0x59d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    2e51:	83 ec 0c             	sub    $0xc,%esp
    2e54:	68 10 55 00 00       	push   $0x5510
    2e59:	e8 34 1a 00 00       	call   4892 <chdir>
    2e5e:	83 c4 10             	add    $0x10,%esp
    2e61:	85 c0                	test   %eax,%eax
    2e63:	0f 85 01 04 00 00    	jne    326a <subdir+0x58a>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	68 de 54 00 00       	push   $0x54de
    2e71:	e8 1c 1a 00 00       	call   4892 <chdir>
    2e76:	83 c4 10             	add    $0x10,%esp
    2e79:	85 c0                	test   %eax,%eax
    2e7b:	0f 85 b9 02 00 00    	jne    313a <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    2e81:	83 ec 0c             	sub    $0xc,%esp
    2e84:	68 04 55 00 00       	push   $0x5504
    2e89:	e8 04 1a 00 00       	call   4892 <chdir>
    2e8e:	83 c4 10             	add    $0x10,%esp
    2e91:	85 c0                	test   %eax,%eax
    2e93:	0f 85 a1 02 00 00    	jne    313a <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    2e99:	83 ec 0c             	sub    $0xc,%esp
    2e9c:	68 13 55 00 00       	push   $0x5513
    2ea1:	e8 ec 19 00 00       	call   4892 <chdir>
    2ea6:	83 c4 10             	add    $0x10,%esp
    2ea9:	85 c0                	test   %eax,%eax
    2eab:	0f 85 21 03 00 00    	jne    31d2 <subdir+0x4f2>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    2eb1:	83 ec 08             	sub    $0x8,%esp
    2eb4:	6a 00                	push   $0x0
    2eb6:	68 aa 54 00 00       	push   $0x54aa
    2ebb:	e8 a2 19 00 00       	call   4862 <open>
  if(fd < 0){
    2ec0:	83 c4 10             	add    $0x10,%esp
    2ec3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    2ec5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2ec7:	0f 88 e0 04 00 00    	js     33ad <subdir+0x6cd>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2ecd:	83 ec 04             	sub    $0x4,%esp
    2ed0:	68 00 20 00 00       	push   $0x2000
    2ed5:	68 c0 94 00 00       	push   $0x94c0
    2eda:	50                   	push   %eax
    2edb:	e8 5a 19 00 00       	call   483a <read>
    2ee0:	83 c4 10             	add    $0x10,%esp
    2ee3:	83 f8 02             	cmp    $0x2,%eax
    2ee6:	0f 85 ae 04 00 00    	jne    339a <subdir+0x6ba>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    2eec:	83 ec 0c             	sub    $0xc,%esp
    2eef:	53                   	push   %ebx
    2ef0:	e8 55 19 00 00       	call   484a <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2ef5:	59                   	pop    %ecx
    2ef6:	5b                   	pop    %ebx
    2ef7:	6a 00                	push   $0x0
    2ef9:	68 46 54 00 00       	push   $0x5446
    2efe:	e8 5f 19 00 00       	call   4862 <open>
    2f03:	83 c4 10             	add    $0x10,%esp
    2f06:	85 c0                	test   %eax,%eax
    2f08:	0f 89 65 02 00 00    	jns    3173 <subdir+0x493>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2f0e:	83 ec 08             	sub    $0x8,%esp
    2f11:	68 02 02 00 00       	push   $0x202
    2f16:	68 5e 55 00 00       	push   $0x555e
    2f1b:	e8 42 19 00 00       	call   4862 <open>
    2f20:	83 c4 10             	add    $0x10,%esp
    2f23:	85 c0                	test   %eax,%eax
    2f25:	0f 89 35 02 00 00    	jns    3160 <subdir+0x480>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2f2b:	83 ec 08             	sub    $0x8,%esp
    2f2e:	68 02 02 00 00       	push   $0x202
    2f33:	68 83 55 00 00       	push   $0x5583
    2f38:	e8 25 19 00 00       	call   4862 <open>
    2f3d:	83 c4 10             	add    $0x10,%esp
    2f40:	85 c0                	test   %eax,%eax
    2f42:	0f 89 0f 03 00 00    	jns    3257 <subdir+0x577>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    2f48:	83 ec 08             	sub    $0x8,%esp
    2f4b:	68 00 02 00 00       	push   $0x200
    2f50:	68 10 55 00 00       	push   $0x5510
    2f55:	e8 08 19 00 00       	call   4862 <open>
    2f5a:	83 c4 10             	add    $0x10,%esp
    2f5d:	85 c0                	test   %eax,%eax
    2f5f:	0f 89 df 02 00 00    	jns    3244 <subdir+0x564>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    2f65:	83 ec 08             	sub    $0x8,%esp
    2f68:	6a 02                	push   $0x2
    2f6a:	68 10 55 00 00       	push   $0x5510
    2f6f:	e8 ee 18 00 00       	call   4862 <open>
    2f74:	83 c4 10             	add    $0x10,%esp
    2f77:	85 c0                	test   %eax,%eax
    2f79:	0f 89 b2 02 00 00    	jns    3231 <subdir+0x551>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    2f7f:	83 ec 08             	sub    $0x8,%esp
    2f82:	6a 01                	push   $0x1
    2f84:	68 10 55 00 00       	push   $0x5510
    2f89:	e8 d4 18 00 00       	call   4862 <open>
    2f8e:	83 c4 10             	add    $0x10,%esp
    2f91:	85 c0                	test   %eax,%eax
    2f93:	0f 89 85 02 00 00    	jns    321e <subdir+0x53e>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2f99:	83 ec 08             	sub    $0x8,%esp
    2f9c:	68 f2 55 00 00       	push   $0x55f2
    2fa1:	68 5e 55 00 00       	push   $0x555e
    2fa6:	e8 d7 18 00 00       	call   4882 <link>
    2fab:	83 c4 10             	add    $0x10,%esp
    2fae:	85 c0                	test   %eax,%eax
    2fb0:	0f 84 55 02 00 00    	je     320b <subdir+0x52b>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2fb6:	83 ec 08             	sub    $0x8,%esp
    2fb9:	68 f2 55 00 00       	push   $0x55f2
    2fbe:	68 83 55 00 00       	push   $0x5583
    2fc3:	e8 ba 18 00 00       	call   4882 <link>
    2fc8:	83 c4 10             	add    $0x10,%esp
    2fcb:	85 c0                	test   %eax,%eax
    2fcd:	0f 84 25 02 00 00    	je     31f8 <subdir+0x518>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2fd3:	83 ec 08             	sub    $0x8,%esp
    2fd6:	68 aa 54 00 00       	push   $0x54aa
    2fdb:	68 49 54 00 00       	push   $0x5449
    2fe0:	e8 9d 18 00 00       	call   4882 <link>
    2fe5:	83 c4 10             	add    $0x10,%esp
    2fe8:	85 c0                	test   %eax,%eax
    2fea:	0f 84 a9 01 00 00    	je     3199 <subdir+0x4b9>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    2ff0:	83 ec 0c             	sub    $0xc,%esp
    2ff3:	68 5e 55 00 00       	push   $0x555e
    2ff8:	e8 8d 18 00 00       	call   488a <mkdir>
    2ffd:	83 c4 10             	add    $0x10,%esp
    3000:	85 c0                	test   %eax,%eax
    3002:	0f 84 7e 01 00 00    	je     3186 <subdir+0x4a6>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    3008:	83 ec 0c             	sub    $0xc,%esp
    300b:	68 83 55 00 00       	push   $0x5583
    3010:	e8 75 18 00 00       	call   488a <mkdir>
    3015:	83 c4 10             	add    $0x10,%esp
    3018:	85 c0                	test   %eax,%eax
    301a:	0f 84 67 03 00 00    	je     3387 <subdir+0x6a7>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    3020:	83 ec 0c             	sub    $0xc,%esp
    3023:	68 aa 54 00 00       	push   $0x54aa
    3028:	e8 5d 18 00 00       	call   488a <mkdir>
    302d:	83 c4 10             	add    $0x10,%esp
    3030:	85 c0                	test   %eax,%eax
    3032:	0f 84 3c 03 00 00    	je     3374 <subdir+0x694>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    3038:	83 ec 0c             	sub    $0xc,%esp
    303b:	68 83 55 00 00       	push   $0x5583
    3040:	e8 2d 18 00 00       	call   4872 <unlink>
    3045:	83 c4 10             	add    $0x10,%esp
    3048:	85 c0                	test   %eax,%eax
    304a:	0f 84 11 03 00 00    	je     3361 <subdir+0x681>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    3050:	83 ec 0c             	sub    $0xc,%esp
    3053:	68 5e 55 00 00       	push   $0x555e
    3058:	e8 15 18 00 00       	call   4872 <unlink>
    305d:	83 c4 10             	add    $0x10,%esp
    3060:	85 c0                	test   %eax,%eax
    3062:	0f 84 e6 02 00 00    	je     334e <subdir+0x66e>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    3068:	83 ec 0c             	sub    $0xc,%esp
    306b:	68 49 54 00 00       	push   $0x5449
    3070:	e8 1d 18 00 00       	call   4892 <chdir>
    3075:	83 c4 10             	add    $0x10,%esp
    3078:	85 c0                	test   %eax,%eax
    307a:	0f 84 bb 02 00 00    	je     333b <subdir+0x65b>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    3080:	83 ec 0c             	sub    $0xc,%esp
    3083:	68 f5 55 00 00       	push   $0x55f5
    3088:	e8 05 18 00 00       	call   4892 <chdir>
    308d:	83 c4 10             	add    $0x10,%esp
    3090:	85 c0                	test   %eax,%eax
    3092:	0f 84 90 02 00 00    	je     3328 <subdir+0x648>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    3098:	83 ec 0c             	sub    $0xc,%esp
    309b:	68 aa 54 00 00       	push   $0x54aa
    30a0:	e8 cd 17 00 00       	call   4872 <unlink>
    30a5:	83 c4 10             	add    $0x10,%esp
    30a8:	85 c0                	test   %eax,%eax
    30aa:	0f 85 9d 00 00 00    	jne    314d <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    30b0:	83 ec 0c             	sub    $0xc,%esp
    30b3:	68 49 54 00 00       	push   $0x5449
    30b8:	e8 b5 17 00 00       	call   4872 <unlink>
    30bd:	83 c4 10             	add    $0x10,%esp
    30c0:	85 c0                	test   %eax,%eax
    30c2:	0f 85 4d 02 00 00    	jne    3315 <subdir+0x635>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    30c8:	83 ec 0c             	sub    $0xc,%esp
    30cb:	68 10 55 00 00       	push   $0x5510
    30d0:	e8 9d 17 00 00       	call   4872 <unlink>
    30d5:	83 c4 10             	add    $0x10,%esp
    30d8:	85 c0                	test   %eax,%eax
    30da:	0f 84 22 02 00 00    	je     3302 <subdir+0x622>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    30e0:	83 ec 0c             	sub    $0xc,%esp
    30e3:	68 25 54 00 00       	push   $0x5425
    30e8:	e8 85 17 00 00       	call   4872 <unlink>
    30ed:	83 c4 10             	add    $0x10,%esp
    30f0:	85 c0                	test   %eax,%eax
    30f2:	0f 88 f7 01 00 00    	js     32ef <subdir+0x60f>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    30f8:	83 ec 0c             	sub    $0xc,%esp
    30fb:	68 10 55 00 00       	push   $0x5510
    3100:	e8 6d 17 00 00       	call   4872 <unlink>
    3105:	83 c4 10             	add    $0x10,%esp
    3108:	85 c0                	test   %eax,%eax
    310a:	0f 88 cc 01 00 00    	js     32dc <subdir+0x5fc>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    3110:	83 ec 08             	sub    $0x8,%esp
    3113:	68 f2 56 00 00       	push   $0x56f2
    3118:	6a 01                	push   $0x1
    311a:	e8 61 18 00 00       	call   4980 <printf>
}
    311f:	83 c4 10             	add    $0x10,%esp
    3122:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3125:	c9                   	leave  
    3126:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    3127:	50                   	push   %eax
    3128:	50                   	push   %eax
    3129:	68 8f 54 00 00       	push   $0x548f
    312e:	6a 01                	push   $0x1
    3130:	e8 4b 18 00 00       	call   4980 <printf>
    exit();
    3135:	e8 e8 16 00 00       	call   4822 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    313a:	50                   	push   %eax
    313b:	50                   	push   %eax
    313c:	68 ea 54 00 00       	push   $0x54ea
    3141:	6a 01                	push   $0x1
    3143:	e8 38 18 00 00       	call   4980 <printf>
    exit();
    3148:	e8 d5 16 00 00       	call   4822 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    314d:	52                   	push   %edx
    314e:	52                   	push   %edx
    314f:	68 b5 54 00 00       	push   $0x54b5
    3154:	6a 01                	push   $0x1
    3156:	e8 25 18 00 00       	call   4980 <printf>
    exit();
    315b:	e8 c2 16 00 00       	call   4822 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    3160:	50                   	push   %eax
    3161:	50                   	push   %eax
    3162:	68 67 55 00 00       	push   $0x5567
    3167:	6a 01                	push   $0x1
    3169:	e8 12 18 00 00       	call   4980 <printf>
    exit();
    316e:	e8 af 16 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    3173:	52                   	push   %edx
    3174:	52                   	push   %edx
    3175:	68 28 5f 00 00       	push   $0x5f28
    317a:	6a 01                	push   $0x1
    317c:	e8 ff 17 00 00       	call   4980 <printf>
    exit();
    3181:	e8 9c 16 00 00       	call   4822 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    3186:	52                   	push   %edx
    3187:	52                   	push   %edx
    3188:	68 fb 55 00 00       	push   $0x55fb
    318d:	6a 01                	push   $0x1
    318f:	e8 ec 17 00 00       	call   4980 <printf>
    exit();
    3194:	e8 89 16 00 00       	call   4822 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    3199:	51                   	push   %ecx
    319a:	51                   	push   %ecx
    319b:	68 98 5f 00 00       	push   $0x5f98
    31a0:	6a 01                	push   $0x1
    31a2:	e8 d9 17 00 00       	call   4980 <printf>
    exit();
    31a7:	e8 76 16 00 00       	call   4822 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    31ac:	50                   	push   %eax
    31ad:	50                   	push   %eax
    31ae:	68 76 54 00 00       	push   $0x5476
    31b3:	6a 01                	push   $0x1
    31b5:	e8 c6 17 00 00       	call   4980 <printf>
    exit();
    31ba:	e8 63 16 00 00       	call   4822 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    31bf:	51                   	push   %ecx
    31c0:	51                   	push   %ecx
    31c1:	68 4f 54 00 00       	push   $0x544f
    31c6:	6a 01                	push   $0x1
    31c8:	e8 b3 17 00 00       	call   4980 <printf>
    exit();
    31cd:	e8 50 16 00 00       	call   4822 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    31d2:	50                   	push   %eax
    31d3:	50                   	push   %eax
    31d4:	68 18 55 00 00       	push   $0x5518
    31d9:	6a 01                	push   $0x1
    31db:	e8 a0 17 00 00       	call   4980 <printf>
    exit();
    31e0:	e8 3d 16 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    31e5:	51                   	push   %ecx
    31e6:	51                   	push   %ecx
    31e7:	68 e0 5e 00 00       	push   $0x5ee0
    31ec:	6a 01                	push   $0x1
    31ee:	e8 8d 17 00 00       	call   4980 <printf>
    exit();
    31f3:	e8 2a 16 00 00       	call   4822 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    31f8:	53                   	push   %ebx
    31f9:	53                   	push   %ebx
    31fa:	68 74 5f 00 00       	push   $0x5f74
    31ff:	6a 01                	push   $0x1
    3201:	e8 7a 17 00 00       	call   4980 <printf>
    exit();
    3206:	e8 17 16 00 00       	call   4822 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    320b:	50                   	push   %eax
    320c:	50                   	push   %eax
    320d:	68 50 5f 00 00       	push   $0x5f50
    3212:	6a 01                	push   $0x1
    3214:	e8 67 17 00 00       	call   4980 <printf>
    exit();
    3219:	e8 04 16 00 00       	call   4822 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    321e:	50                   	push   %eax
    321f:	50                   	push   %eax
    3220:	68 d7 55 00 00       	push   $0x55d7
    3225:	6a 01                	push   $0x1
    3227:	e8 54 17 00 00       	call   4980 <printf>
    exit();
    322c:	e8 f1 15 00 00       	call   4822 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    3231:	50                   	push   %eax
    3232:	50                   	push   %eax
    3233:	68 be 55 00 00       	push   $0x55be
    3238:	6a 01                	push   $0x1
    323a:	e8 41 17 00 00       	call   4980 <printf>
    exit();
    323f:	e8 de 15 00 00       	call   4822 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    3244:	50                   	push   %eax
    3245:	50                   	push   %eax
    3246:	68 a8 55 00 00       	push   $0x55a8
    324b:	6a 01                	push   $0x1
    324d:	e8 2e 17 00 00       	call   4980 <printf>
    exit();
    3252:	e8 cb 15 00 00       	call   4822 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    3257:	50                   	push   %eax
    3258:	50                   	push   %eax
    3259:	68 8c 55 00 00       	push   $0x558c
    325e:	6a 01                	push   $0x1
    3260:	e8 1b 17 00 00       	call   4980 <printf>
    exit();
    3265:	e8 b8 15 00 00       	call   4822 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    326a:	50                   	push   %eax
    326b:	50                   	push   %eax
    326c:	68 cd 54 00 00       	push   $0x54cd
    3271:	6a 01                	push   $0x1
    3273:	e8 08 17 00 00       	call   4980 <printf>
    exit();
    3278:	e8 a5 15 00 00       	call   4822 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    327d:	50                   	push   %eax
    327e:	50                   	push   %eax
    327f:	68 04 5f 00 00       	push   $0x5f04
    3284:	6a 01                	push   $0x1
    3286:	e8 f5 16 00 00       	call   4980 <printf>
    exit();
    328b:	e8 92 15 00 00       	call   4822 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    3290:	53                   	push   %ebx
    3291:	53                   	push   %ebx
    3292:	68 2b 54 00 00       	push   $0x542b
    3297:	6a 01                	push   $0x1
    3299:	e8 e2 16 00 00       	call   4980 <printf>
    exit();
    329e:	e8 7f 15 00 00       	call   4822 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    32a3:	50                   	push   %eax
    32a4:	50                   	push   %eax
    32a5:	68 b8 5e 00 00       	push   $0x5eb8
    32aa:	6a 01                	push   $0x1
    32ac:	e8 cf 16 00 00       	call   4980 <printf>
    exit();
    32b1:	e8 6c 15 00 00       	call   4822 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    32b6:	50                   	push   %eax
    32b7:	50                   	push   %eax
    32b8:	68 0f 54 00 00       	push   $0x540f
    32bd:	6a 01                	push   $0x1
    32bf:	e8 bc 16 00 00       	call   4980 <printf>
    exit();
    32c4:	e8 59 15 00 00       	call   4822 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    32c9:	50                   	push   %eax
    32ca:	50                   	push   %eax
    32cb:	68 f7 53 00 00       	push   $0x53f7
    32d0:	6a 01                	push   $0x1
    32d2:	e8 a9 16 00 00       	call   4980 <printf>
    exit();
    32d7:	e8 46 15 00 00       	call   4822 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    32dc:	50                   	push   %eax
    32dd:	50                   	push   %eax
    32de:	68 e0 56 00 00       	push   $0x56e0
    32e3:	6a 01                	push   $0x1
    32e5:	e8 96 16 00 00       	call   4980 <printf>
    exit();
    32ea:	e8 33 15 00 00       	call   4822 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    32ef:	52                   	push   %edx
    32f0:	52                   	push   %edx
    32f1:	68 cb 56 00 00       	push   $0x56cb
    32f6:	6a 01                	push   $0x1
    32f8:	e8 83 16 00 00       	call   4980 <printf>
    exit();
    32fd:	e8 20 15 00 00       	call   4822 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    3302:	51                   	push   %ecx
    3303:	51                   	push   %ecx
    3304:	68 bc 5f 00 00       	push   $0x5fbc
    3309:	6a 01                	push   $0x1
    330b:	e8 70 16 00 00       	call   4980 <printf>
    exit();
    3310:	e8 0d 15 00 00       	call   4822 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    3315:	53                   	push   %ebx
    3316:	53                   	push   %ebx
    3317:	68 b6 56 00 00       	push   $0x56b6
    331c:	6a 01                	push   $0x1
    331e:	e8 5d 16 00 00       	call   4980 <printf>
    exit();
    3323:	e8 fa 14 00 00       	call   4822 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    3328:	50                   	push   %eax
    3329:	50                   	push   %eax
    332a:	68 9e 56 00 00       	push   $0x569e
    332f:	6a 01                	push   $0x1
    3331:	e8 4a 16 00 00       	call   4980 <printf>
    exit();
    3336:	e8 e7 14 00 00       	call   4822 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    333b:	50                   	push   %eax
    333c:	50                   	push   %eax
    333d:	68 86 56 00 00       	push   $0x5686
    3342:	6a 01                	push   $0x1
    3344:	e8 37 16 00 00       	call   4980 <printf>
    exit();
    3349:	e8 d4 14 00 00       	call   4822 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    334e:	50                   	push   %eax
    334f:	50                   	push   %eax
    3350:	68 6a 56 00 00       	push   $0x566a
    3355:	6a 01                	push   $0x1
    3357:	e8 24 16 00 00       	call   4980 <printf>
    exit();
    335c:	e8 c1 14 00 00       	call   4822 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    3361:	50                   	push   %eax
    3362:	50                   	push   %eax
    3363:	68 4e 56 00 00       	push   $0x564e
    3368:	6a 01                	push   $0x1
    336a:	e8 11 16 00 00       	call   4980 <printf>
    exit();
    336f:	e8 ae 14 00 00       	call   4822 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    3374:	50                   	push   %eax
    3375:	50                   	push   %eax
    3376:	68 31 56 00 00       	push   $0x5631
    337b:	6a 01                	push   $0x1
    337d:	e8 fe 15 00 00       	call   4980 <printf>
    exit();
    3382:	e8 9b 14 00 00       	call   4822 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    3387:	50                   	push   %eax
    3388:	50                   	push   %eax
    3389:	68 16 56 00 00       	push   $0x5616
    338e:	6a 01                	push   $0x1
    3390:	e8 eb 15 00 00       	call   4980 <printf>
    exit();
    3395:	e8 88 14 00 00       	call   4822 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    339a:	50                   	push   %eax
    339b:	50                   	push   %eax
    339c:	68 43 55 00 00       	push   $0x5543
    33a1:	6a 01                	push   $0x1
    33a3:	e8 d8 15 00 00       	call   4980 <printf>
    exit();
    33a8:	e8 75 14 00 00       	call   4822 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    33ad:	50                   	push   %eax
    33ae:	50                   	push   %eax
    33af:	68 2b 55 00 00       	push   $0x552b
    33b4:	6a 01                	push   $0x1
    33b6:	e8 c5 15 00 00       	call   4980 <printf>
    exit();
    33bb:	e8 62 14 00 00       	call   4822 <exit>

000033c0 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    33c0:	55                   	push   %ebp
    33c1:	89 e5                	mov    %esp,%ebp
    33c3:	56                   	push   %esi
    33c4:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    33c5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
void
bigwrite(void)
{
  int fd, sz;

  printf(1, "bigwrite test\n");
    33ca:	83 ec 08             	sub    $0x8,%esp
    33cd:	68 fd 56 00 00       	push   $0x56fd
    33d2:	6a 01                	push   $0x1
    33d4:	e8 a7 15 00 00       	call   4980 <printf>

  unlink("bigwrite");
    33d9:	c7 04 24 0c 57 00 00 	movl   $0x570c,(%esp)
    33e0:	e8 8d 14 00 00       	call   4872 <unlink>
    33e5:	83 c4 10             	add    $0x10,%esp
    33e8:	90                   	nop
    33e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    33f0:	83 ec 08             	sub    $0x8,%esp
    33f3:	68 02 02 00 00       	push   $0x202
    33f8:	68 0c 57 00 00       	push   $0x570c
    33fd:	e8 60 14 00 00       	call   4862 <open>
    if(fd < 0){
    3402:	83 c4 10             	add    $0x10,%esp
    3405:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    3407:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    3409:	78 7e                	js     3489 <bigwrite+0xc9>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    340b:	83 ec 04             	sub    $0x4,%esp
    340e:	53                   	push   %ebx
    340f:	68 c0 94 00 00       	push   $0x94c0
    3414:	50                   	push   %eax
    3415:	e8 28 14 00 00       	call   4842 <write>
      if(cc != sz){
    341a:	83 c4 10             	add    $0x10,%esp
    341d:	39 c3                	cmp    %eax,%ebx
    341f:	75 55                	jne    3476 <bigwrite+0xb6>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    3421:	83 ec 04             	sub    $0x4,%esp
    3424:	53                   	push   %ebx
    3425:	68 c0 94 00 00       	push   $0x94c0
    342a:	56                   	push   %esi
    342b:	e8 12 14 00 00       	call   4842 <write>
      if(cc != sz){
    3430:	83 c4 10             	add    $0x10,%esp
    3433:	39 c3                	cmp    %eax,%ebx
    3435:	75 3f                	jne    3476 <bigwrite+0xb6>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    3437:	83 ec 0c             	sub    $0xc,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    343a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    3440:	56                   	push   %esi
    3441:	e8 04 14 00 00       	call   484a <close>
    unlink("bigwrite");
    3446:	c7 04 24 0c 57 00 00 	movl   $0x570c,(%esp)
    344d:	e8 20 14 00 00       	call   4872 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    3452:	83 c4 10             	add    $0x10,%esp
    3455:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    345b:	75 93                	jne    33f0 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    345d:	83 ec 08             	sub    $0x8,%esp
    3460:	68 3f 57 00 00       	push   $0x573f
    3465:	6a 01                	push   $0x1
    3467:	e8 14 15 00 00       	call   4980 <printf>
}
    346c:	83 c4 10             	add    $0x10,%esp
    346f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3472:	5b                   	pop    %ebx
    3473:	5e                   	pop    %esi
    3474:	5d                   	pop    %ebp
    3475:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    3476:	50                   	push   %eax
    3477:	53                   	push   %ebx
    3478:	68 2d 57 00 00       	push   $0x572d
    347d:	6a 01                	push   $0x1
    347f:	e8 fc 14 00 00       	call   4980 <printf>
        exit();
    3484:	e8 99 13 00 00       	call   4822 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    3489:	83 ec 08             	sub    $0x8,%esp
    348c:	68 15 57 00 00       	push   $0x5715
    3491:	6a 01                	push   $0x1
    3493:	e8 e8 14 00 00       	call   4980 <printf>
      exit();
    3498:	e8 85 13 00 00       	call   4822 <exit>
    349d:	8d 76 00             	lea    0x0(%esi),%esi

000034a0 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    34a0:	55                   	push   %ebp
    34a1:	89 e5                	mov    %esp,%ebp
    34a3:	57                   	push   %edi
    34a4:	56                   	push   %esi
    34a5:	53                   	push   %ebx
    34a6:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    34a9:	68 4c 57 00 00       	push   $0x574c
    34ae:	6a 01                	push   $0x1
    34b0:	e8 cb 14 00 00       	call   4980 <printf>

  unlink("bigfile");
    34b5:	c7 04 24 68 57 00 00 	movl   $0x5768,(%esp)
    34bc:	e8 b1 13 00 00       	call   4872 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    34c1:	5e                   	pop    %esi
    34c2:	5f                   	pop    %edi
    34c3:	68 02 02 00 00       	push   $0x202
    34c8:	68 68 57 00 00       	push   $0x5768
    34cd:	e8 90 13 00 00       	call   4862 <open>
  if(fd < 0){
    34d2:	83 c4 10             	add    $0x10,%esp
    34d5:	85 c0                	test   %eax,%eax
    34d7:	0f 88 5f 01 00 00    	js     363c <bigfile+0x19c>
    34dd:	89 c6                	mov    %eax,%esi
    34df:	31 db                	xor    %ebx,%ebx
    34e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    34e8:	83 ec 04             	sub    $0x4,%esp
    34eb:	68 58 02 00 00       	push   $0x258
    34f0:	53                   	push   %ebx
    34f1:	68 c0 94 00 00       	push   $0x94c0
    34f6:	e8 95 11 00 00       	call   4690 <memset>
    if(write(fd, buf, 600) != 600){
    34fb:	83 c4 0c             	add    $0xc,%esp
    34fe:	68 58 02 00 00       	push   $0x258
    3503:	68 c0 94 00 00       	push   $0x94c0
    3508:	56                   	push   %esi
    3509:	e8 34 13 00 00       	call   4842 <write>
    350e:	83 c4 10             	add    $0x10,%esp
    3511:	3d 58 02 00 00       	cmp    $0x258,%eax
    3516:	0f 85 f8 00 00 00    	jne    3614 <bigfile+0x174>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    351c:	83 c3 01             	add    $0x1,%ebx
    351f:	83 fb 14             	cmp    $0x14,%ebx
    3522:	75 c4                	jne    34e8 <bigfile+0x48>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    3524:	83 ec 0c             	sub    $0xc,%esp
    3527:	56                   	push   %esi
    3528:	e8 1d 13 00 00       	call   484a <close>

  fd = open("bigfile", 0);
    352d:	59                   	pop    %ecx
    352e:	5b                   	pop    %ebx
    352f:	6a 00                	push   $0x0
    3531:	68 68 57 00 00       	push   $0x5768
    3536:	e8 27 13 00 00       	call   4862 <open>
  if(fd < 0){
    353b:	83 c4 10             	add    $0x10,%esp
    353e:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    3540:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    3542:	0f 88 e0 00 00 00    	js     3628 <bigfile+0x188>
    3548:	31 db                	xor    %ebx,%ebx
    354a:	31 ff                	xor    %edi,%edi
    354c:	eb 30                	jmp    357e <bigfile+0xde>
    354e:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    3550:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    3555:	0f 85 91 00 00 00    	jne    35ec <bigfile+0x14c>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    355b:	0f be 05 c0 94 00 00 	movsbl 0x94c0,%eax
    3562:	89 fa                	mov    %edi,%edx
    3564:	d1 fa                	sar    %edx
    3566:	39 d0                	cmp    %edx,%eax
    3568:	75 6e                	jne    35d8 <bigfile+0x138>
    356a:	0f be 15 eb 95 00 00 	movsbl 0x95eb,%edx
    3571:	39 d0                	cmp    %edx,%eax
    3573:	75 63                	jne    35d8 <bigfile+0x138>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    3575:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    357b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    357e:	83 ec 04             	sub    $0x4,%esp
    3581:	68 2c 01 00 00       	push   $0x12c
    3586:	68 c0 94 00 00       	push   $0x94c0
    358b:	56                   	push   %esi
    358c:	e8 a9 12 00 00       	call   483a <read>
    if(cc < 0){
    3591:	83 c4 10             	add    $0x10,%esp
    3594:	85 c0                	test   %eax,%eax
    3596:	78 68                	js     3600 <bigfile+0x160>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    3598:	75 b6                	jne    3550 <bigfile+0xb0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    359a:	83 ec 0c             	sub    $0xc,%esp
    359d:	56                   	push   %esi
    359e:	e8 a7 12 00 00       	call   484a <close>
  if(total != 20*600){
    35a3:	83 c4 10             	add    $0x10,%esp
    35a6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    35ac:	0f 85 9e 00 00 00    	jne    3650 <bigfile+0x1b0>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    35b2:	83 ec 0c             	sub    $0xc,%esp
    35b5:	68 68 57 00 00       	push   $0x5768
    35ba:	e8 b3 12 00 00       	call   4872 <unlink>

  printf(1, "bigfile test ok\n");
    35bf:	58                   	pop    %eax
    35c0:	5a                   	pop    %edx
    35c1:	68 f7 57 00 00       	push   $0x57f7
    35c6:	6a 01                	push   $0x1
    35c8:	e8 b3 13 00 00       	call   4980 <printf>
}
    35cd:	83 c4 10             	add    $0x10,%esp
    35d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    35d3:	5b                   	pop    %ebx
    35d4:	5e                   	pop    %esi
    35d5:	5f                   	pop    %edi
    35d6:	5d                   	pop    %ebp
    35d7:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    35d8:	83 ec 08             	sub    $0x8,%esp
    35db:	68 c4 57 00 00       	push   $0x57c4
    35e0:	6a 01                	push   $0x1
    35e2:	e8 99 13 00 00       	call   4980 <printf>
      exit();
    35e7:	e8 36 12 00 00       	call   4822 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    35ec:	83 ec 08             	sub    $0x8,%esp
    35ef:	68 b0 57 00 00       	push   $0x57b0
    35f4:	6a 01                	push   $0x1
    35f6:	e8 85 13 00 00       	call   4980 <printf>
      exit();
    35fb:	e8 22 12 00 00       	call   4822 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    3600:	83 ec 08             	sub    $0x8,%esp
    3603:	68 9b 57 00 00       	push   $0x579b
    3608:	6a 01                	push   $0x1
    360a:	e8 71 13 00 00       	call   4980 <printf>
      exit();
    360f:	e8 0e 12 00 00       	call   4822 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    3614:	83 ec 08             	sub    $0x8,%esp
    3617:	68 70 57 00 00       	push   $0x5770
    361c:	6a 01                	push   $0x1
    361e:	e8 5d 13 00 00       	call   4980 <printf>
      exit();
    3623:	e8 fa 11 00 00       	call   4822 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    3628:	83 ec 08             	sub    $0x8,%esp
    362b:	68 86 57 00 00       	push   $0x5786
    3630:	6a 01                	push   $0x1
    3632:	e8 49 13 00 00       	call   4980 <printf>
    exit();
    3637:	e8 e6 11 00 00       	call   4822 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    363c:	83 ec 08             	sub    $0x8,%esp
    363f:	68 5a 57 00 00       	push   $0x575a
    3644:	6a 01                	push   $0x1
    3646:	e8 35 13 00 00       	call   4980 <printf>
    exit();
    364b:	e8 d2 11 00 00       	call   4822 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    3650:	83 ec 08             	sub    $0x8,%esp
    3653:	68 dd 57 00 00       	push   $0x57dd
    3658:	6a 01                	push   $0x1
    365a:	e8 21 13 00 00       	call   4980 <printf>
    exit();
    365f:	e8 be 11 00 00       	call   4822 <exit>
    3664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    366a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003670 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    3670:	55                   	push   %ebp
    3671:	89 e5                	mov    %esp,%ebp
    3673:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    3676:	68 08 58 00 00       	push   $0x5808
    367b:	6a 01                	push   $0x1
    367d:	e8 fe 12 00 00       	call   4980 <printf>

  if(mkdir("12345678901234") != 0){
    3682:	c7 04 24 43 58 00 00 	movl   $0x5843,(%esp)
    3689:	e8 fc 11 00 00       	call   488a <mkdir>
    368e:	83 c4 10             	add    $0x10,%esp
    3691:	85 c0                	test   %eax,%eax
    3693:	0f 85 97 00 00 00    	jne    3730 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    3699:	83 ec 0c             	sub    $0xc,%esp
    369c:	68 dc 5f 00 00       	push   $0x5fdc
    36a1:	e8 e4 11 00 00       	call   488a <mkdir>
    36a6:	83 c4 10             	add    $0x10,%esp
    36a9:	85 c0                	test   %eax,%eax
    36ab:	0f 85 de 00 00 00    	jne    378f <fourteen+0x11f>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    36b1:	83 ec 08             	sub    $0x8,%esp
    36b4:	68 00 02 00 00       	push   $0x200
    36b9:	68 2c 60 00 00       	push   $0x602c
    36be:	e8 9f 11 00 00       	call   4862 <open>
  if(fd < 0){
    36c3:	83 c4 10             	add    $0x10,%esp
    36c6:	85 c0                	test   %eax,%eax
    36c8:	0f 88 ae 00 00 00    	js     377c <fourteen+0x10c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    36ce:	83 ec 0c             	sub    $0xc,%esp
    36d1:	50                   	push   %eax
    36d2:	e8 73 11 00 00       	call   484a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    36d7:	58                   	pop    %eax
    36d8:	5a                   	pop    %edx
    36d9:	6a 00                	push   $0x0
    36db:	68 9c 60 00 00       	push   $0x609c
    36e0:	e8 7d 11 00 00       	call   4862 <open>
  if(fd < 0){
    36e5:	83 c4 10             	add    $0x10,%esp
    36e8:	85 c0                	test   %eax,%eax
    36ea:	78 7d                	js     3769 <fourteen+0xf9>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    36ec:	83 ec 0c             	sub    $0xc,%esp
    36ef:	50                   	push   %eax
    36f0:	e8 55 11 00 00       	call   484a <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    36f5:	c7 04 24 34 58 00 00 	movl   $0x5834,(%esp)
    36fc:	e8 89 11 00 00       	call   488a <mkdir>
    3701:	83 c4 10             	add    $0x10,%esp
    3704:	85 c0                	test   %eax,%eax
    3706:	74 4e                	je     3756 <fourteen+0xe6>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    3708:	83 ec 0c             	sub    $0xc,%esp
    370b:	68 38 61 00 00       	push   $0x6138
    3710:	e8 75 11 00 00       	call   488a <mkdir>
    3715:	83 c4 10             	add    $0x10,%esp
    3718:	85 c0                	test   %eax,%eax
    371a:	74 27                	je     3743 <fourteen+0xd3>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    371c:	83 ec 08             	sub    $0x8,%esp
    371f:	68 52 58 00 00       	push   $0x5852
    3724:	6a 01                	push   $0x1
    3726:	e8 55 12 00 00       	call   4980 <printf>
}
    372b:	83 c4 10             	add    $0x10,%esp
    372e:	c9                   	leave  
    372f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    3730:	50                   	push   %eax
    3731:	50                   	push   %eax
    3732:	68 17 58 00 00       	push   $0x5817
    3737:	6a 01                	push   $0x1
    3739:	e8 42 12 00 00       	call   4980 <printf>
    exit();
    373e:	e8 df 10 00 00       	call   4822 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    3743:	50                   	push   %eax
    3744:	50                   	push   %eax
    3745:	68 58 61 00 00       	push   $0x6158
    374a:	6a 01                	push   $0x1
    374c:	e8 2f 12 00 00       	call   4980 <printf>
    exit();
    3751:	e8 cc 10 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    3756:	52                   	push   %edx
    3757:	52                   	push   %edx
    3758:	68 08 61 00 00       	push   $0x6108
    375d:	6a 01                	push   $0x1
    375f:	e8 1c 12 00 00       	call   4980 <printf>
    exit();
    3764:	e8 b9 10 00 00       	call   4822 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    3769:	51                   	push   %ecx
    376a:	51                   	push   %ecx
    376b:	68 cc 60 00 00       	push   $0x60cc
    3770:	6a 01                	push   $0x1
    3772:	e8 09 12 00 00       	call   4980 <printf>
    exit();
    3777:	e8 a6 10 00 00       	call   4822 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    377c:	51                   	push   %ecx
    377d:	51                   	push   %ecx
    377e:	68 5c 60 00 00       	push   $0x605c
    3783:	6a 01                	push   $0x1
    3785:	e8 f6 11 00 00       	call   4980 <printf>
    exit();
    378a:	e8 93 10 00 00       	call   4822 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    378f:	50                   	push   %eax
    3790:	50                   	push   %eax
    3791:	68 fc 5f 00 00       	push   $0x5ffc
    3796:	6a 01                	push   $0x1
    3798:	e8 e3 11 00 00       	call   4980 <printf>
    exit();
    379d:	e8 80 10 00 00       	call   4822 <exit>
    37a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037b0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    37b0:	55                   	push   %ebp
    37b1:	89 e5                	mov    %esp,%ebp
    37b3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    37b6:	68 5f 58 00 00       	push   $0x585f
    37bb:	6a 01                	push   $0x1
    37bd:	e8 be 11 00 00       	call   4980 <printf>
  if(mkdir("dots") != 0){
    37c2:	c7 04 24 6b 58 00 00 	movl   $0x586b,(%esp)
    37c9:	e8 bc 10 00 00       	call   488a <mkdir>
    37ce:	83 c4 10             	add    $0x10,%esp
    37d1:	85 c0                	test   %eax,%eax
    37d3:	0f 85 b0 00 00 00    	jne    3889 <rmdot+0xd9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    37d9:	83 ec 0c             	sub    $0xc,%esp
    37dc:	68 6b 58 00 00       	push   $0x586b
    37e1:	e8 ac 10 00 00       	call   4892 <chdir>
    37e6:	83 c4 10             	add    $0x10,%esp
    37e9:	85 c0                	test   %eax,%eax
    37eb:	0f 85 1d 01 00 00    	jne    390e <rmdot+0x15e>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    37f1:	83 ec 0c             	sub    $0xc,%esp
    37f4:	68 16 55 00 00       	push   $0x5516
    37f9:	e8 74 10 00 00       	call   4872 <unlink>
    37fe:	83 c4 10             	add    $0x10,%esp
    3801:	85 c0                	test   %eax,%eax
    3803:	0f 84 f2 00 00 00    	je     38fb <rmdot+0x14b>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    3809:	83 ec 0c             	sub    $0xc,%esp
    380c:	68 15 55 00 00       	push   $0x5515
    3811:	e8 5c 10 00 00       	call   4872 <unlink>
    3816:	83 c4 10             	add    $0x10,%esp
    3819:	85 c0                	test   %eax,%eax
    381b:	0f 84 c7 00 00 00    	je     38e8 <rmdot+0x138>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    3821:	83 ec 0c             	sub    $0xc,%esp
    3824:	68 e9 4c 00 00       	push   $0x4ce9
    3829:	e8 64 10 00 00       	call   4892 <chdir>
    382e:	83 c4 10             	add    $0x10,%esp
    3831:	85 c0                	test   %eax,%eax
    3833:	0f 85 9c 00 00 00    	jne    38d5 <rmdot+0x125>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    3839:	83 ec 0c             	sub    $0xc,%esp
    383c:	68 b3 58 00 00       	push   $0x58b3
    3841:	e8 2c 10 00 00       	call   4872 <unlink>
    3846:	83 c4 10             	add    $0x10,%esp
    3849:	85 c0                	test   %eax,%eax
    384b:	74 75                	je     38c2 <rmdot+0x112>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    384d:	83 ec 0c             	sub    $0xc,%esp
    3850:	68 d1 58 00 00       	push   $0x58d1
    3855:	e8 18 10 00 00       	call   4872 <unlink>
    385a:	83 c4 10             	add    $0x10,%esp
    385d:	85 c0                	test   %eax,%eax
    385f:	74 4e                	je     38af <rmdot+0xff>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    3861:	83 ec 0c             	sub    $0xc,%esp
    3864:	68 6b 58 00 00       	push   $0x586b
    3869:	e8 04 10 00 00       	call   4872 <unlink>
    386e:	83 c4 10             	add    $0x10,%esp
    3871:	85 c0                	test   %eax,%eax
    3873:	75 27                	jne    389c <rmdot+0xec>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    3875:	83 ec 08             	sub    $0x8,%esp
    3878:	68 06 59 00 00       	push   $0x5906
    387d:	6a 01                	push   $0x1
    387f:	e8 fc 10 00 00       	call   4980 <printf>
}
    3884:	83 c4 10             	add    $0x10,%esp
    3887:	c9                   	leave  
    3888:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    3889:	50                   	push   %eax
    388a:	50                   	push   %eax
    388b:	68 70 58 00 00       	push   $0x5870
    3890:	6a 01                	push   $0x1
    3892:	e8 e9 10 00 00       	call   4980 <printf>
    exit();
    3897:	e8 86 0f 00 00       	call   4822 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    389c:	50                   	push   %eax
    389d:	50                   	push   %eax
    389e:	68 f1 58 00 00       	push   $0x58f1
    38a3:	6a 01                	push   $0x1
    38a5:	e8 d6 10 00 00       	call   4980 <printf>
    exit();
    38aa:	e8 73 0f 00 00       	call   4822 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    38af:	52                   	push   %edx
    38b0:	52                   	push   %edx
    38b1:	68 d9 58 00 00       	push   $0x58d9
    38b6:	6a 01                	push   $0x1
    38b8:	e8 c3 10 00 00       	call   4980 <printf>
    exit();
    38bd:	e8 60 0f 00 00       	call   4822 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    38c2:	51                   	push   %ecx
    38c3:	51                   	push   %ecx
    38c4:	68 ba 58 00 00       	push   $0x58ba
    38c9:	6a 01                	push   $0x1
    38cb:	e8 b0 10 00 00       	call   4980 <printf>
    exit();
    38d0:	e8 4d 0f 00 00       	call   4822 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    38d5:	50                   	push   %eax
    38d6:	50                   	push   %eax
    38d7:	68 eb 4c 00 00       	push   $0x4ceb
    38dc:	6a 01                	push   $0x1
    38de:	e8 9d 10 00 00       	call   4980 <printf>
    exit();
    38e3:	e8 3a 0f 00 00       	call   4822 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    38e8:	50                   	push   %eax
    38e9:	50                   	push   %eax
    38ea:	68 a4 58 00 00       	push   $0x58a4
    38ef:	6a 01                	push   $0x1
    38f1:	e8 8a 10 00 00       	call   4980 <printf>
    exit();
    38f6:	e8 27 0f 00 00       	call   4822 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    38fb:	50                   	push   %eax
    38fc:	50                   	push   %eax
    38fd:	68 96 58 00 00       	push   $0x5896
    3902:	6a 01                	push   $0x1
    3904:	e8 77 10 00 00       	call   4980 <printf>
    exit();
    3909:	e8 14 0f 00 00       	call   4822 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    390e:	50                   	push   %eax
    390f:	50                   	push   %eax
    3910:	68 83 58 00 00       	push   $0x5883
    3915:	6a 01                	push   $0x1
    3917:	e8 64 10 00 00       	call   4980 <printf>
    exit();
    391c:	e8 01 0f 00 00       	call   4822 <exit>
    3921:	eb 0d                	jmp    3930 <dirfile>
    3923:	90                   	nop
    3924:	90                   	nop
    3925:	90                   	nop
    3926:	90                   	nop
    3927:	90                   	nop
    3928:	90                   	nop
    3929:	90                   	nop
    392a:	90                   	nop
    392b:	90                   	nop
    392c:	90                   	nop
    392d:	90                   	nop
    392e:	90                   	nop
    392f:	90                   	nop

00003930 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    3930:	55                   	push   %ebp
    3931:	89 e5                	mov    %esp,%ebp
    3933:	53                   	push   %ebx
    3934:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    3937:	68 10 59 00 00       	push   $0x5910
    393c:	6a 01                	push   $0x1
    393e:	e8 3d 10 00 00       	call   4980 <printf>

  fd = open("dirfile", O_CREATE);
    3943:	59                   	pop    %ecx
    3944:	5b                   	pop    %ebx
    3945:	68 00 02 00 00       	push   $0x200
    394a:	68 1d 59 00 00       	push   $0x591d
    394f:	e8 0e 0f 00 00       	call   4862 <open>
  if(fd < 0){
    3954:	83 c4 10             	add    $0x10,%esp
    3957:	85 c0                	test   %eax,%eax
    3959:	0f 88 43 01 00 00    	js     3aa2 <dirfile+0x172>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    395f:	83 ec 0c             	sub    $0xc,%esp
    3962:	50                   	push   %eax
    3963:	e8 e2 0e 00 00       	call   484a <close>
  if(chdir("dirfile") == 0){
    3968:	c7 04 24 1d 59 00 00 	movl   $0x591d,(%esp)
    396f:	e8 1e 0f 00 00       	call   4892 <chdir>
    3974:	83 c4 10             	add    $0x10,%esp
    3977:	85 c0                	test   %eax,%eax
    3979:	0f 84 10 01 00 00    	je     3a8f <dirfile+0x15f>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    397f:	83 ec 08             	sub    $0x8,%esp
    3982:	6a 00                	push   $0x0
    3984:	68 56 59 00 00       	push   $0x5956
    3989:	e8 d4 0e 00 00       	call   4862 <open>
  if(fd >= 0){
    398e:	83 c4 10             	add    $0x10,%esp
    3991:	85 c0                	test   %eax,%eax
    3993:	0f 89 e3 00 00 00    	jns    3a7c <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    3999:	83 ec 08             	sub    $0x8,%esp
    399c:	68 00 02 00 00       	push   $0x200
    39a1:	68 56 59 00 00       	push   $0x5956
    39a6:	e8 b7 0e 00 00       	call   4862 <open>
  if(fd >= 0){
    39ab:	83 c4 10             	add    $0x10,%esp
    39ae:	85 c0                	test   %eax,%eax
    39b0:	0f 89 c6 00 00 00    	jns    3a7c <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    39b6:	83 ec 0c             	sub    $0xc,%esp
    39b9:	68 56 59 00 00       	push   $0x5956
    39be:	e8 c7 0e 00 00       	call   488a <mkdir>
    39c3:	83 c4 10             	add    $0x10,%esp
    39c6:	85 c0                	test   %eax,%eax
    39c8:	0f 84 46 01 00 00    	je     3b14 <dirfile+0x1e4>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    39ce:	83 ec 0c             	sub    $0xc,%esp
    39d1:	68 56 59 00 00       	push   $0x5956
    39d6:	e8 97 0e 00 00       	call   4872 <unlink>
    39db:	83 c4 10             	add    $0x10,%esp
    39de:	85 c0                	test   %eax,%eax
    39e0:	0f 84 1b 01 00 00    	je     3b01 <dirfile+0x1d1>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    39e6:	83 ec 08             	sub    $0x8,%esp
    39e9:	68 56 59 00 00       	push   $0x5956
    39ee:	68 ba 59 00 00       	push   $0x59ba
    39f3:	e8 8a 0e 00 00       	call   4882 <link>
    39f8:	83 c4 10             	add    $0x10,%esp
    39fb:	85 c0                	test   %eax,%eax
    39fd:	0f 84 eb 00 00 00    	je     3aee <dirfile+0x1be>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    3a03:	83 ec 0c             	sub    $0xc,%esp
    3a06:	68 1d 59 00 00       	push   $0x591d
    3a0b:	e8 62 0e 00 00       	call   4872 <unlink>
    3a10:	83 c4 10             	add    $0x10,%esp
    3a13:	85 c0                	test   %eax,%eax
    3a15:	0f 85 c0 00 00 00    	jne    3adb <dirfile+0x1ab>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    3a1b:	83 ec 08             	sub    $0x8,%esp
    3a1e:	6a 02                	push   $0x2
    3a20:	68 16 55 00 00       	push   $0x5516
    3a25:	e8 38 0e 00 00       	call   4862 <open>
  if(fd >= 0){
    3a2a:	83 c4 10             	add    $0x10,%esp
    3a2d:	85 c0                	test   %eax,%eax
    3a2f:	0f 89 93 00 00 00    	jns    3ac8 <dirfile+0x198>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    3a35:	83 ec 08             	sub    $0x8,%esp
    3a38:	6a 00                	push   $0x0
    3a3a:	68 16 55 00 00       	push   $0x5516
    3a3f:	e8 1e 0e 00 00       	call   4862 <open>
  if(write(fd, "x", 1) > 0){
    3a44:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    3a47:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    3a49:	6a 01                	push   $0x1
    3a4b:	68 f9 55 00 00       	push   $0x55f9
    3a50:	50                   	push   %eax
    3a51:	e8 ec 0d 00 00       	call   4842 <write>
    3a56:	83 c4 10             	add    $0x10,%esp
    3a59:	85 c0                	test   %eax,%eax
    3a5b:	7f 58                	jg     3ab5 <dirfile+0x185>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    3a5d:	83 ec 0c             	sub    $0xc,%esp
    3a60:	53                   	push   %ebx
    3a61:	e8 e4 0d 00 00       	call   484a <close>

  printf(1, "dir vs file OK\n");
    3a66:	58                   	pop    %eax
    3a67:	5a                   	pop    %edx
    3a68:	68 ed 59 00 00       	push   $0x59ed
    3a6d:	6a 01                	push   $0x1
    3a6f:	e8 0c 0f 00 00       	call   4980 <printf>
}
    3a74:	83 c4 10             	add    $0x10,%esp
    3a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3a7a:	c9                   	leave  
    3a7b:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    3a7c:	50                   	push   %eax
    3a7d:	50                   	push   %eax
    3a7e:	68 61 59 00 00       	push   $0x5961
    3a83:	6a 01                	push   $0x1
    3a85:	e8 f6 0e 00 00       	call   4980 <printf>
    exit();
    3a8a:	e8 93 0d 00 00       	call   4822 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    3a8f:	50                   	push   %eax
    3a90:	50                   	push   %eax
    3a91:	68 3c 59 00 00       	push   $0x593c
    3a96:	6a 01                	push   $0x1
    3a98:	e8 e3 0e 00 00       	call   4980 <printf>
    exit();
    3a9d:	e8 80 0d 00 00       	call   4822 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    3aa2:	52                   	push   %edx
    3aa3:	52                   	push   %edx
    3aa4:	68 25 59 00 00       	push   $0x5925
    3aa9:	6a 01                	push   $0x1
    3aab:	e8 d0 0e 00 00       	call   4980 <printf>
    exit();
    3ab0:	e8 6d 0d 00 00       	call   4822 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    3ab5:	51                   	push   %ecx
    3ab6:	51                   	push   %ecx
    3ab7:	68 d9 59 00 00       	push   $0x59d9
    3abc:	6a 01                	push   $0x1
    3abe:	e8 bd 0e 00 00       	call   4980 <printf>
    exit();
    3ac3:	e8 5a 0d 00 00       	call   4822 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    3ac8:	53                   	push   %ebx
    3ac9:	53                   	push   %ebx
    3aca:	68 ac 61 00 00       	push   $0x61ac
    3acf:	6a 01                	push   $0x1
    3ad1:	e8 aa 0e 00 00       	call   4980 <printf>
    exit();
    3ad6:	e8 47 0d 00 00       	call   4822 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    3adb:	50                   	push   %eax
    3adc:	50                   	push   %eax
    3add:	68 c1 59 00 00       	push   $0x59c1
    3ae2:	6a 01                	push   $0x1
    3ae4:	e8 97 0e 00 00       	call   4980 <printf>
    exit();
    3ae9:	e8 34 0d 00 00       	call   4822 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    3aee:	50                   	push   %eax
    3aef:	50                   	push   %eax
    3af0:	68 8c 61 00 00       	push   $0x618c
    3af5:	6a 01                	push   $0x1
    3af7:	e8 84 0e 00 00       	call   4980 <printf>
    exit();
    3afc:	e8 21 0d 00 00       	call   4822 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    3b01:	50                   	push   %eax
    3b02:	50                   	push   %eax
    3b03:	68 9c 59 00 00       	push   $0x599c
    3b08:	6a 01                	push   $0x1
    3b0a:	e8 71 0e 00 00       	call   4980 <printf>
    exit();
    3b0f:	e8 0e 0d 00 00       	call   4822 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    3b14:	50                   	push   %eax
    3b15:	50                   	push   %eax
    3b16:	68 7f 59 00 00       	push   $0x597f
    3b1b:	6a 01                	push   $0x1
    3b1d:	e8 5e 0e 00 00       	call   4980 <printf>
    exit();
    3b22:	e8 fb 0c 00 00       	call   4822 <exit>
    3b27:	89 f6                	mov    %esi,%esi
    3b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003b30 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3b30:	55                   	push   %ebp
    3b31:	89 e5                	mov    %esp,%ebp
    3b33:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    3b34:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3b39:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    3b3c:	68 fd 59 00 00       	push   $0x59fd
    3b41:	6a 01                	push   $0x1
    3b43:	e8 38 0e 00 00       	call   4980 <printf>
    3b48:	83 c4 10             	add    $0x10,%esp
    3b4b:	90                   	nop
    3b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    3b50:	83 ec 0c             	sub    $0xc,%esp
    3b53:	68 0e 5a 00 00       	push   $0x5a0e
    3b58:	e8 2d 0d 00 00       	call   488a <mkdir>
    3b5d:	83 c4 10             	add    $0x10,%esp
    3b60:	85 c0                	test   %eax,%eax
    3b62:	0f 85 bb 00 00 00    	jne    3c23 <iref+0xf3>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    3b68:	83 ec 0c             	sub    $0xc,%esp
    3b6b:	68 0e 5a 00 00       	push   $0x5a0e
    3b70:	e8 1d 0d 00 00       	call   4892 <chdir>
    3b75:	83 c4 10             	add    $0x10,%esp
    3b78:	85 c0                	test   %eax,%eax
    3b7a:	0f 85 b7 00 00 00    	jne    3c37 <iref+0x107>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    3b80:	83 ec 0c             	sub    $0xc,%esp
    3b83:	68 c3 50 00 00       	push   $0x50c3
    3b88:	e8 fd 0c 00 00       	call   488a <mkdir>
    link("README", "");
    3b8d:	59                   	pop    %ecx
    3b8e:	58                   	pop    %eax
    3b8f:	68 c3 50 00 00       	push   $0x50c3
    3b94:	68 ba 59 00 00       	push   $0x59ba
    3b99:	e8 e4 0c 00 00       	call   4882 <link>
    fd = open("", O_CREATE);
    3b9e:	58                   	pop    %eax
    3b9f:	5a                   	pop    %edx
    3ba0:	68 00 02 00 00       	push   $0x200
    3ba5:	68 c3 50 00 00       	push   $0x50c3
    3baa:	e8 b3 0c 00 00       	call   4862 <open>
    if(fd >= 0)
    3baf:	83 c4 10             	add    $0x10,%esp
    3bb2:	85 c0                	test   %eax,%eax
    3bb4:	78 0c                	js     3bc2 <iref+0x92>
      close(fd);
    3bb6:	83 ec 0c             	sub    $0xc,%esp
    3bb9:	50                   	push   %eax
    3bba:	e8 8b 0c 00 00       	call   484a <close>
    3bbf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    3bc2:	83 ec 08             	sub    $0x8,%esp
    3bc5:	68 00 02 00 00       	push   $0x200
    3bca:	68 f8 55 00 00       	push   $0x55f8
    3bcf:	e8 8e 0c 00 00       	call   4862 <open>
    if(fd >= 0)
    3bd4:	83 c4 10             	add    $0x10,%esp
    3bd7:	85 c0                	test   %eax,%eax
    3bd9:	78 0c                	js     3be7 <iref+0xb7>
      close(fd);
    3bdb:	83 ec 0c             	sub    $0xc,%esp
    3bde:	50                   	push   %eax
    3bdf:	e8 66 0c 00 00       	call   484a <close>
    3be4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    3be7:	83 ec 0c             	sub    $0xc,%esp
    3bea:	68 f8 55 00 00       	push   $0x55f8
    3bef:	e8 7e 0c 00 00       	call   4872 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    3bf4:	83 c4 10             	add    $0x10,%esp
    3bf7:	83 eb 01             	sub    $0x1,%ebx
    3bfa:	0f 85 50 ff ff ff    	jne    3b50 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    3c00:	83 ec 0c             	sub    $0xc,%esp
    3c03:	68 e9 4c 00 00       	push   $0x4ce9
    3c08:	e8 85 0c 00 00       	call   4892 <chdir>
  printf(1, "empty file name OK\n");
    3c0d:	58                   	pop    %eax
    3c0e:	5a                   	pop    %edx
    3c0f:	68 3c 5a 00 00       	push   $0x5a3c
    3c14:	6a 01                	push   $0x1
    3c16:	e8 65 0d 00 00       	call   4980 <printf>
}
    3c1b:	83 c4 10             	add    $0x10,%esp
    3c1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3c21:	c9                   	leave  
    3c22:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    3c23:	83 ec 08             	sub    $0x8,%esp
    3c26:	68 14 5a 00 00       	push   $0x5a14
    3c2b:	6a 01                	push   $0x1
    3c2d:	e8 4e 0d 00 00       	call   4980 <printf>
      exit();
    3c32:	e8 eb 0b 00 00       	call   4822 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    3c37:	83 ec 08             	sub    $0x8,%esp
    3c3a:	68 28 5a 00 00       	push   $0x5a28
    3c3f:	6a 01                	push   $0x1
    3c41:	e8 3a 0d 00 00       	call   4980 <printf>
      exit();
    3c46:	e8 d7 0b 00 00       	call   4822 <exit>
    3c4b:	90                   	nop
    3c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c50 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3c50:	55                   	push   %ebp
    3c51:	89 e5                	mov    %esp,%ebp
    3c53:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    3c54:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3c56:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    3c59:	68 50 5a 00 00       	push   $0x5a50
    3c5e:	6a 01                	push   $0x1
    3c60:	e8 1b 0d 00 00       	call   4980 <printf>
    3c65:	83 c4 10             	add    $0x10,%esp
    3c68:	eb 13                	jmp    3c7d <forktest+0x2d>
    3c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    3c70:	74 62                	je     3cd4 <forktest+0x84>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    3c72:	83 c3 01             	add    $0x1,%ebx
    3c75:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    3c7b:	74 43                	je     3cc0 <forktest+0x70>
    pid = fork();
    3c7d:	e8 98 0b 00 00       	call   481a <fork>
    if(pid < 0)
    3c82:	85 c0                	test   %eax,%eax
    3c84:	79 ea                	jns    3c70 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    3c86:	85 db                	test   %ebx,%ebx
    3c88:	74 14                	je     3c9e <forktest+0x4e>
    3c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    3c90:	e8 95 0b 00 00       	call   482a <wait>
    3c95:	85 c0                	test   %eax,%eax
    3c97:	78 40                	js     3cd9 <forktest+0x89>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    3c99:	83 eb 01             	sub    $0x1,%ebx
    3c9c:	75 f2                	jne    3c90 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    3c9e:	e8 87 0b 00 00       	call   482a <wait>
    3ca3:	83 f8 ff             	cmp    $0xffffffff,%eax
    3ca6:	75 45                	jne    3ced <forktest+0x9d>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    3ca8:	83 ec 08             	sub    $0x8,%esp
    3cab:	68 82 5a 00 00       	push   $0x5a82
    3cb0:	6a 01                	push   $0x1
    3cb2:	e8 c9 0c 00 00       	call   4980 <printf>
}
    3cb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3cba:	c9                   	leave  
    3cbb:	c3                   	ret    
    3cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    3cc0:	83 ec 08             	sub    $0x8,%esp
    3cc3:	68 cc 61 00 00       	push   $0x61cc
    3cc8:	6a 01                	push   $0x1
    3cca:	e8 b1 0c 00 00       	call   4980 <printf>
    exit();
    3ccf:	e8 4e 0b 00 00       	call   4822 <exit>
  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    3cd4:	e8 49 0b 00 00       	call   4822 <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    3cd9:	83 ec 08             	sub    $0x8,%esp
    3cdc:	68 5b 5a 00 00       	push   $0x5a5b
    3ce1:	6a 01                	push   $0x1
    3ce3:	e8 98 0c 00 00       	call   4980 <printf>
      exit();
    3ce8:	e8 35 0b 00 00       	call   4822 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    3ced:	83 ec 08             	sub    $0x8,%esp
    3cf0:	68 6f 5a 00 00       	push   $0x5a6f
    3cf5:	6a 01                	push   $0x1
    3cf7:	e8 84 0c 00 00       	call   4980 <printf>
    exit();
    3cfc:	e8 21 0b 00 00       	call   4822 <exit>
    3d01:	eb 0d                	jmp    3d10 <sbrktest>
    3d03:	90                   	nop
    3d04:	90                   	nop
    3d05:	90                   	nop
    3d06:	90                   	nop
    3d07:	90                   	nop
    3d08:	90                   	nop
    3d09:	90                   	nop
    3d0a:	90                   	nop
    3d0b:	90                   	nop
    3d0c:	90                   	nop
    3d0d:	90                   	nop
    3d0e:	90                   	nop
    3d0f:	90                   	nop

00003d10 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3d10:	55                   	push   %ebp
    3d11:	89 e5                	mov    %esp,%ebp
    3d13:	57                   	push   %edi
    3d14:	56                   	push   %esi
    3d15:	53                   	push   %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3d16:	31 ff                	xor    %edi,%edi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3d18:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3d1b:	68 90 5a 00 00       	push   $0x5a90
    3d20:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    3d26:	e8 55 0c 00 00       	call   4980 <printf>
  oldbrk = sbrk(0);
    3d2b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d32:	e8 73 0b 00 00       	call   48aa <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    3d37:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    3d3e:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    3d41:	e8 64 0b 00 00       	call   48aa <sbrk>
    3d46:	83 c4 10             	add    $0x10,%esp
    3d49:	89 c3                	mov    %eax,%ebx
    3d4b:	90                   	nop
    3d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    3d50:	83 ec 0c             	sub    $0xc,%esp
    3d53:	6a 01                	push   $0x1
    3d55:	e8 50 0b 00 00       	call   48aa <sbrk>
    if(b != a){
    3d5a:	83 c4 10             	add    $0x10,%esp
    3d5d:	39 d8                	cmp    %ebx,%eax
    3d5f:	0f 85 85 02 00 00    	jne    3fea <sbrktest+0x2da>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3d65:	83 c7 01             	add    $0x1,%edi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    3d68:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    3d6b:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3d6e:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    3d74:	75 da                	jne    3d50 <sbrktest+0x40>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3d76:	e8 9f 0a 00 00       	call   481a <fork>
  if(pid < 0){
    3d7b:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3d7d:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    3d7f:	0f 88 93 03 00 00    	js     4118 <sbrktest+0x408>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    3d85:	83 ec 0c             	sub    $0xc,%esp
  c = sbrk(1);
  if(c != a + 1){
    3d88:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    3d8b:	6a 01                	push   $0x1
    3d8d:	e8 18 0b 00 00       	call   48aa <sbrk>
  c = sbrk(1);
    3d92:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d99:	e8 0c 0b 00 00       	call   48aa <sbrk>
  if(c != a + 1){
    3d9e:	83 c4 10             	add    $0x10,%esp
    3da1:	39 d8                	cmp    %ebx,%eax
    3da3:	0f 85 57 03 00 00    	jne    4100 <sbrktest+0x3f0>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    3da9:	85 ff                	test   %edi,%edi
    3dab:	0f 84 4a 03 00 00    	je     40fb <sbrktest+0x3eb>
    exit();
  wait();
    3db1:	e8 74 0a 00 00       	call   482a <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3db6:	83 ec 0c             	sub    $0xc,%esp
    3db9:	6a 00                	push   $0x0
    3dbb:	e8 ea 0a 00 00       	call   48aa <sbrk>
    3dc0:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    3dc2:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3dc7:	29 d8                	sub    %ebx,%eax
    3dc9:	89 04 24             	mov    %eax,(%esp)
    3dcc:	e8 d9 0a 00 00       	call   48aa <sbrk>
  if (p != a) {
    3dd1:	83 c4 10             	add    $0x10,%esp
    3dd4:	39 c3                	cmp    %eax,%ebx
    3dd6:	0f 85 07 03 00 00    	jne    40e3 <sbrktest+0x3d3>
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    3ddc:	83 ec 0c             	sub    $0xc,%esp
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    3ddf:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    3de6:	6a 00                	push   $0x0
    3de8:	e8 bd 0a 00 00       	call   48aa <sbrk>
  c = sbrk(-4096);
    3ded:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    3df4:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    3df6:	e8 af 0a 00 00       	call   48aa <sbrk>
  if(c == (char*)0xffffffff){
    3dfb:	83 c4 10             	add    $0x10,%esp
    3dfe:	83 f8 ff             	cmp    $0xffffffff,%eax
    3e01:	0f 84 c4 02 00 00    	je     40cb <sbrktest+0x3bb>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    3e07:	83 ec 0c             	sub    $0xc,%esp
    3e0a:	6a 00                	push   $0x0
    3e0c:	e8 99 0a 00 00       	call   48aa <sbrk>
  if(c != a - 4096){
    3e11:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    3e17:	83 c4 10             	add    $0x10,%esp
    3e1a:	39 d0                	cmp    %edx,%eax
    3e1c:	0f 85 92 02 00 00    	jne    40b4 <sbrktest+0x3a4>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3e22:	83 ec 0c             	sub    $0xc,%esp
    3e25:	6a 00                	push   $0x0
    3e27:	e8 7e 0a 00 00       	call   48aa <sbrk>
    3e2c:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    3e2e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    3e35:	e8 70 0a 00 00       	call   48aa <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    3e3a:	83 c4 10             	add    $0x10,%esp
    3e3d:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    3e3f:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    3e41:	0f 85 56 02 00 00    	jne    409d <sbrktest+0x38d>
    3e47:	83 ec 0c             	sub    $0xc,%esp
    3e4a:	6a 00                	push   $0x0
    3e4c:	e8 59 0a 00 00       	call   48aa <sbrk>
    3e51:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    3e57:	83 c4 10             	add    $0x10,%esp
    3e5a:	39 d0                	cmp    %edx,%eax
    3e5c:	0f 85 3b 02 00 00    	jne    409d <sbrktest+0x38d>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    3e62:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    3e69:	0f 84 16 02 00 00    	je     4085 <sbrktest+0x375>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    3e6f:	83 ec 0c             	sub    $0xc,%esp
    3e72:	6a 00                	push   $0x0
    3e74:	e8 31 0a 00 00       	call   48aa <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    3e79:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    3e80:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    3e82:	e8 23 0a 00 00       	call   48aa <sbrk>
    3e87:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    3e8a:	29 c1                	sub    %eax,%ecx
    3e8c:	89 0c 24             	mov    %ecx,(%esp)
    3e8f:	e8 16 0a 00 00       	call   48aa <sbrk>
  if(c != a){
    3e94:	83 c4 10             	add    $0x10,%esp
    3e97:	39 c3                	cmp    %eax,%ebx
    3e99:	0f 85 cf 01 00 00    	jne    406e <sbrktest+0x35e>
    3e9f:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    3ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    3ea8:	e8 f5 09 00 00       	call   48a2 <getpid>
    3ead:	89 c7                	mov    %eax,%edi
    pid = fork();
    3eaf:	e8 66 09 00 00       	call   481a <fork>
    if(pid < 0){
    3eb4:	85 c0                	test   %eax,%eax
    3eb6:	0f 88 9a 01 00 00    	js     4056 <sbrktest+0x346>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    3ebc:	0f 84 72 01 00 00    	je     4034 <sbrktest+0x324>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3ec2:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    3ec8:	e8 5d 09 00 00       	call   482a <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3ecd:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    3ed3:	75 d3                	jne    3ea8 <sbrktest+0x198>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    3ed5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    3ed8:	83 ec 0c             	sub    $0xc,%esp
    3edb:	50                   	push   %eax
    3edc:	e8 51 09 00 00       	call   4832 <pipe>
    3ee1:	83 c4 10             	add    $0x10,%esp
    3ee4:	85 c0                	test   %eax,%eax
    3ee6:	0f 85 34 01 00 00    	jne    4020 <sbrktest+0x310>
    3eec:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    3eef:	8d 7d e8             	lea    -0x18(%ebp),%edi
    3ef2:	89 de                	mov    %ebx,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    3ef4:	e8 21 09 00 00       	call   481a <fork>
    3ef9:	85 c0                	test   %eax,%eax
    3efb:	89 06                	mov    %eax,(%esi)
    3efd:	0f 84 a1 00 00 00    	je     3fa4 <sbrktest+0x294>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    3f03:	83 f8 ff             	cmp    $0xffffffff,%eax
    3f06:	74 14                	je     3f1c <sbrktest+0x20c>
      read(fds[0], &scratch, 1);
    3f08:	8d 45 b7             	lea    -0x49(%ebp),%eax
    3f0b:	83 ec 04             	sub    $0x4,%esp
    3f0e:	6a 01                	push   $0x1
    3f10:	50                   	push   %eax
    3f11:	ff 75 b8             	pushl  -0x48(%ebp)
    3f14:	e8 21 09 00 00       	call   483a <read>
    3f19:	83 c4 10             	add    $0x10,%esp
    3f1c:	83 c6 04             	add    $0x4,%esi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3f1f:	39 f7                	cmp    %esi,%edi
    3f21:	75 d1                	jne    3ef4 <sbrktest+0x1e4>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3f23:	83 ec 0c             	sub    $0xc,%esp
    3f26:	68 00 10 00 00       	push   $0x1000
    3f2b:	e8 7a 09 00 00       	call   48aa <sbrk>
    3f30:	83 c4 10             	add    $0x10,%esp
    3f33:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    3f35:	8b 03                	mov    (%ebx),%eax
    3f37:	83 f8 ff             	cmp    $0xffffffff,%eax
    3f3a:	74 11                	je     3f4d <sbrktest+0x23d>
      continue;
    kill(pids[i]);
    3f3c:	83 ec 0c             	sub    $0xc,%esp
    3f3f:	50                   	push   %eax
    3f40:	e8 0d 09 00 00       	call   4852 <kill>
    wait();
    3f45:	e8 e0 08 00 00       	call   482a <wait>
    3f4a:	83 c4 10             	add    $0x10,%esp
    3f4d:	83 c3 04             	add    $0x4,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3f50:	39 fb                	cmp    %edi,%ebx
    3f52:	75 e1                	jne    3f35 <sbrktest+0x225>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    3f54:	83 fe ff             	cmp    $0xffffffff,%esi
    3f57:	0f 84 ab 00 00 00    	je     4008 <sbrktest+0x2f8>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    3f5d:	83 ec 0c             	sub    $0xc,%esp
    3f60:	6a 00                	push   $0x0
    3f62:	e8 43 09 00 00       	call   48aa <sbrk>
    3f67:	83 c4 10             	add    $0x10,%esp
    3f6a:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3f6d:	73 1a                	jae    3f89 <sbrktest+0x279>
    sbrk(-(sbrk(0) - oldbrk));
    3f6f:	83 ec 0c             	sub    $0xc,%esp
    3f72:	6a 00                	push   $0x0
    3f74:	e8 31 09 00 00       	call   48aa <sbrk>
    3f79:	8b 75 a4             	mov    -0x5c(%ebp),%esi
    3f7c:	29 c6                	sub    %eax,%esi
    3f7e:	89 34 24             	mov    %esi,(%esp)
    3f81:	e8 24 09 00 00       	call   48aa <sbrk>
    3f86:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    3f89:	83 ec 08             	sub    $0x8,%esp
    3f8c:	68 38 5b 00 00       	push   $0x5b38
    3f91:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    3f97:	e8 e4 09 00 00       	call   4980 <printf>
}
    3f9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3f9f:	5b                   	pop    %ebx
    3fa0:	5e                   	pop    %esi
    3fa1:	5f                   	pop    %edi
    3fa2:	5d                   	pop    %ebp
    3fa3:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3fa4:	83 ec 0c             	sub    $0xc,%esp
    3fa7:	6a 00                	push   $0x0
    3fa9:	e8 fc 08 00 00       	call   48aa <sbrk>
    3fae:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3fb3:	29 c2                	sub    %eax,%edx
    3fb5:	89 14 24             	mov    %edx,(%esp)
    3fb8:	e8 ed 08 00 00       	call   48aa <sbrk>
      write(fds[1], "x", 1);
    3fbd:	83 c4 0c             	add    $0xc,%esp
    3fc0:	6a 01                	push   $0x1
    3fc2:	68 f9 55 00 00       	push   $0x55f9
    3fc7:	ff 75 bc             	pushl  -0x44(%ebp)
    3fca:	e8 73 08 00 00       	call   4842 <write>
    3fcf:	83 c4 10             	add    $0x10,%esp
    3fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      // sit around until killed
      for(;;) sleep(1000);
    3fd8:	83 ec 0c             	sub    $0xc,%esp
    3fdb:	68 e8 03 00 00       	push   $0x3e8
    3fe0:	e8 cd 08 00 00       	call   48b2 <sleep>
    3fe5:	83 c4 10             	add    $0x10,%esp
    3fe8:	eb ee                	jmp    3fd8 <sbrktest+0x2c8>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3fea:	83 ec 0c             	sub    $0xc,%esp
    3fed:	50                   	push   %eax
    3fee:	53                   	push   %ebx
    3fef:	57                   	push   %edi
    3ff0:	68 9b 5a 00 00       	push   $0x5a9b
    3ff5:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    3ffb:	e8 80 09 00 00       	call   4980 <printf>
      exit();
    4000:	83 c4 20             	add    $0x20,%esp
    4003:	e8 1a 08 00 00       	call   4822 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    4008:	83 ec 08             	sub    $0x8,%esp
    400b:	68 1d 5b 00 00       	push   $0x5b1d
    4010:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4016:	e8 65 09 00 00       	call   4980 <printf>
    exit();
    401b:	e8 02 08 00 00       	call   4822 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    4020:	83 ec 08             	sub    $0x8,%esp
    4023:	68 d9 4f 00 00       	push   $0x4fd9
    4028:	6a 01                	push   $0x1
    402a:	e8 51 09 00 00       	call   4980 <printf>
    exit();
    402f:	e8 ee 07 00 00       	call   4822 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    4034:	0f be 03             	movsbl (%ebx),%eax
    4037:	50                   	push   %eax
    4038:	53                   	push   %ebx
    4039:	68 04 5b 00 00       	push   $0x5b04
    403e:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4044:	e8 37 09 00 00       	call   4980 <printf>
      kill(ppid);
    4049:	89 3c 24             	mov    %edi,(%esp)
    404c:	e8 01 08 00 00       	call   4852 <kill>
      exit();
    4051:	e8 cc 07 00 00       	call   4822 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    4056:	83 ec 08             	sub    $0x8,%esp
    4059:	68 e1 5b 00 00       	push   $0x5be1
    405e:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4064:	e8 17 09 00 00       	call   4980 <printf>
      exit();
    4069:	e8 b4 07 00 00       	call   4822 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    406e:	50                   	push   %eax
    406f:	53                   	push   %ebx
    4070:	68 c0 62 00 00       	push   $0x62c0
    4075:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    407b:	e8 00 09 00 00       	call   4980 <printf>
    exit();
    4080:	e8 9d 07 00 00       	call   4822 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    4085:	83 ec 08             	sub    $0x8,%esp
    4088:	68 90 62 00 00       	push   $0x6290
    408d:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4093:	e8 e8 08 00 00       	call   4980 <printf>
    exit();
    4098:	e8 85 07 00 00       	call   4822 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    409d:	57                   	push   %edi
    409e:	53                   	push   %ebx
    409f:	68 68 62 00 00       	push   $0x6268
    40a4:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    40aa:	e8 d1 08 00 00       	call   4980 <printf>
    exit();
    40af:	e8 6e 07 00 00       	call   4822 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    40b4:	50                   	push   %eax
    40b5:	53                   	push   %ebx
    40b6:	68 30 62 00 00       	push   $0x6230
    40bb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    40c1:	e8 ba 08 00 00       	call   4980 <printf>
    exit();
    40c6:	e8 57 07 00 00       	call   4822 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    40cb:	83 ec 08             	sub    $0x8,%esp
    40ce:	68 e9 5a 00 00       	push   $0x5ae9
    40d3:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    40d9:	e8 a2 08 00 00       	call   4980 <printf>
    exit();
    40de:	e8 3f 07 00 00       	call   4822 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    40e3:	83 ec 08             	sub    $0x8,%esp
    40e6:	68 f0 61 00 00       	push   $0x61f0
    40eb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    40f1:	e8 8a 08 00 00       	call   4980 <printf>
    exit();
    40f6:	e8 27 07 00 00       	call   4822 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    exit();
    40fb:	e8 22 07 00 00       	call   4822 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    4100:	83 ec 08             	sub    $0x8,%esp
    4103:	68 cd 5a 00 00       	push   $0x5acd
    4108:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    410e:	e8 6d 08 00 00       	call   4980 <printf>
    exit();
    4113:	e8 0a 07 00 00       	call   4822 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    4118:	83 ec 08             	sub    $0x8,%esp
    411b:	68 b6 5a 00 00       	push   $0x5ab6
    4120:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4126:	e8 55 08 00 00       	call   4980 <printf>
    exit();
    412b:	e8 f2 06 00 00       	call   4822 <exit>

00004130 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    4130:	55                   	push   %ebp
    4131:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    4133:	5d                   	pop    %ebp
    4134:	c3                   	ret    
    4135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004140 <validatetest>:

void
validatetest(void)
{
    4140:	55                   	push   %ebp
    4141:	89 e5                	mov    %esp,%ebp
    4143:	56                   	push   %esi
    4144:	53                   	push   %ebx
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    4145:	31 db                	xor    %ebx,%ebx
validatetest(void)
{
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    4147:	83 ec 08             	sub    $0x8,%esp
    414a:	68 46 5b 00 00       	push   $0x5b46
    414f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4155:	e8 26 08 00 00       	call   4980 <printf>
    415a:	83 c4 10             	add    $0x10,%esp
    415d:	8d 76 00             	lea    0x0(%esi),%esi
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    4160:	e8 b5 06 00 00       	call   481a <fork>
    4165:	85 c0                	test   %eax,%eax
    4167:	89 c6                	mov    %eax,%esi
    4169:	74 63                	je     41ce <validatetest+0x8e>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    416b:	83 ec 0c             	sub    $0xc,%esp
    416e:	6a 00                	push   $0x0
    4170:	e8 3d 07 00 00       	call   48b2 <sleep>
    sleep(0);
    4175:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    417c:	e8 31 07 00 00       	call   48b2 <sleep>
    kill(pid);
    4181:	89 34 24             	mov    %esi,(%esp)
    4184:	e8 c9 06 00 00       	call   4852 <kill>
    wait();
    4189:	e8 9c 06 00 00       	call   482a <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    418e:	58                   	pop    %eax
    418f:	5a                   	pop    %edx
    4190:	53                   	push   %ebx
    4191:	68 55 5b 00 00       	push   $0x5b55
    4196:	e8 e7 06 00 00       	call   4882 <link>
    419b:	83 c4 10             	add    $0x10,%esp
    419e:	83 f8 ff             	cmp    $0xffffffff,%eax
    41a1:	75 30                	jne    41d3 <validatetest+0x93>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    41a3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    41a9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    41af:	75 af                	jne    4160 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    41b1:	83 ec 08             	sub    $0x8,%esp
    41b4:	68 79 5b 00 00       	push   $0x5b79
    41b9:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    41bf:	e8 bc 07 00 00       	call   4980 <printf>
}
    41c4:	83 c4 10             	add    $0x10,%esp
    41c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    41ca:	5b                   	pop    %ebx
    41cb:	5e                   	pop    %esi
    41cc:	5d                   	pop    %ebp
    41cd:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    41ce:	e8 4f 06 00 00       	call   4822 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    41d3:	83 ec 08             	sub    $0x8,%esp
    41d6:	68 60 5b 00 00       	push   $0x5b60
    41db:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    41e1:	e8 9a 07 00 00       	call   4980 <printf>
      exit();
    41e6:	e8 37 06 00 00       	call   4822 <exit>
    41eb:	90                   	nop
    41ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000041f0 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    41f0:	55                   	push   %ebp
    41f1:	89 e5                	mov    %esp,%ebp
    41f3:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    41f6:	68 86 5b 00 00       	push   $0x5b86
    41fb:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4201:	e8 7a 07 00 00       	call   4980 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    4206:	83 c4 10             	add    $0x10,%esp
    4209:	80 3d a0 6d 00 00 00 	cmpb   $0x0,0x6da0
    4210:	75 35                	jne    4247 <bsstest+0x57>
    4212:	b8 a1 6d 00 00       	mov    $0x6da1,%eax
    4217:	89 f6                	mov    %esi,%esi
    4219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    4220:	80 38 00             	cmpb   $0x0,(%eax)
    4223:	75 22                	jne    4247 <bsstest+0x57>
    4225:	83 c0 01             	add    $0x1,%eax
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    4228:	3d b0 94 00 00       	cmp    $0x94b0,%eax
    422d:	75 f1                	jne    4220 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    422f:	83 ec 08             	sub    $0x8,%esp
    4232:	68 a1 5b 00 00       	push   $0x5ba1
    4237:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    423d:	e8 3e 07 00 00       	call   4980 <printf>
}
    4242:	83 c4 10             	add    $0x10,%esp
    4245:	c9                   	leave  
    4246:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    4247:	83 ec 08             	sub    $0x8,%esp
    424a:	68 90 5b 00 00       	push   $0x5b90
    424f:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4255:	e8 26 07 00 00       	call   4980 <printf>
      exit();
    425a:	e8 c3 05 00 00       	call   4822 <exit>
    425f:	90                   	nop

00004260 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    4260:	55                   	push   %ebp
    4261:	89 e5                	mov    %esp,%ebp
    4263:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    4266:	68 ae 5b 00 00       	push   $0x5bae
    426b:	e8 02 06 00 00       	call   4872 <unlink>
  pid = fork();
    4270:	e8 a5 05 00 00       	call   481a <fork>
  if(pid == 0){
    4275:	83 c4 10             	add    $0x10,%esp
    4278:	85 c0                	test   %eax,%eax
    427a:	74 3f                	je     42bb <bigargtest+0x5b>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    427c:	0f 88 c2 00 00 00    	js     4344 <bigargtest+0xe4>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    4282:	e8 a3 05 00 00       	call   482a <wait>
  fd = open("bigarg-ok", 0);
    4287:	83 ec 08             	sub    $0x8,%esp
    428a:	6a 00                	push   $0x0
    428c:	68 ae 5b 00 00       	push   $0x5bae
    4291:	e8 cc 05 00 00       	call   4862 <open>
  if(fd < 0){
    4296:	83 c4 10             	add    $0x10,%esp
    4299:	85 c0                	test   %eax,%eax
    429b:	0f 88 8c 00 00 00    	js     432d <bigargtest+0xcd>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    42a1:	83 ec 0c             	sub    $0xc,%esp
    42a4:	50                   	push   %eax
    42a5:	e8 a0 05 00 00       	call   484a <close>
  unlink("bigarg-ok");
    42aa:	c7 04 24 ae 5b 00 00 	movl   $0x5bae,(%esp)
    42b1:	e8 bc 05 00 00       	call   4872 <unlink>
}
    42b6:	83 c4 10             	add    $0x10,%esp
    42b9:	c9                   	leave  
    42ba:	c3                   	ret    
    42bb:	b8 00 6d 00 00       	mov    $0x6d00,%eax
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    42c0:	c7 00 e4 62 00 00    	movl   $0x62e4,(%eax)
    42c6:	83 c0 04             	add    $0x4,%eax
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    42c9:	3d 7c 6d 00 00       	cmp    $0x6d7c,%eax
    42ce:	75 f0                	jne    42c0 <bigargtest+0x60>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    42d0:	51                   	push   %ecx
    42d1:	51                   	push   %ecx
    42d2:	68 b8 5b 00 00       	push   $0x5bb8
    42d7:	ff 35 e8 6c 00 00    	pushl  0x6ce8
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    42dd:	c7 05 7c 6d 00 00 00 	movl   $0x0,0x6d7c
    42e4:	00 00 00 
    printf(stdout, "bigarg test\n");
    42e7:	e8 94 06 00 00       	call   4980 <printf>
    exec("echo", args);
    42ec:	58                   	pop    %eax
    42ed:	5a                   	pop    %edx
    42ee:	68 00 6d 00 00       	push   $0x6d00
    42f3:	68 85 4d 00 00       	push   $0x4d85
    42f8:	e8 5d 05 00 00       	call   485a <exec>
    printf(stdout, "bigarg test ok\n");
    42fd:	59                   	pop    %ecx
    42fe:	58                   	pop    %eax
    42ff:	68 c5 5b 00 00       	push   $0x5bc5
    4304:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    430a:	e8 71 06 00 00       	call   4980 <printf>
    fd = open("bigarg-ok", O_CREATE);
    430f:	58                   	pop    %eax
    4310:	5a                   	pop    %edx
    4311:	68 00 02 00 00       	push   $0x200
    4316:	68 ae 5b 00 00       	push   $0x5bae
    431b:	e8 42 05 00 00       	call   4862 <open>
    close(fd);
    4320:	89 04 24             	mov    %eax,(%esp)
    4323:	e8 22 05 00 00       	call   484a <close>
    exit();
    4328:	e8 f5 04 00 00       	call   4822 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    432d:	50                   	push   %eax
    432e:	50                   	push   %eax
    432f:	68 ee 5b 00 00       	push   $0x5bee
    4334:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    433a:	e8 41 06 00 00       	call   4980 <printf>
    exit();
    433f:	e8 de 04 00 00       	call   4822 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    4344:	52                   	push   %edx
    4345:	52                   	push   %edx
    4346:	68 d5 5b 00 00       	push   $0x5bd5
    434b:	ff 35 e8 6c 00 00    	pushl  0x6ce8
    4351:	e8 2a 06 00 00       	call   4980 <printf>
    exit();
    4356:	e8 c7 04 00 00       	call   4822 <exit>
    435b:	90                   	nop
    435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00004360 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    4360:	55                   	push   %ebp
    4361:	89 e5                	mov    %esp,%ebp
    4363:	57                   	push   %edi
    4364:	56                   	push   %esi
    4365:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    4366:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    4368:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    436b:	68 03 5c 00 00       	push   $0x5c03
    4370:	6a 01                	push   $0x1
    4372:	e8 09 06 00 00       	call   4980 <printf>
    4377:	83 c4 10             	add    $0x10,%esp
    437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    4380:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    4385:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    4387:	89 d9                	mov    %ebx,%ecx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    4389:	f7 eb                	imul   %ebx
    438b:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    438e:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    4390:	83 ec 04             	sub    $0x4,%esp

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    4393:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    4397:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    439b:	c1 fa 06             	sar    $0x6,%edx
    439e:	29 f2                	sub    %esi,%edx
    43a0:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    43a3:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    43a9:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    43ac:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    43b1:	29 d1                	sub    %edx,%ecx
    43b3:	f7 e9                	imul   %ecx
    43b5:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    43b8:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    43bd:	c1 fa 05             	sar    $0x5,%edx
    43c0:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    43c2:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    43c7:	83 c2 30             	add    $0x30,%edx
    43ca:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    43cd:	f7 eb                	imul   %ebx
    43cf:	c1 fa 05             	sar    $0x5,%edx
    43d2:	29 f2                	sub    %esi,%edx
    43d4:	6b d2 64             	imul   $0x64,%edx,%edx
    43d7:	29 d7                	sub    %edx,%edi
    43d9:	89 f8                	mov    %edi,%eax
    43db:	c1 ff 1f             	sar    $0x1f,%edi
    43de:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    43e0:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    43e2:	c1 fa 02             	sar    $0x2,%edx
    43e5:	29 fa                	sub    %edi,%edx
    43e7:	83 c2 30             	add    $0x30,%edx
    43ea:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    43ed:	f7 e9                	imul   %ecx
    43ef:	89 d9                	mov    %ebx,%ecx
    43f1:	c1 fa 02             	sar    $0x2,%edx
    43f4:	29 f2                	sub    %esi,%edx
    43f6:	8d 04 92             	lea    (%edx,%edx,4),%eax
    43f9:	01 c0                	add    %eax,%eax
    43fb:	29 c1                	sub    %eax,%ecx
    43fd:	89 c8                	mov    %ecx,%eax
    43ff:	83 c0 30             	add    $0x30,%eax
    4402:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    4405:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4408:	50                   	push   %eax
    4409:	68 10 5c 00 00       	push   $0x5c10
    440e:	6a 01                	push   $0x1
    4410:	e8 6b 05 00 00       	call   4980 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4415:	58                   	pop    %eax
    4416:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4419:	5a                   	pop    %edx
    441a:	68 02 02 00 00       	push   $0x202
    441f:	50                   	push   %eax
    4420:	e8 3d 04 00 00       	call   4862 <open>
    if(fd < 0){
    4425:	83 c4 10             	add    $0x10,%esp
    4428:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    442a:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    442c:	78 50                	js     447e <fsfull+0x11e>
    442e:	31 f6                	xor    %esi,%esi
    4430:	eb 08                	jmp    443a <fsfull+0xda>
    4432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    4438:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    443a:	83 ec 04             	sub    $0x4,%esp
    443d:	68 00 02 00 00       	push   $0x200
    4442:	68 c0 94 00 00       	push   $0x94c0
    4447:	57                   	push   %edi
    4448:	e8 f5 03 00 00       	call   4842 <write>
      if(cc < 512)
    444d:	83 c4 10             	add    $0x10,%esp
    4450:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    4455:	7f e1                	jg     4438 <fsfull+0xd8>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    4457:	83 ec 04             	sub    $0x4,%esp
    445a:	56                   	push   %esi
    445b:	68 2c 5c 00 00       	push   $0x5c2c
    4460:	6a 01                	push   $0x1
    4462:	e8 19 05 00 00       	call   4980 <printf>
    close(fd);
    4467:	89 3c 24             	mov    %edi,(%esp)
    446a:	e8 db 03 00 00       	call   484a <close>
    if(total == 0)
    446f:	83 c4 10             	add    $0x10,%esp
    4472:	85 f6                	test   %esi,%esi
    4474:	74 22                	je     4498 <fsfull+0x138>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    4476:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    4479:	e9 02 ff ff ff       	jmp    4380 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    447e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4481:	83 ec 04             	sub    $0x4,%esp
    4484:	50                   	push   %eax
    4485:	68 1c 5c 00 00       	push   $0x5c1c
    448a:	6a 01                	push   $0x1
    448c:	e8 ef 04 00 00       	call   4980 <printf>
      break;
    4491:	83 c4 10             	add    $0x10,%esp
    4494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    4498:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    449d:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    449f:	89 d9                	mov    %ebx,%ecx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    44a1:	f7 eb                	imul   %ebx
    44a3:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    44a6:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    unlink(name);
    44a8:	83 ec 0c             	sub    $0xc,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    44ab:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    44af:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    44b3:	c1 fa 06             	sar    $0x6,%edx
    44b6:	29 f2                	sub    %esi,%edx
    44b8:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    44bb:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    44c1:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    44c4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    44c9:	29 d1                	sub    %edx,%ecx
    44cb:	f7 e9                	imul   %ecx
    44cd:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    44d0:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    44d5:	c1 fa 05             	sar    $0x5,%edx
    44d8:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    44da:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    44df:	83 c2 30             	add    $0x30,%edx
    44e2:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    44e5:	f7 eb                	imul   %ebx
    44e7:	c1 fa 05             	sar    $0x5,%edx
    44ea:	29 f2                	sub    %esi,%edx
    44ec:	6b d2 64             	imul   $0x64,%edx,%edx
    44ef:	29 d7                	sub    %edx,%edi
    44f1:	89 f8                	mov    %edi,%eax
    44f3:	c1 ff 1f             	sar    $0x1f,%edi
    44f6:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    44f8:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    44fa:	c1 fa 02             	sar    $0x2,%edx
    44fd:	29 fa                	sub    %edi,%edx
    44ff:	83 c2 30             	add    $0x30,%edx
    4502:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    4505:	f7 e9                	imul   %ecx
    4507:	89 d9                	mov    %ebx,%ecx
    name[5] = '\0';
    unlink(name);
    nfiles--;
    4509:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    450c:	c1 fa 02             	sar    $0x2,%edx
    450f:	29 f2                	sub    %esi,%edx
    4511:	8d 04 92             	lea    (%edx,%edx,4),%eax
    4514:	01 c0                	add    %eax,%eax
    4516:	29 c1                	sub    %eax,%ecx
    4518:	89 c8                	mov    %ecx,%eax
    451a:	83 c0 30             	add    $0x30,%eax
    451d:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    4520:	8d 45 a8             	lea    -0x58(%ebp),%eax
    4523:	50                   	push   %eax
    4524:	e8 49 03 00 00       	call   4872 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    4529:	83 c4 10             	add    $0x10,%esp
    452c:	83 fb ff             	cmp    $0xffffffff,%ebx
    452f:	0f 85 63 ff ff ff    	jne    4498 <fsfull+0x138>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    4535:	83 ec 08             	sub    $0x8,%esp
    4538:	68 3c 5c 00 00       	push   $0x5c3c
    453d:	6a 01                	push   $0x1
    453f:	e8 3c 04 00 00       	call   4980 <printf>
}
    4544:	83 c4 10             	add    $0x10,%esp
    4547:	8d 65 f4             	lea    -0xc(%ebp),%esp
    454a:	5b                   	pop    %ebx
    454b:	5e                   	pop    %esi
    454c:	5f                   	pop    %edi
    454d:	5d                   	pop    %ebp
    454e:	c3                   	ret    
    454f:	90                   	nop

00004550 <uio>:

void
uio()
{
    4550:	55                   	push   %ebp
    4551:	89 e5                	mov    %esp,%ebp
    4553:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    4556:	68 52 5c 00 00       	push   $0x5c52
    455b:	6a 01                	push   $0x1
    455d:	e8 1e 04 00 00       	call   4980 <printf>
  pid = fork();
    4562:	e8 b3 02 00 00       	call   481a <fork>
  if(pid == 0){
    4567:	83 c4 10             	add    $0x10,%esp
    456a:	85 c0                	test   %eax,%eax
    456c:	74 1b                	je     4589 <uio+0x39>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    456e:	78 3d                	js     45ad <uio+0x5d>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    4570:	e8 b5 02 00 00       	call   482a <wait>
  printf(1, "uio test done\n");
    4575:	83 ec 08             	sub    $0x8,%esp
    4578:	68 5c 5c 00 00       	push   $0x5c5c
    457d:	6a 01                	push   $0x1
    457f:	e8 fc 03 00 00       	call   4980 <printf>
}
    4584:	83 c4 10             	add    $0x10,%esp
    4587:	c9                   	leave  
    4588:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    4589:	ba 70 00 00 00       	mov    $0x70,%edx
    458e:	b8 09 00 00 00       	mov    $0x9,%eax
    4593:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    4594:	ba 71 00 00 00       	mov    $0x71,%edx
    4599:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    459a:	52                   	push   %edx
    459b:	52                   	push   %edx
    459c:	68 c4 63 00 00       	push   $0x63c4
    45a1:	6a 01                	push   $0x1
    45a3:	e8 d8 03 00 00       	call   4980 <printf>
    exit();
    45a8:	e8 75 02 00 00       	call   4822 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    45ad:	50                   	push   %eax
    45ae:	50                   	push   %eax
    45af:	68 e1 5b 00 00       	push   $0x5be1
    45b4:	6a 01                	push   $0x1
    45b6:	e8 c5 03 00 00       	call   4980 <printf>
    exit();
    45bb:	e8 62 02 00 00       	call   4822 <exit>

000045c0 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    45c0:	69 05 e4 6c 00 00 0d 	imul   $0x19660d,0x6ce4,%eax
    45c7:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    45ca:	55                   	push   %ebp
    45cb:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    45cd:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    45ce:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    45d3:	a3 e4 6c 00 00       	mov    %eax,0x6ce4
  return randstate;
}
    45d8:	c3                   	ret    
    45d9:	66 90                	xchg   %ax,%ax
    45db:	66 90                	xchg   %ax,%ax
    45dd:	66 90                	xchg   %ax,%ax
    45df:	90                   	nop

000045e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    45e0:	55                   	push   %ebp
    45e1:	89 e5                	mov    %esp,%ebp
    45e3:	53                   	push   %ebx
    45e4:	8b 45 08             	mov    0x8(%ebp),%eax
    45e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    45ea:	89 c2                	mov    %eax,%edx
    45ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    45f0:	83 c1 01             	add    $0x1,%ecx
    45f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    45f7:	83 c2 01             	add    $0x1,%edx
    45fa:	84 db                	test   %bl,%bl
    45fc:	88 5a ff             	mov    %bl,-0x1(%edx)
    45ff:	75 ef                	jne    45f0 <strcpy+0x10>
    ;
  return os;
}
    4601:	5b                   	pop    %ebx
    4602:	5d                   	pop    %ebp
    4603:	c3                   	ret    
    4604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    460a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00004610 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4610:	55                   	push   %ebp
    4611:	89 e5                	mov    %esp,%ebp
    4613:	56                   	push   %esi
    4614:	53                   	push   %ebx
    4615:	8b 55 08             	mov    0x8(%ebp),%edx
    4618:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    461b:	0f b6 02             	movzbl (%edx),%eax
    461e:	0f b6 19             	movzbl (%ecx),%ebx
    4621:	84 c0                	test   %al,%al
    4623:	75 1e                	jne    4643 <strcmp+0x33>
    4625:	eb 29                	jmp    4650 <strcmp+0x40>
    4627:	89 f6                	mov    %esi,%esi
    4629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    4630:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4633:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    4636:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4639:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    463d:	84 c0                	test   %al,%al
    463f:	74 0f                	je     4650 <strcmp+0x40>
    4641:	89 f1                	mov    %esi,%ecx
    4643:	38 d8                	cmp    %bl,%al
    4645:	74 e9                	je     4630 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    4647:	29 d8                	sub    %ebx,%eax
}
    4649:	5b                   	pop    %ebx
    464a:	5e                   	pop    %esi
    464b:	5d                   	pop    %ebp
    464c:	c3                   	ret    
    464d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4650:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    4652:	29 d8                	sub    %ebx,%eax
}
    4654:	5b                   	pop    %ebx
    4655:	5e                   	pop    %esi
    4656:	5d                   	pop    %ebp
    4657:	c3                   	ret    
    4658:	90                   	nop
    4659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004660 <strlen>:

uint
strlen(char *s)
{
    4660:	55                   	push   %ebp
    4661:	89 e5                	mov    %esp,%ebp
    4663:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    4666:	80 39 00             	cmpb   $0x0,(%ecx)
    4669:	74 12                	je     467d <strlen+0x1d>
    466b:	31 d2                	xor    %edx,%edx
    466d:	8d 76 00             	lea    0x0(%esi),%esi
    4670:	83 c2 01             	add    $0x1,%edx
    4673:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    4677:	89 d0                	mov    %edx,%eax
    4679:	75 f5                	jne    4670 <strlen+0x10>
    ;
  return n;
}
    467b:	5d                   	pop    %ebp
    467c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    467d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    467f:	5d                   	pop    %ebp
    4680:	c3                   	ret    
    4681:	eb 0d                	jmp    4690 <memset>
    4683:	90                   	nop
    4684:	90                   	nop
    4685:	90                   	nop
    4686:	90                   	nop
    4687:	90                   	nop
    4688:	90                   	nop
    4689:	90                   	nop
    468a:	90                   	nop
    468b:	90                   	nop
    468c:	90                   	nop
    468d:	90                   	nop
    468e:	90                   	nop
    468f:	90                   	nop

00004690 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4690:	55                   	push   %ebp
    4691:	89 e5                	mov    %esp,%ebp
    4693:	57                   	push   %edi
    4694:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    4697:	8b 4d 10             	mov    0x10(%ebp),%ecx
    469a:	8b 45 0c             	mov    0xc(%ebp),%eax
    469d:	89 d7                	mov    %edx,%edi
    469f:	fc                   	cld    
    46a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    46a2:	89 d0                	mov    %edx,%eax
    46a4:	5f                   	pop    %edi
    46a5:	5d                   	pop    %ebp
    46a6:	c3                   	ret    
    46a7:	89 f6                	mov    %esi,%esi
    46a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000046b0 <strchr>:

char*
strchr(const char *s, char c)
{
    46b0:	55                   	push   %ebp
    46b1:	89 e5                	mov    %esp,%ebp
    46b3:	53                   	push   %ebx
    46b4:	8b 45 08             	mov    0x8(%ebp),%eax
    46b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    46ba:	0f b6 10             	movzbl (%eax),%edx
    46bd:	84 d2                	test   %dl,%dl
    46bf:	74 1d                	je     46de <strchr+0x2e>
    if(*s == c)
    46c1:	38 d3                	cmp    %dl,%bl
    46c3:	89 d9                	mov    %ebx,%ecx
    46c5:	75 0d                	jne    46d4 <strchr+0x24>
    46c7:	eb 17                	jmp    46e0 <strchr+0x30>
    46c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    46d0:	38 ca                	cmp    %cl,%dl
    46d2:	74 0c                	je     46e0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    46d4:	83 c0 01             	add    $0x1,%eax
    46d7:	0f b6 10             	movzbl (%eax),%edx
    46da:	84 d2                	test   %dl,%dl
    46dc:	75 f2                	jne    46d0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    46de:	31 c0                	xor    %eax,%eax
}
    46e0:	5b                   	pop    %ebx
    46e1:	5d                   	pop    %ebp
    46e2:	c3                   	ret    
    46e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    46e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000046f0 <gets>:

char*
gets(char *buf, int max)
{
    46f0:	55                   	push   %ebp
    46f1:	89 e5                	mov    %esp,%ebp
    46f3:	57                   	push   %edi
    46f4:	56                   	push   %esi
    46f5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    46f6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    46f8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    46fb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    46fe:	eb 29                	jmp    4729 <gets+0x39>
    cc = read(0, &c, 1);
    4700:	83 ec 04             	sub    $0x4,%esp
    4703:	6a 01                	push   $0x1
    4705:	57                   	push   %edi
    4706:	6a 00                	push   $0x0
    4708:	e8 2d 01 00 00       	call   483a <read>
    if(cc < 1)
    470d:	83 c4 10             	add    $0x10,%esp
    4710:	85 c0                	test   %eax,%eax
    4712:	7e 1d                	jle    4731 <gets+0x41>
      break;
    buf[i++] = c;
    4714:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    4718:	8b 55 08             	mov    0x8(%ebp),%edx
    471b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    471d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    471f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    4723:	74 1b                	je     4740 <gets+0x50>
    4725:	3c 0d                	cmp    $0xd,%al
    4727:	74 17                	je     4740 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4729:	8d 5e 01             	lea    0x1(%esi),%ebx
    472c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    472f:	7c cf                	jl     4700 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    4731:	8b 45 08             	mov    0x8(%ebp),%eax
    4734:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    4738:	8d 65 f4             	lea    -0xc(%ebp),%esp
    473b:	5b                   	pop    %ebx
    473c:	5e                   	pop    %esi
    473d:	5f                   	pop    %edi
    473e:	5d                   	pop    %ebp
    473f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    4740:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4743:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    4745:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    4749:	8d 65 f4             	lea    -0xc(%ebp),%esp
    474c:	5b                   	pop    %ebx
    474d:	5e                   	pop    %esi
    474e:	5f                   	pop    %edi
    474f:	5d                   	pop    %ebp
    4750:	c3                   	ret    
    4751:	eb 0d                	jmp    4760 <stat>
    4753:	90                   	nop
    4754:	90                   	nop
    4755:	90                   	nop
    4756:	90                   	nop
    4757:	90                   	nop
    4758:	90                   	nop
    4759:	90                   	nop
    475a:	90                   	nop
    475b:	90                   	nop
    475c:	90                   	nop
    475d:	90                   	nop
    475e:	90                   	nop
    475f:	90                   	nop

00004760 <stat>:

int
stat(char *n, struct stat *st)
{
    4760:	55                   	push   %ebp
    4761:	89 e5                	mov    %esp,%ebp
    4763:	56                   	push   %esi
    4764:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4765:	83 ec 08             	sub    $0x8,%esp
    4768:	6a 00                	push   $0x0
    476a:	ff 75 08             	pushl  0x8(%ebp)
    476d:	e8 f0 00 00 00       	call   4862 <open>
  if(fd < 0)
    4772:	83 c4 10             	add    $0x10,%esp
    4775:	85 c0                	test   %eax,%eax
    4777:	78 27                	js     47a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    4779:	83 ec 08             	sub    $0x8,%esp
    477c:	ff 75 0c             	pushl  0xc(%ebp)
    477f:	89 c3                	mov    %eax,%ebx
    4781:	50                   	push   %eax
    4782:	e8 f3 00 00 00       	call   487a <fstat>
    4787:	89 c6                	mov    %eax,%esi
  close(fd);
    4789:	89 1c 24             	mov    %ebx,(%esp)
    478c:	e8 b9 00 00 00       	call   484a <close>
  return r;
    4791:	83 c4 10             	add    $0x10,%esp
    4794:	89 f0                	mov    %esi,%eax
}
    4796:	8d 65 f8             	lea    -0x8(%ebp),%esp
    4799:	5b                   	pop    %ebx
    479a:	5e                   	pop    %esi
    479b:	5d                   	pop    %ebp
    479c:	c3                   	ret    
    479d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    47a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    47a5:	eb ef                	jmp    4796 <stat+0x36>
    47a7:	89 f6                	mov    %esi,%esi
    47a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000047b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    47b0:	55                   	push   %ebp
    47b1:	89 e5                	mov    %esp,%ebp
    47b3:	53                   	push   %ebx
    47b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    47b7:	0f be 11             	movsbl (%ecx),%edx
    47ba:	8d 42 d0             	lea    -0x30(%edx),%eax
    47bd:	3c 09                	cmp    $0x9,%al
    47bf:	b8 00 00 00 00       	mov    $0x0,%eax
    47c4:	77 1f                	ja     47e5 <atoi+0x35>
    47c6:	8d 76 00             	lea    0x0(%esi),%esi
    47c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    47d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    47d3:	83 c1 01             	add    $0x1,%ecx
    47d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    47da:	0f be 11             	movsbl (%ecx),%edx
    47dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    47e0:	80 fb 09             	cmp    $0x9,%bl
    47e3:	76 eb                	jbe    47d0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    47e5:	5b                   	pop    %ebx
    47e6:	5d                   	pop    %ebp
    47e7:	c3                   	ret    
    47e8:	90                   	nop
    47e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000047f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    47f0:	55                   	push   %ebp
    47f1:	89 e5                	mov    %esp,%ebp
    47f3:	56                   	push   %esi
    47f4:	53                   	push   %ebx
    47f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    47f8:	8b 45 08             	mov    0x8(%ebp),%eax
    47fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    47fe:	85 db                	test   %ebx,%ebx
    4800:	7e 14                	jle    4816 <memmove+0x26>
    4802:	31 d2                	xor    %edx,%edx
    4804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    4808:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    480c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    480f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4812:	39 da                	cmp    %ebx,%edx
    4814:	75 f2                	jne    4808 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    4816:	5b                   	pop    %ebx
    4817:	5e                   	pop    %esi
    4818:	5d                   	pop    %ebp
    4819:	c3                   	ret    

0000481a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    481a:	b8 01 00 00 00       	mov    $0x1,%eax
    481f:	cd 40                	int    $0x40
    4821:	c3                   	ret    

00004822 <exit>:
SYSCALL(exit)
    4822:	b8 02 00 00 00       	mov    $0x2,%eax
    4827:	cd 40                	int    $0x40
    4829:	c3                   	ret    

0000482a <wait>:
SYSCALL(wait)
    482a:	b8 03 00 00 00       	mov    $0x3,%eax
    482f:	cd 40                	int    $0x40
    4831:	c3                   	ret    

00004832 <pipe>:
SYSCALL(pipe)
    4832:	b8 04 00 00 00       	mov    $0x4,%eax
    4837:	cd 40                	int    $0x40
    4839:	c3                   	ret    

0000483a <read>:
SYSCALL(read)
    483a:	b8 05 00 00 00       	mov    $0x5,%eax
    483f:	cd 40                	int    $0x40
    4841:	c3                   	ret    

00004842 <write>:
SYSCALL(write)
    4842:	b8 10 00 00 00       	mov    $0x10,%eax
    4847:	cd 40                	int    $0x40
    4849:	c3                   	ret    

0000484a <close>:
SYSCALL(close)
    484a:	b8 15 00 00 00       	mov    $0x15,%eax
    484f:	cd 40                	int    $0x40
    4851:	c3                   	ret    

00004852 <kill>:
SYSCALL(kill)
    4852:	b8 06 00 00 00       	mov    $0x6,%eax
    4857:	cd 40                	int    $0x40
    4859:	c3                   	ret    

0000485a <exec>:
SYSCALL(exec)
    485a:	b8 07 00 00 00       	mov    $0x7,%eax
    485f:	cd 40                	int    $0x40
    4861:	c3                   	ret    

00004862 <open>:
SYSCALL(open)
    4862:	b8 0f 00 00 00       	mov    $0xf,%eax
    4867:	cd 40                	int    $0x40
    4869:	c3                   	ret    

0000486a <mknod>:
SYSCALL(mknod)
    486a:	b8 11 00 00 00       	mov    $0x11,%eax
    486f:	cd 40                	int    $0x40
    4871:	c3                   	ret    

00004872 <unlink>:
SYSCALL(unlink)
    4872:	b8 12 00 00 00       	mov    $0x12,%eax
    4877:	cd 40                	int    $0x40
    4879:	c3                   	ret    

0000487a <fstat>:
SYSCALL(fstat)
    487a:	b8 08 00 00 00       	mov    $0x8,%eax
    487f:	cd 40                	int    $0x40
    4881:	c3                   	ret    

00004882 <link>:
SYSCALL(link)
    4882:	b8 13 00 00 00       	mov    $0x13,%eax
    4887:	cd 40                	int    $0x40
    4889:	c3                   	ret    

0000488a <mkdir>:
SYSCALL(mkdir)
    488a:	b8 14 00 00 00       	mov    $0x14,%eax
    488f:	cd 40                	int    $0x40
    4891:	c3                   	ret    

00004892 <chdir>:
SYSCALL(chdir)
    4892:	b8 09 00 00 00       	mov    $0x9,%eax
    4897:	cd 40                	int    $0x40
    4899:	c3                   	ret    

0000489a <dup>:
SYSCALL(dup)
    489a:	b8 0a 00 00 00       	mov    $0xa,%eax
    489f:	cd 40                	int    $0x40
    48a1:	c3                   	ret    

000048a2 <getpid>:
SYSCALL(getpid)
    48a2:	b8 0b 00 00 00       	mov    $0xb,%eax
    48a7:	cd 40                	int    $0x40
    48a9:	c3                   	ret    

000048aa <sbrk>:
SYSCALL(sbrk)
    48aa:	b8 0c 00 00 00       	mov    $0xc,%eax
    48af:	cd 40                	int    $0x40
    48b1:	c3                   	ret    

000048b2 <sleep>:
SYSCALL(sleep)
    48b2:	b8 0d 00 00 00       	mov    $0xd,%eax
    48b7:	cd 40                	int    $0x40
    48b9:	c3                   	ret    

000048ba <uptime>:
SYSCALL(uptime)
    48ba:	b8 0e 00 00 00       	mov    $0xe,%eax
    48bf:	cd 40                	int    $0x40
    48c1:	c3                   	ret    

000048c2 <getcount>:
SYSCALL(getcount) //added getcount here
    48c2:	b8 16 00 00 00       	mov    $0x16,%eax
    48c7:	cd 40                	int    $0x40
    48c9:	c3                   	ret    

000048ca <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    48ca:	b8 17 00 00 00       	mov    $0x17,%eax
    48cf:	cd 40                	int    $0x40
    48d1:	c3                   	ret    

000048d2 <increasepriority>:
SYSCALL(increasepriority)
    48d2:	b8 18 00 00 00       	mov    $0x18,%eax
    48d7:	cd 40                	int    $0x40
    48d9:	c3                   	ret    
    48da:	66 90                	xchg   %ax,%ax
    48dc:	66 90                	xchg   %ax,%ax
    48de:	66 90                	xchg   %ax,%ax

000048e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    48e0:	55                   	push   %ebp
    48e1:	89 e5                	mov    %esp,%ebp
    48e3:	57                   	push   %edi
    48e4:	56                   	push   %esi
    48e5:	53                   	push   %ebx
    48e6:	89 c6                	mov    %eax,%esi
    48e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    48eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    48ee:	85 db                	test   %ebx,%ebx
    48f0:	74 7e                	je     4970 <printint+0x90>
    48f2:	89 d0                	mov    %edx,%eax
    48f4:	c1 e8 1f             	shr    $0x1f,%eax
    48f7:	84 c0                	test   %al,%al
    48f9:	74 75                	je     4970 <printint+0x90>
    neg = 1;
    x = -xx;
    48fb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    48fd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    4904:	f7 d8                	neg    %eax
    4906:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    4909:	31 ff                	xor    %edi,%edi
    490b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    490e:	89 ce                	mov    %ecx,%esi
    4910:	eb 08                	jmp    491a <printint+0x3a>
    4912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    4918:	89 cf                	mov    %ecx,%edi
    491a:	31 d2                	xor    %edx,%edx
    491c:	8d 4f 01             	lea    0x1(%edi),%ecx
    491f:	f7 f6                	div    %esi
    4921:	0f b6 92 1c 64 00 00 	movzbl 0x641c(%edx),%edx
  }while((x /= base) != 0);
    4928:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    492a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    492d:	75 e9                	jne    4918 <printint+0x38>
  if(neg)
    492f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    4932:	8b 75 c0             	mov    -0x40(%ebp),%esi
    4935:	85 c0                	test   %eax,%eax
    4937:	74 08                	je     4941 <printint+0x61>
    buf[i++] = '-';
    4939:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    493e:	8d 4f 02             	lea    0x2(%edi),%ecx
    4941:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    4945:	8d 76 00             	lea    0x0(%esi),%esi
    4948:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    494b:	83 ec 04             	sub    $0x4,%esp
    494e:	83 ef 01             	sub    $0x1,%edi
    4951:	6a 01                	push   $0x1
    4953:	53                   	push   %ebx
    4954:	56                   	push   %esi
    4955:	88 45 d7             	mov    %al,-0x29(%ebp)
    4958:	e8 e5 fe ff ff       	call   4842 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    495d:	83 c4 10             	add    $0x10,%esp
    4960:	39 df                	cmp    %ebx,%edi
    4962:	75 e4                	jne    4948 <printint+0x68>
    putc(fd, buf[i]);
}
    4964:	8d 65 f4             	lea    -0xc(%ebp),%esp
    4967:	5b                   	pop    %ebx
    4968:	5e                   	pop    %esi
    4969:	5f                   	pop    %edi
    496a:	5d                   	pop    %ebp
    496b:	c3                   	ret    
    496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4970:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4972:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    4979:	eb 8b                	jmp    4906 <printint+0x26>
    497b:	90                   	nop
    497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00004980 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4980:	55                   	push   %ebp
    4981:	89 e5                	mov    %esp,%ebp
    4983:	57                   	push   %edi
    4984:	56                   	push   %esi
    4985:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4986:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4989:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    498c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    498f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4992:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4995:	0f b6 1e             	movzbl (%esi),%ebx
    4998:	83 c6 01             	add    $0x1,%esi
    499b:	84 db                	test   %bl,%bl
    499d:	0f 84 b0 00 00 00    	je     4a53 <printf+0xd3>
    49a3:	31 d2                	xor    %edx,%edx
    49a5:	eb 39                	jmp    49e0 <printf+0x60>
    49a7:	89 f6                	mov    %esi,%esi
    49a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    49b0:	83 f8 25             	cmp    $0x25,%eax
    49b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    49b6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    49bb:	74 18                	je     49d5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    49bd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    49c0:	83 ec 04             	sub    $0x4,%esp
    49c3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    49c6:	6a 01                	push   $0x1
    49c8:	50                   	push   %eax
    49c9:	57                   	push   %edi
    49ca:	e8 73 fe ff ff       	call   4842 <write>
    49cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    49d2:	83 c4 10             	add    $0x10,%esp
    49d5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    49d8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    49dc:	84 db                	test   %bl,%bl
    49de:	74 73                	je     4a53 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    49e0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    49e2:	0f be cb             	movsbl %bl,%ecx
    49e5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    49e8:	74 c6                	je     49b0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    49ea:	83 fa 25             	cmp    $0x25,%edx
    49ed:	75 e6                	jne    49d5 <printf+0x55>
      if(c == 'd'){
    49ef:	83 f8 64             	cmp    $0x64,%eax
    49f2:	0f 84 f8 00 00 00    	je     4af0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    49f8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    49fe:	83 f9 70             	cmp    $0x70,%ecx
    4a01:	74 5d                	je     4a60 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    4a03:	83 f8 73             	cmp    $0x73,%eax
    4a06:	0f 84 84 00 00 00    	je     4a90 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4a0c:	83 f8 63             	cmp    $0x63,%eax
    4a0f:	0f 84 ea 00 00 00    	je     4aff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    4a15:	83 f8 25             	cmp    $0x25,%eax
    4a18:	0f 84 c2 00 00 00    	je     4ae0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4a1e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    4a21:	83 ec 04             	sub    $0x4,%esp
    4a24:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    4a28:	6a 01                	push   $0x1
    4a2a:	50                   	push   %eax
    4a2b:	57                   	push   %edi
    4a2c:	e8 11 fe ff ff       	call   4842 <write>
    4a31:	83 c4 0c             	add    $0xc,%esp
    4a34:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    4a37:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    4a3a:	6a 01                	push   $0x1
    4a3c:	50                   	push   %eax
    4a3d:	57                   	push   %edi
    4a3e:	83 c6 01             	add    $0x1,%esi
    4a41:	e8 fc fd ff ff       	call   4842 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4a46:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4a4a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    4a4d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4a4f:	84 db                	test   %bl,%bl
    4a51:	75 8d                	jne    49e0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    4a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
    4a56:	5b                   	pop    %ebx
    4a57:	5e                   	pop    %esi
    4a58:	5f                   	pop    %edi
    4a59:	5d                   	pop    %ebp
    4a5a:	c3                   	ret    
    4a5b:	90                   	nop
    4a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    4a60:	83 ec 0c             	sub    $0xc,%esp
    4a63:	b9 10 00 00 00       	mov    $0x10,%ecx
    4a68:	6a 00                	push   $0x0
    4a6a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    4a6d:	89 f8                	mov    %edi,%eax
    4a6f:	8b 13                	mov    (%ebx),%edx
    4a71:	e8 6a fe ff ff       	call   48e0 <printint>
        ap++;
    4a76:	89 d8                	mov    %ebx,%eax
    4a78:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    4a7b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    4a7d:	83 c0 04             	add    $0x4,%eax
    4a80:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4a83:	e9 4d ff ff ff       	jmp    49d5 <printf+0x55>
    4a88:	90                   	nop
    4a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    4a90:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4a93:	8b 18                	mov    (%eax),%ebx
        ap++;
    4a95:	83 c0 04             	add    $0x4,%eax
    4a98:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    4a9b:	b8 14 64 00 00       	mov    $0x6414,%eax
    4aa0:	85 db                	test   %ebx,%ebx
    4aa2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    4aa5:	0f b6 03             	movzbl (%ebx),%eax
    4aa8:	84 c0                	test   %al,%al
    4aaa:	74 23                	je     4acf <printf+0x14f>
    4aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4ab0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4ab3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    4ab6:	83 ec 04             	sub    $0x4,%esp
    4ab9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    4abb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4abe:	50                   	push   %eax
    4abf:	57                   	push   %edi
    4ac0:	e8 7d fd ff ff       	call   4842 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4ac5:	0f b6 03             	movzbl (%ebx),%eax
    4ac8:	83 c4 10             	add    $0x10,%esp
    4acb:	84 c0                	test   %al,%al
    4acd:	75 e1                	jne    4ab0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    4acf:	31 d2                	xor    %edx,%edx
    4ad1:	e9 ff fe ff ff       	jmp    49d5 <printf+0x55>
    4ad6:	8d 76 00             	lea    0x0(%esi),%esi
    4ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4ae0:	83 ec 04             	sub    $0x4,%esp
    4ae3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    4ae6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    4ae9:	6a 01                	push   $0x1
    4aeb:	e9 4c ff ff ff       	jmp    4a3c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    4af0:	83 ec 0c             	sub    $0xc,%esp
    4af3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    4af8:	6a 01                	push   $0x1
    4afa:	e9 6b ff ff ff       	jmp    4a6a <printf+0xea>
    4aff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4b02:	83 ec 04             	sub    $0x4,%esp
    4b05:	8b 03                	mov    (%ebx),%eax
    4b07:	6a 01                	push   $0x1
    4b09:	88 45 e4             	mov    %al,-0x1c(%ebp)
    4b0c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    4b0f:	50                   	push   %eax
    4b10:	57                   	push   %edi
    4b11:	e8 2c fd ff ff       	call   4842 <write>
    4b16:	e9 5b ff ff ff       	jmp    4a76 <printf+0xf6>
    4b1b:	66 90                	xchg   %ax,%ax
    4b1d:	66 90                	xchg   %ax,%ax
    4b1f:	90                   	nop

00004b20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4b20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b21:	a1 80 6d 00 00       	mov    0x6d80,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    4b26:	89 e5                	mov    %esp,%ebp
    4b28:	57                   	push   %edi
    4b29:	56                   	push   %esi
    4b2a:	53                   	push   %ebx
    4b2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4b2e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4b30:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b33:	39 c8                	cmp    %ecx,%eax
    4b35:	73 19                	jae    4b50 <free+0x30>
    4b37:	89 f6                	mov    %esi,%esi
    4b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    4b40:	39 d1                	cmp    %edx,%ecx
    4b42:	72 1c                	jb     4b60 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4b44:	39 d0                	cmp    %edx,%eax
    4b46:	73 18                	jae    4b60 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    4b48:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b4a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4b4c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b4e:	72 f0                	jb     4b40 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4b50:	39 d0                	cmp    %edx,%eax
    4b52:	72 f4                	jb     4b48 <free+0x28>
    4b54:	39 d1                	cmp    %edx,%ecx
    4b56:	73 f0                	jae    4b48 <free+0x28>
    4b58:	90                   	nop
    4b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    4b60:	8b 73 fc             	mov    -0x4(%ebx),%esi
    4b63:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    4b66:	39 d7                	cmp    %edx,%edi
    4b68:	74 19                	je     4b83 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    4b6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    4b6d:	8b 50 04             	mov    0x4(%eax),%edx
    4b70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4b73:	39 f1                	cmp    %esi,%ecx
    4b75:	74 23                	je     4b9a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    4b77:	89 08                	mov    %ecx,(%eax)
  freep = p;
    4b79:	a3 80 6d 00 00       	mov    %eax,0x6d80
}
    4b7e:	5b                   	pop    %ebx
    4b7f:	5e                   	pop    %esi
    4b80:	5f                   	pop    %edi
    4b81:	5d                   	pop    %ebp
    4b82:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    4b83:	03 72 04             	add    0x4(%edx),%esi
    4b86:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4b89:	8b 10                	mov    (%eax),%edx
    4b8b:	8b 12                	mov    (%edx),%edx
    4b8d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    4b90:	8b 50 04             	mov    0x4(%eax),%edx
    4b93:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4b96:	39 f1                	cmp    %esi,%ecx
    4b98:	75 dd                	jne    4b77 <free+0x57>
    p->s.size += bp->s.size;
    4b9a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    4b9d:	a3 80 6d 00 00       	mov    %eax,0x6d80
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    4ba2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4ba5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4ba8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    4baa:	5b                   	pop    %ebx
    4bab:	5e                   	pop    %esi
    4bac:	5f                   	pop    %edi
    4bad:	5d                   	pop    %ebp
    4bae:	c3                   	ret    
    4baf:	90                   	nop

00004bb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4bb0:	55                   	push   %ebp
    4bb1:	89 e5                	mov    %esp,%ebp
    4bb3:	57                   	push   %edi
    4bb4:	56                   	push   %esi
    4bb5:	53                   	push   %ebx
    4bb6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    4bbc:	8b 15 80 6d 00 00    	mov    0x6d80,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4bc2:	8d 78 07             	lea    0x7(%eax),%edi
    4bc5:	c1 ef 03             	shr    $0x3,%edi
    4bc8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    4bcb:	85 d2                	test   %edx,%edx
    4bcd:	0f 84 a3 00 00 00    	je     4c76 <malloc+0xc6>
    4bd3:	8b 02                	mov    (%edx),%eax
    4bd5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    4bd8:	39 cf                	cmp    %ecx,%edi
    4bda:	76 74                	jbe    4c50 <malloc+0xa0>
    4bdc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    4be2:	be 00 10 00 00       	mov    $0x1000,%esi
    4be7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    4bee:	0f 43 f7             	cmovae %edi,%esi
    4bf1:	ba 00 80 00 00       	mov    $0x8000,%edx
    4bf6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    4bfc:	0f 46 da             	cmovbe %edx,%ebx
    4bff:	eb 10                	jmp    4c11 <malloc+0x61>
    4c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4c08:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    4c0a:	8b 48 04             	mov    0x4(%eax),%ecx
    4c0d:	39 cf                	cmp    %ecx,%edi
    4c0f:	76 3f                	jbe    4c50 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4c11:	39 05 80 6d 00 00    	cmp    %eax,0x6d80
    4c17:	89 c2                	mov    %eax,%edx
    4c19:	75 ed                	jne    4c08 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    4c1b:	83 ec 0c             	sub    $0xc,%esp
    4c1e:	53                   	push   %ebx
    4c1f:	e8 86 fc ff ff       	call   48aa <sbrk>
  if(p == (char*)-1)
    4c24:	83 c4 10             	add    $0x10,%esp
    4c27:	83 f8 ff             	cmp    $0xffffffff,%eax
    4c2a:	74 1c                	je     4c48 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    4c2c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    4c2f:	83 ec 0c             	sub    $0xc,%esp
    4c32:	83 c0 08             	add    $0x8,%eax
    4c35:	50                   	push   %eax
    4c36:	e8 e5 fe ff ff       	call   4b20 <free>
  return freep;
    4c3b:	8b 15 80 6d 00 00    	mov    0x6d80,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    4c41:	83 c4 10             	add    $0x10,%esp
    4c44:	85 d2                	test   %edx,%edx
    4c46:	75 c0                	jne    4c08 <malloc+0x58>
        return 0;
    4c48:	31 c0                	xor    %eax,%eax
    4c4a:	eb 1c                	jmp    4c68 <malloc+0xb8>
    4c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    4c50:	39 cf                	cmp    %ecx,%edi
    4c52:	74 1c                	je     4c70 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    4c54:	29 f9                	sub    %edi,%ecx
    4c56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    4c59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    4c5c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    4c5f:	89 15 80 6d 00 00    	mov    %edx,0x6d80
      return (void*)(p + 1);
    4c65:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    4c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
    4c6b:	5b                   	pop    %ebx
    4c6c:	5e                   	pop    %esi
    4c6d:	5f                   	pop    %edi
    4c6e:	5d                   	pop    %ebp
    4c6f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    4c70:	8b 08                	mov    (%eax),%ecx
    4c72:	89 0a                	mov    %ecx,(%edx)
    4c74:	eb e9                	jmp    4c5f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    4c76:	c7 05 80 6d 00 00 84 	movl   $0x6d84,0x6d80
    4c7d:	6d 00 00 
    4c80:	c7 05 84 6d 00 00 84 	movl   $0x6d84,0x6d84
    4c87:	6d 00 00 
    base.s.size = 0;
    4c8a:	b8 84 6d 00 00       	mov    $0x6d84,%eax
    4c8f:	c7 05 88 6d 00 00 00 	movl   $0x0,0x6d88
    4c96:	00 00 00 
    4c99:	e9 3e ff ff ff       	jmp    4bdc <malloc+0x2c>
