
_rm:     file format elf32-i386


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
    1011:	bf 01 00 00 00       	mov    $0x1,%edi
    1016:	83 ec 08             	sub    $0x8,%esp
    1019:	8b 31                	mov    (%ecx),%esi
    101b:	8b 59 04             	mov    0x4(%ecx),%ebx
    101e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
    1021:	83 fe 01             	cmp    $0x1,%esi
    1024:	7e 3e                	jle    1064 <main+0x64>
    1026:	8d 76 00             	lea    0x0(%esi),%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
    1030:	83 ec 0c             	sub    $0xc,%esp
    1033:	ff 33                	pushl  (%ebx)
    1035:	e8 d8 02 00 00       	call   1312 <unlink>
    103a:	83 c4 10             	add    $0x10,%esp
    103d:	85 c0                	test   %eax,%eax
    103f:	78 0f                	js     1050 <main+0x50>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    1041:	83 c7 01             	add    $0x1,%edi
    1044:	83 c3 04             	add    $0x4,%ebx
    1047:	39 fe                	cmp    %edi,%esi
    1049:	75 e5                	jne    1030 <main+0x30>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
    104b:	e8 72 02 00 00       	call   12c2 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf(2, "rm: %s failed to delete\n", argv[i]);
    1050:	50                   	push   %eax
    1051:	ff 33                	pushl  (%ebx)
    1053:	68 54 17 00 00       	push   $0x1754
    1058:	6a 02                	push   $0x2
    105a:	e8 c1 03 00 00       	call   1420 <printf>
      break;
    105f:	83 c4 10             	add    $0x10,%esp
    1062:	eb e7                	jmp    104b <main+0x4b>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    1064:	52                   	push   %edx
    1065:	52                   	push   %edx
    1066:	68 40 17 00 00       	push   $0x1740
    106b:	6a 02                	push   $0x2
    106d:	e8 ae 03 00 00       	call   1420 <printf>
    exit();
    1072:	e8 4b 02 00 00       	call   12c2 <exit>
    1077:	66 90                	xchg   %ax,%ax
    1079:	66 90                	xchg   %ax,%ax
    107b:	66 90                	xchg   %ax,%ax
    107d:	66 90                	xchg   %ax,%ax
    107f:	90                   	nop

00001080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	53                   	push   %ebx
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    108a:	89 c2                	mov    %eax,%edx
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1090:	83 c1 01             	add    $0x1,%ecx
    1093:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1097:	83 c2 01             	add    $0x1,%edx
    109a:	84 db                	test   %bl,%bl
    109c:	88 5a ff             	mov    %bl,-0x1(%edx)
    109f:	75 ef                	jne    1090 <strcpy+0x10>
    ;
  return os;
}
    10a1:	5b                   	pop    %ebx
    10a2:	5d                   	pop    %ebp
    10a3:	c3                   	ret    
    10a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	56                   	push   %esi
    10b4:	53                   	push   %ebx
    10b5:	8b 55 08             	mov    0x8(%ebp),%edx
    10b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10bb:	0f b6 02             	movzbl (%edx),%eax
    10be:	0f b6 19             	movzbl (%ecx),%ebx
    10c1:	84 c0                	test   %al,%al
    10c3:	75 1e                	jne    10e3 <strcmp+0x33>
    10c5:	eb 29                	jmp    10f0 <strcmp+0x40>
    10c7:	89 f6                	mov    %esi,%esi
    10c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    10d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    10d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    10dd:	84 c0                	test   %al,%al
    10df:	74 0f                	je     10f0 <strcmp+0x40>
    10e1:	89 f1                	mov    %esi,%ecx
    10e3:	38 d8                	cmp    %bl,%al
    10e5:	74 e9                	je     10d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10e7:	29 d8                	sub    %ebx,%eax
}
    10e9:	5b                   	pop    %ebx
    10ea:	5e                   	pop    %esi
    10eb:	5d                   	pop    %ebp
    10ec:	c3                   	ret    
    10ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10f2:	29 d8                	sub    %ebx,%eax
}
    10f4:	5b                   	pop    %ebx
    10f5:	5e                   	pop    %esi
    10f6:	5d                   	pop    %ebp
    10f7:	c3                   	ret    
    10f8:	90                   	nop
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001100 <strlen>:

uint
strlen(char *s)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1106:	80 39 00             	cmpb   $0x0,(%ecx)
    1109:	74 12                	je     111d <strlen+0x1d>
    110b:	31 d2                	xor    %edx,%edx
    110d:	8d 76 00             	lea    0x0(%esi),%esi
    1110:	83 c2 01             	add    $0x1,%edx
    1113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1117:	89 d0                	mov    %edx,%eax
    1119:	75 f5                	jne    1110 <strlen+0x10>
    ;
  return n;
}
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    111d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    111f:	5d                   	pop    %ebp
    1120:	c3                   	ret    
    1121:	eb 0d                	jmp    1130 <memset>
    1123:	90                   	nop
    1124:	90                   	nop
    1125:	90                   	nop
    1126:	90                   	nop
    1127:	90                   	nop
    1128:	90                   	nop
    1129:	90                   	nop
    112a:	90                   	nop
    112b:	90                   	nop
    112c:	90                   	nop
    112d:	90                   	nop
    112e:	90                   	nop
    112f:	90                   	nop

00001130 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1137:	8b 4d 10             	mov    0x10(%ebp),%ecx
    113a:	8b 45 0c             	mov    0xc(%ebp),%eax
    113d:	89 d7                	mov    %edx,%edi
    113f:	fc                   	cld    
    1140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1142:	89 d0                	mov    %edx,%eax
    1144:	5f                   	pop    %edi
    1145:	5d                   	pop    %ebp
    1146:	c3                   	ret    
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <strchr>:

char*
strchr(const char *s, char c)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    115a:	0f b6 10             	movzbl (%eax),%edx
    115d:	84 d2                	test   %dl,%dl
    115f:	74 1d                	je     117e <strchr+0x2e>
    if(*s == c)
    1161:	38 d3                	cmp    %dl,%bl
    1163:	89 d9                	mov    %ebx,%ecx
    1165:	75 0d                	jne    1174 <strchr+0x24>
    1167:	eb 17                	jmp    1180 <strchr+0x30>
    1169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1170:	38 ca                	cmp    %cl,%dl
    1172:	74 0c                	je     1180 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1174:	83 c0 01             	add    $0x1,%eax
    1177:	0f b6 10             	movzbl (%eax),%edx
    117a:	84 d2                	test   %dl,%dl
    117c:	75 f2                	jne    1170 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    117e:	31 c0                	xor    %eax,%eax
}
    1180:	5b                   	pop    %ebx
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    1183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001190 <gets>:

char*
gets(char *buf, int max)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1196:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1198:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    119b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    119e:	eb 29                	jmp    11c9 <gets+0x39>
    cc = read(0, &c, 1);
    11a0:	83 ec 04             	sub    $0x4,%esp
    11a3:	6a 01                	push   $0x1
    11a5:	57                   	push   %edi
    11a6:	6a 00                	push   $0x0
    11a8:	e8 2d 01 00 00       	call   12da <read>
    if(cc < 1)
    11ad:	83 c4 10             	add    $0x10,%esp
    11b0:	85 c0                	test   %eax,%eax
    11b2:	7e 1d                	jle    11d1 <gets+0x41>
      break;
    buf[i++] = c;
    11b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11b8:	8b 55 08             	mov    0x8(%ebp),%edx
    11bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    11bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    11bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    11c3:	74 1b                	je     11e0 <gets+0x50>
    11c5:	3c 0d                	cmp    $0xd,%al
    11c7:	74 17                	je     11e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11c9:	8d 5e 01             	lea    0x1(%esi),%ebx
    11cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11cf:	7c cf                	jl     11a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11d1:	8b 45 08             	mov    0x8(%ebp),%eax
    11d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    11d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11db:	5b                   	pop    %ebx
    11dc:	5e                   	pop    %esi
    11dd:	5f                   	pop    %edi
    11de:	5d                   	pop    %ebp
    11df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    11e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11ec:	5b                   	pop    %ebx
    11ed:	5e                   	pop    %esi
    11ee:	5f                   	pop    %edi
    11ef:	5d                   	pop    %ebp
    11f0:	c3                   	ret    
    11f1:	eb 0d                	jmp    1200 <stat>
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

00001200 <stat>:

int
stat(char *n, struct stat *st)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	56                   	push   %esi
    1204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1205:	83 ec 08             	sub    $0x8,%esp
    1208:	6a 00                	push   $0x0
    120a:	ff 75 08             	pushl  0x8(%ebp)
    120d:	e8 f0 00 00 00       	call   1302 <open>
  if(fd < 0)
    1212:	83 c4 10             	add    $0x10,%esp
    1215:	85 c0                	test   %eax,%eax
    1217:	78 27                	js     1240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1219:	83 ec 08             	sub    $0x8,%esp
    121c:	ff 75 0c             	pushl  0xc(%ebp)
    121f:	89 c3                	mov    %eax,%ebx
    1221:	50                   	push   %eax
    1222:	e8 f3 00 00 00       	call   131a <fstat>
    1227:	89 c6                	mov    %eax,%esi
  close(fd);
    1229:	89 1c 24             	mov    %ebx,(%esp)
    122c:	e8 b9 00 00 00       	call   12ea <close>
  return r;
    1231:	83 c4 10             	add    $0x10,%esp
    1234:	89 f0                	mov    %esi,%eax
}
    1236:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1239:	5b                   	pop    %ebx
    123a:	5e                   	pop    %esi
    123b:	5d                   	pop    %ebp
    123c:	c3                   	ret    
    123d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1245:	eb ef                	jmp    1236 <stat+0x36>
    1247:	89 f6                	mov    %esi,%esi
    1249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001250 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	53                   	push   %ebx
    1254:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1257:	0f be 11             	movsbl (%ecx),%edx
    125a:	8d 42 d0             	lea    -0x30(%edx),%eax
    125d:	3c 09                	cmp    $0x9,%al
    125f:	b8 00 00 00 00       	mov    $0x0,%eax
    1264:	77 1f                	ja     1285 <atoi+0x35>
    1266:	8d 76 00             	lea    0x0(%esi),%esi
    1269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1270:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1273:	83 c1 01             	add    $0x1,%ecx
    1276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    127a:	0f be 11             	movsbl (%ecx),%edx
    127d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1280:	80 fb 09             	cmp    $0x9,%bl
    1283:	76 eb                	jbe    1270 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1285:	5b                   	pop    %ebx
    1286:	5d                   	pop    %ebp
    1287:	c3                   	ret    
    1288:	90                   	nop
    1289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	56                   	push   %esi
    1294:	53                   	push   %ebx
    1295:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    129e:	85 db                	test   %ebx,%ebx
    12a0:	7e 14                	jle    12b6 <memmove+0x26>
    12a2:	31 d2                	xor    %edx,%edx
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    12a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12b2:	39 da                	cmp    %ebx,%edx
    12b4:	75 f2                	jne    12a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12b6:	5b                   	pop    %ebx
    12b7:	5e                   	pop    %esi
    12b8:	5d                   	pop    %ebp
    12b9:	c3                   	ret    

000012ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ba:	b8 01 00 00 00       	mov    $0x1,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <exit>:
SYSCALL(exit)
    12c2:	b8 02 00 00 00       	mov    $0x2,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <wait>:
SYSCALL(wait)
    12ca:	b8 03 00 00 00       	mov    $0x3,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <pipe>:
SYSCALL(pipe)
    12d2:	b8 04 00 00 00       	mov    $0x4,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <read>:
SYSCALL(read)
    12da:	b8 05 00 00 00       	mov    $0x5,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <write>:
SYSCALL(write)
    12e2:	b8 10 00 00 00       	mov    $0x10,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <close>:
SYSCALL(close)
    12ea:	b8 15 00 00 00       	mov    $0x15,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <kill>:
SYSCALL(kill)
    12f2:	b8 06 00 00 00       	mov    $0x6,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <exec>:
SYSCALL(exec)
    12fa:	b8 07 00 00 00       	mov    $0x7,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <open>:
SYSCALL(open)
    1302:	b8 0f 00 00 00       	mov    $0xf,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <mknod>:
SYSCALL(mknod)
    130a:	b8 11 00 00 00       	mov    $0x11,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <unlink>:
SYSCALL(unlink)
    1312:	b8 12 00 00 00       	mov    $0x12,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <fstat>:
SYSCALL(fstat)
    131a:	b8 08 00 00 00       	mov    $0x8,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <link>:
SYSCALL(link)
    1322:	b8 13 00 00 00       	mov    $0x13,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <mkdir>:
SYSCALL(mkdir)
    132a:	b8 14 00 00 00       	mov    $0x14,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <chdir>:
SYSCALL(chdir)
    1332:	b8 09 00 00 00       	mov    $0x9,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <dup>:
SYSCALL(dup)
    133a:	b8 0a 00 00 00       	mov    $0xa,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <getpid>:
SYSCALL(getpid)
    1342:	b8 0b 00 00 00       	mov    $0xb,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <sbrk>:
SYSCALL(sbrk)
    134a:	b8 0c 00 00 00       	mov    $0xc,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <sleep>:
SYSCALL(sleep)
    1352:	b8 0d 00 00 00       	mov    $0xd,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <uptime>:
SYSCALL(uptime)
    135a:	b8 0e 00 00 00       	mov    $0xe,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <getcount>:
SYSCALL(getcount) //added getcount here
    1362:	b8 16 00 00 00       	mov    $0x16,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    136a:	b8 17 00 00 00       	mov    $0x17,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <increasepriority>:
SYSCALL(increasepriority)
    1372:	b8 18 00 00 00       	mov    $0x18,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    
    137a:	66 90                	xchg   %ax,%ax
    137c:	66 90                	xchg   %ax,%ax
    137e:	66 90                	xchg   %ax,%ax

00001380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	57                   	push   %edi
    1384:	56                   	push   %esi
    1385:	53                   	push   %ebx
    1386:	89 c6                	mov    %eax,%esi
    1388:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    138b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    138e:	85 db                	test   %ebx,%ebx
    1390:	74 7e                	je     1410 <printint+0x90>
    1392:	89 d0                	mov    %edx,%eax
    1394:	c1 e8 1f             	shr    $0x1f,%eax
    1397:	84 c0                	test   %al,%al
    1399:	74 75                	je     1410 <printint+0x90>
    neg = 1;
    x = -xx;
    139b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    139d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    13a4:	f7 d8                	neg    %eax
    13a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13a9:	31 ff                	xor    %edi,%edi
    13ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13ae:	89 ce                	mov    %ecx,%esi
    13b0:	eb 08                	jmp    13ba <printint+0x3a>
    13b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    13b8:	89 cf                	mov    %ecx,%edi
    13ba:	31 d2                	xor    %edx,%edx
    13bc:	8d 4f 01             	lea    0x1(%edi),%ecx
    13bf:	f7 f6                	div    %esi
    13c1:	0f b6 92 74 17 00 00 	movzbl 0x1774(%edx),%edx
  }while((x /= base) != 0);
    13c8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    13ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    13cd:	75 e9                	jne    13b8 <printint+0x38>
  if(neg)
    13cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
    13d5:	85 c0                	test   %eax,%eax
    13d7:	74 08                	je     13e1 <printint+0x61>
    buf[i++] = '-';
    13d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    13de:	8d 4f 02             	lea    0x2(%edi),%ecx
    13e1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    13e5:	8d 76 00             	lea    0x0(%esi),%esi
    13e8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13eb:	83 ec 04             	sub    $0x4,%esp
    13ee:	83 ef 01             	sub    $0x1,%edi
    13f1:	6a 01                	push   $0x1
    13f3:	53                   	push   %ebx
    13f4:	56                   	push   %esi
    13f5:	88 45 d7             	mov    %al,-0x29(%ebp)
    13f8:	e8 e5 fe ff ff       	call   12e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13fd:	83 c4 10             	add    $0x10,%esp
    1400:	39 df                	cmp    %ebx,%edi
    1402:	75 e4                	jne    13e8 <printint+0x68>
    putc(fd, buf[i]);
}
    1404:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1407:	5b                   	pop    %ebx
    1408:	5e                   	pop    %esi
    1409:	5f                   	pop    %edi
    140a:	5d                   	pop    %ebp
    140b:	c3                   	ret    
    140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1410:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1412:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1419:	eb 8b                	jmp    13a6 <printint+0x26>
    141b:	90                   	nop
    141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1426:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1429:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    142c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    142f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1432:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1435:	0f b6 1e             	movzbl (%esi),%ebx
    1438:	83 c6 01             	add    $0x1,%esi
    143b:	84 db                	test   %bl,%bl
    143d:	0f 84 b0 00 00 00    	je     14f3 <printf+0xd3>
    1443:	31 d2                	xor    %edx,%edx
    1445:	eb 39                	jmp    1480 <printf+0x60>
    1447:	89 f6                	mov    %esi,%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1450:	83 f8 25             	cmp    $0x25,%eax
    1453:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1456:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    145b:	74 18                	je     1475 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    145d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1466:	6a 01                	push   $0x1
    1468:	50                   	push   %eax
    1469:	57                   	push   %edi
    146a:	e8 73 fe ff ff       	call   12e2 <write>
    146f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1472:	83 c4 10             	add    $0x10,%esp
    1475:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1478:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    147c:	84 db                	test   %bl,%bl
    147e:	74 73                	je     14f3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1480:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1482:	0f be cb             	movsbl %bl,%ecx
    1485:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1488:	74 c6                	je     1450 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    148a:	83 fa 25             	cmp    $0x25,%edx
    148d:	75 e6                	jne    1475 <printf+0x55>
      if(c == 'd'){
    148f:	83 f8 64             	cmp    $0x64,%eax
    1492:	0f 84 f8 00 00 00    	je     1590 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1498:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    149e:	83 f9 70             	cmp    $0x70,%ecx
    14a1:	74 5d                	je     1500 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    14a3:	83 f8 73             	cmp    $0x73,%eax
    14a6:	0f 84 84 00 00 00    	je     1530 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    14ac:	83 f8 63             	cmp    $0x63,%eax
    14af:	0f 84 ea 00 00 00    	je     159f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    14b5:	83 f8 25             	cmp    $0x25,%eax
    14b8:	0f 84 c2 00 00 00    	je     1580 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14be:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14c1:	83 ec 04             	sub    $0x4,%esp
    14c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14c8:	6a 01                	push   $0x1
    14ca:	50                   	push   %eax
    14cb:	57                   	push   %edi
    14cc:	e8 11 fe ff ff       	call   12e2 <write>
    14d1:	83 c4 0c             	add    $0xc,%esp
    14d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    14d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    14da:	6a 01                	push   $0x1
    14dc:	50                   	push   %eax
    14dd:	57                   	push   %edi
    14de:	83 c6 01             	add    $0x1,%esi
    14e1:	e8 fc fd ff ff       	call   12e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    14ed:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14ef:	84 db                	test   %bl,%bl
    14f1:	75 8d                	jne    1480 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14f6:	5b                   	pop    %ebx
    14f7:	5e                   	pop    %esi
    14f8:	5f                   	pop    %edi
    14f9:	5d                   	pop    %ebp
    14fa:	c3                   	ret    
    14fb:	90                   	nop
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1500:	83 ec 0c             	sub    $0xc,%esp
    1503:	b9 10 00 00 00       	mov    $0x10,%ecx
    1508:	6a 00                	push   $0x0
    150a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    150d:	89 f8                	mov    %edi,%eax
    150f:	8b 13                	mov    (%ebx),%edx
    1511:	e8 6a fe ff ff       	call   1380 <printint>
        ap++;
    1516:	89 d8                	mov    %ebx,%eax
    1518:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    151b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    151d:	83 c0 04             	add    $0x4,%eax
    1520:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1523:	e9 4d ff ff ff       	jmp    1475 <printf+0x55>
    1528:	90                   	nop
    1529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1530:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1533:	8b 18                	mov    (%eax),%ebx
        ap++;
    1535:	83 c0 04             	add    $0x4,%eax
    1538:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    153b:	b8 6d 17 00 00       	mov    $0x176d,%eax
    1540:	85 db                	test   %ebx,%ebx
    1542:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1545:	0f b6 03             	movzbl (%ebx),%eax
    1548:	84 c0                	test   %al,%al
    154a:	74 23                	je     156f <printf+0x14f>
    154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1550:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1553:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1556:	83 ec 04             	sub    $0x4,%esp
    1559:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    155b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    155e:	50                   	push   %eax
    155f:	57                   	push   %edi
    1560:	e8 7d fd ff ff       	call   12e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1565:	0f b6 03             	movzbl (%ebx),%eax
    1568:	83 c4 10             	add    $0x10,%esp
    156b:	84 c0                	test   %al,%al
    156d:	75 e1                	jne    1550 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    156f:	31 d2                	xor    %edx,%edx
    1571:	e9 ff fe ff ff       	jmp    1475 <printf+0x55>
    1576:	8d 76 00             	lea    0x0(%esi),%esi
    1579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1580:	83 ec 04             	sub    $0x4,%esp
    1583:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1586:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1589:	6a 01                	push   $0x1
    158b:	e9 4c ff ff ff       	jmp    14dc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1590:	83 ec 0c             	sub    $0xc,%esp
    1593:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1598:	6a 01                	push   $0x1
    159a:	e9 6b ff ff ff       	jmp    150a <printf+0xea>
    159f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15a2:	83 ec 04             	sub    $0x4,%esp
    15a5:	8b 03                	mov    (%ebx),%eax
    15a7:	6a 01                	push   $0x1
    15a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    15ac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    15af:	50                   	push   %eax
    15b0:	57                   	push   %edi
    15b1:	e8 2c fd ff ff       	call   12e2 <write>
    15b6:	e9 5b ff ff ff       	jmp    1516 <printf+0xf6>
    15bb:	66 90                	xchg   %ax,%ax
    15bd:	66 90                	xchg   %ax,%ax
    15bf:	90                   	nop

000015c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15c1:	a1 18 1a 00 00       	mov    0x1a18,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    15c6:	89 e5                	mov    %esp,%ebp
    15c8:	57                   	push   %edi
    15c9:	56                   	push   %esi
    15ca:	53                   	push   %ebx
    15cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15d3:	39 c8                	cmp    %ecx,%eax
    15d5:	73 19                	jae    15f0 <free+0x30>
    15d7:	89 f6                	mov    %esi,%esi
    15d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    15e0:	39 d1                	cmp    %edx,%ecx
    15e2:	72 1c                	jb     1600 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15e4:	39 d0                	cmp    %edx,%eax
    15e6:	73 18                	jae    1600 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15ee:	72 f0                	jb     15e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15f0:	39 d0                	cmp    %edx,%eax
    15f2:	72 f4                	jb     15e8 <free+0x28>
    15f4:	39 d1                	cmp    %edx,%ecx
    15f6:	73 f0                	jae    15e8 <free+0x28>
    15f8:	90                   	nop
    15f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1600:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1603:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1606:	39 d7                	cmp    %edx,%edi
    1608:	74 19                	je     1623 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    160a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    160d:	8b 50 04             	mov    0x4(%eax),%edx
    1610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1613:	39 f1                	cmp    %esi,%ecx
    1615:	74 23                	je     163a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1617:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1619:	a3 18 1a 00 00       	mov    %eax,0x1a18
}
    161e:	5b                   	pop    %ebx
    161f:	5e                   	pop    %esi
    1620:	5f                   	pop    %edi
    1621:	5d                   	pop    %ebp
    1622:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1623:	03 72 04             	add    0x4(%edx),%esi
    1626:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1629:	8b 10                	mov    (%eax),%edx
    162b:	8b 12                	mov    (%edx),%edx
    162d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1630:	8b 50 04             	mov    0x4(%eax),%edx
    1633:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1636:	39 f1                	cmp    %esi,%ecx
    1638:	75 dd                	jne    1617 <free+0x57>
    p->s.size += bp->s.size;
    163a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    163d:	a3 18 1a 00 00       	mov    %eax,0x1a18
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1642:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1645:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1648:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    164a:	5b                   	pop    %ebx
    164b:	5e                   	pop    %esi
    164c:	5f                   	pop    %edi
    164d:	5d                   	pop    %ebp
    164e:	c3                   	ret    
    164f:	90                   	nop

00001650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	56                   	push   %esi
    1655:	53                   	push   %ebx
    1656:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1659:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    165c:	8b 15 18 1a 00 00    	mov    0x1a18,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1662:	8d 78 07             	lea    0x7(%eax),%edi
    1665:	c1 ef 03             	shr    $0x3,%edi
    1668:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    166b:	85 d2                	test   %edx,%edx
    166d:	0f 84 a3 00 00 00    	je     1716 <malloc+0xc6>
    1673:	8b 02                	mov    (%edx),%eax
    1675:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1678:	39 cf                	cmp    %ecx,%edi
    167a:	76 74                	jbe    16f0 <malloc+0xa0>
    167c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1682:	be 00 10 00 00       	mov    $0x1000,%esi
    1687:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    168e:	0f 43 f7             	cmovae %edi,%esi
    1691:	ba 00 80 00 00       	mov    $0x8000,%edx
    1696:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    169c:	0f 46 da             	cmovbe %edx,%ebx
    169f:	eb 10                	jmp    16b1 <malloc+0x61>
    16a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    16aa:	8b 48 04             	mov    0x4(%eax),%ecx
    16ad:	39 cf                	cmp    %ecx,%edi
    16af:	76 3f                	jbe    16f0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16b1:	39 05 18 1a 00 00    	cmp    %eax,0x1a18
    16b7:	89 c2                	mov    %eax,%edx
    16b9:	75 ed                	jne    16a8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	53                   	push   %ebx
    16bf:	e8 86 fc ff ff       	call   134a <sbrk>
  if(p == (char*)-1)
    16c4:	83 c4 10             	add    $0x10,%esp
    16c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    16ca:	74 1c                	je     16e8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16cc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    16cf:	83 ec 0c             	sub    $0xc,%esp
    16d2:	83 c0 08             	add    $0x8,%eax
    16d5:	50                   	push   %eax
    16d6:	e8 e5 fe ff ff       	call   15c0 <free>
  return freep;
    16db:	8b 15 18 1a 00 00    	mov    0x1a18,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    16e1:	83 c4 10             	add    $0x10,%esp
    16e4:	85 d2                	test   %edx,%edx
    16e6:	75 c0                	jne    16a8 <malloc+0x58>
        return 0;
    16e8:	31 c0                	xor    %eax,%eax
    16ea:	eb 1c                	jmp    1708 <malloc+0xb8>
    16ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    16f0:	39 cf                	cmp    %ecx,%edi
    16f2:	74 1c                	je     1710 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16f4:	29 f9                	sub    %edi,%ecx
    16f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    16f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    16fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    16ff:	89 15 18 1a 00 00    	mov    %edx,0x1a18
      return (void*)(p + 1);
    1705:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1708:	8d 65 f4             	lea    -0xc(%ebp),%esp
    170b:	5b                   	pop    %ebx
    170c:	5e                   	pop    %esi
    170d:	5f                   	pop    %edi
    170e:	5d                   	pop    %ebp
    170f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1710:	8b 08                	mov    (%eax),%ecx
    1712:	89 0a                	mov    %ecx,(%edx)
    1714:	eb e9                	jmp    16ff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1716:	c7 05 18 1a 00 00 1c 	movl   $0x1a1c,0x1a18
    171d:	1a 00 00 
    1720:	c7 05 1c 1a 00 00 1c 	movl   $0x1a1c,0x1a1c
    1727:	1a 00 00 
    base.s.size = 0;
    172a:	b8 1c 1a 00 00       	mov    $0x1a1c,%eax
    172f:	c7 05 20 1a 00 00 00 	movl   $0x0,0x1a20
    1736:	00 00 00 
    1739:	e9 3e ff ff ff       	jmp    167c <malloc+0x2c>
