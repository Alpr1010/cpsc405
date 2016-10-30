
_forktest:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	51                   	push   %ecx
    100e:	83 ec 04             	sub    $0x4,%esp
  forktest();
    1011:	e8 3a 00 00 00       	call   1050 <forktest>
  exit();
    1016:	e8 77 03 00 00       	call   1392 <exit>
    101b:	66 90                	xchg   %ax,%ax
    101d:	66 90                	xchg   %ax,%ax
    101f:	90                   	nop

00001020 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	53                   	push   %ebx
    1024:	83 ec 10             	sub    $0x10,%esp
    1027:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
    102a:	53                   	push   %ebx
    102b:	e8 a0 01 00 00       	call   11d0 <strlen>
    1030:	83 c4 0c             	add    $0xc,%esp
    1033:	50                   	push   %eax
    1034:	53                   	push   %ebx
    1035:	ff 75 08             	pushl  0x8(%ebp)
    1038:	e8 75 03 00 00       	call   13b2 <write>
}
    103d:	83 c4 10             	add    $0x10,%esp
    1040:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1043:	c9                   	leave  
    1044:	c3                   	ret    
    1045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001050 <forktest>:

void
forktest(void)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
    1054:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
    1056:	83 ec 10             	sub    $0x10,%esp
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
    1059:	68 4c 14 00 00       	push   $0x144c
    105e:	e8 6d 01 00 00       	call   11d0 <strlen>
    1063:	83 c4 0c             	add    $0xc,%esp
    1066:	50                   	push   %eax
    1067:	68 4c 14 00 00       	push   $0x144c
    106c:	6a 01                	push   $0x1
    106e:	e8 3f 03 00 00       	call   13b2 <write>
    1073:	83 c4 10             	add    $0x10,%esp
    1076:	eb 19                	jmp    1091 <forktest+0x41>
    1078:	90                   	nop
    1079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    1080:	0f 84 7c 00 00 00    	je     1102 <forktest+0xb2>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
    1086:	83 c3 01             	add    $0x1,%ebx
    1089:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    108f:	74 4f                	je     10e0 <forktest+0x90>
    pid = fork();
    1091:	e8 f4 02 00 00       	call   138a <fork>
    if(pid < 0)
    1096:	85 c0                	test   %eax,%eax
    1098:	79 e6                	jns    1080 <forktest+0x30>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
    109a:	85 db                	test   %ebx,%ebx
    109c:	74 10                	je     10ae <forktest+0x5e>
    109e:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
    10a0:	e8 f5 02 00 00       	call   139a <wait>
    10a5:	85 c0                	test   %eax,%eax
    10a7:	78 5e                	js     1107 <forktest+0xb7>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
    10a9:	83 eb 01             	sub    $0x1,%ebx
    10ac:	75 f2                	jne    10a0 <forktest+0x50>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    10ae:	e8 e7 02 00 00       	call   139a <wait>
    10b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    10b6:	75 71                	jne    1129 <forktest+0xd9>
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
    10b8:	83 ec 0c             	sub    $0xc,%esp
    10bb:	68 7e 14 00 00       	push   $0x147e
    10c0:	e8 0b 01 00 00       	call   11d0 <strlen>
    10c5:	83 c4 0c             	add    $0xc,%esp
    10c8:	50                   	push   %eax
    10c9:	68 7e 14 00 00       	push   $0x147e
    10ce:	6a 01                	push   $0x1
    10d0:	e8 dd 02 00 00       	call   13b2 <write>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
}
    10d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10d8:	c9                   	leave  
    10d9:	c3                   	ret    
    10da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
    10e0:	83 ec 0c             	sub    $0xc,%esp
    10e3:	68 8c 14 00 00       	push   $0x148c
    10e8:	e8 e3 00 00 00       	call   11d0 <strlen>
    10ed:	83 c4 0c             	add    $0xc,%esp
    10f0:	50                   	push   %eax
    10f1:	68 8c 14 00 00       	push   $0x148c
    10f6:	6a 01                	push   $0x1
    10f8:	e8 b5 02 00 00       	call   13b2 <write>
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
    10fd:	e8 90 02 00 00       	call   1392 <exit>
  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    1102:	e8 8b 02 00 00       	call   1392 <exit>
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
    1107:	83 ec 0c             	sub    $0xc,%esp
    110a:	68 57 14 00 00       	push   $0x1457
    110f:	e8 bc 00 00 00       	call   11d0 <strlen>
    1114:	83 c4 0c             	add    $0xc,%esp
    1117:	50                   	push   %eax
    1118:	68 57 14 00 00       	push   $0x1457
    111d:	6a 01                	push   $0x1
    111f:	e8 8e 02 00 00       	call   13b2 <write>
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
      exit();
    1124:	e8 69 02 00 00       	call   1392 <exit>
#define N  1000

void
printf(int fd, char *s, ...)
{
  write(fd, s, strlen(s));
    1129:	83 ec 0c             	sub    $0xc,%esp
    112c:	68 6b 14 00 00       	push   $0x146b
    1131:	e8 9a 00 00 00       	call   11d0 <strlen>
    1136:	83 c4 0c             	add    $0xc,%esp
    1139:	50                   	push   %eax
    113a:	68 6b 14 00 00       	push   $0x146b
    113f:	6a 01                	push   $0x1
    1141:	e8 6c 02 00 00       	call   13b2 <write>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    exit();
    1146:	e8 47 02 00 00       	call   1392 <exit>
    114b:	66 90                	xchg   %ax,%ax
    114d:	66 90                	xchg   %ax,%ax
    114f:	90                   	nop

00001150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    115a:	89 c2                	mov    %eax,%edx
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1160:	83 c1 01             	add    $0x1,%ecx
    1163:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1167:	83 c2 01             	add    $0x1,%edx
    116a:	84 db                	test   %bl,%bl
    116c:	88 5a ff             	mov    %bl,-0x1(%edx)
    116f:	75 ef                	jne    1160 <strcpy+0x10>
    ;
  return os;
}
    1171:	5b                   	pop    %ebx
    1172:	5d                   	pop    %ebp
    1173:	c3                   	ret    
    1174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    117a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	56                   	push   %esi
    1184:	53                   	push   %ebx
    1185:	8b 55 08             	mov    0x8(%ebp),%edx
    1188:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    118b:	0f b6 02             	movzbl (%edx),%eax
    118e:	0f b6 19             	movzbl (%ecx),%ebx
    1191:	84 c0                	test   %al,%al
    1193:	75 1e                	jne    11b3 <strcmp+0x33>
    1195:	eb 29                	jmp    11c0 <strcmp+0x40>
    1197:	89 f6                	mov    %esi,%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    11a0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11a3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    11a6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11a9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    11ad:	84 c0                	test   %al,%al
    11af:	74 0f                	je     11c0 <strcmp+0x40>
    11b1:	89 f1                	mov    %esi,%ecx
    11b3:	38 d8                	cmp    %bl,%al
    11b5:	74 e9                	je     11a0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    11b7:	29 d8                	sub    %ebx,%eax
}
    11b9:	5b                   	pop    %ebx
    11ba:	5e                   	pop    %esi
    11bb:	5d                   	pop    %ebp
    11bc:	c3                   	ret    
    11bd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11c0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    11c2:	29 d8                	sub    %ebx,%eax
}
    11c4:	5b                   	pop    %ebx
    11c5:	5e                   	pop    %esi
    11c6:	5d                   	pop    %ebp
    11c7:	c3                   	ret    
    11c8:	90                   	nop
    11c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011d0 <strlen>:

uint
strlen(char *s)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11d6:	80 39 00             	cmpb   $0x0,(%ecx)
    11d9:	74 12                	je     11ed <strlen+0x1d>
    11db:	31 d2                	xor    %edx,%edx
    11dd:	8d 76 00             	lea    0x0(%esi),%esi
    11e0:	83 c2 01             	add    $0x1,%edx
    11e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    11e7:	89 d0                	mov    %edx,%eax
    11e9:	75 f5                	jne    11e0 <strlen+0x10>
    ;
  return n;
}
    11eb:	5d                   	pop    %ebp
    11ec:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    11ed:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    11ef:	5d                   	pop    %ebp
    11f0:	c3                   	ret    
    11f1:	eb 0d                	jmp    1200 <memset>
    11f3:	90                   	nop
    11f4:	90                   	nop
    11f5:	90                   	nop
    11f6:	90                   	nop
    11f7:	90                   	nop
    11f8:	90                   	nop
    11f9:	90                   	nop
    11fa:	90                   	nop
    11fb:	90                   	nop
    11fc:	90                   	nop
    11fd:	90                   	nop
    11fe:	90                   	nop
    11ff:	90                   	nop

00001200 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1207:	8b 4d 10             	mov    0x10(%ebp),%ecx
    120a:	8b 45 0c             	mov    0xc(%ebp),%eax
    120d:	89 d7                	mov    %edx,%edi
    120f:	fc                   	cld    
    1210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1212:	89 d0                	mov    %edx,%eax
    1214:	5f                   	pop    %edi
    1215:	5d                   	pop    %ebp
    1216:	c3                   	ret    
    1217:	89 f6                	mov    %esi,%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001220 <strchr>:

char*
strchr(const char *s, char c)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	53                   	push   %ebx
    1224:	8b 45 08             	mov    0x8(%ebp),%eax
    1227:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    122a:	0f b6 10             	movzbl (%eax),%edx
    122d:	84 d2                	test   %dl,%dl
    122f:	74 1d                	je     124e <strchr+0x2e>
    if(*s == c)
    1231:	38 d3                	cmp    %dl,%bl
    1233:	89 d9                	mov    %ebx,%ecx
    1235:	75 0d                	jne    1244 <strchr+0x24>
    1237:	eb 17                	jmp    1250 <strchr+0x30>
    1239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1240:	38 ca                	cmp    %cl,%dl
    1242:	74 0c                	je     1250 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1244:	83 c0 01             	add    $0x1,%eax
    1247:	0f b6 10             	movzbl (%eax),%edx
    124a:	84 d2                	test   %dl,%dl
    124c:	75 f2                	jne    1240 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    124e:	31 c0                	xor    %eax,%eax
}
    1250:	5b                   	pop    %ebx
    1251:	5d                   	pop    %ebp
    1252:	c3                   	ret    
    1253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001260 <gets>:

char*
gets(char *buf, int max)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1266:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1268:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    126b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    126e:	eb 29                	jmp    1299 <gets+0x39>
    cc = read(0, &c, 1);
    1270:	83 ec 04             	sub    $0x4,%esp
    1273:	6a 01                	push   $0x1
    1275:	57                   	push   %edi
    1276:	6a 00                	push   $0x0
    1278:	e8 2d 01 00 00       	call   13aa <read>
    if(cc < 1)
    127d:	83 c4 10             	add    $0x10,%esp
    1280:	85 c0                	test   %eax,%eax
    1282:	7e 1d                	jle    12a1 <gets+0x41>
      break;
    buf[i++] = c;
    1284:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1288:	8b 55 08             	mov    0x8(%ebp),%edx
    128b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    128d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    128f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1293:	74 1b                	je     12b0 <gets+0x50>
    1295:	3c 0d                	cmp    $0xd,%al
    1297:	74 17                	je     12b0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1299:	8d 5e 01             	lea    0x1(%esi),%ebx
    129c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    129f:	7c cf                	jl     1270 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    12a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12ab:	5b                   	pop    %ebx
    12ac:	5e                   	pop    %esi
    12ad:	5f                   	pop    %edi
    12ae:	5d                   	pop    %ebp
    12af:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12b0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12b3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    12b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12bc:	5b                   	pop    %ebx
    12bd:	5e                   	pop    %esi
    12be:	5f                   	pop    %edi
    12bf:	5d                   	pop    %ebp
    12c0:	c3                   	ret    
    12c1:	eb 0d                	jmp    12d0 <stat>
    12c3:	90                   	nop
    12c4:	90                   	nop
    12c5:	90                   	nop
    12c6:	90                   	nop
    12c7:	90                   	nop
    12c8:	90                   	nop
    12c9:	90                   	nop
    12ca:	90                   	nop
    12cb:	90                   	nop
    12cc:	90                   	nop
    12cd:	90                   	nop
    12ce:	90                   	nop
    12cf:	90                   	nop

000012d0 <stat>:

int
stat(char *n, struct stat *st)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	56                   	push   %esi
    12d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12d5:	83 ec 08             	sub    $0x8,%esp
    12d8:	6a 00                	push   $0x0
    12da:	ff 75 08             	pushl  0x8(%ebp)
    12dd:	e8 f0 00 00 00       	call   13d2 <open>
  if(fd < 0)
    12e2:	83 c4 10             	add    $0x10,%esp
    12e5:	85 c0                	test   %eax,%eax
    12e7:	78 27                	js     1310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    12e9:	83 ec 08             	sub    $0x8,%esp
    12ec:	ff 75 0c             	pushl  0xc(%ebp)
    12ef:	89 c3                	mov    %eax,%ebx
    12f1:	50                   	push   %eax
    12f2:	e8 f3 00 00 00       	call   13ea <fstat>
    12f7:	89 c6                	mov    %eax,%esi
  close(fd);
    12f9:	89 1c 24             	mov    %ebx,(%esp)
    12fc:	e8 b9 00 00 00       	call   13ba <close>
  return r;
    1301:	83 c4 10             	add    $0x10,%esp
    1304:	89 f0                	mov    %esi,%eax
}
    1306:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1309:	5b                   	pop    %ebx
    130a:	5e                   	pop    %esi
    130b:	5d                   	pop    %ebp
    130c:	c3                   	ret    
    130d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1315:	eb ef                	jmp    1306 <stat+0x36>
    1317:	89 f6                	mov    %esi,%esi
    1319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001320 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	53                   	push   %ebx
    1324:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1327:	0f be 11             	movsbl (%ecx),%edx
    132a:	8d 42 d0             	lea    -0x30(%edx),%eax
    132d:	3c 09                	cmp    $0x9,%al
    132f:	b8 00 00 00 00       	mov    $0x0,%eax
    1334:	77 1f                	ja     1355 <atoi+0x35>
    1336:	8d 76 00             	lea    0x0(%esi),%esi
    1339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1340:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1343:	83 c1 01             	add    $0x1,%ecx
    1346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    134a:	0f be 11             	movsbl (%ecx),%edx
    134d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1350:	80 fb 09             	cmp    $0x9,%bl
    1353:	76 eb                	jbe    1340 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1355:	5b                   	pop    %ebx
    1356:	5d                   	pop    %ebp
    1357:	c3                   	ret    
    1358:	90                   	nop
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	56                   	push   %esi
    1364:	53                   	push   %ebx
    1365:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1368:	8b 45 08             	mov    0x8(%ebp),%eax
    136b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    136e:	85 db                	test   %ebx,%ebx
    1370:	7e 14                	jle    1386 <memmove+0x26>
    1372:	31 d2                	xor    %edx,%edx
    1374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    137c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    137f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1382:	39 da                	cmp    %ebx,%edx
    1384:	75 f2                	jne    1378 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1386:	5b                   	pop    %ebx
    1387:	5e                   	pop    %esi
    1388:	5d                   	pop    %ebp
    1389:	c3                   	ret    

0000138a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    138a:	b8 01 00 00 00       	mov    $0x1,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <exit>:
SYSCALL(exit)
    1392:	b8 02 00 00 00       	mov    $0x2,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <wait>:
SYSCALL(wait)
    139a:	b8 03 00 00 00       	mov    $0x3,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <pipe>:
SYSCALL(pipe)
    13a2:	b8 04 00 00 00       	mov    $0x4,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <read>:
SYSCALL(read)
    13aa:	b8 05 00 00 00       	mov    $0x5,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <write>:
SYSCALL(write)
    13b2:	b8 10 00 00 00       	mov    $0x10,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <close>:
SYSCALL(close)
    13ba:	b8 15 00 00 00       	mov    $0x15,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <kill>:
SYSCALL(kill)
    13c2:	b8 06 00 00 00       	mov    $0x6,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <exec>:
SYSCALL(exec)
    13ca:	b8 07 00 00 00       	mov    $0x7,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <open>:
SYSCALL(open)
    13d2:	b8 0f 00 00 00       	mov    $0xf,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <mknod>:
SYSCALL(mknod)
    13da:	b8 11 00 00 00       	mov    $0x11,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <unlink>:
SYSCALL(unlink)
    13e2:	b8 12 00 00 00       	mov    $0x12,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    

000013ea <fstat>:
SYSCALL(fstat)
    13ea:	b8 08 00 00 00       	mov    $0x8,%eax
    13ef:	cd 40                	int    $0x40
    13f1:	c3                   	ret    

000013f2 <link>:
SYSCALL(link)
    13f2:	b8 13 00 00 00       	mov    $0x13,%eax
    13f7:	cd 40                	int    $0x40
    13f9:	c3                   	ret    

000013fa <mkdir>:
SYSCALL(mkdir)
    13fa:	b8 14 00 00 00       	mov    $0x14,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <chdir>:
SYSCALL(chdir)
    1402:	b8 09 00 00 00       	mov    $0x9,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <dup>:
SYSCALL(dup)
    140a:	b8 0a 00 00 00       	mov    $0xa,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <getpid>:
SYSCALL(getpid)
    1412:	b8 0b 00 00 00       	mov    $0xb,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <sbrk>:
SYSCALL(sbrk)
    141a:	b8 0c 00 00 00       	mov    $0xc,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    

00001422 <sleep>:
SYSCALL(sleep)
    1422:	b8 0d 00 00 00       	mov    $0xd,%eax
    1427:	cd 40                	int    $0x40
    1429:	c3                   	ret    

0000142a <uptime>:
SYSCALL(uptime)
    142a:	b8 0e 00 00 00       	mov    $0xe,%eax
    142f:	cd 40                	int    $0x40
    1431:	c3                   	ret    

00001432 <getcount>:
SYSCALL(getcount) //added getcount here
    1432:	b8 16 00 00 00       	mov    $0x16,%eax
    1437:	cd 40                	int    $0x40
    1439:	c3                   	ret    

0000143a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    143a:	b8 17 00 00 00       	mov    $0x17,%eax
    143f:	cd 40                	int    $0x40
    1441:	c3                   	ret    

00001442 <increasepriority>:
SYSCALL(increasepriority)
    1442:	b8 18 00 00 00       	mov    $0x18,%eax
    1447:	cd 40                	int    $0x40
    1449:	c3                   	ret    
