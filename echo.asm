
_echo:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 08             	sub    $0x8,%esp
    1014:	8b 31                	mov    (%ecx),%esi
    1016:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
    1019:	83 fe 01             	cmp    $0x1,%esi
    101c:	7e 41                	jle    105f <main+0x5f>
    101e:	bb 01 00 00 00       	mov    $0x1,%ebx
    1023:	eb 1b                	jmp    1040 <main+0x40>
    1025:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1028:	68 30 17 00 00       	push   $0x1730
    102d:	ff 74 9f fc          	pushl  -0x4(%edi,%ebx,4)
    1031:	68 32 17 00 00       	push   $0x1732
    1036:	6a 01                	push   $0x1
    1038:	e8 d3 03 00 00       	call   1410 <printf>
    103d:	83 c4 10             	add    $0x10,%esp
    1040:	83 c3 01             	add    $0x1,%ebx
    1043:	39 de                	cmp    %ebx,%esi
    1045:	75 e1                	jne    1028 <main+0x28>
    1047:	68 37 17 00 00       	push   $0x1737
    104c:	ff 74 b7 fc          	pushl  -0x4(%edi,%esi,4)
    1050:	68 32 17 00 00       	push   $0x1732
    1055:	6a 01                	push   $0x1
    1057:	e8 b4 03 00 00       	call   1410 <printf>
    105c:	83 c4 10             	add    $0x10,%esp
  exit();
    105f:	e8 4e 02 00 00       	call   12b2 <exit>
    1064:	66 90                	xchg   %ax,%ax
    1066:	66 90                	xchg   %ax,%ax
    1068:	66 90                	xchg   %ax,%ax
    106a:	66 90                	xchg   %ax,%ax
    106c:	66 90                	xchg   %ax,%ax
    106e:	66 90                	xchg   %ax,%ax

00001070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	53                   	push   %ebx
    1074:	8b 45 08             	mov    0x8(%ebp),%eax
    1077:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    107a:	89 c2                	mov    %eax,%edx
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1080:	83 c1 01             	add    $0x1,%ecx
    1083:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1087:	83 c2 01             	add    $0x1,%edx
    108a:	84 db                	test   %bl,%bl
    108c:	88 5a ff             	mov    %bl,-0x1(%edx)
    108f:	75 ef                	jne    1080 <strcpy+0x10>
    ;
  return os;
}
    1091:	5b                   	pop    %ebx
    1092:	5d                   	pop    %ebp
    1093:	c3                   	ret    
    1094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    109a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	56                   	push   %esi
    10a4:	53                   	push   %ebx
    10a5:	8b 55 08             	mov    0x8(%ebp),%edx
    10a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10ab:	0f b6 02             	movzbl (%edx),%eax
    10ae:	0f b6 19             	movzbl (%ecx),%ebx
    10b1:	84 c0                	test   %al,%al
    10b3:	75 1e                	jne    10d3 <strcmp+0x33>
    10b5:	eb 29                	jmp    10e0 <strcmp+0x40>
    10b7:	89 f6                	mov    %esi,%esi
    10b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    10c0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    10c6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    10cd:	84 c0                	test   %al,%al
    10cf:	74 0f                	je     10e0 <strcmp+0x40>
    10d1:	89 f1                	mov    %esi,%ecx
    10d3:	38 d8                	cmp    %bl,%al
    10d5:	74 e9                	je     10c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10d7:	29 d8                	sub    %ebx,%eax
}
    10d9:	5b                   	pop    %ebx
    10da:	5e                   	pop    %esi
    10db:	5d                   	pop    %ebp
    10dc:	c3                   	ret    
    10dd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10e0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10e2:	29 d8                	sub    %ebx,%eax
}
    10e4:	5b                   	pop    %ebx
    10e5:	5e                   	pop    %esi
    10e6:	5d                   	pop    %ebp
    10e7:	c3                   	ret    
    10e8:	90                   	nop
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010f0 <strlen>:

uint
strlen(char *s)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10f6:	80 39 00             	cmpb   $0x0,(%ecx)
    10f9:	74 12                	je     110d <strlen+0x1d>
    10fb:	31 d2                	xor    %edx,%edx
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
    1100:	83 c2 01             	add    $0x1,%edx
    1103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1107:	89 d0                	mov    %edx,%eax
    1109:	75 f5                	jne    1100 <strlen+0x10>
    ;
  return n;
}
    110b:	5d                   	pop    %ebp
    110c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    110d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    110f:	5d                   	pop    %ebp
    1110:	c3                   	ret    
    1111:	eb 0d                	jmp    1120 <memset>
    1113:	90                   	nop
    1114:	90                   	nop
    1115:	90                   	nop
    1116:	90                   	nop
    1117:	90                   	nop
    1118:	90                   	nop
    1119:	90                   	nop
    111a:	90                   	nop
    111b:	90                   	nop
    111c:	90                   	nop
    111d:	90                   	nop
    111e:	90                   	nop
    111f:	90                   	nop

00001120 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1127:	8b 4d 10             	mov    0x10(%ebp),%ecx
    112a:	8b 45 0c             	mov    0xc(%ebp),%eax
    112d:	89 d7                	mov    %edx,%edi
    112f:	fc                   	cld    
    1130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1132:	89 d0                	mov    %edx,%eax
    1134:	5f                   	pop    %edi
    1135:	5d                   	pop    %ebp
    1136:	c3                   	ret    
    1137:	89 f6                	mov    %esi,%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001140 <strchr>:

char*
strchr(const char *s, char c)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	53                   	push   %ebx
    1144:	8b 45 08             	mov    0x8(%ebp),%eax
    1147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    114a:	0f b6 10             	movzbl (%eax),%edx
    114d:	84 d2                	test   %dl,%dl
    114f:	74 1d                	je     116e <strchr+0x2e>
    if(*s == c)
    1151:	38 d3                	cmp    %dl,%bl
    1153:	89 d9                	mov    %ebx,%ecx
    1155:	75 0d                	jne    1164 <strchr+0x24>
    1157:	eb 17                	jmp    1170 <strchr+0x30>
    1159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1160:	38 ca                	cmp    %cl,%dl
    1162:	74 0c                	je     1170 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1164:	83 c0 01             	add    $0x1,%eax
    1167:	0f b6 10             	movzbl (%eax),%edx
    116a:	84 d2                	test   %dl,%dl
    116c:	75 f2                	jne    1160 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    116e:	31 c0                	xor    %eax,%eax
}
    1170:	5b                   	pop    %ebx
    1171:	5d                   	pop    %ebp
    1172:	c3                   	ret    
    1173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001180 <gets>:

char*
gets(char *buf, int max)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	56                   	push   %esi
    1185:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1186:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1188:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    118b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    118e:	eb 29                	jmp    11b9 <gets+0x39>
    cc = read(0, &c, 1);
    1190:	83 ec 04             	sub    $0x4,%esp
    1193:	6a 01                	push   $0x1
    1195:	57                   	push   %edi
    1196:	6a 00                	push   $0x0
    1198:	e8 2d 01 00 00       	call   12ca <read>
    if(cc < 1)
    119d:	83 c4 10             	add    $0x10,%esp
    11a0:	85 c0                	test   %eax,%eax
    11a2:	7e 1d                	jle    11c1 <gets+0x41>
      break;
    buf[i++] = c;
    11a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11a8:	8b 55 08             	mov    0x8(%ebp),%edx
    11ab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    11ad:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    11af:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    11b3:	74 1b                	je     11d0 <gets+0x50>
    11b5:	3c 0d                	cmp    $0xd,%al
    11b7:	74 17                	je     11d0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11b9:	8d 5e 01             	lea    0x1(%esi),%ebx
    11bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11bf:	7c cf                	jl     1190 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11c1:	8b 45 08             	mov    0x8(%ebp),%eax
    11c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    11c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11cb:	5b                   	pop    %ebx
    11cc:	5e                   	pop    %esi
    11cd:	5f                   	pop    %edi
    11ce:	5d                   	pop    %ebp
    11cf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    11d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11dc:	5b                   	pop    %ebx
    11dd:	5e                   	pop    %esi
    11de:	5f                   	pop    %edi
    11df:	5d                   	pop    %ebp
    11e0:	c3                   	ret    
    11e1:	eb 0d                	jmp    11f0 <stat>
    11e3:	90                   	nop
    11e4:	90                   	nop
    11e5:	90                   	nop
    11e6:	90                   	nop
    11e7:	90                   	nop
    11e8:	90                   	nop
    11e9:	90                   	nop
    11ea:	90                   	nop
    11eb:	90                   	nop
    11ec:	90                   	nop
    11ed:	90                   	nop
    11ee:	90                   	nop
    11ef:	90                   	nop

000011f0 <stat>:

int
stat(char *n, struct stat *st)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	56                   	push   %esi
    11f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11f5:	83 ec 08             	sub    $0x8,%esp
    11f8:	6a 00                	push   $0x0
    11fa:	ff 75 08             	pushl  0x8(%ebp)
    11fd:	e8 f0 00 00 00       	call   12f2 <open>
  if(fd < 0)
    1202:	83 c4 10             	add    $0x10,%esp
    1205:	85 c0                	test   %eax,%eax
    1207:	78 27                	js     1230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1209:	83 ec 08             	sub    $0x8,%esp
    120c:	ff 75 0c             	pushl  0xc(%ebp)
    120f:	89 c3                	mov    %eax,%ebx
    1211:	50                   	push   %eax
    1212:	e8 f3 00 00 00       	call   130a <fstat>
    1217:	89 c6                	mov    %eax,%esi
  close(fd);
    1219:	89 1c 24             	mov    %ebx,(%esp)
    121c:	e8 b9 00 00 00       	call   12da <close>
  return r;
    1221:	83 c4 10             	add    $0x10,%esp
    1224:	89 f0                	mov    %esi,%eax
}
    1226:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1229:	5b                   	pop    %ebx
    122a:	5e                   	pop    %esi
    122b:	5d                   	pop    %ebp
    122c:	c3                   	ret    
    122d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1235:	eb ef                	jmp    1226 <stat+0x36>
    1237:	89 f6                	mov    %esi,%esi
    1239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	53                   	push   %ebx
    1244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1247:	0f be 11             	movsbl (%ecx),%edx
    124a:	8d 42 d0             	lea    -0x30(%edx),%eax
    124d:	3c 09                	cmp    $0x9,%al
    124f:	b8 00 00 00 00       	mov    $0x0,%eax
    1254:	77 1f                	ja     1275 <atoi+0x35>
    1256:	8d 76 00             	lea    0x0(%esi),%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1260:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1263:	83 c1 01             	add    $0x1,%ecx
    1266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    126a:	0f be 11             	movsbl (%ecx),%edx
    126d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1270:	80 fb 09             	cmp    $0x9,%bl
    1273:	76 eb                	jbe    1260 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1275:	5b                   	pop    %ebx
    1276:	5d                   	pop    %ebp
    1277:	c3                   	ret    
    1278:	90                   	nop
    1279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	53                   	push   %ebx
    1285:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    128e:	85 db                	test   %ebx,%ebx
    1290:	7e 14                	jle    12a6 <memmove+0x26>
    1292:	31 d2                	xor    %edx,%edx
    1294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    129c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    129f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12a2:	39 da                	cmp    %ebx,%edx
    12a4:	75 f2                	jne    1298 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12a6:	5b                   	pop    %ebx
    12a7:	5e                   	pop    %esi
    12a8:	5d                   	pop    %ebp
    12a9:	c3                   	ret    

000012aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12aa:	b8 01 00 00 00       	mov    $0x1,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <exit>:
SYSCALL(exit)
    12b2:	b8 02 00 00 00       	mov    $0x2,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    

000012ba <wait>:
SYSCALL(wait)
    12ba:	b8 03 00 00 00       	mov    $0x3,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <pipe>:
SYSCALL(pipe)
    12c2:	b8 04 00 00 00       	mov    $0x4,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <read>:
SYSCALL(read)
    12ca:	b8 05 00 00 00       	mov    $0x5,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <write>:
SYSCALL(write)
    12d2:	b8 10 00 00 00       	mov    $0x10,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <close>:
SYSCALL(close)
    12da:	b8 15 00 00 00       	mov    $0x15,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <kill>:
SYSCALL(kill)
    12e2:	b8 06 00 00 00       	mov    $0x6,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <exec>:
SYSCALL(exec)
    12ea:	b8 07 00 00 00       	mov    $0x7,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <open>:
SYSCALL(open)
    12f2:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <mknod>:
SYSCALL(mknod)
    12fa:	b8 11 00 00 00       	mov    $0x11,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <unlink>:
SYSCALL(unlink)
    1302:	b8 12 00 00 00       	mov    $0x12,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <fstat>:
SYSCALL(fstat)
    130a:	b8 08 00 00 00       	mov    $0x8,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <link>:
SYSCALL(link)
    1312:	b8 13 00 00 00       	mov    $0x13,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <mkdir>:
SYSCALL(mkdir)
    131a:	b8 14 00 00 00       	mov    $0x14,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <chdir>:
SYSCALL(chdir)
    1322:	b8 09 00 00 00       	mov    $0x9,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <dup>:
SYSCALL(dup)
    132a:	b8 0a 00 00 00       	mov    $0xa,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <getpid>:
SYSCALL(getpid)
    1332:	b8 0b 00 00 00       	mov    $0xb,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <sbrk>:
SYSCALL(sbrk)
    133a:	b8 0c 00 00 00       	mov    $0xc,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <sleep>:
SYSCALL(sleep)
    1342:	b8 0d 00 00 00       	mov    $0xd,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <uptime>:
SYSCALL(uptime)
    134a:	b8 0e 00 00 00       	mov    $0xe,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <getcount>:
SYSCALL(getcount) //added getcount here
    1352:	b8 16 00 00 00       	mov    $0x16,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    135a:	b8 17 00 00 00       	mov    $0x17,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <increasepriority>:
SYSCALL(increasepriority)
    1362:	b8 18 00 00 00       	mov    $0x18,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    
    136a:	66 90                	xchg   %ax,%ax
    136c:	66 90                	xchg   %ax,%ax
    136e:	66 90                	xchg   %ax,%ax

00001370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	57                   	push   %edi
    1374:	56                   	push   %esi
    1375:	53                   	push   %ebx
    1376:	89 c6                	mov    %eax,%esi
    1378:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    137b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    137e:	85 db                	test   %ebx,%ebx
    1380:	74 7e                	je     1400 <printint+0x90>
    1382:	89 d0                	mov    %edx,%eax
    1384:	c1 e8 1f             	shr    $0x1f,%eax
    1387:	84 c0                	test   %al,%al
    1389:	74 75                	je     1400 <printint+0x90>
    neg = 1;
    x = -xx;
    138b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    138d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1394:	f7 d8                	neg    %eax
    1396:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1399:	31 ff                	xor    %edi,%edi
    139b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    139e:	89 ce                	mov    %ecx,%esi
    13a0:	eb 08                	jmp    13aa <printint+0x3a>
    13a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    13a8:	89 cf                	mov    %ecx,%edi
    13aa:	31 d2                	xor    %edx,%edx
    13ac:	8d 4f 01             	lea    0x1(%edi),%ecx
    13af:	f7 f6                	div    %esi
    13b1:	0f b6 92 40 17 00 00 	movzbl 0x1740(%edx),%edx
  }while((x /= base) != 0);
    13b8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    13ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    13bd:	75 e9                	jne    13a8 <printint+0x38>
  if(neg)
    13bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13c2:	8b 75 c0             	mov    -0x40(%ebp),%esi
    13c5:	85 c0                	test   %eax,%eax
    13c7:	74 08                	je     13d1 <printint+0x61>
    buf[i++] = '-';
    13c9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    13ce:	8d 4f 02             	lea    0x2(%edi),%ecx
    13d1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    13d5:	8d 76 00             	lea    0x0(%esi),%esi
    13d8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13db:	83 ec 04             	sub    $0x4,%esp
    13de:	83 ef 01             	sub    $0x1,%edi
    13e1:	6a 01                	push   $0x1
    13e3:	53                   	push   %ebx
    13e4:	56                   	push   %esi
    13e5:	88 45 d7             	mov    %al,-0x29(%ebp)
    13e8:	e8 e5 fe ff ff       	call   12d2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13ed:	83 c4 10             	add    $0x10,%esp
    13f0:	39 df                	cmp    %ebx,%edi
    13f2:	75 e4                	jne    13d8 <printint+0x68>
    putc(fd, buf[i]);
}
    13f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13f7:	5b                   	pop    %ebx
    13f8:	5e                   	pop    %esi
    13f9:	5f                   	pop    %edi
    13fa:	5d                   	pop    %ebp
    13fb:	c3                   	ret    
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1400:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1402:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1409:	eb 8b                	jmp    1396 <printint+0x26>
    140b:	90                   	nop
    140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001410 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	56                   	push   %esi
    1415:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1416:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1419:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    141c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    141f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1422:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1425:	0f b6 1e             	movzbl (%esi),%ebx
    1428:	83 c6 01             	add    $0x1,%esi
    142b:	84 db                	test   %bl,%bl
    142d:	0f 84 b0 00 00 00    	je     14e3 <printf+0xd3>
    1433:	31 d2                	xor    %edx,%edx
    1435:	eb 39                	jmp    1470 <printf+0x60>
    1437:	89 f6                	mov    %esi,%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1440:	83 f8 25             	cmp    $0x25,%eax
    1443:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1446:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    144b:	74 18                	je     1465 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    144d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1450:	83 ec 04             	sub    $0x4,%esp
    1453:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1456:	6a 01                	push   $0x1
    1458:	50                   	push   %eax
    1459:	57                   	push   %edi
    145a:	e8 73 fe ff ff       	call   12d2 <write>
    145f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1462:	83 c4 10             	add    $0x10,%esp
    1465:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1468:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    146c:	84 db                	test   %bl,%bl
    146e:	74 73                	je     14e3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1470:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1472:	0f be cb             	movsbl %bl,%ecx
    1475:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1478:	74 c6                	je     1440 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    147a:	83 fa 25             	cmp    $0x25,%edx
    147d:	75 e6                	jne    1465 <printf+0x55>
      if(c == 'd'){
    147f:	83 f8 64             	cmp    $0x64,%eax
    1482:	0f 84 f8 00 00 00    	je     1580 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1488:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    148e:	83 f9 70             	cmp    $0x70,%ecx
    1491:	74 5d                	je     14f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1493:	83 f8 73             	cmp    $0x73,%eax
    1496:	0f 84 84 00 00 00    	je     1520 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    149c:	83 f8 63             	cmp    $0x63,%eax
    149f:	0f 84 ea 00 00 00    	je     158f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    14a5:	83 f8 25             	cmp    $0x25,%eax
    14a8:	0f 84 c2 00 00 00    	je     1570 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14b1:	83 ec 04             	sub    $0x4,%esp
    14b4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14b8:	6a 01                	push   $0x1
    14ba:	50                   	push   %eax
    14bb:	57                   	push   %edi
    14bc:	e8 11 fe ff ff       	call   12d2 <write>
    14c1:	83 c4 0c             	add    $0xc,%esp
    14c4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14c7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    14ca:	6a 01                	push   $0x1
    14cc:	50                   	push   %eax
    14cd:	57                   	push   %edi
    14ce:	83 c6 01             	add    $0x1,%esi
    14d1:	e8 fc fd ff ff       	call   12d2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14d6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14da:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14dd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14df:	84 db                	test   %bl,%bl
    14e1:	75 8d                	jne    1470 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14e6:	5b                   	pop    %ebx
    14e7:	5e                   	pop    %esi
    14e8:	5f                   	pop    %edi
    14e9:	5d                   	pop    %ebp
    14ea:	c3                   	ret    
    14eb:	90                   	nop
    14ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14f0:	83 ec 0c             	sub    $0xc,%esp
    14f3:	b9 10 00 00 00       	mov    $0x10,%ecx
    14f8:	6a 00                	push   $0x0
    14fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    14fd:	89 f8                	mov    %edi,%eax
    14ff:	8b 13                	mov    (%ebx),%edx
    1501:	e8 6a fe ff ff       	call   1370 <printint>
        ap++;
    1506:	89 d8                	mov    %ebx,%eax
    1508:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    150b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    150d:	83 c0 04             	add    $0x4,%eax
    1510:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1513:	e9 4d ff ff ff       	jmp    1465 <printf+0x55>
    1518:	90                   	nop
    1519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1520:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1523:	8b 18                	mov    (%eax),%ebx
        ap++;
    1525:	83 c0 04             	add    $0x4,%eax
    1528:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    152b:	b8 39 17 00 00       	mov    $0x1739,%eax
    1530:	85 db                	test   %ebx,%ebx
    1532:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1535:	0f b6 03             	movzbl (%ebx),%eax
    1538:	84 c0                	test   %al,%al
    153a:	74 23                	je     155f <printf+0x14f>
    153c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1540:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1543:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1546:	83 ec 04             	sub    $0x4,%esp
    1549:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    154b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    154e:	50                   	push   %eax
    154f:	57                   	push   %edi
    1550:	e8 7d fd ff ff       	call   12d2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1555:	0f b6 03             	movzbl (%ebx),%eax
    1558:	83 c4 10             	add    $0x10,%esp
    155b:	84 c0                	test   %al,%al
    155d:	75 e1                	jne    1540 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    155f:	31 d2                	xor    %edx,%edx
    1561:	e9 ff fe ff ff       	jmp    1465 <printf+0x55>
    1566:	8d 76 00             	lea    0x0(%esi),%esi
    1569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1570:	83 ec 04             	sub    $0x4,%esp
    1573:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1576:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1579:	6a 01                	push   $0x1
    157b:	e9 4c ff ff ff       	jmp    14cc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1580:	83 ec 0c             	sub    $0xc,%esp
    1583:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1588:	6a 01                	push   $0x1
    158a:	e9 6b ff ff ff       	jmp    14fa <printf+0xea>
    158f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1592:	83 ec 04             	sub    $0x4,%esp
    1595:	8b 03                	mov    (%ebx),%eax
    1597:	6a 01                	push   $0x1
    1599:	88 45 e4             	mov    %al,-0x1c(%ebp)
    159c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    159f:	50                   	push   %eax
    15a0:	57                   	push   %edi
    15a1:	e8 2c fd ff ff       	call   12d2 <write>
    15a6:	e9 5b ff ff ff       	jmp    1506 <printf+0xf6>
    15ab:	66 90                	xchg   %ax,%ax
    15ad:	66 90                	xchg   %ax,%ax
    15af:	90                   	nop

000015b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15b1:	a1 e4 19 00 00       	mov    0x19e4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    15b6:	89 e5                	mov    %esp,%ebp
    15b8:	57                   	push   %edi
    15b9:	56                   	push   %esi
    15ba:	53                   	push   %ebx
    15bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15be:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15c3:	39 c8                	cmp    %ecx,%eax
    15c5:	73 19                	jae    15e0 <free+0x30>
    15c7:	89 f6                	mov    %esi,%esi
    15c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    15d0:	39 d1                	cmp    %edx,%ecx
    15d2:	72 1c                	jb     15f0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15d4:	39 d0                	cmp    %edx,%eax
    15d6:	73 18                	jae    15f0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    15d8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15da:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15dc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15de:	72 f0                	jb     15d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15e0:	39 d0                	cmp    %edx,%eax
    15e2:	72 f4                	jb     15d8 <free+0x28>
    15e4:	39 d1                	cmp    %edx,%ecx
    15e6:	73 f0                	jae    15d8 <free+0x28>
    15e8:	90                   	nop
    15e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    15f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    15f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15f6:	39 d7                	cmp    %edx,%edi
    15f8:	74 19                	je     1613 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    15fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15fd:	8b 50 04             	mov    0x4(%eax),%edx
    1600:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1603:	39 f1                	cmp    %esi,%ecx
    1605:	74 23                	je     162a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1607:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1609:	a3 e4 19 00 00       	mov    %eax,0x19e4
}
    160e:	5b                   	pop    %ebx
    160f:	5e                   	pop    %esi
    1610:	5f                   	pop    %edi
    1611:	5d                   	pop    %ebp
    1612:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1613:	03 72 04             	add    0x4(%edx),%esi
    1616:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1619:	8b 10                	mov    (%eax),%edx
    161b:	8b 12                	mov    (%edx),%edx
    161d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1620:	8b 50 04             	mov    0x4(%eax),%edx
    1623:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1626:	39 f1                	cmp    %esi,%ecx
    1628:	75 dd                	jne    1607 <free+0x57>
    p->s.size += bp->s.size;
    162a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    162d:	a3 e4 19 00 00       	mov    %eax,0x19e4
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1632:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1635:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1638:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    163a:	5b                   	pop    %ebx
    163b:	5e                   	pop    %esi
    163c:	5f                   	pop    %edi
    163d:	5d                   	pop    %ebp
    163e:	c3                   	ret    
    163f:	90                   	nop

00001640 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	57                   	push   %edi
    1644:	56                   	push   %esi
    1645:	53                   	push   %ebx
    1646:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1649:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    164c:	8b 15 e4 19 00 00    	mov    0x19e4,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1652:	8d 78 07             	lea    0x7(%eax),%edi
    1655:	c1 ef 03             	shr    $0x3,%edi
    1658:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    165b:	85 d2                	test   %edx,%edx
    165d:	0f 84 a3 00 00 00    	je     1706 <malloc+0xc6>
    1663:	8b 02                	mov    (%edx),%eax
    1665:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1668:	39 cf                	cmp    %ecx,%edi
    166a:	76 74                	jbe    16e0 <malloc+0xa0>
    166c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1672:	be 00 10 00 00       	mov    $0x1000,%esi
    1677:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    167e:	0f 43 f7             	cmovae %edi,%esi
    1681:	ba 00 80 00 00       	mov    $0x8000,%edx
    1686:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    168c:	0f 46 da             	cmovbe %edx,%ebx
    168f:	eb 10                	jmp    16a1 <malloc+0x61>
    1691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1698:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    169a:	8b 48 04             	mov    0x4(%eax),%ecx
    169d:	39 cf                	cmp    %ecx,%edi
    169f:	76 3f                	jbe    16e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16a1:	39 05 e4 19 00 00    	cmp    %eax,0x19e4
    16a7:	89 c2                	mov    %eax,%edx
    16a9:	75 ed                	jne    1698 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	53                   	push   %ebx
    16af:	e8 86 fc ff ff       	call   133a <sbrk>
  if(p == (char*)-1)
    16b4:	83 c4 10             	add    $0x10,%esp
    16b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    16ba:	74 1c                	je     16d8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16bc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    16bf:	83 ec 0c             	sub    $0xc,%esp
    16c2:	83 c0 08             	add    $0x8,%eax
    16c5:	50                   	push   %eax
    16c6:	e8 e5 fe ff ff       	call   15b0 <free>
  return freep;
    16cb:	8b 15 e4 19 00 00    	mov    0x19e4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    16d1:	83 c4 10             	add    $0x10,%esp
    16d4:	85 d2                	test   %edx,%edx
    16d6:	75 c0                	jne    1698 <malloc+0x58>
        return 0;
    16d8:	31 c0                	xor    %eax,%eax
    16da:	eb 1c                	jmp    16f8 <malloc+0xb8>
    16dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    16e0:	39 cf                	cmp    %ecx,%edi
    16e2:	74 1c                	je     1700 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16e4:	29 f9                	sub    %edi,%ecx
    16e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    16e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    16ec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    16ef:	89 15 e4 19 00 00    	mov    %edx,0x19e4
      return (void*)(p + 1);
    16f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16fb:	5b                   	pop    %ebx
    16fc:	5e                   	pop    %esi
    16fd:	5f                   	pop    %edi
    16fe:	5d                   	pop    %ebp
    16ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1700:	8b 08                	mov    (%eax),%ecx
    1702:	89 0a                	mov    %ecx,(%edx)
    1704:	eb e9                	jmp    16ef <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1706:	c7 05 e4 19 00 00 e8 	movl   $0x19e8,0x19e4
    170d:	19 00 00 
    1710:	c7 05 e8 19 00 00 e8 	movl   $0x19e8,0x19e8
    1717:	19 00 00 
    base.s.size = 0;
    171a:	b8 e8 19 00 00       	mov    $0x19e8,%eax
    171f:	c7 05 ec 19 00 00 00 	movl   $0x0,0x19ec
    1726:	00 00 00 
    1729:	e9 3e ff ff ff       	jmp    166c <malloc+0x2c>
