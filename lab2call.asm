
_lab2call:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    //Prints out number of sys calls made
    printf(1, "Number of System Calls = %d\n", getcount());
  11:	e8 0c 03 00 00       	call   322 <getcount>
  16:	83 ec 04             	sub    $0x4,%esp
  19:	50                   	push   %eax
  1a:	68 00 07 00 00       	push   $0x700
  1f:	6a 01                	push   $0x1
  21:	e8 ba 03 00 00       	call   3e0 <printf>
    printf(1, " ", getprocessinfo());
  26:	e8 ff 02 00 00       	call   32a <getprocessinfo>
  2b:	83 c4 0c             	add    $0xc,%esp
  2e:	50                   	push   %eax
  2f:	68 1d 07 00 00       	push   $0x71d
  34:	6a 01                	push   $0x1
  36:	e8 a5 03 00 00       	call   3e0 <printf>
    exit();
  3b:	e8 42 02 00 00       	call   282 <exit>

00000040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 45 08             	mov    0x8(%ebp),%eax
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	89 c2                	mov    %eax,%edx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	83 c1 01             	add    $0x1,%ecx
  53:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  57:	83 c2 01             	add    $0x1,%edx
  5a:	84 db                	test   %bl,%bl
  5c:	88 5a ff             	mov    %bl,-0x1(%edx)
  5f:	75 ef                	jne    50 <strcpy+0x10>
    ;
  return os;
}
  61:	5b                   	pop    %ebx
  62:	5d                   	pop    %ebp
  63:	c3                   	ret    
  64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	56                   	push   %esi
  74:	53                   	push   %ebx
  75:	8b 55 08             	mov    0x8(%ebp),%edx
  78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7b:	0f b6 02             	movzbl (%edx),%eax
  7e:	0f b6 19             	movzbl (%ecx),%ebx
  81:	84 c0                	test   %al,%al
  83:	75 1e                	jne    a3 <strcmp+0x33>
  85:	eb 29                	jmp    b0 <strcmp+0x40>
  87:	89 f6                	mov    %esi,%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  90:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  93:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  96:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  99:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  9d:	84 c0                	test   %al,%al
  9f:	74 0f                	je     b0 <strcmp+0x40>
  a1:	89 f1                	mov    %esi,%ecx
  a3:	38 d8                	cmp    %bl,%al
  a5:	74 e9                	je     90 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a7:	29 d8                	sub    %ebx,%eax
}
  a9:	5b                   	pop    %ebx
  aa:	5e                   	pop    %esi
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b2:	29 d8                	sub    %ebx,%eax
}
  b4:	5b                   	pop    %ebx
  b5:	5e                   	pop    %esi
  b6:	5d                   	pop    %ebp
  b7:	c3                   	ret    
  b8:	90                   	nop
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strlen>:

uint
strlen(char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c6:	80 39 00             	cmpb   $0x0,(%ecx)
  c9:	74 12                	je     dd <strlen+0x1d>
  cb:	31 d2                	xor    %edx,%edx
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c2 01             	add    $0x1,%edx
  d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d7:	89 d0                	mov    %edx,%eax
  d9:	75 f5                	jne    d0 <strlen+0x10>
    ;
  return n;
}
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  df:	5d                   	pop    %ebp
  e0:	c3                   	ret    
  e1:	eb 0d                	jmp    f0 <memset>
  e3:	90                   	nop
  e4:	90                   	nop
  e5:	90                   	nop
  e6:	90                   	nop
  e7:	90                   	nop
  e8:	90                   	nop
  e9:	90                   	nop
  ea:	90                   	nop
  eb:	90                   	nop
  ec:	90                   	nop
  ed:	90                   	nop
  ee:	90                   	nop
  ef:	90                   	nop

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	89 d0                	mov    %edx,%eax
 104:	5f                   	pop    %edi
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	74 1d                	je     13e <strchr+0x2e>
    if(*s == c)
 121:	38 d3                	cmp    %dl,%bl
 123:	89 d9                	mov    %ebx,%ecx
 125:	75 0d                	jne    134 <strchr+0x24>
 127:	eb 17                	jmp    140 <strchr+0x30>
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 130:	38 ca                	cmp    %cl,%dl
 132:	74 0c                	je     140 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 134:	83 c0 01             	add    $0x1,%eax
 137:	0f b6 10             	movzbl (%eax),%edx
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 13e:	31 c0                	xor    %eax,%eax
}
 140:	5b                   	pop    %ebx
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
 143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
 155:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 156:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 158:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 15b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	eb 29                	jmp    189 <gets+0x39>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	57                   	push   %edi
 166:	6a 00                	push   $0x0
 168:	e8 2d 01 00 00       	call   29a <read>
    if(cc < 1)
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	7e 1d                	jle    191 <gets+0x41>
      break;
    buf[i++] = c;
 174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 178:	8b 55 08             	mov    0x8(%ebp),%edx
 17b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 17d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 17f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 183:	74 1b                	je     1a0 <gets+0x50>
 185:	3c 0d                	cmp    $0xd,%al
 187:	74 17                	je     1a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 189:	8d 5e 01             	lea    0x1(%esi),%ebx
 18c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 18f:	7c cf                	jl     160 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 198:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19b:	5b                   	pop    %ebx
 19c:	5e                   	pop    %esi
 19d:	5f                   	pop    %edi
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ac:	5b                   	pop    %ebx
 1ad:	5e                   	pop    %esi
 1ae:	5f                   	pop    %edi
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    
 1b1:	eb 0d                	jmp    1c0 <stat>
 1b3:	90                   	nop
 1b4:	90                   	nop
 1b5:	90                   	nop
 1b6:	90                   	nop
 1b7:	90                   	nop
 1b8:	90                   	nop
 1b9:	90                   	nop
 1ba:	90                   	nop
 1bb:	90                   	nop
 1bc:	90                   	nop
 1bd:	90                   	nop
 1be:	90                   	nop
 1bf:	90                   	nop

000001c0 <stat>:

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f0 00 00 00       	call   2c2 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 f3 00 00 00       	call   2da <fstat>
 1e7:	89 c6                	mov    %eax,%esi
  close(fd);
 1e9:	89 1c 24             	mov    %ebx,(%esp)
 1ec:	e8 b9 00 00 00       	call   2aa <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	89 f0                	mov    %esi,%eax
}
 1f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 200:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 205:	eb ef                	jmp    1f6 <stat+0x36>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	39 da                	cmp    %ebx,%edx
 274:	75 f2                	jne    268 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getcount>:
SYSCALL(getcount) //added getcount here
 322:	b8 16 00 00 00       	mov    $0x16,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
 32a:	b8 17 00 00 00       	mov    $0x17,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <increasepriority>:
SYSCALL(increasepriority)
 332:	b8 18 00 00 00       	mov    $0x18,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	89 c6                	mov    %eax,%esi
 348:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34e:	85 db                	test   %ebx,%ebx
 350:	74 7e                	je     3d0 <printint+0x90>
 352:	89 d0                	mov    %edx,%eax
 354:	c1 e8 1f             	shr    $0x1f,%eax
 357:	84 c0                	test   %al,%al
 359:	74 75                	je     3d0 <printint+0x90>
    neg = 1;
    x = -xx;
 35b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 35d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 364:	f7 d8                	neg    %eax
 366:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 369:	31 ff                	xor    %edi,%edi
 36b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 36e:	89 ce                	mov    %ecx,%esi
 370:	eb 08                	jmp    37a <printint+0x3a>
 372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 378:	89 cf                	mov    %ecx,%edi
 37a:	31 d2                	xor    %edx,%edx
 37c:	8d 4f 01             	lea    0x1(%edi),%ecx
 37f:	f7 f6                	div    %esi
 381:	0f b6 92 28 07 00 00 	movzbl 0x728(%edx),%edx
  }while((x /= base) != 0);
 388:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 38a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 38d:	75 e9                	jne    378 <printint+0x38>
  if(neg)
 38f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 392:	8b 75 c0             	mov    -0x40(%ebp),%esi
 395:	85 c0                	test   %eax,%eax
 397:	74 08                	je     3a1 <printint+0x61>
    buf[i++] = '-';
 399:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 39e:	8d 4f 02             	lea    0x2(%edi),%ecx
 3a1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3a5:	8d 76 00             	lea    0x0(%esi),%esi
 3a8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3ab:	83 ec 04             	sub    $0x4,%esp
 3ae:	83 ef 01             	sub    $0x1,%edi
 3b1:	6a 01                	push   $0x1
 3b3:	53                   	push   %ebx
 3b4:	56                   	push   %esi
 3b5:	88 45 d7             	mov    %al,-0x29(%ebp)
 3b8:	e8 e5 fe ff ff       	call   2a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3bd:	83 c4 10             	add    $0x10,%esp
 3c0:	39 df                	cmp    %ebx,%edi
 3c2:	75 e4                	jne    3a8 <printint+0x68>
    putc(fd, buf[i]);
}
 3c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3c7:	5b                   	pop    %ebx
 3c8:	5e                   	pop    %esi
 3c9:	5f                   	pop    %edi
 3ca:	5d                   	pop    %ebp
 3cb:	c3                   	ret    
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3d9:	eb 8b                	jmp    366 <printint+0x26>
 3db:	90                   	nop
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 3f5:	0f b6 1e             	movzbl (%esi),%ebx
 3f8:	83 c6 01             	add    $0x1,%esi
 3fb:	84 db                	test   %bl,%bl
 3fd:	0f 84 b0 00 00 00    	je     4b3 <printf+0xd3>
 403:	31 d2                	xor    %edx,%edx
 405:	eb 39                	jmp    440 <printf+0x60>
 407:	89 f6                	mov    %esi,%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 410:	83 f8 25             	cmp    $0x25,%eax
 413:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 416:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 41b:	74 18                	je     435 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 420:	83 ec 04             	sub    $0x4,%esp
 423:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 426:	6a 01                	push   $0x1
 428:	50                   	push   %eax
 429:	57                   	push   %edi
 42a:	e8 73 fe ff ff       	call   2a2 <write>
 42f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 432:	83 c4 10             	add    $0x10,%esp
 435:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 438:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 43c:	84 db                	test   %bl,%bl
 43e:	74 73                	je     4b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 440:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 442:	0f be cb             	movsbl %bl,%ecx
 445:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 448:	74 c6                	je     410 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 44a:	83 fa 25             	cmp    $0x25,%edx
 44d:	75 e6                	jne    435 <printf+0x55>
      if(c == 'd'){
 44f:	83 f8 64             	cmp    $0x64,%eax
 452:	0f 84 f8 00 00 00    	je     550 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 458:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 45e:	83 f9 70             	cmp    $0x70,%ecx
 461:	74 5d                	je     4c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 463:	83 f8 73             	cmp    $0x73,%eax
 466:	0f 84 84 00 00 00    	je     4f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 46c:	83 f8 63             	cmp    $0x63,%eax
 46f:	0f 84 ea 00 00 00    	je     55f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 475:	83 f8 25             	cmp    $0x25,%eax
 478:	0f 84 c2 00 00 00    	je     540 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 481:	83 ec 04             	sub    $0x4,%esp
 484:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 488:	6a 01                	push   $0x1
 48a:	50                   	push   %eax
 48b:	57                   	push   %edi
 48c:	e8 11 fe ff ff       	call   2a2 <write>
 491:	83 c4 0c             	add    $0xc,%esp
 494:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 497:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 49a:	6a 01                	push   $0x1
 49c:	50                   	push   %eax
 49d:	57                   	push   %edi
 49e:	83 c6 01             	add    $0x1,%esi
 4a1:	e8 fc fd ff ff       	call   2a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4af:	84 db                	test   %bl,%bl
 4b1:	75 8d                	jne    440 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5f                   	pop    %edi
 4b9:	5d                   	pop    %ebp
 4ba:	c3                   	ret    
 4bb:	90                   	nop
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4c8:	6a 00                	push   $0x0
 4ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4cd:	89 f8                	mov    %edi,%eax
 4cf:	8b 13                	mov    (%ebx),%edx
 4d1:	e8 6a fe ff ff       	call   340 <printint>
        ap++;
 4d6:	89 d8                	mov    %ebx,%eax
 4d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4dd:	83 c0 04             	add    $0x4,%eax
 4e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e3:	e9 4d ff ff ff       	jmp    435 <printf+0x55>
 4e8:	90                   	nop
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 4f5:	83 c0 04             	add    $0x4,%eax
 4f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 4fb:	b8 1f 07 00 00       	mov    $0x71f,%eax
 500:	85 db                	test   %ebx,%ebx
 502:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 505:	0f b6 03             	movzbl (%ebx),%eax
 508:	84 c0                	test   %al,%al
 50a:	74 23                	je     52f <printf+0x14f>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 513:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 516:	83 ec 04             	sub    $0x4,%esp
 519:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 51b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51e:	50                   	push   %eax
 51f:	57                   	push   %edi
 520:	e8 7d fd ff ff       	call   2a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 525:	0f b6 03             	movzbl (%ebx),%eax
 528:	83 c4 10             	add    $0x10,%esp
 52b:	84 c0                	test   %al,%al
 52d:	75 e1                	jne    510 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 52f:	31 d2                	xor    %edx,%edx
 531:	e9 ff fe ff ff       	jmp    435 <printf+0x55>
 536:	8d 76 00             	lea    0x0(%esi),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 546:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 549:	6a 01                	push   $0x1
 54b:	e9 4c ff ff ff       	jmp    49c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 0a 00 00 00       	mov    $0xa,%ecx
 558:	6a 01                	push   $0x1
 55a:	e9 6b ff ff ff       	jmp    4ca <printf+0xea>
 55f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 562:	83 ec 04             	sub    $0x4,%esp
 565:	8b 03                	mov    (%ebx),%eax
 567:	6a 01                	push   $0x1
 569:	88 45 e4             	mov    %al,-0x1c(%ebp)
 56c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 56f:	50                   	push   %eax
 570:	57                   	push   %edi
 571:	e8 2c fd ff ff       	call   2a2 <write>
 576:	e9 5b ff ff ff       	jmp    4d6 <printf+0xf6>
 57b:	66 90                	xchg   %ax,%ax
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 580:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	a1 c0 09 00 00       	mov    0x9c0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 586:	89 e5                	mov    %esp,%ebp
 588:	57                   	push   %edi
 589:	56                   	push   %esi
 58a:	53                   	push   %ebx
 58b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 590:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 593:	39 c8                	cmp    %ecx,%eax
 595:	73 19                	jae    5b0 <free+0x30>
 597:	89 f6                	mov    %esi,%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 5a0:	39 d1                	cmp    %edx,%ecx
 5a2:	72 1c                	jb     5c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a4:	39 d0                	cmp    %edx,%eax
 5a6:	73 18                	jae    5c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ae:	72 f0                	jb     5a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b0:	39 d0                	cmp    %edx,%eax
 5b2:	72 f4                	jb     5a8 <free+0x28>
 5b4:	39 d1                	cmp    %edx,%ecx
 5b6:	73 f0                	jae    5a8 <free+0x28>
 5b8:	90                   	nop
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5c6:	39 d7                	cmp    %edx,%edi
 5c8:	74 19                	je     5e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5cd:	8b 50 04             	mov    0x4(%eax),%edx
 5d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5d3:	39 f1                	cmp    %esi,%ecx
 5d5:	74 23                	je     5fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5d9:	a3 c0 09 00 00       	mov    %eax,0x9c0
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5f                   	pop    %edi
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5e3:	03 72 04             	add    0x4(%edx),%esi
 5e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e9:	8b 10                	mov    (%eax),%edx
 5eb:	8b 12                	mov    (%edx),%edx
 5ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5f0:	8b 50 04             	mov    0x4(%eax),%edx
 5f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f6:	39 f1                	cmp    %esi,%ecx
 5f8:	75 dd                	jne    5d7 <free+0x57>
    p->s.size += bp->s.size;
 5fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5fd:	a3 c0 09 00 00       	mov    %eax,0x9c0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 602:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 605:	8b 53 f8             	mov    -0x8(%ebx),%edx
 608:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 60a:	5b                   	pop    %ebx
 60b:	5e                   	pop    %esi
 60c:	5f                   	pop    %edi
 60d:	5d                   	pop    %ebp
 60e:	c3                   	ret    
 60f:	90                   	nop

00000610 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
 616:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 619:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 61c:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 622:	8d 78 07             	lea    0x7(%eax),%edi
 625:	c1 ef 03             	shr    $0x3,%edi
 628:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 62b:	85 d2                	test   %edx,%edx
 62d:	0f 84 a3 00 00 00    	je     6d6 <malloc+0xc6>
 633:	8b 02                	mov    (%edx),%eax
 635:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 638:	39 cf                	cmp    %ecx,%edi
 63a:	76 74                	jbe    6b0 <malloc+0xa0>
 63c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 642:	be 00 10 00 00       	mov    $0x1000,%esi
 647:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 64e:	0f 43 f7             	cmovae %edi,%esi
 651:	ba 00 80 00 00       	mov    $0x8000,%edx
 656:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 65c:	0f 46 da             	cmovbe %edx,%ebx
 65f:	eb 10                	jmp    671 <malloc+0x61>
 661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 668:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 66a:	8b 48 04             	mov    0x4(%eax),%ecx
 66d:	39 cf                	cmp    %ecx,%edi
 66f:	76 3f                	jbe    6b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 671:	39 05 c0 09 00 00    	cmp    %eax,0x9c0
 677:	89 c2                	mov    %eax,%edx
 679:	75 ed                	jne    668 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 67b:	83 ec 0c             	sub    $0xc,%esp
 67e:	53                   	push   %ebx
 67f:	e8 86 fc ff ff       	call   30a <sbrk>
  if(p == (char*)-1)
 684:	83 c4 10             	add    $0x10,%esp
 687:	83 f8 ff             	cmp    $0xffffffff,%eax
 68a:	74 1c                	je     6a8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 68c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 68f:	83 ec 0c             	sub    $0xc,%esp
 692:	83 c0 08             	add    $0x8,%eax
 695:	50                   	push   %eax
 696:	e8 e5 fe ff ff       	call   580 <free>
  return freep;
 69b:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6a1:	83 c4 10             	add    $0x10,%esp
 6a4:	85 d2                	test   %edx,%edx
 6a6:	75 c0                	jne    668 <malloc+0x58>
        return 0;
 6a8:	31 c0                	xor    %eax,%eax
 6aa:	eb 1c                	jmp    6c8 <malloc+0xb8>
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6b0:	39 cf                	cmp    %ecx,%edi
 6b2:	74 1c                	je     6d0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6b4:	29 f9                	sub    %edi,%ecx
 6b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6bc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6bf:	89 15 c0 09 00 00    	mov    %edx,0x9c0
      return (void*)(p + 1);
 6c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6cb:	5b                   	pop    %ebx
 6cc:	5e                   	pop    %esi
 6cd:	5f                   	pop    %edi
 6ce:	5d                   	pop    %ebp
 6cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6d0:	8b 08                	mov    (%eax),%ecx
 6d2:	89 0a                	mov    %ecx,(%edx)
 6d4:	eb e9                	jmp    6bf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6d6:	c7 05 c0 09 00 00 c4 	movl   $0x9c4,0x9c0
 6dd:	09 00 00 
 6e0:	c7 05 c4 09 00 00 c4 	movl   $0x9c4,0x9c4
 6e7:	09 00 00 
    base.s.size = 0;
 6ea:	b8 c4 09 00 00       	mov    $0x9c4,%eax
 6ef:	c7 05 c8 09 00 00 00 	movl   $0x0,0x9c8
 6f6:	00 00 00 
 6f9:	e9 3e ff ff ff       	jmp    63c <malloc+0x2c>
