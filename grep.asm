
_grep:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  }
}

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
    1011:	83 ec 18             	sub    $0x18,%esp
    1014:	8b 01                	mov    (%ecx),%eax
    1016:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
    1019:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
    101c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
    101f:	7e 76                	jle    1097 <main+0x97>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
    1021:	8b 43 04             	mov    0x4(%ebx),%eax
    1024:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
    1027:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    102b:	be 02 00 00 00       	mov    $0x2,%esi

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
    1030:	89 45 e0             	mov    %eax,-0x20(%ebp)

  if(argc <= 2){
    1033:	74 53                	je     1088 <main+0x88>
    1035:	8d 76 00             	lea    0x0(%esi),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    1038:	83 ec 08             	sub    $0x8,%esp
    103b:	6a 00                	push   $0x0
    103d:	ff 33                	pushl  (%ebx)
    103f:	e8 5e 05 00 00       	call   15a2 <open>
    1044:	83 c4 10             	add    $0x10,%esp
    1047:	85 c0                	test   %eax,%eax
    1049:	89 c7                	mov    %eax,%edi
    104b:	78 27                	js     1074 <main+0x74>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
    104d:	83 ec 08             	sub    $0x8,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    1050:	83 c6 01             	add    $0x1,%esi
    1053:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
    1056:	50                   	push   %eax
    1057:	ff 75 e0             	pushl  -0x20(%ebp)
    105a:	e8 c1 01 00 00       	call   1220 <grep>
    close(fd);
    105f:	89 3c 24             	mov    %edi,(%esp)
    1062:	e8 23 05 00 00       	call   158a <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    1067:	83 c4 10             	add    $0x10,%esp
    106a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    106d:	7f c9                	jg     1038 <main+0x38>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
    106f:	e8 ee 04 00 00       	call   1562 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
    1074:	50                   	push   %eax
    1075:	ff 33                	pushl  (%ebx)
    1077:	68 00 1a 00 00       	push   $0x1a00
    107c:	6a 01                	push   $0x1
    107e:	e8 3d 06 00 00       	call   16c0 <printf>
      exit();
    1083:	e8 da 04 00 00       	call   1562 <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
    1088:	52                   	push   %edx
    1089:	52                   	push   %edx
    108a:	6a 00                	push   $0x0
    108c:	50                   	push   %eax
    108d:	e8 8e 01 00 00       	call   1220 <grep>
    exit();
    1092:	e8 cb 04 00 00       	call   1562 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    1097:	51                   	push   %ecx
    1098:	51                   	push   %ecx
    1099:	68 e0 19 00 00       	push   $0x19e0
    109e:	6a 02                	push   $0x2
    10a0:	e8 1b 06 00 00       	call   16c0 <printf>
    exit();
    10a5:	e8 b8 04 00 00       	call   1562 <exit>
    10aa:	66 90                	xchg   %ax,%ax
    10ac:	66 90                	xchg   %ax,%ax
    10ae:	66 90                	xchg   %ax,%ax

000010b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	83 ec 0c             	sub    $0xc,%esp
    10b9:	8b 75 08             	mov    0x8(%ebp),%esi
    10bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
    10bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    10c8:	83 ec 08             	sub    $0x8,%esp
    10cb:	53                   	push   %ebx
    10cc:	57                   	push   %edi
    10cd:	e8 3e 00 00 00       	call   1110 <matchhere>
    10d2:	83 c4 10             	add    $0x10,%esp
    10d5:	85 c0                	test   %eax,%eax
    10d7:	75 1f                	jne    10f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    10d9:	0f be 13             	movsbl (%ebx),%edx
    10dc:	84 d2                	test   %dl,%dl
    10de:	74 0c                	je     10ec <matchstar+0x3c>
    10e0:	83 c3 01             	add    $0x1,%ebx
    10e3:	83 fe 2e             	cmp    $0x2e,%esi
    10e6:	74 e0                	je     10c8 <matchstar+0x18>
    10e8:	39 f2                	cmp    %esi,%edx
    10ea:	74 dc                	je     10c8 <matchstar+0x18>
  return 0;
}
    10ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10ef:	5b                   	pop    %ebx
    10f0:	5e                   	pop    %esi
    10f1:	5f                   	pop    %edi
    10f2:	5d                   	pop    %ebp
    10f3:	c3                   	ret    
    10f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
    10fb:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
    1100:	5b                   	pop    %ebx
    1101:	5e                   	pop    %esi
    1102:	5f                   	pop    %edi
    1103:	5d                   	pop    %ebp
    1104:	c3                   	ret    
    1105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	57                   	push   %edi
    1114:	56                   	push   %esi
    1115:	53                   	push   %ebx
    1116:	83 ec 0c             	sub    $0xc,%esp
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
    111f:	0f b6 18             	movzbl (%eax),%ebx
    1122:	84 db                	test   %bl,%bl
    1124:	74 63                	je     1189 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
    1126:	0f be 50 01          	movsbl 0x1(%eax),%edx
    112a:	80 fa 2a             	cmp    $0x2a,%dl
    112d:	74 7b                	je     11aa <matchhere+0x9a>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    112f:	80 fb 24             	cmp    $0x24,%bl
    1132:	75 08                	jne    113c <matchhere+0x2c>
    1134:	84 d2                	test   %dl,%dl
    1136:	0f 84 8a 00 00 00    	je     11c6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    113c:	0f b6 37             	movzbl (%edi),%esi
    113f:	89 f1                	mov    %esi,%ecx
    1141:	84 c9                	test   %cl,%cl
    1143:	74 5b                	je     11a0 <matchhere+0x90>
    1145:	38 cb                	cmp    %cl,%bl
    1147:	74 05                	je     114e <matchhere+0x3e>
    1149:	80 fb 2e             	cmp    $0x2e,%bl
    114c:	75 52                	jne    11a0 <matchhere+0x90>
    return matchhere(re+1, text+1);
    114e:	83 c7 01             	add    $0x1,%edi
    1151:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    1154:	84 d2                	test   %dl,%dl
    1156:	74 31                	je     1189 <matchhere+0x79>
    return 1;
  if(re[1] == '*')
    1158:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
    115c:	80 fb 2a             	cmp    $0x2a,%bl
    115f:	74 4c                	je     11ad <matchhere+0x9d>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    1161:	80 fa 24             	cmp    $0x24,%dl
    1164:	75 04                	jne    116a <matchhere+0x5a>
    1166:	84 db                	test   %bl,%bl
    1168:	74 5c                	je     11c6 <matchhere+0xb6>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    116a:	0f b6 37             	movzbl (%edi),%esi
    116d:	89 f1                	mov    %esi,%ecx
    116f:	84 c9                	test   %cl,%cl
    1171:	74 2d                	je     11a0 <matchhere+0x90>
    1173:	80 fa 2e             	cmp    $0x2e,%dl
    1176:	74 04                	je     117c <matchhere+0x6c>
    1178:	38 d1                	cmp    %dl,%cl
    117a:	75 24                	jne    11a0 <matchhere+0x90>
    117c:	0f be d3             	movsbl %bl,%edx
    return matchhere(re+1, text+1);
    117f:	83 c7 01             	add    $0x1,%edi
    1182:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    1185:	84 d2                	test   %dl,%dl
    1187:	75 cf                	jne    1158 <matchhere+0x48>
    return 1;
    1189:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
    118e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1191:	5b                   	pop    %ebx
    1192:	5e                   	pop    %esi
    1193:	5f                   	pop    %edi
    1194:	5d                   	pop    %ebp
    1195:	c3                   	ret    
    1196:	8d 76 00             	lea    0x0(%esi),%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    11a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
    11a3:	31 c0                	xor    %eax,%eax
}
    11a5:	5b                   	pop    %ebx
    11a6:	5e                   	pop    %esi
    11a7:	5f                   	pop    %edi
    11a8:	5d                   	pop    %ebp
    11a9:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    11aa:	0f be d3             	movsbl %bl,%edx
    return matchstar(re[0], re+2, text);
    11ad:	83 ec 04             	sub    $0x4,%esp
    11b0:	83 c0 02             	add    $0x2,%eax
    11b3:	57                   	push   %edi
    11b4:	50                   	push   %eax
    11b5:	52                   	push   %edx
    11b6:	e8 f5 fe ff ff       	call   10b0 <matchstar>
    11bb:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
    11be:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11c1:	5b                   	pop    %ebx
    11c2:	5e                   	pop    %esi
    11c3:	5f                   	pop    %edi
    11c4:	5d                   	pop    %ebp
    11c5:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
    11c6:	31 c0                	xor    %eax,%eax
    11c8:	80 3f 00             	cmpb   $0x0,(%edi)
    11cb:	0f 94 c0             	sete   %al
    11ce:	eb be                	jmp    118e <matchhere+0x7e>

000011d0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	56                   	push   %esi
    11d4:	53                   	push   %ebx
    11d5:	8b 75 08             	mov    0x8(%ebp),%esi
    11d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
    11db:	80 3e 5e             	cmpb   $0x5e,(%esi)
    11de:	75 11                	jne    11f1 <match+0x21>
    11e0:	eb 2c                	jmp    120e <match+0x3e>
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
    11e8:	83 c3 01             	add    $0x1,%ebx
    11eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
    11ef:	74 16                	je     1207 <match+0x37>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
    11f1:	83 ec 08             	sub    $0x8,%esp
    11f4:	53                   	push   %ebx
    11f5:	56                   	push   %esi
    11f6:	e8 15 ff ff ff       	call   1110 <matchhere>
    11fb:	83 c4 10             	add    $0x10,%esp
    11fe:	85 c0                	test   %eax,%eax
    1200:	74 e6                	je     11e8 <match+0x18>
      return 1;
    1202:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
    1207:	8d 65 f8             	lea    -0x8(%ebp),%esp
    120a:	5b                   	pop    %ebx
    120b:	5e                   	pop    %esi
    120c:	5d                   	pop    %ebp
    120d:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
    120e:	83 c6 01             	add    $0x1,%esi
    1211:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
    1214:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1217:	5b                   	pop    %ebx
    1218:	5e                   	pop    %esi
    1219:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
    121a:	e9 f1 fe ff ff       	jmp    1110 <matchhere>
    121f:	90                   	nop

00001220 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	83 ec 1c             	sub    $0x1c,%esp
    1229:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
    122c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1233:	90                   	nop
    1234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1238:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    123b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
    1240:	83 ec 04             	sub    $0x4,%esp
    1243:	29 c8                	sub    %ecx,%eax
    1245:	50                   	push   %eax
    1246:	8d 81 e0 1d 00 00    	lea    0x1de0(%ecx),%eax
    124c:	50                   	push   %eax
    124d:	ff 75 0c             	pushl  0xc(%ebp)
    1250:	e8 25 03 00 00       	call   157a <read>
    1255:	83 c4 10             	add    $0x10,%esp
    1258:	85 c0                	test   %eax,%eax
    125a:	0f 8e ac 00 00 00    	jle    130c <grep+0xec>
    m += n;
    1260:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    p = buf;
    1263:	bb e0 1d 00 00       	mov    $0x1de0,%ebx
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    1268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
    126b:	c6 82 e0 1d 00 00 00 	movb   $0x0,0x1de0(%edx)
    1272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
    1278:	83 ec 08             	sub    $0x8,%esp
    127b:	6a 0a                	push   $0xa
    127d:	53                   	push   %ebx
    127e:	e8 6d 01 00 00       	call   13f0 <strchr>
    1283:	83 c4 10             	add    $0x10,%esp
    1286:	85 c0                	test   %eax,%eax
    1288:	89 c7                	mov    %eax,%edi
    128a:	74 3c                	je     12c8 <grep+0xa8>
      *q = 0;
      if(match(pattern, p)){
    128c:	83 ec 08             	sub    $0x8,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      *q = 0;
    128f:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
    1292:	53                   	push   %ebx
    1293:	56                   	push   %esi
    1294:	e8 37 ff ff ff       	call   11d0 <match>
    1299:	83 c4 10             	add    $0x10,%esp
    129c:	85 c0                	test   %eax,%eax
    129e:	75 08                	jne    12a8 <grep+0x88>
    12a0:	8d 5f 01             	lea    0x1(%edi),%ebx
    12a3:	eb d3                	jmp    1278 <grep+0x58>
    12a5:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
    12a8:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
    12ab:	83 c7 01             	add    $0x1,%edi
    12ae:	83 ec 04             	sub    $0x4,%esp
    12b1:	89 f8                	mov    %edi,%eax
    12b3:	29 d8                	sub    %ebx,%eax
    12b5:	50                   	push   %eax
    12b6:	53                   	push   %ebx
    12b7:	89 fb                	mov    %edi,%ebx
    12b9:	6a 01                	push   $0x1
    12bb:	e8 c2 02 00 00       	call   1582 <write>
    12c0:	83 c4 10             	add    $0x10,%esp
    12c3:	eb b3                	jmp    1278 <grep+0x58>
    12c5:	8d 76 00             	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
    12c8:	81 fb e0 1d 00 00    	cmp    $0x1de0,%ebx
    12ce:	74 30                	je     1300 <grep+0xe0>
      m = 0;
    if(m > 0){
    12d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12d3:	85 c0                	test   %eax,%eax
    12d5:	0f 8e 5d ff ff ff    	jle    1238 <grep+0x18>
      m -= p - buf;
    12db:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
    12dd:	83 ec 04             	sub    $0x4,%esp
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
      m -= p - buf;
    12e0:	2d e0 1d 00 00       	sub    $0x1de0,%eax
    12e5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
    12e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
    12eb:	51                   	push   %ecx
    12ec:	53                   	push   %ebx
    12ed:	68 e0 1d 00 00       	push   $0x1de0
    12f2:	e8 39 02 00 00       	call   1530 <memmove>
    12f7:	83 c4 10             	add    $0x10,%esp
    12fa:	e9 39 ff ff ff       	jmp    1238 <grep+0x18>
    12ff:	90                   	nop
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
    1300:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1307:	e9 2c ff ff ff       	jmp    1238 <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
    130c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    130f:	5b                   	pop    %ebx
    1310:	5e                   	pop    %esi
    1311:	5f                   	pop    %edi
    1312:	5d                   	pop    %ebp
    1313:	c3                   	ret    
    1314:	66 90                	xchg   %ax,%ax
    1316:	66 90                	xchg   %ax,%ax
    1318:	66 90                	xchg   %ax,%ax
    131a:	66 90                	xchg   %ax,%ax
    131c:	66 90                	xchg   %ax,%ax
    131e:	66 90                	xchg   %ax,%ax

00001320 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	53                   	push   %ebx
    1324:	8b 45 08             	mov    0x8(%ebp),%eax
    1327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    132a:	89 c2                	mov    %eax,%edx
    132c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1330:	83 c1 01             	add    $0x1,%ecx
    1333:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1337:	83 c2 01             	add    $0x1,%edx
    133a:	84 db                	test   %bl,%bl
    133c:	88 5a ff             	mov    %bl,-0x1(%edx)
    133f:	75 ef                	jne    1330 <strcpy+0x10>
    ;
  return os;
}
    1341:	5b                   	pop    %ebx
    1342:	5d                   	pop    %ebp
    1343:	c3                   	ret    
    1344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    134a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	56                   	push   %esi
    1354:	53                   	push   %ebx
    1355:	8b 55 08             	mov    0x8(%ebp),%edx
    1358:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    135b:	0f b6 02             	movzbl (%edx),%eax
    135e:	0f b6 19             	movzbl (%ecx),%ebx
    1361:	84 c0                	test   %al,%al
    1363:	75 1e                	jne    1383 <strcmp+0x33>
    1365:	eb 29                	jmp    1390 <strcmp+0x40>
    1367:	89 f6                	mov    %esi,%esi
    1369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1370:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1373:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1376:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1379:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    137d:	84 c0                	test   %al,%al
    137f:	74 0f                	je     1390 <strcmp+0x40>
    1381:	89 f1                	mov    %esi,%ecx
    1383:	38 d8                	cmp    %bl,%al
    1385:	74 e9                	je     1370 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1387:	29 d8                	sub    %ebx,%eax
}
    1389:	5b                   	pop    %ebx
    138a:	5e                   	pop    %esi
    138b:	5d                   	pop    %ebp
    138c:	c3                   	ret    
    138d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1390:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1392:	29 d8                	sub    %ebx,%eax
}
    1394:	5b                   	pop    %ebx
    1395:	5e                   	pop    %esi
    1396:	5d                   	pop    %ebp
    1397:	c3                   	ret    
    1398:	90                   	nop
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013a0 <strlen>:

uint
strlen(char *s)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    13a6:	80 39 00             	cmpb   $0x0,(%ecx)
    13a9:	74 12                	je     13bd <strlen+0x1d>
    13ab:	31 d2                	xor    %edx,%edx
    13ad:	8d 76 00             	lea    0x0(%esi),%esi
    13b0:	83 c2 01             	add    $0x1,%edx
    13b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    13b7:	89 d0                	mov    %edx,%eax
    13b9:	75 f5                	jne    13b0 <strlen+0x10>
    ;
  return n;
}
    13bb:	5d                   	pop    %ebp
    13bc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    13bd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    13bf:	5d                   	pop    %ebp
    13c0:	c3                   	ret    
    13c1:	eb 0d                	jmp    13d0 <memset>
    13c3:	90                   	nop
    13c4:	90                   	nop
    13c5:	90                   	nop
    13c6:	90                   	nop
    13c7:	90                   	nop
    13c8:	90                   	nop
    13c9:	90                   	nop
    13ca:	90                   	nop
    13cb:	90                   	nop
    13cc:	90                   	nop
    13cd:	90                   	nop
    13ce:	90                   	nop
    13cf:	90                   	nop

000013d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	57                   	push   %edi
    13d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    13d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13da:	8b 45 0c             	mov    0xc(%ebp),%eax
    13dd:	89 d7                	mov    %edx,%edi
    13df:	fc                   	cld    
    13e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    13e2:	89 d0                	mov    %edx,%eax
    13e4:	5f                   	pop    %edi
    13e5:	5d                   	pop    %ebp
    13e6:	c3                   	ret    
    13e7:	89 f6                	mov    %esi,%esi
    13e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013f0 <strchr>:

char*
strchr(const char *s, char c)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	53                   	push   %ebx
    13f4:	8b 45 08             	mov    0x8(%ebp),%eax
    13f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    13fa:	0f b6 10             	movzbl (%eax),%edx
    13fd:	84 d2                	test   %dl,%dl
    13ff:	74 1d                	je     141e <strchr+0x2e>
    if(*s == c)
    1401:	38 d3                	cmp    %dl,%bl
    1403:	89 d9                	mov    %ebx,%ecx
    1405:	75 0d                	jne    1414 <strchr+0x24>
    1407:	eb 17                	jmp    1420 <strchr+0x30>
    1409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1410:	38 ca                	cmp    %cl,%dl
    1412:	74 0c                	je     1420 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1414:	83 c0 01             	add    $0x1,%eax
    1417:	0f b6 10             	movzbl (%eax),%edx
    141a:	84 d2                	test   %dl,%dl
    141c:	75 f2                	jne    1410 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    141e:	31 c0                	xor    %eax,%eax
}
    1420:	5b                   	pop    %ebx
    1421:	5d                   	pop    %ebp
    1422:	c3                   	ret    
    1423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001430 <gets>:

char*
gets(char *buf, int max)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1436:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1438:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    143b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    143e:	eb 29                	jmp    1469 <gets+0x39>
    cc = read(0, &c, 1);
    1440:	83 ec 04             	sub    $0x4,%esp
    1443:	6a 01                	push   $0x1
    1445:	57                   	push   %edi
    1446:	6a 00                	push   $0x0
    1448:	e8 2d 01 00 00       	call   157a <read>
    if(cc < 1)
    144d:	83 c4 10             	add    $0x10,%esp
    1450:	85 c0                	test   %eax,%eax
    1452:	7e 1d                	jle    1471 <gets+0x41>
      break;
    buf[i++] = c;
    1454:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1458:	8b 55 08             	mov    0x8(%ebp),%edx
    145b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    145d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    145f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1463:	74 1b                	je     1480 <gets+0x50>
    1465:	3c 0d                	cmp    $0xd,%al
    1467:	74 17                	je     1480 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1469:	8d 5e 01             	lea    0x1(%esi),%ebx
    146c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    146f:	7c cf                	jl     1440 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1471:	8b 45 08             	mov    0x8(%ebp),%eax
    1474:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1478:	8d 65 f4             	lea    -0xc(%ebp),%esp
    147b:	5b                   	pop    %ebx
    147c:	5e                   	pop    %esi
    147d:	5f                   	pop    %edi
    147e:	5d                   	pop    %ebp
    147f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1483:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1485:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1489:	8d 65 f4             	lea    -0xc(%ebp),%esp
    148c:	5b                   	pop    %ebx
    148d:	5e                   	pop    %esi
    148e:	5f                   	pop    %edi
    148f:	5d                   	pop    %ebp
    1490:	c3                   	ret    
    1491:	eb 0d                	jmp    14a0 <stat>
    1493:	90                   	nop
    1494:	90                   	nop
    1495:	90                   	nop
    1496:	90                   	nop
    1497:	90                   	nop
    1498:	90                   	nop
    1499:	90                   	nop
    149a:	90                   	nop
    149b:	90                   	nop
    149c:	90                   	nop
    149d:	90                   	nop
    149e:	90                   	nop
    149f:	90                   	nop

000014a0 <stat>:

int
stat(char *n, struct stat *st)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	56                   	push   %esi
    14a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14a5:	83 ec 08             	sub    $0x8,%esp
    14a8:	6a 00                	push   $0x0
    14aa:	ff 75 08             	pushl  0x8(%ebp)
    14ad:	e8 f0 00 00 00       	call   15a2 <open>
  if(fd < 0)
    14b2:	83 c4 10             	add    $0x10,%esp
    14b5:	85 c0                	test   %eax,%eax
    14b7:	78 27                	js     14e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    14b9:	83 ec 08             	sub    $0x8,%esp
    14bc:	ff 75 0c             	pushl  0xc(%ebp)
    14bf:	89 c3                	mov    %eax,%ebx
    14c1:	50                   	push   %eax
    14c2:	e8 f3 00 00 00       	call   15ba <fstat>
    14c7:	89 c6                	mov    %eax,%esi
  close(fd);
    14c9:	89 1c 24             	mov    %ebx,(%esp)
    14cc:	e8 b9 00 00 00       	call   158a <close>
  return r;
    14d1:	83 c4 10             	add    $0x10,%esp
    14d4:	89 f0                	mov    %esi,%eax
}
    14d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14d9:	5b                   	pop    %ebx
    14da:	5e                   	pop    %esi
    14db:	5d                   	pop    %ebp
    14dc:	c3                   	ret    
    14dd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    14e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14e5:	eb ef                	jmp    14d6 <stat+0x36>
    14e7:	89 f6                	mov    %esi,%esi
    14e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	53                   	push   %ebx
    14f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    14f7:	0f be 11             	movsbl (%ecx),%edx
    14fa:	8d 42 d0             	lea    -0x30(%edx),%eax
    14fd:	3c 09                	cmp    $0x9,%al
    14ff:	b8 00 00 00 00       	mov    $0x0,%eax
    1504:	77 1f                	ja     1525 <atoi+0x35>
    1506:	8d 76 00             	lea    0x0(%esi),%esi
    1509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1510:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1513:	83 c1 01             	add    $0x1,%ecx
    1516:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    151a:	0f be 11             	movsbl (%ecx),%edx
    151d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1520:	80 fb 09             	cmp    $0x9,%bl
    1523:	76 eb                	jbe    1510 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1525:	5b                   	pop    %ebx
    1526:	5d                   	pop    %ebp
    1527:	c3                   	ret    
    1528:	90                   	nop
    1529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001530 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	56                   	push   %esi
    1534:	53                   	push   %ebx
    1535:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1538:	8b 45 08             	mov    0x8(%ebp),%eax
    153b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    153e:	85 db                	test   %ebx,%ebx
    1540:	7e 14                	jle    1556 <memmove+0x26>
    1542:	31 d2                	xor    %edx,%edx
    1544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1548:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    154c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    154f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1552:	39 da                	cmp    %ebx,%edx
    1554:	75 f2                	jne    1548 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1556:	5b                   	pop    %ebx
    1557:	5e                   	pop    %esi
    1558:	5d                   	pop    %ebp
    1559:	c3                   	ret    

0000155a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    155a:	b8 01 00 00 00       	mov    $0x1,%eax
    155f:	cd 40                	int    $0x40
    1561:	c3                   	ret    

00001562 <exit>:
SYSCALL(exit)
    1562:	b8 02 00 00 00       	mov    $0x2,%eax
    1567:	cd 40                	int    $0x40
    1569:	c3                   	ret    

0000156a <wait>:
SYSCALL(wait)
    156a:	b8 03 00 00 00       	mov    $0x3,%eax
    156f:	cd 40                	int    $0x40
    1571:	c3                   	ret    

00001572 <pipe>:
SYSCALL(pipe)
    1572:	b8 04 00 00 00       	mov    $0x4,%eax
    1577:	cd 40                	int    $0x40
    1579:	c3                   	ret    

0000157a <read>:
SYSCALL(read)
    157a:	b8 05 00 00 00       	mov    $0x5,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <write>:
SYSCALL(write)
    1582:	b8 10 00 00 00       	mov    $0x10,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <close>:
SYSCALL(close)
    158a:	b8 15 00 00 00       	mov    $0x15,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <kill>:
SYSCALL(kill)
    1592:	b8 06 00 00 00       	mov    $0x6,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    

0000159a <exec>:
SYSCALL(exec)
    159a:	b8 07 00 00 00       	mov    $0x7,%eax
    159f:	cd 40                	int    $0x40
    15a1:	c3                   	ret    

000015a2 <open>:
SYSCALL(open)
    15a2:	b8 0f 00 00 00       	mov    $0xf,%eax
    15a7:	cd 40                	int    $0x40
    15a9:	c3                   	ret    

000015aa <mknod>:
SYSCALL(mknod)
    15aa:	b8 11 00 00 00       	mov    $0x11,%eax
    15af:	cd 40                	int    $0x40
    15b1:	c3                   	ret    

000015b2 <unlink>:
SYSCALL(unlink)
    15b2:	b8 12 00 00 00       	mov    $0x12,%eax
    15b7:	cd 40                	int    $0x40
    15b9:	c3                   	ret    

000015ba <fstat>:
SYSCALL(fstat)
    15ba:	b8 08 00 00 00       	mov    $0x8,%eax
    15bf:	cd 40                	int    $0x40
    15c1:	c3                   	ret    

000015c2 <link>:
SYSCALL(link)
    15c2:	b8 13 00 00 00       	mov    $0x13,%eax
    15c7:	cd 40                	int    $0x40
    15c9:	c3                   	ret    

000015ca <mkdir>:
SYSCALL(mkdir)
    15ca:	b8 14 00 00 00       	mov    $0x14,%eax
    15cf:	cd 40                	int    $0x40
    15d1:	c3                   	ret    

000015d2 <chdir>:
SYSCALL(chdir)
    15d2:	b8 09 00 00 00       	mov    $0x9,%eax
    15d7:	cd 40                	int    $0x40
    15d9:	c3                   	ret    

000015da <dup>:
SYSCALL(dup)
    15da:	b8 0a 00 00 00       	mov    $0xa,%eax
    15df:	cd 40                	int    $0x40
    15e1:	c3                   	ret    

000015e2 <getpid>:
SYSCALL(getpid)
    15e2:	b8 0b 00 00 00       	mov    $0xb,%eax
    15e7:	cd 40                	int    $0x40
    15e9:	c3                   	ret    

000015ea <sbrk>:
SYSCALL(sbrk)
    15ea:	b8 0c 00 00 00       	mov    $0xc,%eax
    15ef:	cd 40                	int    $0x40
    15f1:	c3                   	ret    

000015f2 <sleep>:
SYSCALL(sleep)
    15f2:	b8 0d 00 00 00       	mov    $0xd,%eax
    15f7:	cd 40                	int    $0x40
    15f9:	c3                   	ret    

000015fa <uptime>:
SYSCALL(uptime)
    15fa:	b8 0e 00 00 00       	mov    $0xe,%eax
    15ff:	cd 40                	int    $0x40
    1601:	c3                   	ret    

00001602 <getcount>:
SYSCALL(getcount) //added getcount here
    1602:	b8 16 00 00 00       	mov    $0x16,%eax
    1607:	cd 40                	int    $0x40
    1609:	c3                   	ret    

0000160a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    160a:	b8 17 00 00 00       	mov    $0x17,%eax
    160f:	cd 40                	int    $0x40
    1611:	c3                   	ret    

00001612 <increasepriority>:
SYSCALL(increasepriority)
    1612:	b8 18 00 00 00       	mov    $0x18,%eax
    1617:	cd 40                	int    $0x40
    1619:	c3                   	ret    
    161a:	66 90                	xchg   %ax,%ax
    161c:	66 90                	xchg   %ax,%ax
    161e:	66 90                	xchg   %ax,%ax

00001620 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	57                   	push   %edi
    1624:	56                   	push   %esi
    1625:	53                   	push   %ebx
    1626:	89 c6                	mov    %eax,%esi
    1628:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    162b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    162e:	85 db                	test   %ebx,%ebx
    1630:	74 7e                	je     16b0 <printint+0x90>
    1632:	89 d0                	mov    %edx,%eax
    1634:	c1 e8 1f             	shr    $0x1f,%eax
    1637:	84 c0                	test   %al,%al
    1639:	74 75                	je     16b0 <printint+0x90>
    neg = 1;
    x = -xx;
    163b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    163d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1644:	f7 d8                	neg    %eax
    1646:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1649:	31 ff                	xor    %edi,%edi
    164b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    164e:	89 ce                	mov    %ecx,%esi
    1650:	eb 08                	jmp    165a <printint+0x3a>
    1652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1658:	89 cf                	mov    %ecx,%edi
    165a:	31 d2                	xor    %edx,%edx
    165c:	8d 4f 01             	lea    0x1(%edi),%ecx
    165f:	f7 f6                	div    %esi
    1661:	0f b6 92 20 1a 00 00 	movzbl 0x1a20(%edx),%edx
  }while((x /= base) != 0);
    1668:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    166a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    166d:	75 e9                	jne    1658 <printint+0x38>
  if(neg)
    166f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1672:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1675:	85 c0                	test   %eax,%eax
    1677:	74 08                	je     1681 <printint+0x61>
    buf[i++] = '-';
    1679:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    167e:	8d 4f 02             	lea    0x2(%edi),%ecx
    1681:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    1685:	8d 76 00             	lea    0x0(%esi),%esi
    1688:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    168b:	83 ec 04             	sub    $0x4,%esp
    168e:	83 ef 01             	sub    $0x1,%edi
    1691:	6a 01                	push   $0x1
    1693:	53                   	push   %ebx
    1694:	56                   	push   %esi
    1695:	88 45 d7             	mov    %al,-0x29(%ebp)
    1698:	e8 e5 fe ff ff       	call   1582 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    169d:	83 c4 10             	add    $0x10,%esp
    16a0:	39 df                	cmp    %ebx,%edi
    16a2:	75 e4                	jne    1688 <printint+0x68>
    putc(fd, buf[i]);
}
    16a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16a7:	5b                   	pop    %ebx
    16a8:	5e                   	pop    %esi
    16a9:	5f                   	pop    %edi
    16aa:	5d                   	pop    %ebp
    16ab:	c3                   	ret    
    16ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    16b0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16b2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    16b9:	eb 8b                	jmp    1646 <printint+0x26>
    16bb:	90                   	nop
    16bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16c0:	55                   	push   %ebp
    16c1:	89 e5                	mov    %esp,%ebp
    16c3:	57                   	push   %edi
    16c4:	56                   	push   %esi
    16c5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16c6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16c9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16cc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16cf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    16d5:	0f b6 1e             	movzbl (%esi),%ebx
    16d8:	83 c6 01             	add    $0x1,%esi
    16db:	84 db                	test   %bl,%bl
    16dd:	0f 84 b0 00 00 00    	je     1793 <printf+0xd3>
    16e3:	31 d2                	xor    %edx,%edx
    16e5:	eb 39                	jmp    1720 <printf+0x60>
    16e7:	89 f6                	mov    %esi,%esi
    16e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    16f0:	83 f8 25             	cmp    $0x25,%eax
    16f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    16f6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    16fb:	74 18                	je     1715 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16fd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1700:	83 ec 04             	sub    $0x4,%esp
    1703:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1706:	6a 01                	push   $0x1
    1708:	50                   	push   %eax
    1709:	57                   	push   %edi
    170a:	e8 73 fe ff ff       	call   1582 <write>
    170f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1712:	83 c4 10             	add    $0x10,%esp
    1715:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1718:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    171c:	84 db                	test   %bl,%bl
    171e:	74 73                	je     1793 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1720:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1722:	0f be cb             	movsbl %bl,%ecx
    1725:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1728:	74 c6                	je     16f0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    172a:	83 fa 25             	cmp    $0x25,%edx
    172d:	75 e6                	jne    1715 <printf+0x55>
      if(c == 'd'){
    172f:	83 f8 64             	cmp    $0x64,%eax
    1732:	0f 84 f8 00 00 00    	je     1830 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1738:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    173e:	83 f9 70             	cmp    $0x70,%ecx
    1741:	74 5d                	je     17a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1743:	83 f8 73             	cmp    $0x73,%eax
    1746:	0f 84 84 00 00 00    	je     17d0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    174c:	83 f8 63             	cmp    $0x63,%eax
    174f:	0f 84 ea 00 00 00    	je     183f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1755:	83 f8 25             	cmp    $0x25,%eax
    1758:	0f 84 c2 00 00 00    	je     1820 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    175e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1761:	83 ec 04             	sub    $0x4,%esp
    1764:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1768:	6a 01                	push   $0x1
    176a:	50                   	push   %eax
    176b:	57                   	push   %edi
    176c:	e8 11 fe ff ff       	call   1582 <write>
    1771:	83 c4 0c             	add    $0xc,%esp
    1774:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1777:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    177a:	6a 01                	push   $0x1
    177c:	50                   	push   %eax
    177d:	57                   	push   %edi
    177e:	83 c6 01             	add    $0x1,%esi
    1781:	e8 fc fd ff ff       	call   1582 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1786:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    178a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    178d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    178f:	84 db                	test   %bl,%bl
    1791:	75 8d                	jne    1720 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1793:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1796:	5b                   	pop    %ebx
    1797:	5e                   	pop    %esi
    1798:	5f                   	pop    %edi
    1799:	5d                   	pop    %ebp
    179a:	c3                   	ret    
    179b:	90                   	nop
    179c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    17a0:	83 ec 0c             	sub    $0xc,%esp
    17a3:	b9 10 00 00 00       	mov    $0x10,%ecx
    17a8:	6a 00                	push   $0x0
    17aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    17ad:	89 f8                	mov    %edi,%eax
    17af:	8b 13                	mov    (%ebx),%edx
    17b1:	e8 6a fe ff ff       	call   1620 <printint>
        ap++;
    17b6:	89 d8                	mov    %ebx,%eax
    17b8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    17bb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    17bd:	83 c0 04             	add    $0x4,%eax
    17c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    17c3:	e9 4d ff ff ff       	jmp    1715 <printf+0x55>
    17c8:	90                   	nop
    17c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    17d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    17d3:	8b 18                	mov    (%eax),%ebx
        ap++;
    17d5:	83 c0 04             	add    $0x4,%eax
    17d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    17db:	b8 16 1a 00 00       	mov    $0x1a16,%eax
    17e0:	85 db                	test   %ebx,%ebx
    17e2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    17e5:	0f b6 03             	movzbl (%ebx),%eax
    17e8:	84 c0                	test   %al,%al
    17ea:	74 23                	je     180f <printf+0x14f>
    17ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17f0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17f3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    17f6:	83 ec 04             	sub    $0x4,%esp
    17f9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    17fb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17fe:	50                   	push   %eax
    17ff:	57                   	push   %edi
    1800:	e8 7d fd ff ff       	call   1582 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1805:	0f b6 03             	movzbl (%ebx),%eax
    1808:	83 c4 10             	add    $0x10,%esp
    180b:	84 c0                	test   %al,%al
    180d:	75 e1                	jne    17f0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    180f:	31 d2                	xor    %edx,%edx
    1811:	e9 ff fe ff ff       	jmp    1715 <printf+0x55>
    1816:	8d 76 00             	lea    0x0(%esi),%esi
    1819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1820:	83 ec 04             	sub    $0x4,%esp
    1823:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1826:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1829:	6a 01                	push   $0x1
    182b:	e9 4c ff ff ff       	jmp    177c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1830:	83 ec 0c             	sub    $0xc,%esp
    1833:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1838:	6a 01                	push   $0x1
    183a:	e9 6b ff ff ff       	jmp    17aa <printf+0xea>
    183f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1842:	83 ec 04             	sub    $0x4,%esp
    1845:	8b 03                	mov    (%ebx),%eax
    1847:	6a 01                	push   $0x1
    1849:	88 45 e4             	mov    %al,-0x1c(%ebp)
    184c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    184f:	50                   	push   %eax
    1850:	57                   	push   %edi
    1851:	e8 2c fd ff ff       	call   1582 <write>
    1856:	e9 5b ff ff ff       	jmp    17b6 <printf+0xf6>
    185b:	66 90                	xchg   %ax,%ax
    185d:	66 90                	xchg   %ax,%ax
    185f:	90                   	nop

00001860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1860:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1861:	a1 c0 1d 00 00       	mov    0x1dc0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1866:	89 e5                	mov    %esp,%ebp
    1868:	57                   	push   %edi
    1869:	56                   	push   %esi
    186a:	53                   	push   %ebx
    186b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    186e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1870:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1873:	39 c8                	cmp    %ecx,%eax
    1875:	73 19                	jae    1890 <free+0x30>
    1877:	89 f6                	mov    %esi,%esi
    1879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1880:	39 d1                	cmp    %edx,%ecx
    1882:	72 1c                	jb     18a0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1884:	39 d0                	cmp    %edx,%eax
    1886:	73 18                	jae    18a0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1888:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    188a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    188c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    188e:	72 f0                	jb     1880 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1890:	39 d0                	cmp    %edx,%eax
    1892:	72 f4                	jb     1888 <free+0x28>
    1894:	39 d1                	cmp    %edx,%ecx
    1896:	73 f0                	jae    1888 <free+0x28>
    1898:	90                   	nop
    1899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    18a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18a6:	39 d7                	cmp    %edx,%edi
    18a8:	74 19                	je     18c3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18ad:	8b 50 04             	mov    0x4(%eax),%edx
    18b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18b3:	39 f1                	cmp    %esi,%ecx
    18b5:	74 23                	je     18da <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18b7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18b9:	a3 c0 1d 00 00       	mov    %eax,0x1dc0
}
    18be:	5b                   	pop    %ebx
    18bf:	5e                   	pop    %esi
    18c0:	5f                   	pop    %edi
    18c1:	5d                   	pop    %ebp
    18c2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    18c3:	03 72 04             	add    0x4(%edx),%esi
    18c6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    18c9:	8b 10                	mov    (%eax),%edx
    18cb:	8b 12                	mov    (%edx),%edx
    18cd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    18d0:	8b 50 04             	mov    0x4(%eax),%edx
    18d3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18d6:	39 f1                	cmp    %esi,%ecx
    18d8:	75 dd                	jne    18b7 <free+0x57>
    p->s.size += bp->s.size;
    18da:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    18dd:	a3 c0 1d 00 00       	mov    %eax,0x1dc0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    18e2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    18e5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    18e8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    18ea:	5b                   	pop    %ebx
    18eb:	5e                   	pop    %esi
    18ec:	5f                   	pop    %edi
    18ed:	5d                   	pop    %ebp
    18ee:	c3                   	ret    
    18ef:	90                   	nop

000018f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    18f0:	55                   	push   %ebp
    18f1:	89 e5                	mov    %esp,%ebp
    18f3:	57                   	push   %edi
    18f4:	56                   	push   %esi
    18f5:	53                   	push   %ebx
    18f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    18fc:	8b 15 c0 1d 00 00    	mov    0x1dc0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1902:	8d 78 07             	lea    0x7(%eax),%edi
    1905:	c1 ef 03             	shr    $0x3,%edi
    1908:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    190b:	85 d2                	test   %edx,%edx
    190d:	0f 84 a3 00 00 00    	je     19b6 <malloc+0xc6>
    1913:	8b 02                	mov    (%edx),%eax
    1915:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1918:	39 cf                	cmp    %ecx,%edi
    191a:	76 74                	jbe    1990 <malloc+0xa0>
    191c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1922:	be 00 10 00 00       	mov    $0x1000,%esi
    1927:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    192e:	0f 43 f7             	cmovae %edi,%esi
    1931:	ba 00 80 00 00       	mov    $0x8000,%edx
    1936:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    193c:	0f 46 da             	cmovbe %edx,%ebx
    193f:	eb 10                	jmp    1951 <malloc+0x61>
    1941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1948:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    194a:	8b 48 04             	mov    0x4(%eax),%ecx
    194d:	39 cf                	cmp    %ecx,%edi
    194f:	76 3f                	jbe    1990 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1951:	39 05 c0 1d 00 00    	cmp    %eax,0x1dc0
    1957:	89 c2                	mov    %eax,%edx
    1959:	75 ed                	jne    1948 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    195b:	83 ec 0c             	sub    $0xc,%esp
    195e:	53                   	push   %ebx
    195f:	e8 86 fc ff ff       	call   15ea <sbrk>
  if(p == (char*)-1)
    1964:	83 c4 10             	add    $0x10,%esp
    1967:	83 f8 ff             	cmp    $0xffffffff,%eax
    196a:	74 1c                	je     1988 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    196c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    196f:	83 ec 0c             	sub    $0xc,%esp
    1972:	83 c0 08             	add    $0x8,%eax
    1975:	50                   	push   %eax
    1976:	e8 e5 fe ff ff       	call   1860 <free>
  return freep;
    197b:	8b 15 c0 1d 00 00    	mov    0x1dc0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1981:	83 c4 10             	add    $0x10,%esp
    1984:	85 d2                	test   %edx,%edx
    1986:	75 c0                	jne    1948 <malloc+0x58>
        return 0;
    1988:	31 c0                	xor    %eax,%eax
    198a:	eb 1c                	jmp    19a8 <malloc+0xb8>
    198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1990:	39 cf                	cmp    %ecx,%edi
    1992:	74 1c                	je     19b0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1994:	29 f9                	sub    %edi,%ecx
    1996:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1999:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    199c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    199f:	89 15 c0 1d 00 00    	mov    %edx,0x1dc0
      return (void*)(p + 1);
    19a5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    19a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19ab:	5b                   	pop    %ebx
    19ac:	5e                   	pop    %esi
    19ad:	5f                   	pop    %edi
    19ae:	5d                   	pop    %ebp
    19af:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    19b0:	8b 08                	mov    (%eax),%ecx
    19b2:	89 0a                	mov    %ecx,(%edx)
    19b4:	eb e9                	jmp    199f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    19b6:	c7 05 c0 1d 00 00 c4 	movl   $0x1dc4,0x1dc0
    19bd:	1d 00 00 
    19c0:	c7 05 c4 1d 00 00 c4 	movl   $0x1dc4,0x1dc4
    19c7:	1d 00 00 
    base.s.size = 0;
    19ca:	b8 c4 1d 00 00       	mov    $0x1dc4,%eax
    19cf:	c7 05 c8 1d 00 00 00 	movl   $0x0,0x1dc8
    19d6:	00 00 00 
    19d9:	e9 3e ff ff ff       	jmp    191c <malloc+0x2c>
