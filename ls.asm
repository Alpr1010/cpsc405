
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
  close(fd);
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
    1011:	bb 01 00 00 00       	mov    $0x1,%ebx
    1016:	83 ec 08             	sub    $0x8,%esp
    1019:	8b 31                	mov    (%ecx),%esi
    101b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
    101e:	83 fe 01             	cmp    $0x1,%esi
    1021:	7e 1f                	jle    1042 <main+0x42>
    1023:	90                   	nop
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
    1028:	83 ec 0c             	sub    $0xc,%esp
    102b:	ff 34 9f             	pushl  (%edi,%ebx,4)

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    102e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
    1031:	e8 ca 00 00 00       	call   1100 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    1036:	83 c4 10             	add    $0x10,%esp
    1039:	39 de                	cmp    %ebx,%esi
    103b:	75 eb                	jne    1028 <main+0x28>
    ls(argv[i]);
  exit();
    103d:	e8 40 05 00 00       	call   1582 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
    1042:	83 ec 0c             	sub    $0xc,%esp
    1045:	68 48 1a 00 00       	push   $0x1a48
    104a:	e8 b1 00 00 00       	call   1100 <ls>
    exit();
    104f:	e8 2e 05 00 00       	call   1582 <exit>
    1054:	66 90                	xchg   %ax,%ax
    1056:	66 90                	xchg   %ax,%ax
    1058:	66 90                	xchg   %ax,%ax
    105a:	66 90                	xchg   %ax,%ax
    105c:	66 90                	xchg   %ax,%ax
    105e:	66 90                	xchg   %ax,%ax

00001060 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	56                   	push   %esi
    1064:	53                   	push   %ebx
    1065:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    1068:	83 ec 0c             	sub    $0xc,%esp
    106b:	53                   	push   %ebx
    106c:	e8 4f 03 00 00       	call   13c0 <strlen>
    1071:	83 c4 10             	add    $0x10,%esp
    1074:	01 d8                	add    %ebx,%eax
    1076:	73 0f                	jae    1087 <fmtname+0x27>
    1078:	eb 12                	jmp    108c <fmtname+0x2c>
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1080:	83 e8 01             	sub    $0x1,%eax
    1083:	39 c3                	cmp    %eax,%ebx
    1085:	77 05                	ja     108c <fmtname+0x2c>
    1087:	80 38 2f             	cmpb   $0x2f,(%eax)
    108a:	75 f4                	jne    1080 <fmtname+0x20>
    ;
  p++;
    108c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    108f:	83 ec 0c             	sub    $0xc,%esp
    1092:	53                   	push   %ebx
    1093:	e8 28 03 00 00       	call   13c0 <strlen>
    1098:	83 c4 10             	add    $0x10,%esp
    109b:	83 f8 0d             	cmp    $0xd,%eax
    109e:	77 4a                	ja     10ea <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
    10a0:	83 ec 0c             	sub    $0xc,%esp
    10a3:	53                   	push   %ebx
    10a4:	e8 17 03 00 00       	call   13c0 <strlen>
    10a9:	83 c4 0c             	add    $0xc,%esp
    10ac:	50                   	push   %eax
    10ad:	53                   	push   %ebx
    10ae:	68 60 1d 00 00       	push   $0x1d60
    10b3:	e8 98 04 00 00       	call   1550 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10b8:	89 1c 24             	mov    %ebx,(%esp)
    10bb:	e8 00 03 00 00       	call   13c0 <strlen>
    10c0:	89 1c 24             	mov    %ebx,(%esp)
    10c3:	89 c6                	mov    %eax,%esi
  return buf;
    10c5:	bb 60 1d 00 00       	mov    $0x1d60,%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    10ca:	e8 f1 02 00 00       	call   13c0 <strlen>
    10cf:	ba 0e 00 00 00       	mov    $0xe,%edx
    10d4:	83 c4 0c             	add    $0xc,%esp
    10d7:	05 60 1d 00 00       	add    $0x1d60,%eax
    10dc:	29 f2                	sub    %esi,%edx
    10de:	52                   	push   %edx
    10df:	6a 20                	push   $0x20
    10e1:	50                   	push   %eax
    10e2:	e8 09 03 00 00       	call   13f0 <memset>
  return buf;
    10e7:	83 c4 10             	add    $0x10,%esp
}
    10ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
    10ed:	89 d8                	mov    %ebx,%eax
    10ef:	5b                   	pop    %ebx
    10f0:	5e                   	pop    %esi
    10f1:	5d                   	pop    %ebp
    10f2:	c3                   	ret    
    10f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <ls>:

void
ls(char *path)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	56                   	push   %esi
    1105:	53                   	push   %ebx
    1106:	81 ec 64 02 00 00    	sub    $0x264,%esp
    110c:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    110f:	6a 00                	push   $0x0
    1111:	57                   	push   %edi
    1112:	e8 ab 04 00 00       	call   15c2 <open>
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	85 c0                	test   %eax,%eax
    111c:	0f 88 9e 01 00 00    	js     12c0 <ls+0x1c0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    1122:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
    1128:	83 ec 08             	sub    $0x8,%esp
    112b:	89 c3                	mov    %eax,%ebx
    112d:	56                   	push   %esi
    112e:	50                   	push   %eax
    112f:	e8 a6 04 00 00       	call   15da <fstat>
    1134:	83 c4 10             	add    $0x10,%esp
    1137:	85 c0                	test   %eax,%eax
    1139:	0f 88 c1 01 00 00    	js     1300 <ls+0x200>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
    113f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
    1146:	66 83 f8 01          	cmp    $0x1,%ax
    114a:	74 54                	je     11a0 <ls+0xa0>
    114c:	66 83 f8 02          	cmp    $0x2,%ax
    1150:	75 37                	jne    1189 <ls+0x89>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1152:	83 ec 0c             	sub    $0xc,%esp
    1155:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    115b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
    1161:	57                   	push   %edi
    1162:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
    1168:	e8 f3 fe ff ff       	call   1060 <fmtname>
    116d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
    1173:	59                   	pop    %ecx
    1174:	5f                   	pop    %edi
    1175:	52                   	push   %edx
    1176:	56                   	push   %esi
    1177:	6a 02                	push   $0x2
    1179:	50                   	push   %eax
    117a:	68 28 1a 00 00       	push   $0x1a28
    117f:	6a 01                	push   $0x1
    1181:	e8 5a 05 00 00       	call   16e0 <printf>
    break;
    1186:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
    1189:	83 ec 0c             	sub    $0xc,%esp
    118c:	53                   	push   %ebx
    118d:	e8 18 04 00 00       	call   15aa <close>
    1192:	83 c4 10             	add    $0x10,%esp
}
    1195:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1198:	5b                   	pop    %ebx
    1199:	5e                   	pop    %esi
    119a:	5f                   	pop    %edi
    119b:	5d                   	pop    %ebp
    119c:	c3                   	ret    
    119d:	8d 76 00             	lea    0x0(%esi),%esi
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    11a0:	83 ec 0c             	sub    $0xc,%esp
    11a3:	57                   	push   %edi
    11a4:	e8 17 02 00 00       	call   13c0 <strlen>
    11a9:	83 c0 10             	add    $0x10,%eax
    11ac:	83 c4 10             	add    $0x10,%esp
    11af:	3d 00 02 00 00       	cmp    $0x200,%eax
    11b4:	0f 87 26 01 00 00    	ja     12e0 <ls+0x1e0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    11ba:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    11c0:	83 ec 08             	sub    $0x8,%esp
    11c3:	57                   	push   %edi
    11c4:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
    11ca:	50                   	push   %eax
    11cb:	e8 70 01 00 00       	call   1340 <strcpy>
    p = buf+strlen(buf);
    11d0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    11d6:	89 04 24             	mov    %eax,(%esp)
    11d9:	e8 e2 01 00 00       	call   13c0 <strlen>
    11de:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11e4:	83 c4 10             	add    $0x10,%esp
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    11e7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    *p++ = '/';
    11ea:	8d 84 05 e9 fd ff ff 	lea    -0x217(%ebp,%eax,1),%eax
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    11f1:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
    11f7:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
    11fd:	c6 01 2f             	movb   $0x2f,(%ecx)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    1200:	83 ec 04             	sub    $0x4,%esp
    1203:	6a 10                	push   $0x10
    1205:	57                   	push   %edi
    1206:	53                   	push   %ebx
    1207:	e8 8e 03 00 00       	call   159a <read>
    120c:	83 c4 10             	add    $0x10,%esp
    120f:	83 f8 10             	cmp    $0x10,%eax
    1212:	0f 85 71 ff ff ff    	jne    1189 <ls+0x89>
      if(de.inum == 0)
    1218:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
    121f:	00 
    1220:	74 de                	je     1200 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
    1222:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
    1228:	83 ec 04             	sub    $0x4,%esp
    122b:	6a 0e                	push   $0xe
    122d:	50                   	push   %eax
    122e:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
    1234:	e8 17 03 00 00       	call   1550 <memmove>
      p[DIRSIZ] = 0;
    1239:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
    123f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
    1243:	58                   	pop    %eax
    1244:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    124a:	5a                   	pop    %edx
    124b:	56                   	push   %esi
    124c:	50                   	push   %eax
    124d:	e8 6e 02 00 00       	call   14c0 <stat>
    1252:	83 c4 10             	add    $0x10,%esp
    1255:	85 c0                	test   %eax,%eax
    1257:	0f 88 c3 00 00 00    	js     1320 <ls+0x220>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    125d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
    1263:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
    126a:	83 ec 0c             	sub    $0xc,%esp
    126d:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
    1273:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
    1279:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    127f:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
    1285:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    128b:	51                   	push   %ecx
    128c:	e8 cf fd ff ff       	call   1060 <fmtname>
    1291:	5a                   	pop    %edx
    1292:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
    1298:	59                   	pop    %ecx
    1299:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
    129f:	51                   	push   %ecx
    12a0:	52                   	push   %edx
    12a1:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
    12a7:	50                   	push   %eax
    12a8:	68 28 1a 00 00       	push   $0x1a28
    12ad:	6a 01                	push   $0x1
    12af:	e8 2c 04 00 00       	call   16e0 <printf>
    12b4:	83 c4 20             	add    $0x20,%esp
    12b7:	e9 44 ff ff ff       	jmp    1200 <ls+0x100>
    12bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    12c0:	83 ec 04             	sub    $0x4,%esp
    12c3:	57                   	push   %edi
    12c4:	68 00 1a 00 00       	push   $0x1a00
    12c9:	6a 02                	push   $0x2
    12cb:	e8 10 04 00 00       	call   16e0 <printf>
    return;
    12d0:	83 c4 10             	add    $0x10,%esp
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
    12d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12d6:	5b                   	pop    %ebx
    12d7:	5e                   	pop    %esi
    12d8:	5f                   	pop    %edi
    12d9:	5d                   	pop    %ebp
    12da:	c3                   	ret    
    12db:	90                   	nop
    12dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
    12e0:	83 ec 08             	sub    $0x8,%esp
    12e3:	68 35 1a 00 00       	push   $0x1a35
    12e8:	6a 01                	push   $0x1
    12ea:	e8 f1 03 00 00       	call   16e0 <printf>
      break;
    12ef:	83 c4 10             	add    $0x10,%esp
    12f2:	e9 92 fe ff ff       	jmp    1189 <ls+0x89>
    12f7:	89 f6                	mov    %esi,%esi
    12f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    1300:	83 ec 04             	sub    $0x4,%esp
    1303:	57                   	push   %edi
    1304:	68 14 1a 00 00       	push   $0x1a14
    1309:	6a 02                	push   $0x2
    130b:	e8 d0 03 00 00       	call   16e0 <printf>
    close(fd);
    1310:	89 1c 24             	mov    %ebx,(%esp)
    1313:	e8 92 02 00 00       	call   15aa <close>
    return;
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	e9 75 fe ff ff       	jmp    1195 <ls+0x95>
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
    1320:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    1326:	83 ec 04             	sub    $0x4,%esp
    1329:	50                   	push   %eax
    132a:	68 14 1a 00 00       	push   $0x1a14
    132f:	6a 01                	push   $0x1
    1331:	e8 aa 03 00 00       	call   16e0 <printf>
        continue;
    1336:	83 c4 10             	add    $0x10,%esp
    1339:	e9 c2 fe ff ff       	jmp    1200 <ls+0x100>
    133e:	66 90                	xchg   %ax,%ax

00001340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	53                   	push   %ebx
    1344:	8b 45 08             	mov    0x8(%ebp),%eax
    1347:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    134a:	89 c2                	mov    %eax,%edx
    134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1350:	83 c1 01             	add    $0x1,%ecx
    1353:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1357:	83 c2 01             	add    $0x1,%edx
    135a:	84 db                	test   %bl,%bl
    135c:	88 5a ff             	mov    %bl,-0x1(%edx)
    135f:	75 ef                	jne    1350 <strcpy+0x10>
    ;
  return os;
}
    1361:	5b                   	pop    %ebx
    1362:	5d                   	pop    %ebp
    1363:	c3                   	ret    
    1364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    136a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	56                   	push   %esi
    1374:	53                   	push   %ebx
    1375:	8b 55 08             	mov    0x8(%ebp),%edx
    1378:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    137b:	0f b6 02             	movzbl (%edx),%eax
    137e:	0f b6 19             	movzbl (%ecx),%ebx
    1381:	84 c0                	test   %al,%al
    1383:	75 1e                	jne    13a3 <strcmp+0x33>
    1385:	eb 29                	jmp    13b0 <strcmp+0x40>
    1387:	89 f6                	mov    %esi,%esi
    1389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1390:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1393:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1396:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1399:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    139d:	84 c0                	test   %al,%al
    139f:	74 0f                	je     13b0 <strcmp+0x40>
    13a1:	89 f1                	mov    %esi,%ecx
    13a3:	38 d8                	cmp    %bl,%al
    13a5:	74 e9                	je     1390 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    13a7:	29 d8                	sub    %ebx,%eax
}
    13a9:	5b                   	pop    %ebx
    13aa:	5e                   	pop    %esi
    13ab:	5d                   	pop    %ebp
    13ac:	c3                   	ret    
    13ad:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13b0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    13b2:	29 d8                	sub    %ebx,%eax
}
    13b4:	5b                   	pop    %ebx
    13b5:	5e                   	pop    %esi
    13b6:	5d                   	pop    %ebp
    13b7:	c3                   	ret    
    13b8:	90                   	nop
    13b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013c0 <strlen>:

uint
strlen(char *s)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    13c6:	80 39 00             	cmpb   $0x0,(%ecx)
    13c9:	74 12                	je     13dd <strlen+0x1d>
    13cb:	31 d2                	xor    %edx,%edx
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
    13d0:	83 c2 01             	add    $0x1,%edx
    13d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    13d7:	89 d0                	mov    %edx,%eax
    13d9:	75 f5                	jne    13d0 <strlen+0x10>
    ;
  return n;
}
    13db:	5d                   	pop    %ebp
    13dc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    13dd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    13df:	5d                   	pop    %ebp
    13e0:	c3                   	ret    
    13e1:	eb 0d                	jmp    13f0 <memset>
    13e3:	90                   	nop
    13e4:	90                   	nop
    13e5:	90                   	nop
    13e6:	90                   	nop
    13e7:	90                   	nop
    13e8:	90                   	nop
    13e9:	90                   	nop
    13ea:	90                   	nop
    13eb:	90                   	nop
    13ec:	90                   	nop
    13ed:	90                   	nop
    13ee:	90                   	nop
    13ef:	90                   	nop

000013f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	57                   	push   %edi
    13f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    13f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    13fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fd:	89 d7                	mov    %edx,%edi
    13ff:	fc                   	cld    
    1400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1402:	89 d0                	mov    %edx,%eax
    1404:	5f                   	pop    %edi
    1405:	5d                   	pop    %ebp
    1406:	c3                   	ret    
    1407:	89 f6                	mov    %esi,%esi
    1409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001410 <strchr>:

char*
strchr(const char *s, char c)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	53                   	push   %ebx
    1414:	8b 45 08             	mov    0x8(%ebp),%eax
    1417:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    141a:	0f b6 10             	movzbl (%eax),%edx
    141d:	84 d2                	test   %dl,%dl
    141f:	74 1d                	je     143e <strchr+0x2e>
    if(*s == c)
    1421:	38 d3                	cmp    %dl,%bl
    1423:	89 d9                	mov    %ebx,%ecx
    1425:	75 0d                	jne    1434 <strchr+0x24>
    1427:	eb 17                	jmp    1440 <strchr+0x30>
    1429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1430:	38 ca                	cmp    %cl,%dl
    1432:	74 0c                	je     1440 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1434:	83 c0 01             	add    $0x1,%eax
    1437:	0f b6 10             	movzbl (%eax),%edx
    143a:	84 d2                	test   %dl,%dl
    143c:	75 f2                	jne    1430 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    143e:	31 c0                	xor    %eax,%eax
}
    1440:	5b                   	pop    %ebx
    1441:	5d                   	pop    %ebp
    1442:	c3                   	ret    
    1443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001450 <gets>:

char*
gets(char *buf, int max)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	57                   	push   %edi
    1454:	56                   	push   %esi
    1455:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1456:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1458:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    145b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    145e:	eb 29                	jmp    1489 <gets+0x39>
    cc = read(0, &c, 1);
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	6a 01                	push   $0x1
    1465:	57                   	push   %edi
    1466:	6a 00                	push   $0x0
    1468:	e8 2d 01 00 00       	call   159a <read>
    if(cc < 1)
    146d:	83 c4 10             	add    $0x10,%esp
    1470:	85 c0                	test   %eax,%eax
    1472:	7e 1d                	jle    1491 <gets+0x41>
      break;
    buf[i++] = c;
    1474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1478:	8b 55 08             	mov    0x8(%ebp),%edx
    147b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    147d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    147f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1483:	74 1b                	je     14a0 <gets+0x50>
    1485:	3c 0d                	cmp    $0xd,%al
    1487:	74 17                	je     14a0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1489:	8d 5e 01             	lea    0x1(%esi),%ebx
    148c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    148f:	7c cf                	jl     1460 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1498:	8d 65 f4             	lea    -0xc(%ebp),%esp
    149b:	5b                   	pop    %ebx
    149c:	5e                   	pop    %esi
    149d:	5f                   	pop    %edi
    149e:	5d                   	pop    %ebp
    149f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    14a0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14a3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    14a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    14a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14ac:	5b                   	pop    %ebx
    14ad:	5e                   	pop    %esi
    14ae:	5f                   	pop    %edi
    14af:	5d                   	pop    %ebp
    14b0:	c3                   	ret    
    14b1:	eb 0d                	jmp    14c0 <stat>
    14b3:	90                   	nop
    14b4:	90                   	nop
    14b5:	90                   	nop
    14b6:	90                   	nop
    14b7:	90                   	nop
    14b8:	90                   	nop
    14b9:	90                   	nop
    14ba:	90                   	nop
    14bb:	90                   	nop
    14bc:	90                   	nop
    14bd:	90                   	nop
    14be:	90                   	nop
    14bf:	90                   	nop

000014c0 <stat>:

int
stat(char *n, struct stat *st)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	56                   	push   %esi
    14c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14c5:	83 ec 08             	sub    $0x8,%esp
    14c8:	6a 00                	push   $0x0
    14ca:	ff 75 08             	pushl  0x8(%ebp)
    14cd:	e8 f0 00 00 00       	call   15c2 <open>
  if(fd < 0)
    14d2:	83 c4 10             	add    $0x10,%esp
    14d5:	85 c0                	test   %eax,%eax
    14d7:	78 27                	js     1500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    14d9:	83 ec 08             	sub    $0x8,%esp
    14dc:	ff 75 0c             	pushl  0xc(%ebp)
    14df:	89 c3                	mov    %eax,%ebx
    14e1:	50                   	push   %eax
    14e2:	e8 f3 00 00 00       	call   15da <fstat>
    14e7:	89 c6                	mov    %eax,%esi
  close(fd);
    14e9:	89 1c 24             	mov    %ebx,(%esp)
    14ec:	e8 b9 00 00 00       	call   15aa <close>
  return r;
    14f1:	83 c4 10             	add    $0x10,%esp
    14f4:	89 f0                	mov    %esi,%eax
}
    14f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14f9:	5b                   	pop    %ebx
    14fa:	5e                   	pop    %esi
    14fb:	5d                   	pop    %ebp
    14fc:	c3                   	ret    
    14fd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1505:	eb ef                	jmp    14f6 <stat+0x36>
    1507:	89 f6                	mov    %esi,%esi
    1509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001510 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	53                   	push   %ebx
    1514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1517:	0f be 11             	movsbl (%ecx),%edx
    151a:	8d 42 d0             	lea    -0x30(%edx),%eax
    151d:	3c 09                	cmp    $0x9,%al
    151f:	b8 00 00 00 00       	mov    $0x0,%eax
    1524:	77 1f                	ja     1545 <atoi+0x35>
    1526:	8d 76 00             	lea    0x0(%esi),%esi
    1529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1530:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1533:	83 c1 01             	add    $0x1,%ecx
    1536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    153a:	0f be 11             	movsbl (%ecx),%edx
    153d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1540:	80 fb 09             	cmp    $0x9,%bl
    1543:	76 eb                	jbe    1530 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1545:	5b                   	pop    %ebx
    1546:	5d                   	pop    %ebp
    1547:	c3                   	ret    
    1548:	90                   	nop
    1549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	56                   	push   %esi
    1554:	53                   	push   %ebx
    1555:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    155e:	85 db                	test   %ebx,%ebx
    1560:	7e 14                	jle    1576 <memmove+0x26>
    1562:	31 d2                	xor    %edx,%edx
    1564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    156c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    156f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1572:	39 da                	cmp    %ebx,%edx
    1574:	75 f2                	jne    1568 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1576:	5b                   	pop    %ebx
    1577:	5e                   	pop    %esi
    1578:	5d                   	pop    %ebp
    1579:	c3                   	ret    

0000157a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    157a:	b8 01 00 00 00       	mov    $0x1,%eax
    157f:	cd 40                	int    $0x40
    1581:	c3                   	ret    

00001582 <exit>:
SYSCALL(exit)
    1582:	b8 02 00 00 00       	mov    $0x2,%eax
    1587:	cd 40                	int    $0x40
    1589:	c3                   	ret    

0000158a <wait>:
SYSCALL(wait)
    158a:	b8 03 00 00 00       	mov    $0x3,%eax
    158f:	cd 40                	int    $0x40
    1591:	c3                   	ret    

00001592 <pipe>:
SYSCALL(pipe)
    1592:	b8 04 00 00 00       	mov    $0x4,%eax
    1597:	cd 40                	int    $0x40
    1599:	c3                   	ret    

0000159a <read>:
SYSCALL(read)
    159a:	b8 05 00 00 00       	mov    $0x5,%eax
    159f:	cd 40                	int    $0x40
    15a1:	c3                   	ret    

000015a2 <write>:
SYSCALL(write)
    15a2:	b8 10 00 00 00       	mov    $0x10,%eax
    15a7:	cd 40                	int    $0x40
    15a9:	c3                   	ret    

000015aa <close>:
SYSCALL(close)
    15aa:	b8 15 00 00 00       	mov    $0x15,%eax
    15af:	cd 40                	int    $0x40
    15b1:	c3                   	ret    

000015b2 <kill>:
SYSCALL(kill)
    15b2:	b8 06 00 00 00       	mov    $0x6,%eax
    15b7:	cd 40                	int    $0x40
    15b9:	c3                   	ret    

000015ba <exec>:
SYSCALL(exec)
    15ba:	b8 07 00 00 00       	mov    $0x7,%eax
    15bf:	cd 40                	int    $0x40
    15c1:	c3                   	ret    

000015c2 <open>:
SYSCALL(open)
    15c2:	b8 0f 00 00 00       	mov    $0xf,%eax
    15c7:	cd 40                	int    $0x40
    15c9:	c3                   	ret    

000015ca <mknod>:
SYSCALL(mknod)
    15ca:	b8 11 00 00 00       	mov    $0x11,%eax
    15cf:	cd 40                	int    $0x40
    15d1:	c3                   	ret    

000015d2 <unlink>:
SYSCALL(unlink)
    15d2:	b8 12 00 00 00       	mov    $0x12,%eax
    15d7:	cd 40                	int    $0x40
    15d9:	c3                   	ret    

000015da <fstat>:
SYSCALL(fstat)
    15da:	b8 08 00 00 00       	mov    $0x8,%eax
    15df:	cd 40                	int    $0x40
    15e1:	c3                   	ret    

000015e2 <link>:
SYSCALL(link)
    15e2:	b8 13 00 00 00       	mov    $0x13,%eax
    15e7:	cd 40                	int    $0x40
    15e9:	c3                   	ret    

000015ea <mkdir>:
SYSCALL(mkdir)
    15ea:	b8 14 00 00 00       	mov    $0x14,%eax
    15ef:	cd 40                	int    $0x40
    15f1:	c3                   	ret    

000015f2 <chdir>:
SYSCALL(chdir)
    15f2:	b8 09 00 00 00       	mov    $0x9,%eax
    15f7:	cd 40                	int    $0x40
    15f9:	c3                   	ret    

000015fa <dup>:
SYSCALL(dup)
    15fa:	b8 0a 00 00 00       	mov    $0xa,%eax
    15ff:	cd 40                	int    $0x40
    1601:	c3                   	ret    

00001602 <getpid>:
SYSCALL(getpid)
    1602:	b8 0b 00 00 00       	mov    $0xb,%eax
    1607:	cd 40                	int    $0x40
    1609:	c3                   	ret    

0000160a <sbrk>:
SYSCALL(sbrk)
    160a:	b8 0c 00 00 00       	mov    $0xc,%eax
    160f:	cd 40                	int    $0x40
    1611:	c3                   	ret    

00001612 <sleep>:
SYSCALL(sleep)
    1612:	b8 0d 00 00 00       	mov    $0xd,%eax
    1617:	cd 40                	int    $0x40
    1619:	c3                   	ret    

0000161a <uptime>:
SYSCALL(uptime)
    161a:	b8 0e 00 00 00       	mov    $0xe,%eax
    161f:	cd 40                	int    $0x40
    1621:	c3                   	ret    

00001622 <getcount>:
SYSCALL(getcount) //added getcount here
    1622:	b8 16 00 00 00       	mov    $0x16,%eax
    1627:	cd 40                	int    $0x40
    1629:	c3                   	ret    

0000162a <getprocessinfo>:
SYSCALL(getprocessinfo) //printing all process info
    162a:	b8 17 00 00 00       	mov    $0x17,%eax
    162f:	cd 40                	int    $0x40
    1631:	c3                   	ret    

00001632 <increasepriority>:
SYSCALL(increasepriority)
    1632:	b8 18 00 00 00       	mov    $0x18,%eax
    1637:	cd 40                	int    $0x40
    1639:	c3                   	ret    
    163a:	66 90                	xchg   %ax,%ax
    163c:	66 90                	xchg   %ax,%ax
    163e:	66 90                	xchg   %ax,%ax

00001640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	57                   	push   %edi
    1644:	56                   	push   %esi
    1645:	53                   	push   %ebx
    1646:	89 c6                	mov    %eax,%esi
    1648:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    164b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    164e:	85 db                	test   %ebx,%ebx
    1650:	74 7e                	je     16d0 <printint+0x90>
    1652:	89 d0                	mov    %edx,%eax
    1654:	c1 e8 1f             	shr    $0x1f,%eax
    1657:	84 c0                	test   %al,%al
    1659:	74 75                	je     16d0 <printint+0x90>
    neg = 1;
    x = -xx;
    165b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    165d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1664:	f7 d8                	neg    %eax
    1666:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1669:	31 ff                	xor    %edi,%edi
    166b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    166e:	89 ce                	mov    %ecx,%esi
    1670:	eb 08                	jmp    167a <printint+0x3a>
    1672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1678:	89 cf                	mov    %ecx,%edi
    167a:	31 d2                	xor    %edx,%edx
    167c:	8d 4f 01             	lea    0x1(%edi),%ecx
    167f:	f7 f6                	div    %esi
    1681:	0f b6 92 54 1a 00 00 	movzbl 0x1a54(%edx),%edx
  }while((x /= base) != 0);
    1688:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    168a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    168d:	75 e9                	jne    1678 <printint+0x38>
  if(neg)
    168f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1692:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1695:	85 c0                	test   %eax,%eax
    1697:	74 08                	je     16a1 <printint+0x61>
    buf[i++] = '-';
    1699:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    169e:	8d 4f 02             	lea    0x2(%edi),%ecx
    16a1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    16a5:	8d 76 00             	lea    0x0(%esi),%esi
    16a8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16ab:	83 ec 04             	sub    $0x4,%esp
    16ae:	83 ef 01             	sub    $0x1,%edi
    16b1:	6a 01                	push   $0x1
    16b3:	53                   	push   %ebx
    16b4:	56                   	push   %esi
    16b5:	88 45 d7             	mov    %al,-0x29(%ebp)
    16b8:	e8 e5 fe ff ff       	call   15a2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16bd:	83 c4 10             	add    $0x10,%esp
    16c0:	39 df                	cmp    %ebx,%edi
    16c2:	75 e4                	jne    16a8 <printint+0x68>
    putc(fd, buf[i]);
}
    16c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16c7:	5b                   	pop    %ebx
    16c8:	5e                   	pop    %esi
    16c9:	5f                   	pop    %edi
    16ca:	5d                   	pop    %ebp
    16cb:	c3                   	ret    
    16cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    16d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    16d9:	eb 8b                	jmp    1666 <printint+0x26>
    16db:	90                   	nop
    16dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	57                   	push   %edi
    16e4:	56                   	push   %esi
    16e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16e6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16e9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16ec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    16f5:	0f b6 1e             	movzbl (%esi),%ebx
    16f8:	83 c6 01             	add    $0x1,%esi
    16fb:	84 db                	test   %bl,%bl
    16fd:	0f 84 b0 00 00 00    	je     17b3 <printf+0xd3>
    1703:	31 d2                	xor    %edx,%edx
    1705:	eb 39                	jmp    1740 <printf+0x60>
    1707:	89 f6                	mov    %esi,%esi
    1709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1710:	83 f8 25             	cmp    $0x25,%eax
    1713:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1716:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    171b:	74 18                	je     1735 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    171d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1720:	83 ec 04             	sub    $0x4,%esp
    1723:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1726:	6a 01                	push   $0x1
    1728:	50                   	push   %eax
    1729:	57                   	push   %edi
    172a:	e8 73 fe ff ff       	call   15a2 <write>
    172f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1732:	83 c4 10             	add    $0x10,%esp
    1735:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1738:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    173c:	84 db                	test   %bl,%bl
    173e:	74 73                	je     17b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1740:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1742:	0f be cb             	movsbl %bl,%ecx
    1745:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1748:	74 c6                	je     1710 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    174a:	83 fa 25             	cmp    $0x25,%edx
    174d:	75 e6                	jne    1735 <printf+0x55>
      if(c == 'd'){
    174f:	83 f8 64             	cmp    $0x64,%eax
    1752:	0f 84 f8 00 00 00    	je     1850 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1758:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    175e:	83 f9 70             	cmp    $0x70,%ecx
    1761:	74 5d                	je     17c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1763:	83 f8 73             	cmp    $0x73,%eax
    1766:	0f 84 84 00 00 00    	je     17f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    176c:	83 f8 63             	cmp    $0x63,%eax
    176f:	0f 84 ea 00 00 00    	je     185f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1775:	83 f8 25             	cmp    $0x25,%eax
    1778:	0f 84 c2 00 00 00    	je     1840 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    177e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1781:	83 ec 04             	sub    $0x4,%esp
    1784:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1788:	6a 01                	push   $0x1
    178a:	50                   	push   %eax
    178b:	57                   	push   %edi
    178c:	e8 11 fe ff ff       	call   15a2 <write>
    1791:	83 c4 0c             	add    $0xc,%esp
    1794:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1797:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    179a:	6a 01                	push   $0x1
    179c:	50                   	push   %eax
    179d:	57                   	push   %edi
    179e:	83 c6 01             	add    $0x1,%esi
    17a1:	e8 fc fd ff ff       	call   15a2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    17ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17af:	84 db                	test   %bl,%bl
    17b1:	75 8d                	jne    1740 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17b6:	5b                   	pop    %ebx
    17b7:	5e                   	pop    %esi
    17b8:	5f                   	pop    %edi
    17b9:	5d                   	pop    %ebp
    17ba:	c3                   	ret    
    17bb:	90                   	nop
    17bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    17c0:	83 ec 0c             	sub    $0xc,%esp
    17c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    17c8:	6a 00                	push   $0x0
    17ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    17cd:	89 f8                	mov    %edi,%eax
    17cf:	8b 13                	mov    (%ebx),%edx
    17d1:	e8 6a fe ff ff       	call   1640 <printint>
        ap++;
    17d6:	89 d8                	mov    %ebx,%eax
    17d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    17db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    17dd:	83 c0 04             	add    $0x4,%eax
    17e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    17e3:	e9 4d ff ff ff       	jmp    1735 <printf+0x55>
    17e8:	90                   	nop
    17e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    17f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    17f3:	8b 18                	mov    (%eax),%ebx
        ap++;
    17f5:	83 c0 04             	add    $0x4,%eax
    17f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    17fb:	b8 4a 1a 00 00       	mov    $0x1a4a,%eax
    1800:	85 db                	test   %ebx,%ebx
    1802:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1805:	0f b6 03             	movzbl (%ebx),%eax
    1808:	84 c0                	test   %al,%al
    180a:	74 23                	je     182f <printf+0x14f>
    180c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1810:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1813:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1816:	83 ec 04             	sub    $0x4,%esp
    1819:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    181b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    181e:	50                   	push   %eax
    181f:	57                   	push   %edi
    1820:	e8 7d fd ff ff       	call   15a2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1825:	0f b6 03             	movzbl (%ebx),%eax
    1828:	83 c4 10             	add    $0x10,%esp
    182b:	84 c0                	test   %al,%al
    182d:	75 e1                	jne    1810 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    182f:	31 d2                	xor    %edx,%edx
    1831:	e9 ff fe ff ff       	jmp    1735 <printf+0x55>
    1836:	8d 76 00             	lea    0x0(%esi),%esi
    1839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1840:	83 ec 04             	sub    $0x4,%esp
    1843:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1846:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1849:	6a 01                	push   $0x1
    184b:	e9 4c ff ff ff       	jmp    179c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1850:	83 ec 0c             	sub    $0xc,%esp
    1853:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1858:	6a 01                	push   $0x1
    185a:	e9 6b ff ff ff       	jmp    17ca <printf+0xea>
    185f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1862:	83 ec 04             	sub    $0x4,%esp
    1865:	8b 03                	mov    (%ebx),%eax
    1867:	6a 01                	push   $0x1
    1869:	88 45 e4             	mov    %al,-0x1c(%ebp)
    186c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    186f:	50                   	push   %eax
    1870:	57                   	push   %edi
    1871:	e8 2c fd ff ff       	call   15a2 <write>
    1876:	e9 5b ff ff ff       	jmp    17d6 <printf+0xf6>
    187b:	66 90                	xchg   %ax,%ax
    187d:	66 90                	xchg   %ax,%ax
    187f:	90                   	nop

00001880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1881:	a1 70 1d 00 00       	mov    0x1d70,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1886:	89 e5                	mov    %esp,%ebp
    1888:	57                   	push   %edi
    1889:	56                   	push   %esi
    188a:	53                   	push   %ebx
    188b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    188e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1890:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1893:	39 c8                	cmp    %ecx,%eax
    1895:	73 19                	jae    18b0 <free+0x30>
    1897:	89 f6                	mov    %esi,%esi
    1899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    18a0:	39 d1                	cmp    %edx,%ecx
    18a2:	72 1c                	jb     18c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18a4:	39 d0                	cmp    %edx,%eax
    18a6:	73 18                	jae    18c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    18a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18ae:	72 f0                	jb     18a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18b0:	39 d0                	cmp    %edx,%eax
    18b2:	72 f4                	jb     18a8 <free+0x28>
    18b4:	39 d1                	cmp    %edx,%ecx
    18b6:	73 f0                	jae    18a8 <free+0x28>
    18b8:	90                   	nop
    18b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    18c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    18c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    18c6:	39 d7                	cmp    %edx,%edi
    18c8:	74 19                	je     18e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    18ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    18cd:	8b 50 04             	mov    0x4(%eax),%edx
    18d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18d3:	39 f1                	cmp    %esi,%ecx
    18d5:	74 23                	je     18fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    18d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    18d9:	a3 70 1d 00 00       	mov    %eax,0x1d70
}
    18de:	5b                   	pop    %ebx
    18df:	5e                   	pop    %esi
    18e0:	5f                   	pop    %edi
    18e1:	5d                   	pop    %ebp
    18e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    18e3:	03 72 04             	add    0x4(%edx),%esi
    18e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    18e9:	8b 10                	mov    (%eax),%edx
    18eb:	8b 12                	mov    (%edx),%edx
    18ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    18f0:	8b 50 04             	mov    0x4(%eax),%edx
    18f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    18f6:	39 f1                	cmp    %esi,%ecx
    18f8:	75 dd                	jne    18d7 <free+0x57>
    p->s.size += bp->s.size;
    18fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    18fd:	a3 70 1d 00 00       	mov    %eax,0x1d70
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1902:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1905:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1908:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    190a:	5b                   	pop    %ebx
    190b:	5e                   	pop    %esi
    190c:	5f                   	pop    %edi
    190d:	5d                   	pop    %ebp
    190e:	c3                   	ret    
    190f:	90                   	nop

00001910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1910:	55                   	push   %ebp
    1911:	89 e5                	mov    %esp,%ebp
    1913:	57                   	push   %edi
    1914:	56                   	push   %esi
    1915:	53                   	push   %ebx
    1916:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    191c:	8b 15 70 1d 00 00    	mov    0x1d70,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1922:	8d 78 07             	lea    0x7(%eax),%edi
    1925:	c1 ef 03             	shr    $0x3,%edi
    1928:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    192b:	85 d2                	test   %edx,%edx
    192d:	0f 84 a3 00 00 00    	je     19d6 <malloc+0xc6>
    1933:	8b 02                	mov    (%edx),%eax
    1935:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1938:	39 cf                	cmp    %ecx,%edi
    193a:	76 74                	jbe    19b0 <malloc+0xa0>
    193c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1942:	be 00 10 00 00       	mov    $0x1000,%esi
    1947:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    194e:	0f 43 f7             	cmovae %edi,%esi
    1951:	ba 00 80 00 00       	mov    $0x8000,%edx
    1956:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    195c:	0f 46 da             	cmovbe %edx,%ebx
    195f:	eb 10                	jmp    1971 <malloc+0x61>
    1961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1968:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    196a:	8b 48 04             	mov    0x4(%eax),%ecx
    196d:	39 cf                	cmp    %ecx,%edi
    196f:	76 3f                	jbe    19b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1971:	39 05 70 1d 00 00    	cmp    %eax,0x1d70
    1977:	89 c2                	mov    %eax,%edx
    1979:	75 ed                	jne    1968 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    197b:	83 ec 0c             	sub    $0xc,%esp
    197e:	53                   	push   %ebx
    197f:	e8 86 fc ff ff       	call   160a <sbrk>
  if(p == (char*)-1)
    1984:	83 c4 10             	add    $0x10,%esp
    1987:	83 f8 ff             	cmp    $0xffffffff,%eax
    198a:	74 1c                	je     19a8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    198c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    198f:	83 ec 0c             	sub    $0xc,%esp
    1992:	83 c0 08             	add    $0x8,%eax
    1995:	50                   	push   %eax
    1996:	e8 e5 fe ff ff       	call   1880 <free>
  return freep;
    199b:	8b 15 70 1d 00 00    	mov    0x1d70,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    19a1:	83 c4 10             	add    $0x10,%esp
    19a4:	85 d2                	test   %edx,%edx
    19a6:	75 c0                	jne    1968 <malloc+0x58>
        return 0;
    19a8:	31 c0                	xor    %eax,%eax
    19aa:	eb 1c                	jmp    19c8 <malloc+0xb8>
    19ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    19b0:	39 cf                	cmp    %ecx,%edi
    19b2:	74 1c                	je     19d0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    19b4:	29 f9                	sub    %edi,%ecx
    19b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    19b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    19bc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    19bf:	89 15 70 1d 00 00    	mov    %edx,0x1d70
      return (void*)(p + 1);
    19c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    19c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19cb:	5b                   	pop    %ebx
    19cc:	5e                   	pop    %esi
    19cd:	5f                   	pop    %edi
    19ce:	5d                   	pop    %ebp
    19cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    19d0:	8b 08                	mov    (%eax),%ecx
    19d2:	89 0a                	mov    %ecx,(%edx)
    19d4:	eb e9                	jmp    19bf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    19d6:	c7 05 70 1d 00 00 74 	movl   $0x1d74,0x1d70
    19dd:	1d 00 00 
    19e0:	c7 05 74 1d 00 00 74 	movl   $0x1d74,0x1d74
    19e7:	1d 00 00 
    base.s.size = 0;
    19ea:	b8 74 1d 00 00       	mov    $0x1d74,%eax
    19ef:	c7 05 78 1d 00 00 00 	movl   $0x0,0x1d78
    19f6:	00 00 00 
    19f9:	e9 3e ff ff ff       	jmp    193c <malloc+0x2c>
