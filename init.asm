
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	53                   	push   %ebx
    100e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100f:	83 ec 08             	sub    $0x8,%esp
    1012:	6a 02                	push   $0x2
    1014:	68 b0 17 00 00       	push   $0x17b0
    1019:	e8 54 03 00 00       	call   1372 <open>
    101e:	83 c4 10             	add    $0x10,%esp
    1021:	85 c0                	test   %eax,%eax
    1023:	0f 88 9f 00 00 00    	js     10c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	6a 00                	push   $0x0
    102e:	e8 77 03 00 00       	call   13aa <dup>
  dup(0);  // stderr
    1033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103a:	e8 6b 03 00 00       	call   13aa <dup>
    103f:	83 c4 10             	add    $0x10,%esp
    1042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
    1048:	83 ec 08             	sub    $0x8,%esp
    104b:	68 b8 17 00 00       	push   $0x17b8
    1050:	6a 01                	push   $0x1
    1052:	e8 39 04 00 00       	call   1490 <printf>
    pid = fork();
    1057:	e8 ce 02 00 00       	call   132a <fork>
    if(pid < 0){
    105c:	83 c4 10             	add    $0x10,%esp
    105f:	85 c0                	test   %eax,%eax
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    1061:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1063:	78 2c                	js     1091 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
    1065:	74 3d                	je     10a4 <main+0xa4>
    1067:	89 f6                	mov    %esi,%esi
    1069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    1070:	e8 c5 02 00 00       	call   133a <wait>
    1075:	85 c0                	test   %eax,%eax
    1077:	78 cf                	js     1048 <main+0x48>
    1079:	39 c3                	cmp    %eax,%ebx
    107b:	74 cb                	je     1048 <main+0x48>
      printf(1, "zombie!\n");
    107d:	83 ec 08             	sub    $0x8,%esp
    1080:	68 f7 17 00 00       	push   $0x17f7
    1085:	6a 01                	push   $0x1
    1087:	e8 04 04 00 00       	call   1490 <printf>
    108c:	83 c4 10             	add    $0x10,%esp
    108f:	eb df                	jmp    1070 <main+0x70>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
    1091:	53                   	push   %ebx
    1092:	53                   	push   %ebx
    1093:	68 cb 17 00 00       	push   $0x17cb
    1098:	6a 01                	push   $0x1
    109a:	e8 f1 03 00 00       	call   1490 <printf>
      exit();
    109f:	e8 8e 02 00 00       	call   1332 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
    10a4:	50                   	push   %eax
    10a5:	50                   	push   %eax
    10a6:	68 a4 1a 00 00       	push   $0x1aa4
    10ab:	68 de 17 00 00       	push   $0x17de
    10b0:	e8 b5 02 00 00       	call   136a <exec>
      printf(1, "init: exec sh failed\n");
    10b5:	5a                   	pop    %edx
    10b6:	59                   	pop    %ecx
    10b7:	68 e1 17 00 00       	push   $0x17e1
    10bc:	6a 01                	push   $0x1
    10be:	e8 cd 03 00 00       	call   1490 <printf>
      exit();
    10c3:	e8 6a 02 00 00       	call   1332 <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
    10c8:	50                   	push   %eax
    10c9:	6a 01                	push   $0x1
    10cb:	6a 01                	push   $0x1
    10cd:	68 b0 17 00 00       	push   $0x17b0
    10d2:	e8 a3 02 00 00       	call   137a <mknod>
    open("console", O_RDWR);
    10d7:	58                   	pop    %eax
    10d8:	5a                   	pop    %edx
    10d9:	6a 02                	push   $0x2
    10db:	68 b0 17 00 00       	push   $0x17b0
    10e0:	e8 8d 02 00 00       	call   1372 <open>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	e9 3c ff ff ff       	jmp    1029 <main+0x29>
    10ed:	66 90                	xchg   %ax,%ax
    10ef:	90                   	nop

000010f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	53                   	push   %ebx
    10f4:	8b 45 08             	mov    0x8(%ebp),%eax
    10f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10fa:	89 c2                	mov    %eax,%edx
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1100:	83 c1 01             	add    $0x1,%ecx
    1103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1107:	83 c2 01             	add    $0x1,%edx
    110a:	84 db                	test   %bl,%bl
    110c:	88 5a ff             	mov    %bl,-0x1(%edx)
    110f:	75 ef                	jne    1100 <strcpy+0x10>
    ;
  return os;
}
    1111:	5b                   	pop    %ebx
    1112:	5d                   	pop    %ebp
    1113:	c3                   	ret    
    1114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    111a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	56                   	push   %esi
    1124:	53                   	push   %ebx
    1125:	8b 55 08             	mov    0x8(%ebp),%edx
    1128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    112b:	0f b6 02             	movzbl (%edx),%eax
    112e:	0f b6 19             	movzbl (%ecx),%ebx
    1131:	84 c0                	test   %al,%al
    1133:	75 1e                	jne    1153 <strcmp+0x33>
    1135:	eb 29                	jmp    1160 <strcmp+0x40>
    1137:	89 f6                	mov    %esi,%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1140:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1146:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1149:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    114d:	84 c0                	test   %al,%al
    114f:	74 0f                	je     1160 <strcmp+0x40>
    1151:	89 f1                	mov    %esi,%ecx
    1153:	38 d8                	cmp    %bl,%al
    1155:	74 e9                	je     1140 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1157:	29 d8                	sub    %ebx,%eax
}
    1159:	5b                   	pop    %ebx
    115a:	5e                   	pop    %esi
    115b:	5d                   	pop    %ebp
    115c:	c3                   	ret    
    115d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1160:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1162:	29 d8                	sub    %ebx,%eax
}
    1164:	5b                   	pop    %ebx
    1165:	5e                   	pop    %esi
    1166:	5d                   	pop    %ebp
    1167:	c3                   	ret    
    1168:	90                   	nop
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001170 <strlen>:

uint
strlen(char *s)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1176:	80 39 00             	cmpb   $0x0,(%ecx)
    1179:	74 12                	je     118d <strlen+0x1d>
    117b:	31 d2                	xor    %edx,%edx
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	83 c2 01             	add    $0x1,%edx
    1183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1187:	89 d0                	mov    %edx,%eax
    1189:	75 f5                	jne    1180 <strlen+0x10>
    ;
  return n;
}
    118b:	5d                   	pop    %ebp
    118c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    118d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    118f:	5d                   	pop    %ebp
    1190:	c3                   	ret    
    1191:	eb 0d                	jmp    11a0 <memset>
    1193:	90                   	nop
    1194:	90                   	nop
    1195:	90                   	nop
    1196:	90                   	nop
    1197:	90                   	nop
    1198:	90                   	nop
    1199:	90                   	nop
    119a:	90                   	nop
    119b:	90                   	nop
    119c:	90                   	nop
    119d:	90                   	nop
    119e:	90                   	nop
    119f:	90                   	nop

000011a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	57                   	push   %edi
    11a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ad:	89 d7                	mov    %edx,%edi
    11af:	fc                   	cld    
    11b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11b2:	89 d0                	mov    %edx,%eax
    11b4:	5f                   	pop    %edi
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret    
    11b7:	89 f6                	mov    %esi,%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011c0 <strchr>:

char*
strchr(const char *s, char c)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	53                   	push   %ebx
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    11ca:	0f b6 10             	movzbl (%eax),%edx
    11cd:	84 d2                	test   %dl,%dl
    11cf:	74 1d                	je     11ee <strchr+0x2e>
    if(*s == c)
    11d1:	38 d3                	cmp    %dl,%bl
    11d3:	89 d9                	mov    %ebx,%ecx
    11d5:	75 0d                	jne    11e4 <strchr+0x24>
    11d7:	eb 17                	jmp    11f0 <strchr+0x30>
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11e0:	38 ca                	cmp    %cl,%dl
    11e2:	74 0c                	je     11f0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    11e4:	83 c0 01             	add    $0x1,%eax
    11e7:	0f b6 10             	movzbl (%eax),%edx
    11ea:	84 d2                	test   %dl,%dl
    11ec:	75 f2                	jne    11e0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    11ee:	31 c0                	xor    %eax,%eax
}
    11f0:	5b                   	pop    %ebx
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    
    11f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <gets>:

char*
gets(char *buf, int max)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1206:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1208:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    120b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    120e:	eb 29                	jmp    1239 <gets+0x39>
    cc = read(0, &c, 1);
    1210:	83 ec 04             	sub    $0x4,%esp
    1213:	6a 01                	push   $0x1
    1215:	57                   	push   %edi
    1216:	6a 00                	push   $0x0
    1218:	e8 2d 01 00 00       	call   134a <read>
    if(cc < 1)
    121d:	83 c4 10             	add    $0x10,%esp
    1220:	85 c0                	test   %eax,%eax
    1222:	7e 1d                	jle    1241 <gets+0x41>
      break;
    buf[i++] = c;
    1224:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1228:	8b 55 08             	mov    0x8(%ebp),%edx
    122b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    122d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    122f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1233:	74 1b                	je     1250 <gets+0x50>
    1235:	3c 0d                	cmp    $0xd,%al
    1237:	74 17                	je     1250 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1239:	8d 5e 01             	lea    0x1(%esi),%ebx
    123c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    123f:	7c cf                	jl     1210 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1241:	8b 45 08             	mov    0x8(%ebp),%eax
    1244:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1248:	8d 65 f4             	lea    -0xc(%ebp),%esp
    124b:	5b                   	pop    %ebx
    124c:	5e                   	pop    %esi
    124d:	5f                   	pop    %edi
    124e:	5d                   	pop    %ebp
    124f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1253:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1255:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1259:	8d 65 f4             	lea    -0xc(%ebp),%esp
    125c:	5b                   	pop    %ebx
    125d:	5e                   	pop    %esi
    125e:	5f                   	pop    %edi
    125f:	5d                   	pop    %ebp
    1260:	c3                   	ret    
    1261:	eb 0d                	jmp    1270 <stat>
    1263:	90                   	nop
    1264:	90                   	nop
    1265:	90                   	nop
    1266:	90                   	nop
    1267:	90                   	nop
    1268:	90                   	nop
    1269:	90                   	nop
    126a:	90                   	nop
    126b:	90                   	nop
    126c:	90                   	nop
    126d:	90                   	nop
    126e:	90                   	nop
    126f:	90                   	nop

00001270 <stat>:

int
stat(char *n, struct stat *st)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	56                   	push   %esi
    1274:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1275:	83 ec 08             	sub    $0x8,%esp
    1278:	6a 00                	push   $0x0
    127a:	ff 75 08             	pushl  0x8(%ebp)
    127d:	e8 f0 00 00 00       	call   1372 <open>
  if(fd < 0)
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	85 c0                	test   %eax,%eax
    1287:	78 27                	js     12b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1289:	83 ec 08             	sub    $0x8,%esp
    128c:	ff 75 0c             	pushl  0xc(%ebp)
    128f:	89 c3                	mov    %eax,%ebx
    1291:	50                   	push   %eax
    1292:	e8 f3 00 00 00       	call   138a <fstat>
    1297:	89 c6                	mov    %eax,%esi
  close(fd);
    1299:	89 1c 24             	mov    %ebx,(%esp)
    129c:	e8 b9 00 00 00       	call   135a <close>
  return r;
    12a1:	83 c4 10             	add    $0x10,%esp
    12a4:	89 f0                	mov    %esi,%eax
}
    12a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12a9:	5b                   	pop    %ebx
    12aa:	5e                   	pop    %esi
    12ab:	5d                   	pop    %ebp
    12ac:	c3                   	ret    
    12ad:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    12b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12b5:	eb ef                	jmp    12a6 <stat+0x36>
    12b7:	89 f6                	mov    %esi,%esi
    12b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	53                   	push   %ebx
    12c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12c7:	0f be 11             	movsbl (%ecx),%edx
    12ca:	8d 42 d0             	lea    -0x30(%edx),%eax
    12cd:	3c 09                	cmp    $0x9,%al
    12cf:	b8 00 00 00 00       	mov    $0x0,%eax
    12d4:	77 1f                	ja     12f5 <atoi+0x35>
    12d6:	8d 76 00             	lea    0x0(%esi),%esi
    12d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    12e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12e3:	83 c1 01             	add    $0x1,%ecx
    12e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12ea:	0f be 11             	movsbl (%ecx),%edx
    12ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12f0:	80 fb 09             	cmp    $0x9,%bl
    12f3:	76 eb                	jbe    12e0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    12f5:	5b                   	pop    %ebx
    12f6:	5d                   	pop    %ebp
    12f7:	c3                   	ret    
    12f8:	90                   	nop
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	56                   	push   %esi
    1304:	53                   	push   %ebx
    1305:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1308:	8b 45 08             	mov    0x8(%ebp),%eax
    130b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    130e:	85 db                	test   %ebx,%ebx
    1310:	7e 14                	jle    1326 <memmove+0x26>
    1312:	31 d2                	xor    %edx,%edx
    1314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1318:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    131c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    131f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1322:	39 da                	cmp    %ebx,%edx
    1324:	75 f2                	jne    1318 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1326:	5b                   	pop    %ebx
    1327:	5e                   	pop    %esi
    1328:	5d                   	pop    %ebp
    1329:	c3                   	ret    

0000132a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    132a:	b8 01 00 00 00       	mov    $0x1,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <exit>:
SYSCALL(exit)
    1332:	b8 02 00 00 00       	mov    $0x2,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <wait>:
SYSCALL(wait)
    133a:	b8 03 00 00 00       	mov    $0x3,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <pipe>:
SYSCALL(pipe)
    1342:	b8 04 00 00 00       	mov    $0x4,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <read>:
SYSCALL(read)
    134a:	b8 05 00 00 00       	mov    $0x5,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <write>:
SYSCALL(write)
    1352:	b8 10 00 00 00       	mov    $0x10,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <close>:
SYSCALL(close)
    135a:	b8 15 00 00 00       	mov    $0x15,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <kill>:
SYSCALL(kill)
    1362:	b8 06 00 00 00       	mov    $0x6,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <exec>:
SYSCALL(exec)
    136a:	b8 07 00 00 00       	mov    $0x7,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <open>:
SYSCALL(open)
    1372:	b8 0f 00 00 00       	mov    $0xf,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <mknod>:
SYSCALL(mknod)
    137a:	b8 11 00 00 00       	mov    $0x11,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <unlink>:
SYSCALL(unlink)
    1382:	b8 12 00 00 00       	mov    $0x12,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <fstat>:
SYSCALL(fstat)
    138a:	b8 08 00 00 00       	mov    $0x8,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <link>:
SYSCALL(link)
    1392:	b8 13 00 00 00       	mov    $0x13,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <mkdir>:
SYSCALL(mkdir)
    139a:	b8 14 00 00 00       	mov    $0x14,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <chdir>:
SYSCALL(chdir)
    13a2:	b8 09 00 00 00       	mov    $0x9,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <dup>:
SYSCALL(dup)
    13aa:	b8 0a 00 00 00       	mov    $0xa,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <getpid>:
SYSCALL(getpid)
    13b2:	b8 0b 00 00 00       	mov    $0xb,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <sbrk>:
SYSCALL(sbrk)
    13ba:	b8 0c 00 00 00       	mov    $0xc,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <sleep>:
SYSCALL(sleep)
    13c2:	b8 0d 00 00 00       	mov    $0xd,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <uptime>:
SYSCALL(uptime)
    13ca:	b8 0e 00 00 00       	mov    $0xe,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <getcount>:
SYSCALL(getcount) //added getcount here
    13d2:	b8 16 00 00 00       	mov    $0x16,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    13da:	b8 17 00 00 00       	mov    $0x17,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <increasepriority>:
SYSCALL(increasepriority)
    13e2:	b8 18 00 00 00       	mov    $0x18,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    
    13ea:	66 90                	xchg   %ax,%ax
    13ec:	66 90                	xchg   %ax,%ax
    13ee:	66 90                	xchg   %ax,%ax

000013f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	57                   	push   %edi
    13f4:	56                   	push   %esi
    13f5:	53                   	push   %ebx
    13f6:	89 c6                	mov    %eax,%esi
    13f8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13fe:	85 db                	test   %ebx,%ebx
    1400:	74 7e                	je     1480 <printint+0x90>
    1402:	89 d0                	mov    %edx,%eax
    1404:	c1 e8 1f             	shr    $0x1f,%eax
    1407:	84 c0                	test   %al,%al
    1409:	74 75                	je     1480 <printint+0x90>
    neg = 1;
    x = -xx;
    140b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    140d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1414:	f7 d8                	neg    %eax
    1416:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1419:	31 ff                	xor    %edi,%edi
    141b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    141e:	89 ce                	mov    %ecx,%esi
    1420:	eb 08                	jmp    142a <printint+0x3a>
    1422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1428:	89 cf                	mov    %ecx,%edi
    142a:	31 d2                	xor    %edx,%edx
    142c:	8d 4f 01             	lea    0x1(%edi),%ecx
    142f:	f7 f6                	div    %esi
    1431:	0f b6 92 08 18 00 00 	movzbl 0x1808(%edx),%edx
  }while((x /= base) != 0);
    1438:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    143a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    143d:	75 e9                	jne    1428 <printint+0x38>
  if(neg)
    143f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1442:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1445:	85 c0                	test   %eax,%eax
    1447:	74 08                	je     1451 <printint+0x61>
    buf[i++] = '-';
    1449:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    144e:	8d 4f 02             	lea    0x2(%edi),%ecx
    1451:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    1455:	8d 76 00             	lea    0x0(%esi),%esi
    1458:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    145b:	83 ec 04             	sub    $0x4,%esp
    145e:	83 ef 01             	sub    $0x1,%edi
    1461:	6a 01                	push   $0x1
    1463:	53                   	push   %ebx
    1464:	56                   	push   %esi
    1465:	88 45 d7             	mov    %al,-0x29(%ebp)
    1468:	e8 e5 fe ff ff       	call   1352 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    146d:	83 c4 10             	add    $0x10,%esp
    1470:	39 df                	cmp    %ebx,%edi
    1472:	75 e4                	jne    1458 <printint+0x68>
    putc(fd, buf[i]);
}
    1474:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1477:	5b                   	pop    %ebx
    1478:	5e                   	pop    %esi
    1479:	5f                   	pop    %edi
    147a:	5d                   	pop    %ebp
    147b:	c3                   	ret    
    147c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1480:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1482:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1489:	eb 8b                	jmp    1416 <printint+0x26>
    148b:	90                   	nop
    148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001490 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1490:	55                   	push   %ebp
    1491:	89 e5                	mov    %esp,%ebp
    1493:	57                   	push   %edi
    1494:	56                   	push   %esi
    1495:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1496:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1499:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    149c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    149f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    14a5:	0f b6 1e             	movzbl (%esi),%ebx
    14a8:	83 c6 01             	add    $0x1,%esi
    14ab:	84 db                	test   %bl,%bl
    14ad:	0f 84 b0 00 00 00    	je     1563 <printf+0xd3>
    14b3:	31 d2                	xor    %edx,%edx
    14b5:	eb 39                	jmp    14f0 <printf+0x60>
    14b7:	89 f6                	mov    %esi,%esi
    14b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14c0:	83 f8 25             	cmp    $0x25,%eax
    14c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    14c6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14cb:	74 18                	je     14e5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14cd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    14d0:	83 ec 04             	sub    $0x4,%esp
    14d3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    14d6:	6a 01                	push   $0x1
    14d8:	50                   	push   %eax
    14d9:	57                   	push   %edi
    14da:	e8 73 fe ff ff       	call   1352 <write>
    14df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    14e2:	83 c4 10             	add    $0x10,%esp
    14e5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14e8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    14ec:	84 db                	test   %bl,%bl
    14ee:	74 73                	je     1563 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    14f0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    14f2:	0f be cb             	movsbl %bl,%ecx
    14f5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14f8:	74 c6                	je     14c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14fa:	83 fa 25             	cmp    $0x25,%edx
    14fd:	75 e6                	jne    14e5 <printf+0x55>
      if(c == 'd'){
    14ff:	83 f8 64             	cmp    $0x64,%eax
    1502:	0f 84 f8 00 00 00    	je     1600 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1508:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    150e:	83 f9 70             	cmp    $0x70,%ecx
    1511:	74 5d                	je     1570 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1513:	83 f8 73             	cmp    $0x73,%eax
    1516:	0f 84 84 00 00 00    	je     15a0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    151c:	83 f8 63             	cmp    $0x63,%eax
    151f:	0f 84 ea 00 00 00    	je     160f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1525:	83 f8 25             	cmp    $0x25,%eax
    1528:	0f 84 c2 00 00 00    	je     15f0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    152e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1531:	83 ec 04             	sub    $0x4,%esp
    1534:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1538:	6a 01                	push   $0x1
    153a:	50                   	push   %eax
    153b:	57                   	push   %edi
    153c:	e8 11 fe ff ff       	call   1352 <write>
    1541:	83 c4 0c             	add    $0xc,%esp
    1544:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1547:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    154a:	6a 01                	push   $0x1
    154c:	50                   	push   %eax
    154d:	57                   	push   %edi
    154e:	83 c6 01             	add    $0x1,%esi
    1551:	e8 fc fd ff ff       	call   1352 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1556:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    155a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    155d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    155f:	84 db                	test   %bl,%bl
    1561:	75 8d                	jne    14f0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1563:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1566:	5b                   	pop    %ebx
    1567:	5e                   	pop    %esi
    1568:	5f                   	pop    %edi
    1569:	5d                   	pop    %ebp
    156a:	c3                   	ret    
    156b:	90                   	nop
    156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1570:	83 ec 0c             	sub    $0xc,%esp
    1573:	b9 10 00 00 00       	mov    $0x10,%ecx
    1578:	6a 00                	push   $0x0
    157a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    157d:	89 f8                	mov    %edi,%eax
    157f:	8b 13                	mov    (%ebx),%edx
    1581:	e8 6a fe ff ff       	call   13f0 <printint>
        ap++;
    1586:	89 d8                	mov    %ebx,%eax
    1588:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    158b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    158d:	83 c0 04             	add    $0x4,%eax
    1590:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1593:	e9 4d ff ff ff       	jmp    14e5 <printf+0x55>
    1598:	90                   	nop
    1599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    15a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    15a3:	8b 18                	mov    (%eax),%ebx
        ap++;
    15a5:	83 c0 04             	add    $0x4,%eax
    15a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    15ab:	b8 00 18 00 00       	mov    $0x1800,%eax
    15b0:	85 db                	test   %ebx,%ebx
    15b2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    15b5:	0f b6 03             	movzbl (%ebx),%eax
    15b8:	84 c0                	test   %al,%al
    15ba:	74 23                	je     15df <printf+0x14f>
    15bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15c3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    15c6:	83 ec 04             	sub    $0x4,%esp
    15c9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    15cb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15ce:	50                   	push   %eax
    15cf:	57                   	push   %edi
    15d0:	e8 7d fd ff ff       	call   1352 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15d5:	0f b6 03             	movzbl (%ebx),%eax
    15d8:	83 c4 10             	add    $0x10,%esp
    15db:	84 c0                	test   %al,%al
    15dd:	75 e1                	jne    15c0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    15df:	31 d2                	xor    %edx,%edx
    15e1:	e9 ff fe ff ff       	jmp    14e5 <printf+0x55>
    15e6:	8d 76 00             	lea    0x0(%esi),%esi
    15e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15f0:	83 ec 04             	sub    $0x4,%esp
    15f3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    15f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    15f9:	6a 01                	push   $0x1
    15fb:	e9 4c ff ff ff       	jmp    154c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1600:	83 ec 0c             	sub    $0xc,%esp
    1603:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1608:	6a 01                	push   $0x1
    160a:	e9 6b ff ff ff       	jmp    157a <printf+0xea>
    160f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1612:	83 ec 04             	sub    $0x4,%esp
    1615:	8b 03                	mov    (%ebx),%eax
    1617:	6a 01                	push   $0x1
    1619:	88 45 e4             	mov    %al,-0x1c(%ebp)
    161c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    161f:	50                   	push   %eax
    1620:	57                   	push   %edi
    1621:	e8 2c fd ff ff       	call   1352 <write>
    1626:	e9 5b ff ff ff       	jmp    1586 <printf+0xf6>
    162b:	66 90                	xchg   %ax,%ax
    162d:	66 90                	xchg   %ax,%ax
    162f:	90                   	nop

00001630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1631:	a1 ac 1a 00 00       	mov    0x1aac,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1636:	89 e5                	mov    %esp,%ebp
    1638:	57                   	push   %edi
    1639:	56                   	push   %esi
    163a:	53                   	push   %ebx
    163b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    163e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1640:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1643:	39 c8                	cmp    %ecx,%eax
    1645:	73 19                	jae    1660 <free+0x30>
    1647:	89 f6                	mov    %esi,%esi
    1649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1650:	39 d1                	cmp    %edx,%ecx
    1652:	72 1c                	jb     1670 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1654:	39 d0                	cmp    %edx,%eax
    1656:	73 18                	jae    1670 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1658:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    165a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    165c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    165e:	72 f0                	jb     1650 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1660:	39 d0                	cmp    %edx,%eax
    1662:	72 f4                	jb     1658 <free+0x28>
    1664:	39 d1                	cmp    %edx,%ecx
    1666:	73 f0                	jae    1658 <free+0x28>
    1668:	90                   	nop
    1669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1670:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1676:	39 d7                	cmp    %edx,%edi
    1678:	74 19                	je     1693 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    167a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    167d:	8b 50 04             	mov    0x4(%eax),%edx
    1680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1683:	39 f1                	cmp    %esi,%ecx
    1685:	74 23                	je     16aa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1687:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1689:	a3 ac 1a 00 00       	mov    %eax,0x1aac
}
    168e:	5b                   	pop    %ebx
    168f:	5e                   	pop    %esi
    1690:	5f                   	pop    %edi
    1691:	5d                   	pop    %ebp
    1692:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1693:	03 72 04             	add    0x4(%edx),%esi
    1696:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1699:	8b 10                	mov    (%eax),%edx
    169b:	8b 12                	mov    (%edx),%edx
    169d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    16a0:	8b 50 04             	mov    0x4(%eax),%edx
    16a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16a6:	39 f1                	cmp    %esi,%ecx
    16a8:	75 dd                	jne    1687 <free+0x57>
    p->s.size += bp->s.size;
    16aa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    16ad:	a3 ac 1a 00 00       	mov    %eax,0x1aac
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    16b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16b5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    16b8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    16ba:	5b                   	pop    %ebx
    16bb:	5e                   	pop    %esi
    16bc:	5f                   	pop    %edi
    16bd:	5d                   	pop    %ebp
    16be:	c3                   	ret    
    16bf:	90                   	nop

000016c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16c0:	55                   	push   %ebp
    16c1:	89 e5                	mov    %esp,%ebp
    16c3:	57                   	push   %edi
    16c4:	56                   	push   %esi
    16c5:	53                   	push   %ebx
    16c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16cc:	8b 15 ac 1a 00 00    	mov    0x1aac,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16d2:	8d 78 07             	lea    0x7(%eax),%edi
    16d5:	c1 ef 03             	shr    $0x3,%edi
    16d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16db:	85 d2                	test   %edx,%edx
    16dd:	0f 84 a3 00 00 00    	je     1786 <malloc+0xc6>
    16e3:	8b 02                	mov    (%edx),%eax
    16e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16e8:	39 cf                	cmp    %ecx,%edi
    16ea:	76 74                	jbe    1760 <malloc+0xa0>
    16ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    16f2:	be 00 10 00 00       	mov    $0x1000,%esi
    16f7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    16fe:	0f 43 f7             	cmovae %edi,%esi
    1701:	ba 00 80 00 00       	mov    $0x8000,%edx
    1706:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    170c:	0f 46 da             	cmovbe %edx,%ebx
    170f:	eb 10                	jmp    1721 <malloc+0x61>
    1711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1718:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    171a:	8b 48 04             	mov    0x4(%eax),%ecx
    171d:	39 cf                	cmp    %ecx,%edi
    171f:	76 3f                	jbe    1760 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1721:	39 05 ac 1a 00 00    	cmp    %eax,0x1aac
    1727:	89 c2                	mov    %eax,%edx
    1729:	75 ed                	jne    1718 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    172b:	83 ec 0c             	sub    $0xc,%esp
    172e:	53                   	push   %ebx
    172f:	e8 86 fc ff ff       	call   13ba <sbrk>
  if(p == (char*)-1)
    1734:	83 c4 10             	add    $0x10,%esp
    1737:	83 f8 ff             	cmp    $0xffffffff,%eax
    173a:	74 1c                	je     1758 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    173c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    173f:	83 ec 0c             	sub    $0xc,%esp
    1742:	83 c0 08             	add    $0x8,%eax
    1745:	50                   	push   %eax
    1746:	e8 e5 fe ff ff       	call   1630 <free>
  return freep;
    174b:	8b 15 ac 1a 00 00    	mov    0x1aac,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1751:	83 c4 10             	add    $0x10,%esp
    1754:	85 d2                	test   %edx,%edx
    1756:	75 c0                	jne    1718 <malloc+0x58>
        return 0;
    1758:	31 c0                	xor    %eax,%eax
    175a:	eb 1c                	jmp    1778 <malloc+0xb8>
    175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1760:	39 cf                	cmp    %ecx,%edi
    1762:	74 1c                	je     1780 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1764:	29 f9                	sub    %edi,%ecx
    1766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    176c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    176f:	89 15 ac 1a 00 00    	mov    %edx,0x1aac
      return (void*)(p + 1);
    1775:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1778:	8d 65 f4             	lea    -0xc(%ebp),%esp
    177b:	5b                   	pop    %ebx
    177c:	5e                   	pop    %esi
    177d:	5f                   	pop    %edi
    177e:	5d                   	pop    %ebp
    177f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1780:	8b 08                	mov    (%eax),%ecx
    1782:	89 0a                	mov    %ecx,(%edx)
    1784:	eb e9                	jmp    176f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1786:	c7 05 ac 1a 00 00 b0 	movl   $0x1ab0,0x1aac
    178d:	1a 00 00 
    1790:	c7 05 b0 1a 00 00 b0 	movl   $0x1ab0,0x1ab0
    1797:	1a 00 00 
    base.s.size = 0;
    179a:	b8 b0 1a 00 00       	mov    $0x1ab0,%eax
    179f:	c7 05 b4 1a 00 00 00 	movl   $0x0,0x1ab4
    17a6:	00 00 00 
    17a9:	e9 3e ff ff ff       	jmp    16ec <malloc+0x2c>
