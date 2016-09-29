
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 70 2e 10 80       	mov    $0x80102e70,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100046:	68 00 6f 10 80       	push   $0x80106f00
8010004b:	68 e0 b5 10 80       	push   $0x8010b5e0
80100050:	e8 fb 40 00 00       	call   80104150 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100055:	c7 05 f0 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f0
8010005c:	f4 10 80 
  bcache.head.next = &bcache.head;
8010005f:	c7 05 f4 f4 10 80 e4 	movl   $0x8010f4e4,0x8010f4f4
80100066:	f4 10 80 
80100069:	83 c4 10             	add    $0x10,%esp
8010006c:	b9 e4 f4 10 80       	mov    $0x8010f4e4,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	b8 14 b6 10 80       	mov    $0x8010b614,%eax
80100076:	eb 0a                	jmp    80100082 <binit+0x42>
80100078:	90                   	nop
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
80100082:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
80100085:	c7 40 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%eax)
8010008c:	89 c1                	mov    %eax,%ecx
    b->dev = -1;
8010008e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100095:	8b 15 f4 f4 10 80    	mov    0x8010f4f4,%edx
8010009b:	89 42 0c             	mov    %eax,0xc(%edx)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000a4:	a3 f4 f4 10 80       	mov    %eax,0x8010f4f4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	81 fa e4 f4 10 80    	cmp    $0x8010f4e4,%edx
801000af:	75 cf                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    
801000b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	57                   	push   %edi
801000c4:	56                   	push   %esi
801000c5:	53                   	push   %ebx
801000c6:	83 ec 18             	sub    $0x18,%esp
801000c9:	8b 75 08             	mov    0x8(%ebp),%esi
801000cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000cf:	68 e0 b5 10 80       	push   $0x8010b5e0
801000d4:	e8 97 40 00 00       	call   80104170 <acquire>
801000d9:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000dc:	8b 1d f4 f4 10 80    	mov    0x8010f4f4,%ebx
801000e2:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000e8:	75 11                	jne    801000fb <bread+0x3b>
801000ea:	eb 34                	jmp    80100120 <bread+0x60>
801000ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
801000f9:	74 25                	je     80100120 <bread+0x60>
    if(b->dev == dev && b->blockno == blockno){
801000fb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	74 6c                	je     80100177 <bread+0xb7>
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
8010010b:	83 ec 08             	sub    $0x8,%esp
8010010e:	68 e0 b5 10 80       	push   $0x8010b5e0
80100113:	53                   	push   %ebx
80100114:	e8 b7 3c 00 00       	call   80103dd0 <sleep>
80100119:	83 c4 10             	add    $0x10,%esp
8010011c:	eb be                	jmp    801000dc <bread+0x1c>
8010011e:	66 90                	xchg   %ax,%ax
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d f0 f4 10 80    	mov    0x8010f4f0,%ebx
80100126:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x7b>
8010012e:	eb 5e                	jmp    8010018e <bread+0xce>
80100130:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100133:	81 fb e4 f4 10 80    	cmp    $0x8010f4e4,%ebx
80100139:	74 53                	je     8010018e <bread+0xce>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010013b:	f6 03 05             	testb  $0x5,(%ebx)
8010013e:	75 f0                	jne    80100130 <bread+0x70>
      b->dev = dev;
      b->blockno = blockno;
      b->flags = B_BUSY;
      release(&bcache.lock);
80100140:	83 ec 0c             	sub    $0xc,%esp
  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
      b->dev = dev;
80100143:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100146:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
80100149:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
8010014f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100154:	e8 f7 41 00 00       	call   80104350 <release>
80100159:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
8010015c:	f6 03 02             	testb  $0x2,(%ebx)
8010015f:	75 0c                	jne    8010016d <bread+0xad>
    iderw(b);
80100161:	83 ec 0c             	sub    $0xc,%esp
80100164:	53                   	push   %ebx
80100165:	e8 66 1f 00 00       	call   801020d0 <iderw>
8010016a:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
8010016d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100170:	89 d8                	mov    %ebx,%eax
80100172:	5b                   	pop    %ebx
80100173:	5e                   	pop    %esi
80100174:	5f                   	pop    %edi
80100175:	5d                   	pop    %ebp
80100176:	c3                   	ret    
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
        release(&bcache.lock);
80100177:	83 ec 0c             	sub    $0xc,%esp
 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
8010017a:	83 c8 01             	or     $0x1,%eax
8010017d:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
8010017f:	68 e0 b5 10 80       	push   $0x8010b5e0
80100184:	e8 c7 41 00 00       	call   80104350 <release>
80100189:	83 c4 10             	add    $0x10,%esp
8010018c:	eb ce                	jmp    8010015c <bread+0x9c>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
8010018e:	83 ec 0c             	sub    $0xc,%esp
80100191:	68 07 6f 10 80       	push   $0x80106f07
80100196:	e8 b5 01 00 00       	call   80100350 <panic>
8010019b:	90                   	nop
8010019c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	83 ec 08             	sub    $0x8,%esp
801001a6:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
801001a9:	8b 02                	mov    (%edx),%eax
801001ab:	a8 01                	test   $0x1,%al
801001ad:	74 0e                	je     801001bd <bwrite+0x1d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001af:	83 c8 04             	or     $0x4,%eax
801001b2:	89 02                	mov    %eax,(%edx)
  iderw(b);
801001b4:	89 55 08             	mov    %edx,0x8(%ebp)
}
801001b7:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001b8:	e9 13 1f 00 00       	jmp    801020d0 <iderw>
// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
801001bd:	83 ec 0c             	sub    $0xc,%esp
801001c0:	68 18 6f 10 80       	push   $0x80106f18
801001c5:	e8 86 01 00 00       	call   80100350 <panic>
801001ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001d0 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d0:	55                   	push   %ebp
801001d1:	89 e5                	mov    %esp,%ebp
801001d3:	53                   	push   %ebx
801001d4:	83 ec 04             	sub    $0x4,%esp
801001d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
801001da:	f6 03 01             	testb  $0x1,(%ebx)
801001dd:	74 5a                	je     80100239 <brelse+0x69>
    panic("brelse");

  acquire(&bcache.lock);
801001df:	83 ec 0c             	sub    $0xc,%esp
801001e2:	68 e0 b5 10 80       	push   $0x8010b5e0
801001e7:	e8 84 3f 00 00       	call   80104170 <acquire>

  b->next->prev = b->prev;
801001ec:	8b 43 10             	mov    0x10(%ebx),%eax
801001ef:	8b 53 0c             	mov    0xc(%ebx),%edx
801001f2:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
801001f5:	8b 43 0c             	mov    0xc(%ebx),%eax
801001f8:	8b 53 10             	mov    0x10(%ebx),%edx
801001fb:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
801001fe:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
  b->prev = &bcache.head;
80100203:	c7 43 0c e4 f4 10 80 	movl   $0x8010f4e4,0xc(%ebx)

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
8010020a:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
8010020d:	a1 f4 f4 10 80       	mov    0x8010f4f4,%eax
80100212:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
80100215:	89 1d f4 f4 10 80    	mov    %ebx,0x8010f4f4

  b->flags &= ~B_BUSY;
8010021b:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
8010021e:	89 1c 24             	mov    %ebx,(%esp)
80100221:	e8 5a 3d 00 00       	call   80103f80 <wakeup>

  release(&bcache.lock);
80100226:	83 c4 10             	add    $0x10,%esp
80100229:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100233:	c9                   	leave  
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
80100234:	e9 17 41 00 00       	jmp    80104350 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
80100239:	83 ec 0c             	sub    $0xc,%esp
8010023c:	68 1f 6f 10 80       	push   $0x80106f1f
80100241:	e8 0a 01 00 00       	call   80100350 <panic>
80100246:	66 90                	xchg   %ax,%ax
80100248:	66 90                	xchg   %ax,%ax
8010024a:	66 90                	xchg   %ax,%ax
8010024c:	66 90                	xchg   %ax,%ax
8010024e:	66 90                	xchg   %ax,%ax

80100250 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100250:	55                   	push   %ebp
80100251:	89 e5                	mov    %esp,%ebp
80100253:	57                   	push   %edi
80100254:	56                   	push   %esi
80100255:	53                   	push   %ebx
80100256:	83 ec 28             	sub    $0x28,%esp
80100259:	8b 7d 08             	mov    0x8(%ebp),%edi
8010025c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010025f:	57                   	push   %edi
80100260:	e8 ab 14 00 00       	call   80101710 <iunlock>
  target = n;
  acquire(&cons.lock);
80100265:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010026c:	e8 ff 3e 00 00       	call   80104170 <acquire>
  while(n > 0){
80100271:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100274:	83 c4 10             	add    $0x10,%esp
80100277:	31 c0                	xor    %eax,%eax
80100279:	85 db                	test   %ebx,%ebx
8010027b:	0f 8e 9a 00 00 00    	jle    8010031b <consoleread+0xcb>
    while(input.r == input.w){
80100281:	a1 80 f7 10 80       	mov    0x8010f780,%eax
80100286:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
8010028c:	74 24                	je     801002b2 <consoleread+0x62>
8010028e:	eb 58                	jmp    801002e8 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100290:	83 ec 08             	sub    $0x8,%esp
80100293:	68 20 a5 10 80       	push   $0x8010a520
80100298:	68 80 f7 10 80       	push   $0x8010f780
8010029d:	e8 2e 3b 00 00       	call   80103dd0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002a2:	a1 80 f7 10 80       	mov    0x8010f780,%eax
801002a7:	83 c4 10             	add    $0x10,%esp
801002aa:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
801002b0:	75 36                	jne    801002e8 <consoleread+0x98>
      if(proc->killed){
801002b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002b8:	8b 40 24             	mov    0x24(%eax),%eax
801002bb:	85 c0                	test   %eax,%eax
801002bd:	74 d1                	je     80100290 <consoleread+0x40>
        release(&cons.lock);
801002bf:	83 ec 0c             	sub    $0xc,%esp
801002c2:	68 20 a5 10 80       	push   $0x8010a520
801002c7:	e8 84 40 00 00       	call   80104350 <release>
        ilock(ip);
801002cc:	89 3c 24             	mov    %edi,(%esp)
801002cf:	e8 2c 13 00 00       	call   80101600 <ilock>
        return -1;
801002d4:	83 c4 10             	add    $0x10,%esp
801002d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002df:	5b                   	pop    %ebx
801002e0:	5e                   	pop    %esi
801002e1:	5f                   	pop    %edi
801002e2:	5d                   	pop    %ebp
801002e3:	c3                   	ret    
801002e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002e8:	8d 50 01             	lea    0x1(%eax),%edx
801002eb:	89 15 80 f7 10 80    	mov    %edx,0x8010f780
801002f1:	89 c2                	mov    %eax,%edx
801002f3:	83 e2 7f             	and    $0x7f,%edx
801002f6:	0f be 92 00 f7 10 80 	movsbl -0x7fef0900(%edx),%edx
    if(c == C('D')){  // EOF
801002fd:	83 fa 04             	cmp    $0x4,%edx
80100300:	74 39                	je     8010033b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100302:	83 c6 01             	add    $0x1,%esi
    --n;
80100305:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100308:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010030b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010030e:	74 35                	je     80100345 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100310:	85 db                	test   %ebx,%ebx
80100312:	0f 85 69 ff ff ff    	jne    80100281 <consoleread+0x31>
80100318:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010031b:	83 ec 0c             	sub    $0xc,%esp
8010031e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100321:	68 20 a5 10 80       	push   $0x8010a520
80100326:	e8 25 40 00 00       	call   80104350 <release>
  ilock(ip);
8010032b:	89 3c 24             	mov    %edi,(%esp)
8010032e:	e8 cd 12 00 00       	call   80101600 <ilock>

  return target - n;
80100333:	83 c4 10             	add    $0x10,%esp
80100336:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100339:	eb a1                	jmp    801002dc <consoleread+0x8c>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010033b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010033e:	76 05                	jbe    80100345 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100340:	a3 80 f7 10 80       	mov    %eax,0x8010f780
80100345:	8b 45 10             	mov    0x10(%ebp),%eax
80100348:	29 d8                	sub    %ebx,%eax
8010034a:	eb cf                	jmp    8010031b <consoleread+0xcb>
8010034c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100350 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100350:	55                   	push   %ebp
80100351:	89 e5                	mov    %esp,%ebp
80100353:	56                   	push   %esi
80100354:	53                   	push   %ebx
80100355:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100358:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
80100359:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010035f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100366:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100369:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010036c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
8010036f:	0f b6 00             	movzbl (%eax),%eax
80100372:	50                   	push   %eax
80100373:	68 26 6f 10 80       	push   $0x80106f26
80100378:	e8 c3 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010037d:	58                   	pop    %eax
8010037e:	ff 75 08             	pushl  0x8(%ebp)
80100381:	e8 ba 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
80100386:	c7 04 24 16 74 10 80 	movl   $0x80107416,(%esp)
8010038d:	e8 ae 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
80100392:	5a                   	pop    %edx
80100393:	8d 45 08             	lea    0x8(%ebp),%eax
80100396:	59                   	pop    %ecx
80100397:	53                   	push   %ebx
80100398:	50                   	push   %eax
80100399:	e8 a2 3e 00 00       	call   80104240 <getcallerpcs>
8010039e:	83 c4 10             	add    $0x10,%esp
801003a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003a8:	83 ec 08             	sub    $0x8,%esp
801003ab:	ff 33                	pushl  (%ebx)
801003ad:	83 c3 04             	add    $0x4,%ebx
801003b0:	68 35 6f 10 80       	push   $0x80106f35
801003b5:	e8 86 02 00 00       	call   80100640 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003ba:	83 c4 10             	add    $0x10,%esp
801003bd:	39 f3                	cmp    %esi,%ebx
801003bf:	75 e7                	jne    801003a8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003c1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003c8:	00 00 00 
801003cb:	eb fe                	jmp    801003cb <panic+0x7b>
801003cd:	8d 76 00             	lea    0x0(%esi),%esi

801003d0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003d0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003d6:	85 d2                	test   %edx,%edx
801003d8:	74 06                	je     801003e0 <consputc+0x10>
801003da:	fa                   	cli    
801003db:	eb fe                	jmp    801003db <consputc+0xb>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003e0:	55                   	push   %ebp
801003e1:	89 e5                	mov    %esp,%ebp
801003e3:	57                   	push   %edi
801003e4:	56                   	push   %esi
801003e5:	53                   	push   %ebx
801003e6:	89 c3                	mov    %eax,%ebx
801003e8:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003eb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003f0:	0f 84 b8 00 00 00    	je     801004ae <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003f6:	83 ec 0c             	sub    $0xc,%esp
801003f9:	50                   	push   %eax
801003fa:	e8 01 57 00 00       	call   80105b00 <uartputc>
801003ff:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100402:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100407:	b8 0e 00 00 00       	mov    $0xe,%eax
8010040c:	89 fa                	mov    %edi,%edx
8010040e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010040f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100414:	89 f2                	mov    %esi,%edx
80100416:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100417:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010041a:	89 fa                	mov    %edi,%edx
8010041c:	c1 e0 08             	shl    $0x8,%eax
8010041f:	89 c1                	mov    %eax,%ecx
80100421:	b8 0f 00 00 00       	mov    $0xf,%eax
80100426:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100427:	89 f2                	mov    %esi,%edx
80100429:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010042a:	0f b6 c0             	movzbl %al,%eax
8010042d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010042f:	83 fb 0a             	cmp    $0xa,%ebx
80100432:	0f 84 0b 01 00 00    	je     80100543 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100438:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010043e:	0f 84 e6 00 00 00    	je     8010052a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100444:	0f b6 d3             	movzbl %bl,%edx
80100447:	8d 78 01             	lea    0x1(%eax),%edi
8010044a:	80 ce 07             	or     $0x7,%dh
8010044d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100454:	80 

  if(pos < 0 || pos > 25*80)
80100455:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010045b:	0f 8f bc 00 00 00    	jg     8010051d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100461:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100467:	7f 6f                	jg     801004d8 <consputc+0x108>
80100469:	89 f8                	mov    %edi,%eax
8010046b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100472:	89 fb                	mov    %edi,%ebx
80100474:	c1 e8 08             	shr    $0x8,%eax
80100477:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100479:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010047e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100483:	89 fa                	mov    %edi,%edx
80100485:	ee                   	out    %al,(%dx)
80100486:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010048b:	89 f0                	mov    %esi,%eax
8010048d:	ee                   	out    %al,(%dx)
8010048e:	b8 0f 00 00 00       	mov    $0xf,%eax
80100493:	89 fa                	mov    %edi,%edx
80100495:	ee                   	out    %al,(%dx)
80100496:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010049b:	89 d8                	mov    %ebx,%eax
8010049d:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
8010049e:	b8 20 07 00 00       	mov    $0x720,%eax
801004a3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004a9:	5b                   	pop    %ebx
801004aa:	5e                   	pop    %esi
801004ab:	5f                   	pop    %edi
801004ac:	5d                   	pop    %ebp
801004ad:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ae:	83 ec 0c             	sub    $0xc,%esp
801004b1:	6a 08                	push   $0x8
801004b3:	e8 48 56 00 00       	call   80105b00 <uartputc>
801004b8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004bf:	e8 3c 56 00 00       	call   80105b00 <uartputc>
801004c4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004cb:	e8 30 56 00 00       	call   80105b00 <uartputc>
801004d0:	83 c4 10             	add    $0x10,%esp
801004d3:	e9 2a ff ff ff       	jmp    80100402 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004d8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004db:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004de:	68 60 0e 00 00       	push   $0xe60
801004e3:	68 a0 80 0b 80       	push   $0x800b80a0
801004e8:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ed:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f4:	e8 57 3f 00 00       	call   80104450 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f9:	b8 80 07 00 00       	mov    $0x780,%eax
801004fe:	83 c4 0c             	add    $0xc,%esp
80100501:	29 d8                	sub    %ebx,%eax
80100503:	01 c0                	add    %eax,%eax
80100505:	50                   	push   %eax
80100506:	6a 00                	push   $0x0
80100508:	56                   	push   %esi
80100509:	e8 92 3e 00 00       	call   801043a0 <memset>
8010050e:	89 f1                	mov    %esi,%ecx
80100510:	83 c4 10             	add    $0x10,%esp
80100513:	be 07 00 00 00       	mov    $0x7,%esi
80100518:	e9 5c ff ff ff       	jmp    80100479 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010051d:	83 ec 0c             	sub    $0xc,%esp
80100520:	68 39 6f 10 80       	push   $0x80106f39
80100525:	e8 26 fe ff ff       	call   80100350 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010052a:	85 c0                	test   %eax,%eax
8010052c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010052f:	0f 85 20 ff ff ff    	jne    80100455 <consputc+0x85>
80100535:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010053a:	31 db                	xor    %ebx,%ebx
8010053c:	31 f6                	xor    %esi,%esi
8010053e:	e9 36 ff ff ff       	jmp    80100479 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100543:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100548:	f7 ea                	imul   %edx
8010054a:	89 d0                	mov    %edx,%eax
8010054c:	c1 e8 05             	shr    $0x5,%eax
8010054f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100552:	c1 e0 04             	shl    $0x4,%eax
80100555:	8d 78 50             	lea    0x50(%eax),%edi
80100558:	e9 f8 fe ff ff       	jmp    80100455 <consputc+0x85>
8010055d:	8d 76 00             	lea    0x0(%esi),%esi

80100560 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100560:	55                   	push   %ebp
80100561:	89 e5                	mov    %esp,%ebp
80100563:	57                   	push   %edi
80100564:	56                   	push   %esi
80100565:	53                   	push   %ebx
80100566:	89 d6                	mov    %edx,%esi
80100568:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010056b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010056d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100570:	74 0c                	je     8010057e <printint+0x1e>
80100572:	89 c7                	mov    %eax,%edi
80100574:	c1 ef 1f             	shr    $0x1f,%edi
80100577:	85 c0                	test   %eax,%eax
80100579:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010057c:	78 51                	js     801005cf <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010057e:	31 ff                	xor    %edi,%edi
80100580:	8d 5d d7             	lea    -0x29(%ebp),%ebx
80100583:	eb 05                	jmp    8010058a <printint+0x2a>
80100585:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
80100588:	89 cf                	mov    %ecx,%edi
8010058a:	31 d2                	xor    %edx,%edx
8010058c:	8d 4f 01             	lea    0x1(%edi),%ecx
8010058f:	f7 f6                	div    %esi
80100591:	0f b6 92 64 6f 10 80 	movzbl -0x7fef909c(%edx),%edx
  }while((x /= base) != 0);
80100598:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010059a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
8010059d:	75 e9                	jne    80100588 <printint+0x28>

  if(sign)
8010059f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005a2:	85 c0                	test   %eax,%eax
801005a4:	74 08                	je     801005ae <printint+0x4e>
    buf[i++] = '-';
801005a6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005ab:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ae:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005b8:	0f be 06             	movsbl (%esi),%eax
801005bb:	83 ee 01             	sub    $0x1,%esi
801005be:	e8 0d fe ff ff       	call   801003d0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005c3:	39 de                	cmp    %ebx,%esi
801005c5:	75 f1                	jne    801005b8 <printint+0x58>
    consputc(buf[i]);
}
801005c7:	83 c4 2c             	add    $0x2c,%esp
801005ca:	5b                   	pop    %ebx
801005cb:	5e                   	pop    %esi
801005cc:	5f                   	pop    %edi
801005cd:	5d                   	pop    %ebp
801005ce:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005cf:	f7 d8                	neg    %eax
801005d1:	eb ab                	jmp    8010057e <printint+0x1e>
801005d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801005e0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
801005e5:	53                   	push   %ebx
801005e6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801005e9:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005ec:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005ef:	e8 1c 11 00 00       	call   80101710 <iunlock>
  acquire(&cons.lock);
801005f4:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801005fb:	e8 70 3b 00 00       	call   80104170 <acquire>
80100600:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100603:	83 c4 10             	add    $0x10,%esp
80100606:	85 f6                	test   %esi,%esi
80100608:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010060b:	7e 12                	jle    8010061f <consolewrite+0x3f>
8010060d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 07             	movzbl (%edi),%eax
80100613:	83 c7 01             	add    $0x1,%edi
80100616:	e8 b5 fd ff ff       	call   801003d0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010061b:	39 df                	cmp    %ebx,%edi
8010061d:	75 f1                	jne    80100610 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010061f:	83 ec 0c             	sub    $0xc,%esp
80100622:	68 20 a5 10 80       	push   $0x8010a520
80100627:	e8 24 3d 00 00       	call   80104350 <release>
  ilock(ip);
8010062c:	58                   	pop    %eax
8010062d:	ff 75 08             	pushl  0x8(%ebp)
80100630:	e8 cb 0f 00 00       	call   80101600 <ilock>

  return n;
}
80100635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100638:	89 f0                	mov    %esi,%eax
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret    
8010063f:	90                   	nop

80100640 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100649:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010064e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100650:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100653:	0f 85 47 01 00 00    	jne    801007a0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100659:	8b 45 08             	mov    0x8(%ebp),%eax
8010065c:	85 c0                	test   %eax,%eax
8010065e:	89 c1                	mov    %eax,%ecx
80100660:	0f 84 4f 01 00 00    	je     801007b5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100666:	0f b6 00             	movzbl (%eax),%eax
80100669:	31 db                	xor    %ebx,%ebx
8010066b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010066e:	89 cf                	mov    %ecx,%edi
80100670:	85 c0                	test   %eax,%eax
80100672:	75 55                	jne    801006c9 <cprintf+0x89>
80100674:	eb 68                	jmp    801006de <cprintf+0x9e>
80100676:	8d 76 00             	lea    0x0(%esi),%esi
80100679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100680:	83 c3 01             	add    $0x1,%ebx
80100683:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100687:	85 d2                	test   %edx,%edx
80100689:	74 53                	je     801006de <cprintf+0x9e>
      break;
    switch(c){
8010068b:	83 fa 70             	cmp    $0x70,%edx
8010068e:	74 7a                	je     8010070a <cprintf+0xca>
80100690:	7f 6e                	jg     80100700 <cprintf+0xc0>
80100692:	83 fa 25             	cmp    $0x25,%edx
80100695:	0f 84 ad 00 00 00    	je     80100748 <cprintf+0x108>
8010069b:	83 fa 64             	cmp    $0x64,%edx
8010069e:	0f 85 84 00 00 00    	jne    80100728 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006a4:	8d 46 04             	lea    0x4(%esi),%eax
801006a7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006ac:	ba 0a 00 00 00       	mov    $0xa,%edx
801006b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b4:	8b 06                	mov    (%esi),%eax
801006b6:	e8 a5 fe ff ff       	call   80100560 <printint>
801006bb:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006be:	83 c3 01             	add    $0x1,%ebx
801006c1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006c5:	85 c0                	test   %eax,%eax
801006c7:	74 15                	je     801006de <cprintf+0x9e>
    if(c != '%'){
801006c9:	83 f8 25             	cmp    $0x25,%eax
801006cc:	74 b2                	je     80100680 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ce:	e8 fd fc ff ff       	call   801003d0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d3:	83 c3 01             	add    $0x1,%ebx
801006d6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	75 eb                	jne    801006c9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	74 10                	je     801006f5 <cprintf+0xb5>
    release(&cons.lock);
801006e5:	83 ec 0c             	sub    $0xc,%esp
801006e8:	68 20 a5 10 80       	push   $0x8010a520
801006ed:	e8 5e 3c 00 00       	call   80104350 <release>
801006f2:	83 c4 10             	add    $0x10,%esp
}
801006f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006f8:	5b                   	pop    %ebx
801006f9:	5e                   	pop    %esi
801006fa:	5f                   	pop    %edi
801006fb:	5d                   	pop    %ebp
801006fc:	c3                   	ret    
801006fd:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100700:	83 fa 73             	cmp    $0x73,%edx
80100703:	74 5b                	je     80100760 <cprintf+0x120>
80100705:	83 fa 78             	cmp    $0x78,%edx
80100708:	75 1e                	jne    80100728 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010070a:	8d 46 04             	lea    0x4(%esi),%eax
8010070d:	31 c9                	xor    %ecx,%ecx
8010070f:	ba 10 00 00 00       	mov    $0x10,%edx
80100714:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100717:	8b 06                	mov    (%esi),%eax
80100719:	e8 42 fe ff ff       	call   80100560 <printint>
8010071e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100721:	eb 9b                	jmp    801006be <cprintf+0x7e>
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100728:	b8 25 00 00 00       	mov    $0x25,%eax
8010072d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100730:	e8 9b fc ff ff       	call   801003d0 <consputc>
      consputc(c);
80100735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100738:	89 d0                	mov    %edx,%eax
8010073a:	e8 91 fc ff ff       	call   801003d0 <consputc>
      break;
8010073f:	e9 7a ff ff ff       	jmp    801006be <cprintf+0x7e>
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	e8 7e fc ff ff       	call   801003d0 <consputc>
80100752:	e9 7c ff ff ff       	jmp    801006d3 <cprintf+0x93>
80100757:	89 f6                	mov    %esi,%esi
80100759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100760:	8d 46 04             	lea    0x4(%esi),%eax
80100763:	8b 36                	mov    (%esi),%esi
80100765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100768:	b8 4c 6f 10 80       	mov    $0x80106f4c,%eax
8010076d:	85 f6                	test   %esi,%esi
8010076f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100772:	0f be 06             	movsbl (%esi),%eax
80100775:	84 c0                	test   %al,%al
80100777:	74 16                	je     8010078f <cprintf+0x14f>
80100779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100780:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
80100783:	e8 48 fc ff ff       	call   801003d0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100788:	0f be 06             	movsbl (%esi),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010078f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100792:	e9 27 ff ff ff       	jmp    801006be <cprintf+0x7e>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	68 20 a5 10 80       	push   $0x8010a520
801007a8:	e8 c3 39 00 00       	call   80104170 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 a4 fe ff ff       	jmp    80100659 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 53 6f 10 80       	push   $0x80106f53
801007bd:	e8 8e fb ff ff       	call   80100350 <panic>
801007c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007d0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	57                   	push   %edi
801007d4:	56                   	push   %esi
801007d5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007d6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d8:	83 ec 18             	sub    $0x18,%esp
801007db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007de:	68 20 a5 10 80       	push   $0x8010a520
801007e3:	e8 88 39 00 00       	call   80104170 <acquire>
  while((c = getc()) >= 0){
801007e8:	83 c4 10             	add    $0x10,%esp
801007eb:	90                   	nop
801007ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c7                	mov    %eax,%edi
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 ff 10             	cmp    $0x10,%edi
801007fb:	0f 84 3f 01 00 00    	je     80100940 <consoleintr+0x170>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 ff 15             	cmp    $0x15,%edi
80100806:	0f 84 dc 00 00 00    	je     801008e8 <consoleintr+0x118>
8010080c:	83 ff 7f             	cmp    $0x7f,%edi
8010080f:	75 54                	jne    80100865 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100811:	a1 88 f7 10 80       	mov    0x8010f788,%eax
80100816:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
8010081c:	74 d2                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081e:	83 e8 01             	sub    $0x1,%eax
80100821:	a3 88 f7 10 80       	mov    %eax,0x8010f788
        consputc(BACKSPACE);
80100826:	b8 00 01 00 00       	mov    $0x100,%eax
8010082b:	e8 a0 fb ff ff       	call   801003d0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	79 c0                	jns    801007f8 <consoleintr+0x28>
80100838:	90                   	nop
80100839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100840:	83 ec 0c             	sub    $0xc,%esp
80100843:	68 20 a5 10 80       	push   $0x8010a520
80100848:	e8 03 3b 00 00       	call   80104350 <release>
  if(doprocdump) {
8010084d:	83 c4 10             	add    $0x10,%esp
80100850:	85 f6                	test   %esi,%esi
80100852:	0f 85 f8 00 00 00    	jne    80100950 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100858:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010085b:	5b                   	pop    %ebx
8010085c:	5e                   	pop    %esi
8010085d:	5f                   	pop    %edi
8010085e:	5d                   	pop    %ebp
8010085f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100860:	83 ff 08             	cmp    $0x8,%edi
80100863:	74 ac                	je     80100811 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 ff                	test   %edi,%edi
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 88 f7 10 80       	mov    0x8010f788,%eax
8010086e:	89 c2                	mov    %eax,%edx
80100870:	2b 15 80 f7 10 80    	sub    0x8010f780,%edx
80100876:	83 fa 7f             	cmp    $0x7f,%edx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010087f:	8d 50 01             	lea    0x1(%eax),%edx
80100882:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100885:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 15 88 f7 10 80    	mov    %edx,0x8010f788
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c8 00 00 00    	je     8010095c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	89 f9                	mov    %edi,%ecx
80100896:	88 88 00 f7 10 80    	mov    %cl,-0x7fef0900(%eax)
        consputc(c);
8010089c:	89 f8                	mov    %edi,%eax
8010089e:	e8 2d fb ff ff       	call   801003d0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a3:	83 ff 0a             	cmp    $0xa,%edi
801008a6:	0f 84 c1 00 00 00    	je     8010096d <consoleintr+0x19d>
801008ac:	83 ff 04             	cmp    $0x4,%edi
801008af:	0f 84 b8 00 00 00    	je     8010096d <consoleintr+0x19d>
801008b5:	a1 80 f7 10 80       	mov    0x8010f780,%eax
801008ba:	83 e8 80             	sub    $0xffffff80,%eax
801008bd:	39 05 88 f7 10 80    	cmp    %eax,0x8010f788
801008c3:	0f 85 27 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008c9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008cc:	a3 84 f7 10 80       	mov    %eax,0x8010f784
          wakeup(&input.r);
801008d1:	68 80 f7 10 80       	push   $0x8010f780
801008d6:	e8 a5 36 00 00       	call   80103f80 <wakeup>
801008db:	83 c4 10             	add    $0x10,%esp
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008e8:	a1 88 f7 10 80       	mov    0x8010f788,%eax
801008ed:	39 05 84 f7 10 80    	cmp    %eax,0x8010f784
801008f3:	75 2b                	jne    80100920 <consoleintr+0x150>
801008f5:	e9 f6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100900:	a3 88 f7 10 80       	mov    %eax,0x8010f788
        consputc(BACKSPACE);
80100905:	b8 00 01 00 00       	mov    $0x100,%eax
8010090a:	e8 c1 fa ff ff       	call   801003d0 <consputc>
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010090f:	a1 88 f7 10 80       	mov    0x8010f788,%eax
80100914:	3b 05 84 f7 10 80    	cmp    0x8010f784,%eax
8010091a:	0f 84 d0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100920:	83 e8 01             	sub    $0x1,%eax
80100923:	89 c2                	mov    %eax,%edx
80100925:	83 e2 7f             	and    $0x7f,%edx
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100928:	80 ba 00 f7 10 80 0a 	cmpb   $0xa,-0x7fef0900(%edx)
8010092f:	75 cf                	jne    80100900 <consoleintr+0x130>
80100931:	e9 ba fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100936:	8d 76 00             	lea    0x0(%esi),%esi
80100939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
80100940:	be 01 00 00 00       	mov    $0x1,%esi
80100945:	e9 a6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100950:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100953:	5b                   	pop    %ebx
80100954:	5e                   	pop    %esi
80100955:	5f                   	pop    %edi
80100956:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100957:	e9 14 37 00 00       	jmp    80104070 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010095c:	c6 80 00 f7 10 80 0a 	movb   $0xa,-0x7fef0900(%eax)
        consputc(c);
80100963:	b8 0a 00 00 00       	mov    $0xa,%eax
80100968:	e8 63 fa ff ff       	call   801003d0 <consputc>
8010096d:	a1 88 f7 10 80       	mov    0x8010f788,%eax
80100972:	e9 52 ff ff ff       	jmp    801008c9 <consoleintr+0xf9>
80100977:	89 f6                	mov    %esi,%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
80100981:	89 e5                	mov    %esp,%ebp
80100983:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100986:	68 5c 6f 10 80       	push   $0x80106f5c
8010098b:	68 20 a5 10 80       	push   $0x8010a520
80100990:	e8 bb 37 00 00       	call   80104150 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
80100995:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
8010099c:	c7 05 4c 01 11 80 e0 	movl   $0x801005e0,0x8011014c
801009a3:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009a6:	c7 05 48 01 11 80 50 	movl   $0x80100250,0x80110148
801009ad:	02 10 80 
  cons.locking = 1;
801009b0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009b7:	00 00 00 

  picenable(IRQ_KBD);
801009ba:	e8 b1 28 00 00       	call   80103270 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009bf:	58                   	pop    %eax
801009c0:	5a                   	pop    %edx
801009c1:	6a 00                	push   $0x0
801009c3:	6a 01                	push   $0x1
801009c5:	e8 b6 18 00 00       	call   80102280 <ioapicenable>
}
801009ca:	83 c4 10             	add    $0x10,%esp
801009cd:	c9                   	leave  
801009ce:	c3                   	ret    
801009cf:	90                   	nop

801009d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	57                   	push   %edi
801009d4:	56                   	push   %esi
801009d5:	53                   	push   %ebx
801009d6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009dc:	e8 7f 21 00 00       	call   80102b60 <begin_op>
  if((ip = namei(path)) == 0){
801009e1:	83 ec 0c             	sub    $0xc,%esp
801009e4:	ff 75 08             	pushl  0x8(%ebp)
801009e7:	e8 a4 14 00 00       	call   80101e90 <namei>
801009ec:	83 c4 10             	add    $0x10,%esp
801009ef:	85 c0                	test   %eax,%eax
801009f1:	0f 84 a3 01 00 00    	je     80100b9a <exec+0x1ca>
    end_op();
    return -1;
  }
  ilock(ip);
801009f7:	83 ec 0c             	sub    $0xc,%esp
801009fa:	89 c3                	mov    %eax,%ebx
801009fc:	50                   	push   %eax
801009fd:	e8 fe 0b 00 00       	call   80101600 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a02:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a08:	6a 34                	push   $0x34
80100a0a:	6a 00                	push   $0x0
80100a0c:	50                   	push   %eax
80100a0d:	53                   	push   %ebx
80100a0e:	e8 0d 0f 00 00       	call   80101920 <readi>
80100a13:	83 c4 20             	add    $0x20,%esp
80100a16:	83 f8 33             	cmp    $0x33,%eax
80100a19:	77 25                	ja     80100a40 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a1b:	83 ec 0c             	sub    $0xc,%esp
80100a1e:	53                   	push   %ebx
80100a1f:	e8 ac 0e 00 00       	call   801018d0 <iunlockput>
    end_op();
80100a24:	e8 a7 21 00 00       	call   80102bd0 <end_op>
80100a29:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a34:	5b                   	pop    %ebx
80100a35:	5e                   	pop    %esi
80100a36:	5f                   	pop    %edi
80100a37:	5d                   	pop    %ebp
80100a38:	c3                   	ret    
80100a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a40:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a47:	45 4c 46 
80100a4a:	75 cf                	jne    80100a1b <exec+0x4b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a4c:	e8 6f 5e 00 00       	call   801068c0 <setupkvm>
80100a51:	85 c0                	test   %eax,%eax
80100a53:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a59:	74 c0                	je     80100a1b <exec+0x4b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a5b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a62:	00 
80100a63:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a69:	0f 84 a1 02 00 00    	je     80100d10 <exec+0x340>
80100a6f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a76:	00 00 00 
80100a79:	31 ff                	xor    %edi,%edi
80100a7b:	eb 18                	jmp    80100a95 <exec+0xc5>
80100a7d:	8d 76 00             	lea    0x0(%esi),%esi
80100a80:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a87:	83 c7 01             	add    $0x1,%edi
80100a8a:	83 c6 20             	add    $0x20,%esi
80100a8d:	39 f8                	cmp    %edi,%eax
80100a8f:	0f 8e ab 00 00 00    	jle    80100b40 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a95:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a9b:	6a 20                	push   $0x20
80100a9d:	56                   	push   %esi
80100a9e:	50                   	push   %eax
80100a9f:	53                   	push   %ebx
80100aa0:	e8 7b 0e 00 00       	call   80101920 <readi>
80100aa5:	83 c4 10             	add    $0x10,%esp
80100aa8:	83 f8 20             	cmp    $0x20,%eax
80100aab:	75 7b                	jne    80100b28 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100aad:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ab4:	75 ca                	jne    80100a80 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100ab6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100abc:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ac2:	72 64                	jb     80100b28 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ac4:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100aca:	72 5c                	jb     80100b28 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100acc:	83 ec 04             	sub    $0x4,%esp
80100acf:	50                   	push   %eax
80100ad0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ad6:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100adc:	e8 6f 60 00 00       	call   80106b50 <allocuvm>
80100ae1:	83 c4 10             	add    $0x10,%esp
80100ae4:	85 c0                	test   %eax,%eax
80100ae6:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aec:	74 3a                	je     80100b28 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100aee:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100af4:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100af9:	75 2d                	jne    80100b28 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100afb:	83 ec 0c             	sub    $0xc,%esp
80100afe:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b04:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b0a:	53                   	push   %ebx
80100b0b:	50                   	push   %eax
80100b0c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b12:	e8 79 5f 00 00       	call   80106a90 <loaduvm>
80100b17:	83 c4 20             	add    $0x20,%esp
80100b1a:	85 c0                	test   %eax,%eax
80100b1c:	0f 89 5e ff ff ff    	jns    80100a80 <exec+0xb0>
80100b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b28:	83 ec 0c             	sub    $0xc,%esp
80100b2b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b31:	e8 4a 61 00 00       	call   80106c80 <freevm>
80100b36:	83 c4 10             	add    $0x10,%esp
80100b39:	e9 dd fe ff ff       	jmp    80100a1b <exec+0x4b>
80100b3e:	66 90                	xchg   %ax,%ax
80100b40:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b46:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b4c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b52:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b58:	83 ec 0c             	sub    $0xc,%esp
80100b5b:	53                   	push   %ebx
80100b5c:	e8 6f 0d 00 00       	call   801018d0 <iunlockput>
  end_op();
80100b61:	e8 6a 20 00 00       	call   80102bd0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b66:	83 c4 0c             	add    $0xc,%esp
80100b69:	57                   	push   %edi
80100b6a:	56                   	push   %esi
80100b6b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b71:	e8 da 5f 00 00       	call   80106b50 <allocuvm>
80100b76:	83 c4 10             	add    $0x10,%esp
80100b79:	85 c0                	test   %eax,%eax
80100b7b:	89 c6                	mov    %eax,%esi
80100b7d:	75 2a                	jne    80100ba9 <exec+0x1d9>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b7f:	83 ec 0c             	sub    $0xc,%esp
80100b82:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b88:	e8 f3 60 00 00       	call   80106c80 <freevm>
80100b8d:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b95:	e9 97 fe ff ff       	jmp    80100a31 <exec+0x61>
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
  if((ip = namei(path)) == 0){
    end_op();
80100b9a:	e8 31 20 00 00       	call   80102bd0 <end_op>
    return -1;
80100b9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba4:	e9 88 fe ff ff       	jmp    80100a31 <exec+0x61>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ba9:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100baf:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bb2:	31 ff                	xor    %edi,%edi
80100bb4:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bb6:	50                   	push   %eax
80100bb7:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bbd:	e8 3e 61 00 00       	call   80106d00 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bc5:	83 c4 10             	add    $0x10,%esp
80100bc8:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bce:	8b 00                	mov    (%eax),%eax
80100bd0:	85 c0                	test   %eax,%eax
80100bd2:	74 71                	je     80100c45 <exec+0x275>
80100bd4:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100bda:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100be0:	eb 0b                	jmp    80100bed <exec+0x21d>
80100be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100be8:	83 ff 20             	cmp    $0x20,%edi
80100beb:	74 92                	je     80100b7f <exec+0x1af>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bed:	83 ec 0c             	sub    $0xc,%esp
80100bf0:	50                   	push   %eax
80100bf1:	e8 ea 39 00 00       	call   801045e0 <strlen>
80100bf6:	f7 d0                	not    %eax
80100bf8:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bfa:	58                   	pop    %eax
80100bfb:	8b 45 0c             	mov    0xc(%ebp),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bfe:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c01:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c04:	e8 d7 39 00 00       	call   801045e0 <strlen>
80100c09:	83 c0 01             	add    $0x1,%eax
80100c0c:	50                   	push   %eax
80100c0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c10:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c13:	53                   	push   %ebx
80100c14:	56                   	push   %esi
80100c15:	e8 46 62 00 00       	call   80106e60 <copyout>
80100c1a:	83 c4 20             	add    $0x20,%esp
80100c1d:	85 c0                	test   %eax,%eax
80100c1f:	0f 88 5a ff ff ff    	js     80100b7f <exec+0x1af>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c25:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c28:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c2f:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c32:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c38:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3b:	85 c0                	test   %eax,%eax
80100c3d:	75 a9                	jne    80100be8 <exec+0x218>
80100c3f:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c45:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c4c:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c4e:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c55:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c59:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c60:	ff ff ff 
  ustack[1] = argc;
80100c63:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c69:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c6b:	83 c0 0c             	add    $0xc,%eax
80100c6e:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c70:	50                   	push   %eax
80100c71:	52                   	push   %edx
80100c72:	53                   	push   %ebx
80100c73:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c79:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c7f:	e8 dc 61 00 00       	call   80106e60 <copyout>
80100c84:	83 c4 10             	add    $0x10,%esp
80100c87:	85 c0                	test   %eax,%eax
80100c89:	0f 88 f0 fe ff ff    	js     80100b7f <exec+0x1af>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80100c92:	0f b6 10             	movzbl (%eax),%edx
80100c95:	84 d2                	test   %dl,%dl
80100c97:	74 1a                	je     80100cb3 <exec+0x2e3>
80100c99:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100c9c:	83 c0 01             	add    $0x1,%eax
80100c9f:	90                   	nop
    if(*s == '/')
      last = s+1;
80100ca0:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ca3:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ca6:	0f 44 c8             	cmove  %eax,%ecx
80100ca9:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cac:	84 d2                	test   %dl,%dl
80100cae:	75 f0                	jne    80100ca0 <exec+0x2d0>
80100cb0:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cb3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cb9:	83 ec 04             	sub    $0x4,%esp
80100cbc:	6a 10                	push   $0x10
80100cbe:	ff 75 08             	pushl  0x8(%ebp)
80100cc1:	83 c0 6c             	add    $0x6c,%eax
80100cc4:	50                   	push   %eax
80100cc5:	e8 d6 38 00 00       	call   801045a0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100cd0:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cd6:	8b 78 04             	mov    0x4(%eax),%edi
  proc->pgdir = pgdir;
  proc->sz = sz;
80100cd9:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
80100cdb:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->sz = sz;
  proc->tf->eip = elf.entry;  // main
80100cde:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ce4:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100cea:	8b 50 18             	mov    0x18(%eax),%edx
80100ced:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100cf0:	8b 50 18             	mov    0x18(%eax),%edx
80100cf3:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100cf6:	89 04 24             	mov    %eax,(%esp)
80100cf9:	e8 72 5c 00 00       	call   80106970 <switchuvm>
  freevm(oldpgdir);
80100cfe:	89 3c 24             	mov    %edi,(%esp)
80100d01:	e8 7a 5f 00 00       	call   80106c80 <freevm>
  return 0;
80100d06:	83 c4 10             	add    $0x10,%esp
80100d09:	31 c0                	xor    %eax,%eax
80100d0b:	e9 21 fd ff ff       	jmp    80100a31 <exec+0x61>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d10:	bf 00 20 00 00       	mov    $0x2000,%edi
80100d15:	31 f6                	xor    %esi,%esi
80100d17:	e9 3c fe ff ff       	jmp    80100b58 <exec+0x188>
80100d1c:	66 90                	xchg   %ax,%ax
80100d1e:	66 90                	xchg   %ax,%ax

80100d20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d20:	55                   	push   %ebp
80100d21:	89 e5                	mov    %esp,%ebp
80100d23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d26:	68 75 6f 10 80       	push   $0x80106f75
80100d2b:	68 a0 f7 10 80       	push   $0x8010f7a0
80100d30:	e8 1b 34 00 00       	call   80104150 <initlock>
}
80100d35:	83 c4 10             	add    $0x10,%esp
80100d38:	c9                   	leave  
80100d39:	c3                   	ret    
80100d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d44:	bb d4 f7 10 80       	mov    $0x8010f7d4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d49:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d4c:	68 a0 f7 10 80       	push   $0x8010f7a0
80100d51:	e8 1a 34 00 00       	call   80104170 <acquire>
80100d56:	83 c4 10             	add    $0x10,%esp
80100d59:	eb 10                	jmp    80100d6b <filealloc+0x2b>
80100d5b:	90                   	nop
80100d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d60:	83 c3 18             	add    $0x18,%ebx
80100d63:	81 fb 34 01 11 80    	cmp    $0x80110134,%ebx
80100d69:	74 25                	je     80100d90 <filealloc+0x50>
    if(f->ref == 0){
80100d6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d6e:	85 c0                	test   %eax,%eax
80100d70:	75 ee                	jne    80100d60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d72:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d7c:	68 a0 f7 10 80       	push   $0x8010f7a0
80100d81:	e8 ca 35 00 00       	call   80104350 <release>
      return f;
80100d86:	89 d8                	mov    %ebx,%eax
80100d88:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d8e:	c9                   	leave  
80100d8f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100d90:	83 ec 0c             	sub    $0xc,%esp
80100d93:	68 a0 f7 10 80       	push   $0x8010f7a0
80100d98:	e8 b3 35 00 00       	call   80104350 <release>
  return 0;
80100d9d:	83 c4 10             	add    $0x10,%esp
80100da0:	31 c0                	xor    %eax,%eax
}
80100da2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100da5:	c9                   	leave  
80100da6:	c3                   	ret    
80100da7:	89 f6                	mov    %esi,%esi
80100da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100db0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100db0:	55                   	push   %ebp
80100db1:	89 e5                	mov    %esp,%ebp
80100db3:	53                   	push   %ebx
80100db4:	83 ec 10             	sub    $0x10,%esp
80100db7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dba:	68 a0 f7 10 80       	push   $0x8010f7a0
80100dbf:	e8 ac 33 00 00       	call   80104170 <acquire>
  if(f->ref < 1)
80100dc4:	8b 43 04             	mov    0x4(%ebx),%eax
80100dc7:	83 c4 10             	add    $0x10,%esp
80100dca:	85 c0                	test   %eax,%eax
80100dcc:	7e 1a                	jle    80100de8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dce:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100dd1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100dd4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100dd7:	68 a0 f7 10 80       	push   $0x8010f7a0
80100ddc:	e8 6f 35 00 00       	call   80104350 <release>
  return f;
}
80100de1:	89 d8                	mov    %ebx,%eax
80100de3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de6:	c9                   	leave  
80100de7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100de8:	83 ec 0c             	sub    $0xc,%esp
80100deb:	68 7c 6f 10 80       	push   $0x80106f7c
80100df0:	e8 5b f5 ff ff       	call   80100350 <panic>
80100df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e00 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	57                   	push   %edi
80100e04:	56                   	push   %esi
80100e05:	53                   	push   %ebx
80100e06:	83 ec 28             	sub    $0x28,%esp
80100e09:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e0c:	68 a0 f7 10 80       	push   $0x8010f7a0
80100e11:	e8 5a 33 00 00       	call   80104170 <acquire>
  if(f->ref < 1)
80100e16:	8b 47 04             	mov    0x4(%edi),%eax
80100e19:	83 c4 10             	add    $0x10,%esp
80100e1c:	85 c0                	test   %eax,%eax
80100e1e:	0f 8e 9b 00 00 00    	jle    80100ebf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e24:	83 e8 01             	sub    $0x1,%eax
80100e27:	85 c0                	test   %eax,%eax
80100e29:	89 47 04             	mov    %eax,0x4(%edi)
80100e2c:	74 1a                	je     80100e48 <fileclose+0x48>
    release(&ftable.lock);
80100e2e:	c7 45 08 a0 f7 10 80 	movl   $0x8010f7a0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e38:	5b                   	pop    %ebx
80100e39:	5e                   	pop    %esi
80100e3a:	5f                   	pop    %edi
80100e3b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e3c:	e9 0f 35 00 00       	jmp    80104350 <release>
80100e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e48:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e4c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e4e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e51:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e54:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e5d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e60:	68 a0 f7 10 80       	push   $0x8010f7a0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e65:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e68:	e8 e3 34 00 00       	call   80104350 <release>

  if(ff.type == FD_PIPE)
80100e6d:	83 c4 10             	add    $0x10,%esp
80100e70:	83 fb 01             	cmp    $0x1,%ebx
80100e73:	74 13                	je     80100e88 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e75:	83 fb 02             	cmp    $0x2,%ebx
80100e78:	74 26                	je     80100ea0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e7d:	5b                   	pop    %ebx
80100e7e:	5e                   	pop    %esi
80100e7f:	5f                   	pop    %edi
80100e80:	5d                   	pop    %ebp
80100e81:	c3                   	ret    
80100e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100e88:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100e8c:	83 ec 08             	sub    $0x8,%esp
80100e8f:	53                   	push   %ebx
80100e90:	56                   	push   %esi
80100e91:	e8 aa 25 00 00       	call   80103440 <pipeclose>
80100e96:	83 c4 10             	add    $0x10,%esp
80100e99:	eb df                	jmp    80100e7a <fileclose+0x7a>
80100e9b:	90                   	nop
80100e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ea0:	e8 bb 1c 00 00       	call   80102b60 <begin_op>
    iput(ff.ip);
80100ea5:	83 ec 0c             	sub    $0xc,%esp
80100ea8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eab:	e8 c0 08 00 00       	call   80101770 <iput>
    end_op();
80100eb0:	83 c4 10             	add    $0x10,%esp
  }
}
80100eb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb6:	5b                   	pop    %ebx
80100eb7:	5e                   	pop    %esi
80100eb8:	5f                   	pop    %edi
80100eb9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eba:	e9 11 1d 00 00       	jmp    80102bd0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ebf:	83 ec 0c             	sub    $0xc,%esp
80100ec2:	68 84 6f 10 80       	push   $0x80106f84
80100ec7:	e8 84 f4 ff ff       	call   80100350 <panic>
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ed0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ed0:	55                   	push   %ebp
80100ed1:	89 e5                	mov    %esp,%ebp
80100ed3:	53                   	push   %ebx
80100ed4:	83 ec 04             	sub    $0x4,%esp
80100ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100edd:	75 31                	jne    80100f10 <filestat+0x40>
    ilock(f->ip);
80100edf:	83 ec 0c             	sub    $0xc,%esp
80100ee2:	ff 73 10             	pushl  0x10(%ebx)
80100ee5:	e8 16 07 00 00       	call   80101600 <ilock>
    stati(f->ip, st);
80100eea:	58                   	pop    %eax
80100eeb:	5a                   	pop    %edx
80100eec:	ff 75 0c             	pushl  0xc(%ebp)
80100eef:	ff 73 10             	pushl  0x10(%ebx)
80100ef2:	e8 f9 09 00 00       	call   801018f0 <stati>
    iunlock(f->ip);
80100ef7:	59                   	pop    %ecx
80100ef8:	ff 73 10             	pushl  0x10(%ebx)
80100efb:	e8 10 08 00 00       	call   80101710 <iunlock>
    return 0;
80100f00:	83 c4 10             	add    $0x10,%esp
80100f03:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f08:	c9                   	leave  
80100f09:	c3                   	ret    
80100f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f18:	c9                   	leave  
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f20 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	57                   	push   %edi
80100f24:	56                   	push   %esi
80100f25:	53                   	push   %ebx
80100f26:	83 ec 0c             	sub    $0xc,%esp
80100f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f32:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f36:	74 60                	je     80100f98 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f38:	8b 03                	mov    (%ebx),%eax
80100f3a:	83 f8 01             	cmp    $0x1,%eax
80100f3d:	74 41                	je     80100f80 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f3f:	83 f8 02             	cmp    $0x2,%eax
80100f42:	75 5b                	jne    80100f9f <fileread+0x7f>
    ilock(f->ip);
80100f44:	83 ec 0c             	sub    $0xc,%esp
80100f47:	ff 73 10             	pushl  0x10(%ebx)
80100f4a:	e8 b1 06 00 00       	call   80101600 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f4f:	57                   	push   %edi
80100f50:	ff 73 14             	pushl  0x14(%ebx)
80100f53:	56                   	push   %esi
80100f54:	ff 73 10             	pushl  0x10(%ebx)
80100f57:	e8 c4 09 00 00       	call   80101920 <readi>
80100f5c:	83 c4 20             	add    $0x20,%esp
80100f5f:	85 c0                	test   %eax,%eax
80100f61:	89 c6                	mov    %eax,%esi
80100f63:	7e 03                	jle    80100f68 <fileread+0x48>
      f->off += r;
80100f65:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f68:	83 ec 0c             	sub    $0xc,%esp
80100f6b:	ff 73 10             	pushl  0x10(%ebx)
80100f6e:	e8 9d 07 00 00       	call   80101710 <iunlock>
    return r;
80100f73:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f76:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7b:	5b                   	pop    %ebx
80100f7c:	5e                   	pop    %esi
80100f7d:	5f                   	pop    %edi
80100f7e:	5d                   	pop    %ebp
80100f7f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f80:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f83:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f89:	5b                   	pop    %ebx
80100f8a:	5e                   	pop    %esi
80100f8b:	5f                   	pop    %edi
80100f8c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f8d:	e9 7e 26 00 00       	jmp    80103610 <piperead>
80100f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f9d:	eb d9                	jmp    80100f78 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100f9f:	83 ec 0c             	sub    $0xc,%esp
80100fa2:	68 8e 6f 10 80       	push   $0x80106f8e
80100fa7:	e8 a4 f3 ff ff       	call   80100350 <panic>
80100fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fb0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	57                   	push   %edi
80100fb4:	56                   	push   %esi
80100fb5:	53                   	push   %ebx
80100fb6:	83 ec 1c             	sub    $0x1c,%esp
80100fb9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fbf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fc3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fc6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fcc:	0f 84 aa 00 00 00    	je     8010107c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100fd2:	8b 06                	mov    (%esi),%eax
80100fd4:	83 f8 01             	cmp    $0x1,%eax
80100fd7:	0f 84 c2 00 00 00    	je     8010109f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fdd:	83 f8 02             	cmp    $0x2,%eax
80100fe0:	0f 85 d8 00 00 00    	jne    801010be <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100fe6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100fe9:	31 ff                	xor    %edi,%edi
80100feb:	85 c0                	test   %eax,%eax
80100fed:	7f 34                	jg     80101023 <filewrite+0x73>
80100fef:	e9 9c 00 00 00       	jmp    80101090 <filewrite+0xe0>
80100ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100ff8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80100ffb:	83 ec 0c             	sub    $0xc,%esp
80100ffe:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101001:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101004:	e8 07 07 00 00       	call   80101710 <iunlock>
      end_op();
80101009:	e8 c2 1b 00 00       	call   80102bd0 <end_op>
8010100e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101011:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101014:	39 d8                	cmp    %ebx,%eax
80101016:	0f 85 95 00 00 00    	jne    801010b1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010101c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010101e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101021:	7e 6d                	jle    80101090 <filewrite+0xe0>
      int n1 = n - i;
80101023:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101026:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010102b:	29 fb                	sub    %edi,%ebx
8010102d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101033:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101036:	e8 25 1b 00 00       	call   80102b60 <begin_op>
      ilock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
80101041:	e8 ba 05 00 00       	call   80101600 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101046:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101049:	53                   	push   %ebx
8010104a:	ff 76 14             	pushl  0x14(%esi)
8010104d:	01 f8                	add    %edi,%eax
8010104f:	50                   	push   %eax
80101050:	ff 76 10             	pushl  0x10(%esi)
80101053:	e8 c8 09 00 00       	call   80101a20 <writei>
80101058:	83 c4 20             	add    $0x20,%esp
8010105b:	85 c0                	test   %eax,%eax
8010105d:	7f 99                	jg     80100ff8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	ff 76 10             	pushl  0x10(%esi)
80101065:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101068:	e8 a3 06 00 00       	call   80101710 <iunlock>
      end_op();
8010106d:	e8 5e 1b 00 00       	call   80102bd0 <end_op>

      if(r < 0)
80101072:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101075:	83 c4 10             	add    $0x10,%esp
80101078:	85 c0                	test   %eax,%eax
8010107a:	74 98                	je     80101014 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010107c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010107f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101084:	5b                   	pop    %ebx
80101085:	5e                   	pop    %esi
80101086:	5f                   	pop    %edi
80101087:	5d                   	pop    %ebp
80101088:	c3                   	ret    
80101089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101090:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101093:	75 e7                	jne    8010107c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101098:	89 f8                	mov    %edi,%eax
8010109a:	5b                   	pop    %ebx
8010109b:	5e                   	pop    %esi
8010109c:	5f                   	pop    %edi
8010109d:	5d                   	pop    %ebp
8010109e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010109f:	8b 46 0c             	mov    0xc(%esi),%eax
801010a2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a8:	5b                   	pop    %ebx
801010a9:	5e                   	pop    %esi
801010aa:	5f                   	pop    %edi
801010ab:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010ac:	e9 2f 24 00 00       	jmp    801034e0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010b1:	83 ec 0c             	sub    $0xc,%esp
801010b4:	68 97 6f 10 80       	push   $0x80106f97
801010b9:	e8 92 f2 ff ff       	call   80100350 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010be:	83 ec 0c             	sub    $0xc,%esp
801010c1:	68 9d 6f 10 80       	push   $0x80106f9d
801010c6:	e8 85 f2 ff ff       	call   80100350 <panic>
801010cb:	66 90                	xchg   %ax,%ax
801010cd:	66 90                	xchg   %ax,%ax
801010cf:	90                   	nop

801010d0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010d0:	55                   	push   %ebp
801010d1:	89 e5                	mov    %esp,%ebp
801010d3:	57                   	push   %edi
801010d4:	56                   	push   %esi
801010d5:	53                   	push   %ebx
801010d6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010d9:	8b 0d a0 01 11 80    	mov    0x801101a0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010e2:	85 c9                	test   %ecx,%ecx
801010e4:	0f 84 85 00 00 00    	je     8010116f <balloc+0x9f>
801010ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801010f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801010f4:	83 ec 08             	sub    $0x8,%esp
801010f7:	89 f0                	mov    %esi,%eax
801010f9:	c1 f8 0c             	sar    $0xc,%eax
801010fc:	03 05 b8 01 11 80    	add    0x801101b8,%eax
80101102:	50                   	push   %eax
80101103:	ff 75 d8             	pushl  -0x28(%ebp)
80101106:	e8 b5 ef ff ff       	call   801000c0 <bread>
8010110b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010110e:	a1 a0 01 11 80       	mov    0x801101a0,%eax
80101113:	83 c4 10             	add    $0x10,%esp
80101116:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101119:	31 c0                	xor    %eax,%eax
8010111b:	eb 2d                	jmp    8010114a <balloc+0x7a>
8010111d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101120:	89 c1                	mov    %eax,%ecx
80101122:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101127:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010112a:	83 e1 07             	and    $0x7,%ecx
8010112d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010112f:	89 c1                	mov    %eax,%ecx
80101131:	c1 f9 03             	sar    $0x3,%ecx
80101134:	0f b6 7c 0b 18       	movzbl 0x18(%ebx,%ecx,1),%edi
80101139:	85 d7                	test   %edx,%edi
8010113b:	74 43                	je     80101180 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010113d:	83 c0 01             	add    $0x1,%eax
80101140:	83 c6 01             	add    $0x1,%esi
80101143:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101148:	74 05                	je     8010114f <balloc+0x7f>
8010114a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010114d:	72 d1                	jb     80101120 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	ff 75 e4             	pushl  -0x1c(%ebp)
80101155:	e8 76 f0 ff ff       	call   801001d0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010115a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101161:	83 c4 10             	add    $0x10,%esp
80101164:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101167:	39 05 a0 01 11 80    	cmp    %eax,0x801101a0
8010116d:	77 82                	ja     801010f1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	68 a7 6f 10 80       	push   $0x80106fa7
80101177:	e8 d4 f1 ff ff       	call   80100350 <panic>
8010117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101180:	09 fa                	or     %edi,%edx
80101182:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101185:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101188:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
        log_write(bp);
8010118c:	57                   	push   %edi
8010118d:	e8 ae 1b 00 00       	call   80102d40 <log_write>
        brelse(bp);
80101192:	89 3c 24             	mov    %edi,(%esp)
80101195:	e8 36 f0 ff ff       	call   801001d0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010119a:	58                   	pop    %eax
8010119b:	5a                   	pop    %edx
8010119c:	56                   	push   %esi
8010119d:	ff 75 d8             	pushl  -0x28(%ebp)
801011a0:	e8 1b ef ff ff       	call   801000c0 <bread>
801011a5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011a7:	8d 40 18             	lea    0x18(%eax),%eax
801011aa:	83 c4 0c             	add    $0xc,%esp
801011ad:	68 00 02 00 00       	push   $0x200
801011b2:	6a 00                	push   $0x0
801011b4:	50                   	push   %eax
801011b5:	e8 e6 31 00 00       	call   801043a0 <memset>
  log_write(bp);
801011ba:	89 1c 24             	mov    %ebx,(%esp)
801011bd:	e8 7e 1b 00 00       	call   80102d40 <log_write>
  brelse(bp);
801011c2:	89 1c 24             	mov    %ebx,(%esp)
801011c5:	e8 06 f0 ff ff       	call   801001d0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011cd:	89 f0                	mov    %esi,%eax
801011cf:	5b                   	pop    %ebx
801011d0:	5e                   	pop    %esi
801011d1:	5f                   	pop    %edi
801011d2:	5d                   	pop    %ebp
801011d3:	c3                   	ret    
801011d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801011e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801011e8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011ea:	bb f4 01 11 80       	mov    $0x801101f4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011ef:	83 ec 28             	sub    $0x28,%esp
801011f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801011f5:	68 c0 01 11 80       	push   $0x801101c0
801011fa:	e8 71 2f 00 00       	call   80104170 <acquire>
801011ff:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101202:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101205:	eb 18                	jmp    8010121f <iget+0x3f>
80101207:	89 f6                	mov    %esi,%esi
80101209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101210:	85 f6                	test   %esi,%esi
80101212:	74 44                	je     80101258 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101214:	83 c3 50             	add    $0x50,%ebx
80101217:	81 fb 94 11 11 80    	cmp    $0x80111194,%ebx
8010121d:	74 51                	je     80101270 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010121f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101222:	85 c9                	test   %ecx,%ecx
80101224:	7e ea                	jle    80101210 <iget+0x30>
80101226:	39 3b                	cmp    %edi,(%ebx)
80101228:	75 e6                	jne    80101210 <iget+0x30>
8010122a:	39 53 04             	cmp    %edx,0x4(%ebx)
8010122d:	75 e1                	jne    80101210 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
8010122f:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101232:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101235:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
80101237:	68 c0 01 11 80       	push   $0x801101c0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010123c:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010123f:	e8 0c 31 00 00       	call   80104350 <release>
      return ip;
80101244:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
80101247:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010124a:	89 f0                	mov    %esi,%eax
8010124c:	5b                   	pop    %ebx
8010124d:	5e                   	pop    %esi
8010124e:	5f                   	pop    %edi
8010124f:	5d                   	pop    %ebp
80101250:	c3                   	ret    
80101251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101258:	85 c9                	test   %ecx,%ecx
8010125a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010125d:	83 c3 50             	add    $0x50,%ebx
80101260:	81 fb 94 11 11 80    	cmp    $0x80111194,%ebx
80101266:	75 b7                	jne    8010121f <iget+0x3f>
80101268:	90                   	nop
80101269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101270:	85 f6                	test   %esi,%esi
80101272:	74 2d                	je     801012a1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101274:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101277:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101279:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010127c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101283:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
8010128a:	68 c0 01 11 80       	push   $0x801101c0
8010128f:	e8 bc 30 00 00       	call   80104350 <release>

  return ip;
80101294:	83 c4 10             	add    $0x10,%esp
}
80101297:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129a:	89 f0                	mov    %esi,%eax
8010129c:	5b                   	pop    %ebx
8010129d:	5e                   	pop    %esi
8010129e:	5f                   	pop    %edi
8010129f:	5d                   	pop    %ebp
801012a0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012a1:	83 ec 0c             	sub    $0xc,%esp
801012a4:	68 bd 6f 10 80       	push   $0x80106fbd
801012a9:	e8 a2 f0 ff ff       	call   80100350 <panic>
801012ae:	66 90                	xchg   %ax,%ax

801012b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	56                   	push   %esi
801012b5:	53                   	push   %ebx
801012b6:	89 c6                	mov    %eax,%esi
801012b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012bb:	83 fa 0b             	cmp    $0xb,%edx
801012be:	77 18                	ja     801012d8 <bmap+0x28>
801012c0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012c3:	8b 43 1c             	mov    0x1c(%ebx),%eax
801012c6:	85 c0                	test   %eax,%eax
801012c8:	74 6e                	je     80101338 <bmap+0x88>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012cd:	5b                   	pop    %ebx
801012ce:	5e                   	pop    %esi
801012cf:	5f                   	pop    %edi
801012d0:	5d                   	pop    %ebp
801012d1:	c3                   	ret    
801012d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012d8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012db:	83 fb 7f             	cmp    $0x7f,%ebx
801012de:	77 7c                	ja     8010135c <bmap+0xac>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801012e0:	8b 40 4c             	mov    0x4c(%eax),%eax
801012e3:	85 c0                	test   %eax,%eax
801012e5:	74 69                	je     80101350 <bmap+0xa0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801012e7:	83 ec 08             	sub    $0x8,%esp
801012ea:	50                   	push   %eax
801012eb:	ff 36                	pushl  (%esi)
801012ed:	e8 ce ed ff ff       	call   801000c0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801012f2:	8d 54 98 18          	lea    0x18(%eax,%ebx,4),%edx
801012f6:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801012f9:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801012fb:	8b 1a                	mov    (%edx),%ebx
801012fd:	85 db                	test   %ebx,%ebx
801012ff:	75 1d                	jne    8010131e <bmap+0x6e>
      a[bn] = addr = balloc(ip->dev);
80101301:	8b 06                	mov    (%esi),%eax
80101303:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101306:	e8 c5 fd ff ff       	call   801010d0 <balloc>
8010130b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010130e:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101311:	89 c3                	mov    %eax,%ebx
80101313:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101315:	57                   	push   %edi
80101316:	e8 25 1a 00 00       	call   80102d40 <log_write>
8010131b:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
8010131e:	83 ec 0c             	sub    $0xc,%esp
80101321:	57                   	push   %edi
80101322:	e8 a9 ee ff ff       	call   801001d0 <brelse>
80101327:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
8010132a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
8010132d:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
8010132f:	5b                   	pop    %ebx
80101330:	5e                   	pop    %esi
80101331:	5f                   	pop    %edi
80101332:	5d                   	pop    %ebp
80101333:	c3                   	ret    
80101334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	e8 91 fd ff ff       	call   801010d0 <balloc>
8010133f:	89 43 1c             	mov    %eax,0x1c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101342:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101345:	5b                   	pop    %ebx
80101346:	5e                   	pop    %esi
80101347:	5f                   	pop    %edi
80101348:	5d                   	pop    %ebp
80101349:	c3                   	ret    
8010134a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101350:	8b 06                	mov    (%esi),%eax
80101352:	e8 79 fd ff ff       	call   801010d0 <balloc>
80101357:	89 46 4c             	mov    %eax,0x4c(%esi)
8010135a:	eb 8b                	jmp    801012e7 <bmap+0x37>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
8010135c:	83 ec 0c             	sub    $0xc,%esp
8010135f:	68 cd 6f 10 80       	push   $0x80106fcd
80101364:	e8 e7 ef ff ff       	call   80100350 <panic>
80101369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101370 <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101370:	55                   	push   %ebp
80101371:	89 e5                	mov    %esp,%ebp
80101373:	56                   	push   %esi
80101374:	53                   	push   %ebx
80101375:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101378:	83 ec 08             	sub    $0x8,%esp
8010137b:	6a 01                	push   $0x1
8010137d:	ff 75 08             	pushl  0x8(%ebp)
80101380:	e8 3b ed ff ff       	call   801000c0 <bread>
80101385:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101387:	8d 40 18             	lea    0x18(%eax),%eax
8010138a:	83 c4 0c             	add    $0xc,%esp
8010138d:	6a 1c                	push   $0x1c
8010138f:	50                   	push   %eax
80101390:	56                   	push   %esi
80101391:	e8 ba 30 00 00       	call   80104450 <memmove>
  brelse(bp);
80101396:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101399:	83 c4 10             	add    $0x10,%esp
}
8010139c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010139f:	5b                   	pop    %ebx
801013a0:	5e                   	pop    %esi
801013a1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013a2:	e9 29 ee ff ff       	jmp    801001d0 <brelse>
801013a7:	89 f6                	mov    %esi,%esi
801013a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	89 d3                	mov    %edx,%ebx
801013b7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013b9:	83 ec 08             	sub    $0x8,%esp
801013bc:	68 a0 01 11 80       	push   $0x801101a0
801013c1:	50                   	push   %eax
801013c2:	e8 a9 ff ff ff       	call   80101370 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013c7:	58                   	pop    %eax
801013c8:	5a                   	pop    %edx
801013c9:	89 da                	mov    %ebx,%edx
801013cb:	c1 ea 0c             	shr    $0xc,%edx
801013ce:	03 15 b8 01 11 80    	add    0x801101b8,%edx
801013d4:	52                   	push   %edx
801013d5:	56                   	push   %esi
801013d6:	e8 e5 ec ff ff       	call   801000c0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801013db:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801013dd:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801013e3:	ba 01 00 00 00       	mov    $0x1,%edx
801013e8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801013eb:	c1 fb 03             	sar    $0x3,%ebx
801013ee:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801013f1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801013f3:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
801013f8:	85 d1                	test   %edx,%ecx
801013fa:	74 27                	je     80101423 <bfree+0x73>
801013fc:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801013fe:	f7 d2                	not    %edx
80101400:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101402:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101405:	21 d0                	and    %edx,%eax
80101407:	88 44 1e 18          	mov    %al,0x18(%esi,%ebx,1)
  log_write(bp);
8010140b:	56                   	push   %esi
8010140c:	e8 2f 19 00 00       	call   80102d40 <log_write>
  brelse(bp);
80101411:	89 34 24             	mov    %esi,(%esp)
80101414:	e8 b7 ed ff ff       	call   801001d0 <brelse>
}
80101419:	83 c4 10             	add    $0x10,%esp
8010141c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010141f:	5b                   	pop    %ebx
80101420:	5e                   	pop    %esi
80101421:	5d                   	pop    %ebp
80101422:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101423:	83 ec 0c             	sub    $0xc,%esp
80101426:	68 e0 6f 10 80       	push   $0x80106fe0
8010142b:	e8 20 ef ff ff       	call   80100350 <panic>

80101430 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	83 ec 10             	sub    $0x10,%esp
  initlock(&icache.lock, "icache");
80101436:	68 f3 6f 10 80       	push   $0x80106ff3
8010143b:	68 c0 01 11 80       	push   $0x801101c0
80101440:	e8 0b 2d 00 00       	call   80104150 <initlock>
  readsb(dev, &sb);
80101445:	58                   	pop    %eax
80101446:	5a                   	pop    %edx
80101447:	68 a0 01 11 80       	push   $0x801101a0
8010144c:	ff 75 08             	pushl  0x8(%ebp)
8010144f:	e8 1c ff ff ff       	call   80101370 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
80101454:	ff 35 b8 01 11 80    	pushl  0x801101b8
8010145a:	ff 35 b4 01 11 80    	pushl  0x801101b4
80101460:	ff 35 b0 01 11 80    	pushl  0x801101b0
80101466:	ff 35 ac 01 11 80    	pushl  0x801101ac
8010146c:	ff 35 a8 01 11 80    	pushl  0x801101a8
80101472:	ff 35 a4 01 11 80    	pushl  0x801101a4
80101478:	ff 35 a0 01 11 80    	pushl  0x801101a0
8010147e:	68 54 70 10 80       	push   $0x80107054
80101483:	e8 b8 f1 ff ff       	call   80100640 <cprintf>
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
80101488:	83 c4 30             	add    $0x30,%esp
8010148b:	c9                   	leave  
8010148c:	c3                   	ret    
8010148d:	8d 76 00             	lea    0x0(%esi),%esi

80101490 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	57                   	push   %edi
80101494:	56                   	push   %esi
80101495:	53                   	push   %ebx
80101496:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101499:	83 3d a8 01 11 80 01 	cmpl   $0x1,0x801101a8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801014a3:	8b 75 08             	mov    0x8(%ebp),%esi
801014a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014a9:	0f 86 91 00 00 00    	jbe    80101540 <ialloc+0xb0>
801014af:	bb 01 00 00 00       	mov    $0x1,%ebx
801014b4:	eb 21                	jmp    801014d7 <ialloc+0x47>
801014b6:	8d 76 00             	lea    0x0(%esi),%esi
801014b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801014c0:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014c3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801014c6:	57                   	push   %edi
801014c7:	e8 04 ed ff ff       	call   801001d0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014cc:	83 c4 10             	add    $0x10,%esp
801014cf:	39 1d a8 01 11 80    	cmp    %ebx,0x801101a8
801014d5:	76 69                	jbe    80101540 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801014d7:	89 d8                	mov    %ebx,%eax
801014d9:	83 ec 08             	sub    $0x8,%esp
801014dc:	c1 e8 03             	shr    $0x3,%eax
801014df:	03 05 b4 01 11 80    	add    0x801101b4,%eax
801014e5:	50                   	push   %eax
801014e6:	56                   	push   %esi
801014e7:	e8 d4 eb ff ff       	call   801000c0 <bread>
801014ec:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801014ee:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801014f0:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
801014f3:	83 e0 07             	and    $0x7,%eax
801014f6:	c1 e0 06             	shl    $0x6,%eax
801014f9:	8d 4c 07 18          	lea    0x18(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801014fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101501:	75 bd                	jne    801014c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101503:	83 ec 04             	sub    $0x4,%esp
80101506:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101509:	6a 40                	push   $0x40
8010150b:	6a 00                	push   $0x0
8010150d:	51                   	push   %ecx
8010150e:	e8 8d 2e 00 00       	call   801043a0 <memset>
      dip->type = type;
80101513:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101517:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010151a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010151d:	89 3c 24             	mov    %edi,(%esp)
80101520:	e8 1b 18 00 00       	call   80102d40 <log_write>
      brelse(bp);
80101525:	89 3c 24             	mov    %edi,(%esp)
80101528:	e8 a3 ec ff ff       	call   801001d0 <brelse>
      return iget(dev, inum);
8010152d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101530:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101533:	89 da                	mov    %ebx,%edx
80101535:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101537:	5b                   	pop    %ebx
80101538:	5e                   	pop    %esi
80101539:	5f                   	pop    %edi
8010153a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010153b:	e9 a0 fc ff ff       	jmp    801011e0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101540:	83 ec 0c             	sub    $0xc,%esp
80101543:	68 fa 6f 10 80       	push   $0x80106ffa
80101548:	e8 03 ee ff ff       	call   80100350 <panic>
8010154d:	8d 76 00             	lea    0x0(%esi),%esi

80101550 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	56                   	push   %esi
80101554:	53                   	push   %ebx
80101555:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101558:	83 ec 08             	sub    $0x8,%esp
8010155b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010155e:	83 c3 1c             	add    $0x1c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101561:	c1 e8 03             	shr    $0x3,%eax
80101564:	03 05 b4 01 11 80    	add    0x801101b4,%eax
8010156a:	50                   	push   %eax
8010156b:	ff 73 e4             	pushl  -0x1c(%ebx)
8010156e:	e8 4d eb ff ff       	call   801000c0 <bread>
80101573:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101575:	8b 43 e8             	mov    -0x18(%ebx),%eax
  dip->type = ip->type;
80101578:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010157c:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010157f:	83 e0 07             	and    $0x7,%eax
80101582:	c1 e0 06             	shl    $0x6,%eax
80101585:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
80101589:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010158c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101590:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101593:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101597:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010159b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010159f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801015a3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801015a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801015aa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ad:	6a 34                	push   $0x34
801015af:	53                   	push   %ebx
801015b0:	50                   	push   %eax
801015b1:	e8 9a 2e 00 00       	call   80104450 <memmove>
  log_write(bp);
801015b6:	89 34 24             	mov    %esi,(%esp)
801015b9:	e8 82 17 00 00       	call   80102d40 <log_write>
  brelse(bp);
801015be:	89 75 08             	mov    %esi,0x8(%ebp)
801015c1:	83 c4 10             	add    $0x10,%esp
}
801015c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801015ca:	e9 01 ec ff ff       	jmp    801001d0 <brelse>
801015cf:	90                   	nop

801015d0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	53                   	push   %ebx
801015d4:	83 ec 10             	sub    $0x10,%esp
801015d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801015da:	68 c0 01 11 80       	push   $0x801101c0
801015df:	e8 8c 2b 00 00       	call   80104170 <acquire>
  ip->ref++;
801015e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801015e8:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
801015ef:	e8 5c 2d 00 00       	call   80104350 <release>
  return ip;
}
801015f4:	89 d8                	mov    %ebx,%eax
801015f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015f9:	c9                   	leave  
801015fa:	c3                   	ret    
801015fb:	90                   	nop
801015fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101600 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	56                   	push   %esi
80101604:	53                   	push   %ebx
80101605:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101608:	85 db                	test   %ebx,%ebx
8010160a:	0f 84 f0 00 00 00    	je     80101700 <ilock+0x100>
80101610:	8b 43 08             	mov    0x8(%ebx),%eax
80101613:	85 c0                	test   %eax,%eax
80101615:	0f 8e e5 00 00 00    	jle    80101700 <ilock+0x100>
    panic("ilock");

  acquire(&icache.lock);
8010161b:	83 ec 0c             	sub    $0xc,%esp
8010161e:	68 c0 01 11 80       	push   $0x801101c0
80101623:	e8 48 2b 00 00       	call   80104170 <acquire>
  while(ip->flags & I_BUSY)
80101628:	8b 43 0c             	mov    0xc(%ebx),%eax
8010162b:	83 c4 10             	add    $0x10,%esp
8010162e:	a8 01                	test   $0x1,%al
80101630:	74 1e                	je     80101650 <ilock+0x50>
80101632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
80101638:	83 ec 08             	sub    $0x8,%esp
8010163b:	68 c0 01 11 80       	push   $0x801101c0
80101640:	53                   	push   %ebx
80101641:	e8 8a 27 00 00       	call   80103dd0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101646:	8b 43 0c             	mov    0xc(%ebx),%eax
80101649:	83 c4 10             	add    $0x10,%esp
8010164c:	a8 01                	test   $0x1,%al
8010164e:	75 e8                	jne    80101638 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);
80101650:	83 ec 0c             	sub    $0xc,%esp
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101653:	83 c8 01             	or     $0x1,%eax
80101656:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
80101659:	68 c0 01 11 80       	push   $0x801101c0
8010165e:	e8 ed 2c 00 00       	call   80104350 <release>

  if(!(ip->flags & I_VALID)){
80101663:	83 c4 10             	add    $0x10,%esp
80101666:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
8010166a:	74 0c                	je     80101678 <ilock+0x78>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
8010166c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5d                   	pop    %ebp
80101672:	c3                   	ret    
80101673:	90                   	nop
80101674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101678:	8b 43 04             	mov    0x4(%ebx),%eax
8010167b:	83 ec 08             	sub    $0x8,%esp
8010167e:	c1 e8 03             	shr    $0x3,%eax
80101681:	03 05 b4 01 11 80    	add    0x801101b4,%eax
80101687:	50                   	push   %eax
80101688:	ff 33                	pushl  (%ebx)
8010168a:	e8 31 ea ff ff       	call   801000c0 <bread>
8010168f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101691:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101694:	83 c4 0c             	add    $0xc,%esp
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101697:	83 e0 07             	and    $0x7,%eax
8010169a:	c1 e0 06             	shl    $0x6,%eax
8010169d:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
801016a1:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016a4:	83 c0 0c             	add    $0xc,%eax
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016a7:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
801016ab:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016af:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
801016b3:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016b7:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
801016bb:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016bf:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
801016c3:	8b 50 fc             	mov    -0x4(%eax),%edx
801016c6:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016c9:	6a 34                	push   $0x34
801016cb:	50                   	push   %eax
801016cc:	8d 43 1c             	lea    0x1c(%ebx),%eax
801016cf:	50                   	push   %eax
801016d0:	e8 7b 2d 00 00       	call   80104450 <memmove>
    brelse(bp);
801016d5:	89 34 24             	mov    %esi,(%esp)
801016d8:	e8 f3 ea ff ff       	call   801001d0 <brelse>
    ip->flags |= I_VALID;
801016dd:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
801016e1:	83 c4 10             	add    $0x10,%esp
801016e4:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
801016e9:	75 81                	jne    8010166c <ilock+0x6c>
      panic("ilock: no type");
801016eb:	83 ec 0c             	sub    $0xc,%esp
801016ee:	68 12 70 10 80       	push   $0x80107012
801016f3:	e8 58 ec ff ff       	call   80100350 <panic>
801016f8:	90                   	nop
801016f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101700:	83 ec 0c             	sub    $0xc,%esp
80101703:	68 0c 70 10 80       	push   $0x8010700c
80101708:	e8 43 ec ff ff       	call   80100350 <panic>
8010170d:	8d 76 00             	lea    0x0(%esi),%esi

80101710 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	53                   	push   %ebx
80101714:	83 ec 04             	sub    $0x4,%esp
80101717:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
8010171a:	85 db                	test   %ebx,%ebx
8010171c:	74 39                	je     80101757 <iunlock+0x47>
8010171e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
80101722:	74 33                	je     80101757 <iunlock+0x47>
80101724:	8b 43 08             	mov    0x8(%ebx),%eax
80101727:	85 c0                	test   %eax,%eax
80101729:	7e 2c                	jle    80101757 <iunlock+0x47>
    panic("iunlock");

  acquire(&icache.lock);
8010172b:	83 ec 0c             	sub    $0xc,%esp
8010172e:	68 c0 01 11 80       	push   $0x801101c0
80101733:	e8 38 2a 00 00       	call   80104170 <acquire>
  ip->flags &= ~I_BUSY;
80101738:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
8010173c:	89 1c 24             	mov    %ebx,(%esp)
8010173f:	e8 3c 28 00 00       	call   80103f80 <wakeup>
  release(&icache.lock);
80101744:	83 c4 10             	add    $0x10,%esp
80101747:	c7 45 08 c0 01 11 80 	movl   $0x801101c0,0x8(%ebp)
}
8010174e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101751:	c9                   	leave  
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
80101752:	e9 f9 2b 00 00       	jmp    80104350 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 21 70 10 80       	push   $0x80107021
8010175f:	e8 ec eb ff ff       	call   80100350 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	57                   	push   %edi
80101774:	56                   	push   %esi
80101775:	53                   	push   %ebx
80101776:	83 ec 28             	sub    $0x28,%esp
80101779:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010177c:	68 c0 01 11 80       	push   $0x801101c0
80101781:	e8 ea 29 00 00       	call   80104170 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101786:	8b 46 08             	mov    0x8(%esi),%eax
80101789:	83 c4 10             	add    $0x10,%esp
8010178c:	83 f8 01             	cmp    $0x1,%eax
8010178f:	0f 85 ab 00 00 00    	jne    80101840 <iput+0xd0>
80101795:	8b 56 0c             	mov    0xc(%esi),%edx
80101798:	f6 c2 02             	test   $0x2,%dl
8010179b:	0f 84 9f 00 00 00    	je     80101840 <iput+0xd0>
801017a1:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
801017a6:	0f 85 94 00 00 00    	jne    80101840 <iput+0xd0>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
801017ac:	f6 c2 01             	test   $0x1,%dl
801017af:	0f 85 05 01 00 00    	jne    801018ba <iput+0x14a>
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
801017b5:	83 ec 0c             	sub    $0xc,%esp
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
801017b8:	83 ca 01             	or     $0x1,%edx
801017bb:	8d 5e 1c             	lea    0x1c(%esi),%ebx
801017be:	89 56 0c             	mov    %edx,0xc(%esi)
    release(&icache.lock);
801017c1:	68 c0 01 11 80       	push   $0x801101c0
801017c6:	8d 7e 4c             	lea    0x4c(%esi),%edi
801017c9:	e8 82 2b 00 00       	call   80104350 <release>
801017ce:	83 c4 10             	add    $0x10,%esp
801017d1:	eb 0c                	jmp    801017df <iput+0x6f>
801017d3:	90                   	nop
801017d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017d8:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801017db:	39 fb                	cmp    %edi,%ebx
801017dd:	74 1b                	je     801017fa <iput+0x8a>
    if(ip->addrs[i]){
801017df:	8b 13                	mov    (%ebx),%edx
801017e1:	85 d2                	test   %edx,%edx
801017e3:	74 f3                	je     801017d8 <iput+0x68>
      bfree(ip->dev, ip->addrs[i]);
801017e5:	8b 06                	mov    (%esi),%eax
801017e7:	83 c3 04             	add    $0x4,%ebx
801017ea:	e8 c1 fb ff ff       	call   801013b0 <bfree>
      ip->addrs[i] = 0;
801017ef:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801017f6:	39 fb                	cmp    %edi,%ebx
801017f8:	75 e5                	jne    801017df <iput+0x6f>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
801017fa:	8b 46 4c             	mov    0x4c(%esi),%eax
801017fd:	85 c0                	test   %eax,%eax
801017ff:	75 5f                	jne    80101860 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101801:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101804:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
8010180b:	56                   	push   %esi
8010180c:	e8 3f fd ff ff       	call   80101550 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
80101811:	31 c0                	xor    %eax,%eax
80101813:	66 89 46 10          	mov    %ax,0x10(%esi)
    iupdate(ip);
80101817:	89 34 24             	mov    %esi,(%esp)
8010181a:	e8 31 fd ff ff       	call   80101550 <iupdate>
    acquire(&icache.lock);
8010181f:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101826:	e8 45 29 00 00       	call   80104170 <acquire>
    ip->flags = 0;
8010182b:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
80101832:	89 34 24             	mov    %esi,(%esp)
80101835:	e8 46 27 00 00       	call   80103f80 <wakeup>
8010183a:	8b 46 08             	mov    0x8(%esi),%eax
8010183d:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101840:	83 e8 01             	sub    $0x1,%eax
80101843:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
80101846:	c7 45 08 c0 01 11 80 	movl   $0x801101c0,0x8(%ebp)
}
8010184d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101850:	5b                   	pop    %ebx
80101851:	5e                   	pop    %esi
80101852:	5f                   	pop    %edi
80101853:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
80101854:	e9 f7 2a 00 00       	jmp    80104350 <release>
80101859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101860:	83 ec 08             	sub    $0x8,%esp
80101863:	50                   	push   %eax
80101864:	ff 36                	pushl  (%esi)
80101866:	e8 55 e8 ff ff       	call   801000c0 <bread>
8010186b:	83 c4 10             	add    $0x10,%esp
8010186e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101871:	8d 58 18             	lea    0x18(%eax),%ebx
80101874:	8d b8 18 02 00 00    	lea    0x218(%eax),%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x117>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101883:	39 df                	cmp    %ebx,%edi
80101885:	74 0f                	je     80101896 <iput+0x126>
      if(a[j])
80101887:	8b 13                	mov    (%ebx),%edx
80101889:	85 d2                	test   %edx,%edx
8010188b:	74 f3                	je     80101880 <iput+0x110>
        bfree(ip->dev, a[j]);
8010188d:	8b 06                	mov    (%esi),%eax
8010188f:	e8 1c fb ff ff       	call   801013b0 <bfree>
80101894:	eb ea                	jmp    80101880 <iput+0x110>
    }
    brelse(bp);
80101896:	83 ec 0c             	sub    $0xc,%esp
80101899:	ff 75 e4             	pushl  -0x1c(%ebp)
8010189c:	e8 2f e9 ff ff       	call   801001d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018a1:	8b 56 4c             	mov    0x4c(%esi),%edx
801018a4:	8b 06                	mov    (%esi),%eax
801018a6:	e8 05 fb ff ff       	call   801013b0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018ab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018b2:	83 c4 10             	add    $0x10,%esp
801018b5:	e9 47 ff ff ff       	jmp    80101801 <iput+0x91>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
801018ba:	83 ec 0c             	sub    $0xc,%esp
801018bd:	68 29 70 10 80       	push   $0x80107029
801018c2:	e8 89 ea ff ff       	call   80100350 <panic>
801018c7:	89 f6                	mov    %esi,%esi
801018c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801018d0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	53                   	push   %ebx
801018d4:	83 ec 10             	sub    $0x10,%esp
801018d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018da:	53                   	push   %ebx
801018db:	e8 30 fe ff ff       	call   80101710 <iunlock>
  iput(ip);
801018e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018e3:	83 c4 10             	add    $0x10,%esp
}
801018e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018e9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801018ea:	e9 81 fe ff ff       	jmp    80101770 <iput>
801018ef:	90                   	nop

801018f0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	8b 55 08             	mov    0x8(%ebp),%edx
801018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801018f9:	8b 0a                	mov    (%edx),%ecx
801018fb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801018fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80101901:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101904:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
80101908:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010190b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
8010190f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101913:	8b 52 18             	mov    0x18(%edx),%edx
80101916:	89 50 10             	mov    %edx,0x10(%eax)
}
80101919:	5d                   	pop    %ebp
8010191a:	c3                   	ret    
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 1c             	sub    $0x1c,%esp
80101929:	8b 45 08             	mov    0x8(%ebp),%eax
8010192c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010192f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101932:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101937:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010193a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010193d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101940:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101943:	0f 84 a7 00 00 00    	je     801019f0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101949:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010194c:	8b 40 18             	mov    0x18(%eax),%eax
8010194f:	39 f0                	cmp    %esi,%eax
80101951:	0f 82 c1 00 00 00    	jb     80101a18 <readi+0xf8>
80101957:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010195a:	89 fa                	mov    %edi,%edx
8010195c:	01 f2                	add    %esi,%edx
8010195e:	0f 82 b4 00 00 00    	jb     80101a18 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101964:	89 c1                	mov    %eax,%ecx
80101966:	29 f1                	sub    %esi,%ecx
80101968:	39 d0                	cmp    %edx,%eax
8010196a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010196d:	31 ff                	xor    %edi,%edi
8010196f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101971:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101974:	74 6d                	je     801019e3 <readi+0xc3>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101980:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101983:	89 f2                	mov    %esi,%edx
80101985:	c1 ea 09             	shr    $0x9,%edx
80101988:	89 d8                	mov    %ebx,%eax
8010198a:	e8 21 f9 ff ff       	call   801012b0 <bmap>
8010198f:	83 ec 08             	sub    $0x8,%esp
80101992:	50                   	push   %eax
80101993:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101995:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010199a:	e8 21 e7 ff ff       	call   801000c0 <bread>
8010199f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019a4:	89 f1                	mov    %esi,%ecx
801019a6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019ac:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801019af:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019b2:	29 cb                	sub    %ecx,%ebx
801019b4:	29 f8                	sub    %edi,%eax
801019b6:	39 c3                	cmp    %eax,%ebx
801019b8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019bb:	8d 44 0a 18          	lea    0x18(%edx,%ecx,1),%eax
801019bf:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c0:	01 df                	add    %ebx,%edi
801019c2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019c4:	50                   	push   %eax
801019c5:	ff 75 e0             	pushl  -0x20(%ebp)
801019c8:	e8 83 2a 00 00       	call   80104450 <memmove>
    brelse(bp);
801019cd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019d0:	89 14 24             	mov    %edx,(%esp)
801019d3:	e8 f8 e7 ff ff       	call   801001d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019db:	83 c4 10             	add    $0x10,%esp
801019de:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019e1:	77 9d                	ja     80101980 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801019e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019e9:	5b                   	pop    %ebx
801019ea:	5e                   	pop    %esi
801019eb:	5f                   	pop    %edi
801019ec:	5d                   	pop    %ebp
801019ed:	c3                   	ret    
801019ee:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801019f0:	0f bf 40 12          	movswl 0x12(%eax),%eax
801019f4:	66 83 f8 09          	cmp    $0x9,%ax
801019f8:	77 1e                	ja     80101a18 <readi+0xf8>
801019fa:	8b 04 c5 40 01 11 80 	mov    -0x7feefec0(,%eax,8),%eax
80101a01:	85 c0                	test   %eax,%eax
80101a03:	74 13                	je     80101a18 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a05:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a0b:	5b                   	pop    %ebx
80101a0c:	5e                   	pop    %esi
80101a0d:	5f                   	pop    %edi
80101a0e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a0f:	ff e0                	jmp    *%eax
80101a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a1d:	eb c7                	jmp    801019e6 <readi+0xc6>
80101a1f:	90                   	nop

80101a20 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	57                   	push   %edi
80101a24:	56                   	push   %esi
80101a25:	53                   	push   %ebx
80101a26:	83 ec 1c             	sub    $0x1c,%esp
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a2f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a32:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a37:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a3d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a40:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a43:	0f 84 b7 00 00 00    	je     80101b00 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a4c:	39 70 18             	cmp    %esi,0x18(%eax)
80101a4f:	0f 82 eb 00 00 00    	jb     80101b40 <writei+0x120>
80101a55:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a58:	89 f8                	mov    %edi,%eax
80101a5a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a5c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a61:	0f 87 d9 00 00 00    	ja     80101b40 <writei+0x120>
80101a67:	39 c6                	cmp    %eax,%esi
80101a69:	0f 87 d1 00 00 00    	ja     80101b40 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a6f:	85 ff                	test   %edi,%edi
80101a71:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a78:	74 78                	je     80101af2 <writei+0xd2>
80101a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a80:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a83:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a85:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a8a:	c1 ea 09             	shr    $0x9,%edx
80101a8d:	89 f8                	mov    %edi,%eax
80101a8f:	e8 1c f8 ff ff       	call   801012b0 <bmap>
80101a94:	83 ec 08             	sub    $0x8,%esp
80101a97:	50                   	push   %eax
80101a98:	ff 37                	pushl  (%edi)
80101a9a:	e8 21 e6 ff ff       	call   801000c0 <bread>
80101a9f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101aa4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101aa7:	89 f1                	mov    %esi,%ecx
80101aa9:	83 c4 0c             	add    $0xc,%esp
80101aac:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ab2:	29 cb                	sub    %ecx,%ebx
80101ab4:	39 c3                	cmp    %eax,%ebx
80101ab6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ab9:	8d 44 0f 18          	lea    0x18(%edi,%ecx,1),%eax
80101abd:	53                   	push   %ebx
80101abe:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ac3:	50                   	push   %eax
80101ac4:	e8 87 29 00 00       	call   80104450 <memmove>
    log_write(bp);
80101ac9:	89 3c 24             	mov    %edi,(%esp)
80101acc:	e8 6f 12 00 00       	call   80102d40 <log_write>
    brelse(bp);
80101ad1:	89 3c 24             	mov    %edi,(%esp)
80101ad4:	e8 f7 e6 ff ff       	call   801001d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101adc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101adf:	83 c4 10             	add    $0x10,%esp
80101ae2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ae5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101ae8:	77 96                	ja     80101a80 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101aea:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aed:	3b 70 18             	cmp    0x18(%eax),%esi
80101af0:	77 36                	ja     80101b28 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101af2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101af5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101af8:	5b                   	pop    %ebx
80101af9:	5e                   	pop    %esi
80101afa:	5f                   	pop    %edi
80101afb:	5d                   	pop    %ebp
80101afc:	c3                   	ret    
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b00:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 36                	ja     80101b40 <writei+0x120>
80101b0a:	8b 04 c5 44 01 11 80 	mov    -0x7feefebc(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 2b                	je     80101b40 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b15:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1b:	5b                   	pop    %ebx
80101b1c:	5e                   	pop    %esi
80101b1d:	5f                   	pop    %edi
80101b1e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b1f:	ff e0                	jmp    *%eax
80101b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b2b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b2e:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
80101b31:	50                   	push   %eax
80101b32:	e8 19 fa ff ff       	call   80101550 <iupdate>
80101b37:	83 c4 10             	add    $0x10,%esp
80101b3a:	eb b6                	jmp    80101af2 <writei+0xd2>
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b45:	eb ae                	jmp    80101af5 <writei+0xd5>
80101b47:	89 f6                	mov    %esi,%esi
80101b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b50 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b56:	6a 0e                	push   $0xe
80101b58:	ff 75 0c             	pushl  0xc(%ebp)
80101b5b:	ff 75 08             	pushl  0x8(%ebp)
80101b5e:	e8 6d 29 00 00       	call   801044d0 <strncmp>
}
80101b63:	c9                   	leave  
80101b64:	c3                   	ret    
80101b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b7c:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80101b81:	0f 85 80 00 00 00    	jne    80101c07 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b87:	8b 53 18             	mov    0x18(%ebx),%edx
80101b8a:	31 ff                	xor    %edi,%edi
80101b8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b8f:	85 d2                	test   %edx,%edx
80101b91:	75 0d                	jne    80101ba0 <dirlookup+0x30>
80101b93:	eb 5b                	jmp    80101bf0 <dirlookup+0x80>
80101b95:	8d 76 00             	lea    0x0(%esi),%esi
80101b98:	83 c7 10             	add    $0x10,%edi
80101b9b:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101b9e:	76 50                	jbe    80101bf0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ba0:	6a 10                	push   $0x10
80101ba2:	57                   	push   %edi
80101ba3:	56                   	push   %esi
80101ba4:	53                   	push   %ebx
80101ba5:	e8 76 fd ff ff       	call   80101920 <readi>
80101baa:	83 c4 10             	add    $0x10,%esp
80101bad:	83 f8 10             	cmp    $0x10,%eax
80101bb0:	75 48                	jne    80101bfa <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101bb2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bb7:	74 df                	je     80101b98 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bb9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bbc:	83 ec 04             	sub    $0x4,%esp
80101bbf:	6a 0e                	push   $0xe
80101bc1:	50                   	push   %eax
80101bc2:	ff 75 0c             	pushl  0xc(%ebp)
80101bc5:	e8 06 29 00 00       	call   801044d0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	85 c0                	test   %eax,%eax
80101bcf:	75 c7                	jne    80101b98 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101bd1:	8b 45 10             	mov    0x10(%ebp),%eax
80101bd4:	85 c0                	test   %eax,%eax
80101bd6:	74 05                	je     80101bdd <dirlookup+0x6d>
        *poff = off;
80101bd8:	8b 45 10             	mov    0x10(%ebp),%eax
80101bdb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101bdd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101be1:	8b 03                	mov    (%ebx),%eax
80101be3:	e8 f8 f5 ff ff       	call   801011e0 <iget>
    }
  }

  return 0;
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
80101bef:	c3                   	ret    
80101bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101bf3:	31 c0                	xor    %eax,%eax
}
80101bf5:	5b                   	pop    %ebx
80101bf6:	5e                   	pop    %esi
80101bf7:	5f                   	pop    %edi
80101bf8:	5d                   	pop    %ebp
80101bf9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	68 45 70 10 80       	push   $0x80107045
80101c02:	e8 49 e7 ff ff       	call   80100350 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 33 70 10 80       	push   $0x80107033
80101c0f:	e8 3c e7 ff ff       	call   80100350 <panic>
80101c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c20 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	89 cf                	mov    %ecx,%edi
80101c28:	89 c3                	mov    %eax,%ebx
80101c2a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c2d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c30:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c33:	0f 84 53 01 00 00    	je     80101d8c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c3f:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c42:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c45:	68 c0 01 11 80       	push   $0x801101c0
80101c4a:	e8 21 25 00 00       	call   80104170 <acquire>
  ip->ref++;
80101c4f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c53:	c7 04 24 c0 01 11 80 	movl   $0x801101c0,(%esp)
80101c5a:	e8 f1 26 00 00       	call   80104350 <release>
80101c5f:	83 c4 10             	add    $0x10,%esp
80101c62:	eb 07                	jmp    80101c6b <namex+0x4b>
80101c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c68:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c6b:	0f b6 03             	movzbl (%ebx),%eax
80101c6e:	3c 2f                	cmp    $0x2f,%al
80101c70:	74 f6                	je     80101c68 <namex+0x48>
    path++;
  if(*path == 0)
80101c72:	84 c0                	test   %al,%al
80101c74:	0f 84 e3 00 00 00    	je     80101d5d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c7a:	0f b6 03             	movzbl (%ebx),%eax
80101c7d:	89 da                	mov    %ebx,%edx
80101c7f:	84 c0                	test   %al,%al
80101c81:	0f 84 ac 00 00 00    	je     80101d33 <namex+0x113>
80101c87:	3c 2f                	cmp    $0x2f,%al
80101c89:	75 09                	jne    80101c94 <namex+0x74>
80101c8b:	e9 a3 00 00 00       	jmp    80101d33 <namex+0x113>
80101c90:	84 c0                	test   %al,%al
80101c92:	74 0a                	je     80101c9e <namex+0x7e>
    path++;
80101c94:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c97:	0f b6 02             	movzbl (%edx),%eax
80101c9a:	3c 2f                	cmp    $0x2f,%al
80101c9c:	75 f2                	jne    80101c90 <namex+0x70>
80101c9e:	89 d1                	mov    %edx,%ecx
80101ca0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101ca2:	83 f9 0d             	cmp    $0xd,%ecx
80101ca5:	0f 8e 8d 00 00 00    	jle    80101d38 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cab:	83 ec 04             	sub    $0x4,%esp
80101cae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cb1:	6a 0e                	push   $0xe
80101cb3:	53                   	push   %ebx
80101cb4:	57                   	push   %edi
80101cb5:	e8 96 27 00 00       	call   80104450 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101cbd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cc0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cc2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cc5:	75 11                	jne    80101cd8 <namex+0xb8>
80101cc7:	89 f6                	mov    %esi,%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cd0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cd3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cd6:	74 f8                	je     80101cd0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cd8:	83 ec 0c             	sub    $0xc,%esp
80101cdb:	56                   	push   %esi
80101cdc:	e8 1f f9 ff ff       	call   80101600 <ilock>
    if(ip->type != T_DIR){
80101ce1:	83 c4 10             	add    $0x10,%esp
80101ce4:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80101ce9:	0f 85 7f 00 00 00    	jne    80101d6e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101cef:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101cf2:	85 d2                	test   %edx,%edx
80101cf4:	74 09                	je     80101cff <namex+0xdf>
80101cf6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101cf9:	0f 84 a3 00 00 00    	je     80101da2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101cff:	83 ec 04             	sub    $0x4,%esp
80101d02:	6a 00                	push   $0x0
80101d04:	57                   	push   %edi
80101d05:	56                   	push   %esi
80101d06:	e8 65 fe ff ff       	call   80101b70 <dirlookup>
80101d0b:	83 c4 10             	add    $0x10,%esp
80101d0e:	85 c0                	test   %eax,%eax
80101d10:	74 5c                	je     80101d6e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d12:	83 ec 0c             	sub    $0xc,%esp
80101d15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d18:	56                   	push   %esi
80101d19:	e8 f2 f9 ff ff       	call   80101710 <iunlock>
  iput(ip);
80101d1e:	89 34 24             	mov    %esi,(%esp)
80101d21:	e8 4a fa ff ff       	call   80101770 <iput>
80101d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d29:	83 c4 10             	add    $0x10,%esp
80101d2c:	89 c6                	mov    %eax,%esi
80101d2e:	e9 38 ff ff ff       	jmp    80101c6b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d33:	31 c9                	xor    %ecx,%ecx
80101d35:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d38:	83 ec 04             	sub    $0x4,%esp
80101d3b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d3e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d41:	51                   	push   %ecx
80101d42:	53                   	push   %ebx
80101d43:	57                   	push   %edi
80101d44:	e8 07 27 00 00       	call   80104450 <memmove>
    name[len] = 0;
80101d49:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d4f:	83 c4 10             	add    $0x10,%esp
80101d52:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d56:	89 d3                	mov    %edx,%ebx
80101d58:	e9 65 ff ff ff       	jmp    80101cc2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d60:	85 c0                	test   %eax,%eax
80101d62:	75 54                	jne    80101db8 <namex+0x198>
80101d64:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d69:	5b                   	pop    %ebx
80101d6a:	5e                   	pop    %esi
80101d6b:	5f                   	pop    %edi
80101d6c:	5d                   	pop    %ebp
80101d6d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d6e:	83 ec 0c             	sub    $0xc,%esp
80101d71:	56                   	push   %esi
80101d72:	e8 99 f9 ff ff       	call   80101710 <iunlock>
  iput(ip);
80101d77:	89 34 24             	mov    %esi,(%esp)
80101d7a:	e8 f1 f9 ff ff       	call   80101770 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d7f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d82:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d85:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d87:	5b                   	pop    %ebx
80101d88:	5e                   	pop    %esi
80101d89:	5f                   	pop    %edi
80101d8a:	5d                   	pop    %ebp
80101d8b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101d8c:	ba 01 00 00 00       	mov    $0x1,%edx
80101d91:	b8 01 00 00 00       	mov    $0x1,%eax
80101d96:	e8 45 f4 ff ff       	call   801011e0 <iget>
80101d9b:	89 c6                	mov    %eax,%esi
80101d9d:	e9 c9 fe ff ff       	jmp    80101c6b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101da2:	83 ec 0c             	sub    $0xc,%esp
80101da5:	56                   	push   %esi
80101da6:	e8 65 f9 ff ff       	call   80101710 <iunlock>
      return ip;
80101dab:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dae:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101db1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101db3:	5b                   	pop    %ebx
80101db4:	5e                   	pop    %esi
80101db5:	5f                   	pop    %edi
80101db6:	5d                   	pop    %ebp
80101db7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101db8:	83 ec 0c             	sub    $0xc,%esp
80101dbb:	56                   	push   %esi
80101dbc:	e8 af f9 ff ff       	call   80101770 <iput>
    return 0;
80101dc1:	83 c4 10             	add    $0x10,%esp
80101dc4:	31 c0                	xor    %eax,%eax
80101dc6:	eb 9e                	jmp    80101d66 <namex+0x146>
80101dc8:	90                   	nop
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 20             	sub    $0x20,%esp
80101dd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ddc:	6a 00                	push   $0x0
80101dde:	ff 75 0c             	pushl  0xc(%ebp)
80101de1:	53                   	push   %ebx
80101de2:	e8 89 fd ff ff       	call   80101b70 <dirlookup>
80101de7:	83 c4 10             	add    $0x10,%esp
80101dea:	85 c0                	test   %eax,%eax
80101dec:	75 67                	jne    80101e55 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dee:	8b 7b 18             	mov    0x18(%ebx),%edi
80101df1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101df4:	85 ff                	test   %edi,%edi
80101df6:	74 29                	je     80101e21 <dirlink+0x51>
80101df8:	31 ff                	xor    %edi,%edi
80101dfa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dfd:	eb 09                	jmp    80101e08 <dirlink+0x38>
80101dff:	90                   	nop
80101e00:	83 c7 10             	add    $0x10,%edi
80101e03:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101e06:	76 19                	jbe    80101e21 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e08:	6a 10                	push   $0x10
80101e0a:	57                   	push   %edi
80101e0b:	56                   	push   %esi
80101e0c:	53                   	push   %ebx
80101e0d:	e8 0e fb ff ff       	call   80101920 <readi>
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	83 f8 10             	cmp    $0x10,%eax
80101e18:	75 4e                	jne    80101e68 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e1f:	75 df                	jne    80101e00 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e21:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e24:	83 ec 04             	sub    $0x4,%esp
80101e27:	6a 0e                	push   $0xe
80101e29:	ff 75 0c             	pushl  0xc(%ebp)
80101e2c:	50                   	push   %eax
80101e2d:	e8 0e 27 00 00       	call   80104540 <strncpy>
  de.inum = inum;
80101e32:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e35:	6a 10                	push   $0x10
80101e37:	57                   	push   %edi
80101e38:	56                   	push   %esi
80101e39:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e3a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e3e:	e8 dd fb ff ff       	call   80101a20 <writei>
80101e43:	83 c4 20             	add    $0x20,%esp
80101e46:	83 f8 10             	cmp    $0x10,%eax
80101e49:	75 2a                	jne    80101e75 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e4b:	31 c0                	xor    %eax,%eax
}
80101e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
80101e54:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e55:	83 ec 0c             	sub    $0xc,%esp
80101e58:	50                   	push   %eax
80101e59:	e8 12 f9 ff ff       	call   80101770 <iput>
    return -1;
80101e5e:	83 c4 10             	add    $0x10,%esp
80101e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e66:	eb e5                	jmp    80101e4d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e68:	83 ec 0c             	sub    $0xc,%esp
80101e6b:	68 45 70 10 80       	push   $0x80107045
80101e70:	e8 db e4 ff ff       	call   80100350 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	68 42 76 10 80       	push   $0x80107642
80101e7d:	e8 ce e4 ff ff       	call   80100350 <panic>
80101e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e90 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101e90:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e91:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101e93:	89 e5                	mov    %esp,%ebp
80101e95:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e9e:	e8 7d fd ff ff       	call   80101c20 <namex>
}
80101ea3:	c9                   	leave  
80101ea4:	c3                   	ret    
80101ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101eb0:	55                   	push   %ebp
  return namex(path, 1, name);
80101eb1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101eb6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101eb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ebe:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101ebf:	e9 5c fd ff ff       	jmp    80101c20 <namex>
80101ec4:	66 90                	xchg   %ax,%ax
80101ec6:	66 90                	xchg   %ax,%ax
80101ec8:	66 90                	xchg   %ax,%ax
80101eca:	66 90                	xchg   %ax,%ax
80101ecc:	66 90                	xchg   %ax,%ax
80101ece:	66 90                	xchg   %ax,%ax

80101ed0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ed0:	55                   	push   %ebp
  if(b == 0)
80101ed1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ed3:	89 e5                	mov    %esp,%ebp
80101ed5:	56                   	push   %esi
80101ed6:	53                   	push   %ebx
  if(b == 0)
80101ed7:	0f 84 ad 00 00 00    	je     80101f8a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101edd:	8b 58 08             	mov    0x8(%eax),%ebx
80101ee0:	89 c1                	mov    %eax,%ecx
80101ee2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ee8:	0f 87 8f 00 00 00    	ja     80101f7d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101eee:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ef3:	90                   	nop
80101ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ef9:	83 e0 c0             	and    $0xffffffc0,%eax
80101efc:	3c 40                	cmp    $0x40,%al
80101efe:	75 f8                	jne    80101ef8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f00:	31 f6                	xor    %esi,%esi
80101f02:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f07:	89 f0                	mov    %esi,%eax
80101f09:	ee                   	out    %al,(%dx)
80101f0a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f0f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f14:	ee                   	out    %al,(%dx)
80101f15:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f1a:	89 d8                	mov    %ebx,%eax
80101f1c:	ee                   	out    %al,(%dx)
80101f1d:	89 d8                	mov    %ebx,%eax
80101f1f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f24:	c1 f8 08             	sar    $0x8,%eax
80101f27:	ee                   	out    %al,(%dx)
80101f28:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f2d:	89 f0                	mov    %esi,%eax
80101f2f:	ee                   	out    %al,(%dx)
80101f30:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f34:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f39:	83 e0 01             	and    $0x1,%eax
80101f3c:	c1 e0 04             	shl    $0x4,%eax
80101f3f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f42:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f43:	f6 01 04             	testb  $0x4,(%ecx)
80101f46:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f4b:	75 13                	jne    80101f60 <idestart+0x90>
80101f4d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f52:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f53:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f56:	5b                   	pop    %ebx
80101f57:	5e                   	pop    %esi
80101f58:	5d                   	pop    %ebp
80101f59:	c3                   	ret    
80101f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f60:	b8 30 00 00 00       	mov    $0x30,%eax
80101f65:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f66:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f6b:	8d 71 18             	lea    0x18(%ecx),%esi
80101f6e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f73:	fc                   	cld    
80101f74:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f79:	5b                   	pop    %ebx
80101f7a:	5e                   	pop    %esi
80101f7b:	5d                   	pop    %ebp
80101f7c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f7d:	83 ec 0c             	sub    $0xc,%esp
80101f80:	68 b0 70 10 80       	push   $0x801070b0
80101f85:	e8 c6 e3 ff ff       	call   80100350 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	68 a7 70 10 80       	push   $0x801070a7
80101f92:	e8 b9 e3 ff ff       	call   80100350 <panic>
80101f97:	89 f6                	mov    %esi,%esi
80101f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fa0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 e5                	mov    %esp,%ebp
80101fa3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fa6:	68 c2 70 10 80       	push   $0x801070c2
80101fab:	68 80 a5 10 80       	push   $0x8010a580
80101fb0:	e8 9b 21 00 00       	call   80104150 <initlock>
  picenable(IRQ_IDE);
80101fb5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101fbc:	e8 af 12 00 00       	call   80103270 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fc1:	58                   	pop    %eax
80101fc2:	a1 c0 18 11 80       	mov    0x801118c0,%eax
80101fc7:	5a                   	pop    %edx
80101fc8:	83 e8 01             	sub    $0x1,%eax
80101fcb:	50                   	push   %eax
80101fcc:	6a 0e                	push   $0xe
80101fce:	e8 ad 02 00 00       	call   80102280 <ioapicenable>
80101fd3:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fd6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fdb:	90                   	nop
80101fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fe1:	83 e0 c0             	and    $0xffffffc0,%eax
80101fe4:	3c 40                	cmp    $0x40,%al
80101fe6:	75 f8                	jne    80101fe0 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fe8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fed:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101ff2:	ee                   	out    %al,(%dx)
80101ff3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ff8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ffd:	eb 06                	jmp    80102005 <ideinit+0x65>
80101fff:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102000:	83 e9 01             	sub    $0x1,%ecx
80102003:	74 0f                	je     80102014 <ideinit+0x74>
80102005:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102006:	84 c0                	test   %al,%al
80102008:	74 f6                	je     80102000 <ideinit+0x60>
      havedisk1 = 1;
8010200a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102011:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102014:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102019:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010201e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010201f:	c9                   	leave  
80102020:	c3                   	ret    
80102021:	eb 0d                	jmp    80102030 <ideintr>
80102023:	90                   	nop
80102024:	90                   	nop
80102025:	90                   	nop
80102026:	90                   	nop
80102027:	90                   	nop
80102028:	90                   	nop
80102029:	90                   	nop
8010202a:	90                   	nop
8010202b:	90                   	nop
8010202c:	90                   	nop
8010202d:	90                   	nop
8010202e:	90                   	nop
8010202f:	90                   	nop

80102030 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	57                   	push   %edi
80102034:	56                   	push   %esi
80102035:	53                   	push   %ebx
80102036:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102039:	68 80 a5 10 80       	push   $0x8010a580
8010203e:	e8 2d 21 00 00       	call   80104170 <acquire>
  if((b = idequeue) == 0){
80102043:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102049:	83 c4 10             	add    $0x10,%esp
8010204c:	85 db                	test   %ebx,%ebx
8010204e:	74 34                	je     80102084 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102050:	8b 43 14             	mov    0x14(%ebx),%eax
80102053:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102058:	8b 33                	mov    (%ebx),%esi
8010205a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102060:	74 3e                	je     801020a0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102062:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102065:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102068:	83 ce 02             	or     $0x2,%esi
8010206b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010206d:	53                   	push   %ebx
8010206e:	e8 0d 1f 00 00       	call   80103f80 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102073:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102078:	83 c4 10             	add    $0x10,%esp
8010207b:	85 c0                	test   %eax,%eax
8010207d:	74 05                	je     80102084 <ideintr+0x54>
    idestart(idequeue);
8010207f:	e8 4c fe ff ff       	call   80101ed0 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
80102084:	83 ec 0c             	sub    $0xc,%esp
80102087:	68 80 a5 10 80       	push   $0x8010a580
8010208c:	e8 bf 22 00 00       	call   80104350 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102094:	5b                   	pop    %ebx
80102095:	5e                   	pop    %esi
80102096:	5f                   	pop    %edi
80102097:	5d                   	pop    %ebp
80102098:	c3                   	ret    
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020a0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020a5:	8d 76 00             	lea    0x0(%esi),%esi
801020a8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020a9:	89 c1                	mov    %eax,%ecx
801020ab:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ae:	80 f9 40             	cmp    $0x40,%cl
801020b1:	75 f5                	jne    801020a8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020b3:	a8 21                	test   $0x21,%al
801020b5:	75 ab                	jne    80102062 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020b7:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020ba:	b9 80 00 00 00       	mov    $0x80,%ecx
801020bf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020c4:	fc                   	cld    
801020c5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020c7:	8b 33                	mov    (%ebx),%esi
801020c9:	eb 97                	jmp    80102062 <ideintr+0x32>
801020cb:	90                   	nop
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020d0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	53                   	push   %ebx
801020d4:	83 ec 04             	sub    $0x4,%esp
801020d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801020da:	8b 03                	mov    (%ebx),%eax
801020dc:	a8 01                	test   $0x1,%al
801020de:	0f 84 a7 00 00 00    	je     8010218b <iderw+0xbb>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020e4:	83 e0 06             	and    $0x6,%eax
801020e7:	83 f8 02             	cmp    $0x2,%eax
801020ea:	0f 84 b5 00 00 00    	je     801021a5 <iderw+0xd5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801020f0:	8b 53 04             	mov    0x4(%ebx),%edx
801020f3:	85 d2                	test   %edx,%edx
801020f5:	74 0d                	je     80102104 <iderw+0x34>
801020f7:	a1 60 a5 10 80       	mov    0x8010a560,%eax
801020fc:	85 c0                	test   %eax,%eax
801020fe:	0f 84 94 00 00 00    	je     80102198 <iderw+0xc8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102104:	83 ec 0c             	sub    $0xc,%esp
80102107:	68 80 a5 10 80       	push   $0x8010a580
8010210c:	e8 5f 20 00 00       	call   80104170 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102111:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102117:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
8010211a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102121:	85 d2                	test   %edx,%edx
80102123:	75 0d                	jne    80102132 <iderw+0x62>
80102125:	eb 54                	jmp    8010217b <iderw+0xab>
80102127:	89 f6                	mov    %esi,%esi
80102129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102130:	89 c2                	mov    %eax,%edx
80102132:	8b 42 14             	mov    0x14(%edx),%eax
80102135:	85 c0                	test   %eax,%eax
80102137:	75 f7                	jne    80102130 <iderw+0x60>
80102139:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
8010213c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010213e:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
80102144:	74 3c                	je     80102182 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102146:	8b 03                	mov    (%ebx),%eax
80102148:	83 e0 06             	and    $0x6,%eax
8010214b:	83 f8 02             	cmp    $0x2,%eax
8010214e:	74 1b                	je     8010216b <iderw+0x9b>
    sleep(b, &idelock);
80102150:	83 ec 08             	sub    $0x8,%esp
80102153:	68 80 a5 10 80       	push   $0x8010a580
80102158:	53                   	push   %ebx
80102159:	e8 72 1c 00 00       	call   80103dd0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 c4 10             	add    $0x10,%esp
80102163:	83 e0 06             	and    $0x6,%eax
80102166:	83 f8 02             	cmp    $0x2,%eax
80102169:	75 e5                	jne    80102150 <iderw+0x80>
    sleep(b, &idelock);
  }

  release(&idelock);
8010216b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102172:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102175:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
80102176:	e9 d5 21 00 00       	jmp    80104350 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102180:	eb ba                	jmp    8010213c <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102182:	89 d8                	mov    %ebx,%eax
80102184:	e8 47 fd ff ff       	call   80101ed0 <idestart>
80102189:	eb bb                	jmp    80102146 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
8010218b:	83 ec 0c             	sub    $0xc,%esp
8010218e:	68 c6 70 10 80       	push   $0x801070c6
80102193:	e8 b8 e1 ff ff       	call   80100350 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 ef 70 10 80       	push   $0x801070ef
801021a0:	e8 ab e1 ff ff       	call   80100350 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 da 70 10 80       	push   $0x801070da
801021ad:	e8 9e e1 ff ff       	call   80100350 <panic>
801021b2:	66 90                	xchg   %ax,%ax
801021b4:	66 90                	xchg   %ax,%ax
801021b6:	66 90                	xchg   %ax,%ax
801021b8:	66 90                	xchg   %ax,%ax
801021ba:	66 90                	xchg   %ax,%ax
801021bc:	66 90                	xchg   %ax,%ax
801021be:	66 90                	xchg   %ax,%ax

801021c0 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
801021c0:	a1 c4 12 11 80       	mov    0x801112c4,%eax
801021c5:	85 c0                	test   %eax,%eax
801021c7:	0f 84 a8 00 00 00    	je     80102275 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021cd:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021ce:	c7 05 94 11 11 80 00 	movl   $0xfec00000,0x80111194
801021d5:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021d8:	89 e5                	mov    %esp,%ebp
801021da:	56                   	push   %esi
801021db:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021dc:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021e3:	00 00 00 
  return ioapic->data;
801021e6:	8b 15 94 11 11 80    	mov    0x80111194,%edx
801021ec:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ef:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801021f5:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801021fb:	0f b6 15 c0 12 11 80 	movzbl 0x801112c0,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102202:	89 f0                	mov    %esi,%eax
80102204:	c1 e8 10             	shr    $0x10,%eax
80102207:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010220a:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010220d:	c1 e8 18             	shr    $0x18,%eax
80102210:	39 d0                	cmp    %edx,%eax
80102212:	74 16                	je     8010222a <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 10 71 10 80       	push   $0x80107110
8010221c:	e8 1f e4 ff ff       	call   80100640 <cprintf>
80102221:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
80102227:	83 c4 10             	add    $0x10,%esp
8010222a:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010222d:	ba 10 00 00 00       	mov    $0x10,%edx
80102232:	b8 20 00 00 00       	mov    $0x20,%eax
80102237:	89 f6                	mov    %esi,%esi
80102239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102240:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102242:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102248:	89 c3                	mov    %eax,%ebx
8010224a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102250:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102253:	89 59 10             	mov    %ebx,0x10(%ecx)
80102256:	8d 5a 01             	lea    0x1(%edx),%ebx
80102259:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010225c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010225e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102260:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
80102266:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010226d:	75 d1                	jne    80102240 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010226f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102272:	5b                   	pop    %ebx
80102273:	5e                   	pop    %esi
80102274:	5d                   	pop    %ebp
80102275:	f3 c3                	repz ret 
80102277:	89 f6                	mov    %esi,%esi
80102279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102280 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102280:	8b 15 c4 12 11 80    	mov    0x801112c4,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102286:	55                   	push   %ebp
80102287:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102289:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010228b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010228e:	74 2b                	je     801022bb <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102290:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102296:	8d 50 20             	lea    0x20(%eax),%edx
80102299:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010229d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010229f:	8b 0d 94 11 11 80    	mov    0x80111194,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a5:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022a8:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022ab:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ae:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022b0:	a1 94 11 11 80       	mov    0x80111194,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022b5:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022b8:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022bb:	5d                   	pop    %ebp
801022bc:	c3                   	ret    
801022bd:	66 90                	xchg   %ax,%ax
801022bf:	90                   	nop

801022c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	53                   	push   %ebx
801022c4:	83 ec 04             	sub    $0x4,%esp
801022c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022d0:	75 70                	jne    80102342 <kfree+0x82>
801022d2:	81 fb 68 42 11 80    	cmp    $0x80114268,%ebx
801022d8:	72 68                	jb     80102342 <kfree+0x82>
801022da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022e5:	77 5b                	ja     80102342 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022e7:	83 ec 04             	sub    $0x4,%esp
801022ea:	68 00 10 00 00       	push   $0x1000
801022ef:	6a 01                	push   $0x1
801022f1:	53                   	push   %ebx
801022f2:	e8 a9 20 00 00       	call   801043a0 <memset>

  if(kmem.use_lock)
801022f7:	8b 15 d4 11 11 80    	mov    0x801111d4,%edx
801022fd:	83 c4 10             	add    $0x10,%esp
80102300:	85 d2                	test   %edx,%edx
80102302:	75 2c                	jne    80102330 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102304:	a1 d8 11 11 80       	mov    0x801111d8,%eax
80102309:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010230b:	a1 d4 11 11 80       	mov    0x801111d4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102310:	89 1d d8 11 11 80    	mov    %ebx,0x801111d8
  if(kmem.use_lock)
80102316:	85 c0                	test   %eax,%eax
80102318:	75 06                	jne    80102320 <kfree+0x60>
    release(&kmem.lock);
}
8010231a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010231d:	c9                   	leave  
8010231e:	c3                   	ret    
8010231f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102320:	c7 45 08 a0 11 11 80 	movl   $0x801111a0,0x8(%ebp)
}
80102327:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010232a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010232b:	e9 20 20 00 00       	jmp    80104350 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102330:	83 ec 0c             	sub    $0xc,%esp
80102333:	68 a0 11 11 80       	push   $0x801111a0
80102338:	e8 33 1e 00 00       	call   80104170 <acquire>
8010233d:	83 c4 10             	add    $0x10,%esp
80102340:	eb c2                	jmp    80102304 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102342:	83 ec 0c             	sub    $0xc,%esp
80102345:	68 42 71 10 80       	push   $0x80107142
8010234a:	e8 01 e0 ff ff       	call   80100350 <panic>
8010234f:	90                   	nop

80102350 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102350:	55                   	push   %ebp
80102351:	89 e5                	mov    %esp,%ebp
80102353:	56                   	push   %esi
80102354:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102355:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102358:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010235b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102361:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102367:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010236d:	39 de                	cmp    %ebx,%esi
8010236f:	72 23                	jb     80102394 <freerange+0x44>
80102371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102378:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010237e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102381:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102387:	50                   	push   %eax
80102388:	e8 33 ff ff ff       	call   801022c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	39 f3                	cmp    %esi,%ebx
80102392:	76 e4                	jbe    80102378 <freerange+0x28>
    kfree(p);
}
80102394:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102397:	5b                   	pop    %ebx
80102398:	5e                   	pop    %esi
80102399:	5d                   	pop    %ebp
8010239a:	c3                   	ret    
8010239b:	90                   	nop
8010239c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023a0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	56                   	push   %esi
801023a4:	53                   	push   %ebx
801023a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023a8:	83 ec 08             	sub    $0x8,%esp
801023ab:	68 48 71 10 80       	push   $0x80107148
801023b0:	68 a0 11 11 80       	push   $0x801111a0
801023b5:	e8 96 1d 00 00       	call   80104150 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ba:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023bd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023c0:	c7 05 d4 11 11 80 00 	movl   $0x0,0x801111d4
801023c7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ca:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dc:	39 de                	cmp    %ebx,%esi
801023de:	72 1c                	jb     801023fc <kinit1+0x5c>
    kfree(p);
801023e0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023e6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023ef:	50                   	push   %eax
801023f0:	e8 cb fe ff ff       	call   801022c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f5:	83 c4 10             	add    $0x10,%esp
801023f8:	39 de                	cmp    %ebx,%esi
801023fa:	73 e4                	jae    801023e0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801023fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023ff:	5b                   	pop    %ebx
80102400:	5e                   	pop    %esi
80102401:	5d                   	pop    %ebp
80102402:	c3                   	ret    
80102403:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102415:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102418:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010241b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102421:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102427:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010242d:	39 de                	cmp    %ebx,%esi
8010242f:	72 23                	jb     80102454 <kinit2+0x44>
80102431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102438:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010243e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102441:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102447:	50                   	push   %eax
80102448:	e8 73 fe ff ff       	call   801022c0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010244d:	83 c4 10             	add    $0x10,%esp
80102450:	39 de                	cmp    %ebx,%esi
80102452:	73 e4                	jae    80102438 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102454:	c7 05 d4 11 11 80 01 	movl   $0x1,0x801111d4
8010245b:	00 00 00 
}
8010245e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102461:	5b                   	pop    %ebx
80102462:	5e                   	pop    %esi
80102463:	5d                   	pop    %ebp
80102464:	c3                   	ret    
80102465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	53                   	push   %ebx
80102474:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102477:	a1 d4 11 11 80       	mov    0x801111d4,%eax
8010247c:	85 c0                	test   %eax,%eax
8010247e:	75 30                	jne    801024b0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102480:	8b 1d d8 11 11 80    	mov    0x801111d8,%ebx
  if(r)
80102486:	85 db                	test   %ebx,%ebx
80102488:	74 1c                	je     801024a6 <kalloc+0x36>
    kmem.freelist = r->next;
8010248a:	8b 13                	mov    (%ebx),%edx
8010248c:	89 15 d8 11 11 80    	mov    %edx,0x801111d8
  if(kmem.use_lock)
80102492:	85 c0                	test   %eax,%eax
80102494:	74 10                	je     801024a6 <kalloc+0x36>
    release(&kmem.lock);
80102496:	83 ec 0c             	sub    $0xc,%esp
80102499:	68 a0 11 11 80       	push   $0x801111a0
8010249e:	e8 ad 1e 00 00       	call   80104350 <release>
801024a3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024a6:	89 d8                	mov    %ebx,%eax
801024a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024ab:	c9                   	leave  
801024ac:	c3                   	ret    
801024ad:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024b0:	83 ec 0c             	sub    $0xc,%esp
801024b3:	68 a0 11 11 80       	push   $0x801111a0
801024b8:	e8 b3 1c 00 00       	call   80104170 <acquire>
  r = kmem.freelist;
801024bd:	8b 1d d8 11 11 80    	mov    0x801111d8,%ebx
  if(r)
801024c3:	83 c4 10             	add    $0x10,%esp
801024c6:	a1 d4 11 11 80       	mov    0x801111d4,%eax
801024cb:	85 db                	test   %ebx,%ebx
801024cd:	75 bb                	jne    8010248a <kalloc+0x1a>
801024cf:	eb c1                	jmp    80102492 <kalloc+0x22>
801024d1:	66 90                	xchg   %ax,%ax
801024d3:	66 90                	xchg   %ax,%ax
801024d5:	66 90                	xchg   %ax,%ax
801024d7:	66 90                	xchg   %ax,%ax
801024d9:	66 90                	xchg   %ax,%ax
801024db:	66 90                	xchg   %ax,%ax
801024dd:	66 90                	xchg   %ax,%ax
801024df:	90                   	nop

801024e0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801024e0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024e1:	ba 64 00 00 00       	mov    $0x64,%edx
801024e6:	89 e5                	mov    %esp,%ebp
801024e8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024e9:	a8 01                	test   $0x1,%al
801024eb:	0f 84 af 00 00 00    	je     801025a0 <kbdgetc+0xc0>
801024f1:	ba 60 00 00 00       	mov    $0x60,%edx
801024f6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801024f7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801024fa:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102500:	74 7e                	je     80102580 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102502:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102504:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010250a:	79 24                	jns    80102530 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010250c:	f6 c1 40             	test   $0x40,%cl
8010250f:	75 05                	jne    80102516 <kbdgetc+0x36>
80102511:	89 c2                	mov    %eax,%edx
80102513:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102516:	0f b6 82 80 72 10 80 	movzbl -0x7fef8d80(%edx),%eax
8010251d:	83 c8 40             	or     $0x40,%eax
80102520:	0f b6 c0             	movzbl %al,%eax
80102523:	f7 d0                	not    %eax
80102525:	21 c8                	and    %ecx,%eax
80102527:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010252c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010252e:	5d                   	pop    %ebp
8010252f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102530:	f6 c1 40             	test   $0x40,%cl
80102533:	74 09                	je     8010253e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102535:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102538:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010253b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010253e:	0f b6 82 80 72 10 80 	movzbl -0x7fef8d80(%edx),%eax
80102545:	09 c1                	or     %eax,%ecx
80102547:	0f b6 82 80 71 10 80 	movzbl -0x7fef8e80(%edx),%eax
8010254e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102550:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102552:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102558:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010255b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010255e:	8b 04 85 60 71 10 80 	mov    -0x7fef8ea0(,%eax,4),%eax
80102565:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102569:	74 c3                	je     8010252e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010256b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010256e:	83 fa 19             	cmp    $0x19,%edx
80102571:	77 1d                	ja     80102590 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102573:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102576:	5d                   	pop    %ebp
80102577:	c3                   	ret    
80102578:	90                   	nop
80102579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102580:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102582:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102589:	5d                   	pop    %ebp
8010258a:	c3                   	ret    
8010258b:	90                   	nop
8010258c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102590:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102593:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102596:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102597:	83 f9 19             	cmp    $0x19,%ecx
8010259a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010259d:	c3                   	ret    
8010259e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025a5:	5d                   	pop    %ebp
801025a6:	c3                   	ret    
801025a7:	89 f6                	mov    %esi,%esi
801025a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025b0 <kbdintr>:

void
kbdintr(void)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025b6:	68 e0 24 10 80       	push   $0x801024e0
801025bb:	e8 10 e2 ff ff       	call   801007d0 <consoleintr>
}
801025c0:	83 c4 10             	add    $0x10,%esp
801025c3:	c9                   	leave  
801025c4:	c3                   	ret    
801025c5:	66 90                	xchg   %ax,%ax
801025c7:	66 90                	xchg   %ax,%ax
801025c9:	66 90                	xchg   %ax,%ax
801025cb:	66 90                	xchg   %ax,%ax
801025cd:	66 90                	xchg   %ax,%ax
801025cf:	90                   	nop

801025d0 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
801025d0:	a1 dc 11 11 80       	mov    0x801111dc,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
801025d5:	55                   	push   %ebp
801025d6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025d8:	85 c0                	test   %eax,%eax
801025da:	0f 84 c8 00 00 00    	je     801026a8 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025e0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025e7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025ea:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025ed:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801025f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025f7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025fa:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102601:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102604:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102607:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010260e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102611:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102614:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010261b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010261e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102621:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102628:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010262b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010262e:	8b 50 30             	mov    0x30(%eax),%edx
80102631:	c1 ea 10             	shr    $0x10,%edx
80102634:	80 fa 03             	cmp    $0x3,%dl
80102637:	77 77                	ja     801026b0 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102639:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102640:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102643:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102646:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010264d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102650:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102653:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010265a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102660:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102667:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010266d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102681:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
80102687:	89 f6                	mov    %esi,%esi
80102689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102690:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102696:	80 e6 10             	and    $0x10,%dh
80102699:	75 f5                	jne    80102690 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026a2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026a8:	5d                   	pop    %ebp
801026a9:	c3                   	ret    
801026aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026b7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ba:	8b 50 20             	mov    0x20(%eax),%edx
801026bd:	e9 77 ff ff ff       	jmp    80102639 <lapicinit+0x69>
801026c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026d0 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801026d6:	9c                   	pushf  
801026d7:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801026d8:	f6 c4 02             	test   $0x2,%ah
801026db:	74 12                	je     801026ef <cpunum+0x1f>
    static int n;
    if(n++ == 0)
801026dd:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
801026e2:	8d 50 01             	lea    0x1(%eax),%edx
801026e5:	85 c0                	test   %eax,%eax
801026e7:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
801026ed:	74 11                	je     80102700 <cpunum+0x30>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
801026ef:	a1 dc 11 11 80       	mov    0x801111dc,%eax
801026f4:	85 c0                	test   %eax,%eax
801026f6:	74 24                	je     8010271c <cpunum+0x4c>
    return lapic[ID]>>24;
801026f8:	8b 40 20             	mov    0x20(%eax),%eax
  return 0;
}
801026fb:	c9                   	leave  
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
    return lapic[ID]>>24;
801026fc:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
801026ff:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102700:	83 ec 08             	sub    $0x8,%esp
80102703:	ff 75 04             	pushl  0x4(%ebp)
80102706:	68 80 73 10 80       	push   $0x80107380
8010270b:	e8 30 df ff ff       	call   80100640 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102710:	a1 dc 11 11 80       	mov    0x801111dc,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102715:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102718:	85 c0                	test   %eax,%eax
8010271a:	75 dc                	jne    801026f8 <cpunum+0x28>
    return lapic[ID]>>24;
  return 0;
8010271c:	31 c0                	xor    %eax,%eax
}
8010271e:	c9                   	leave  
8010271f:	c3                   	ret    

80102720 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102720:	a1 dc 11 11 80       	mov    0x801111dc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102725:	55                   	push   %ebp
80102726:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102728:	85 c0                	test   %eax,%eax
8010272a:	74 0d                	je     80102739 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010272c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102733:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102736:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102739:	5d                   	pop    %ebp
8010273a:	c3                   	ret    
8010273b:	90                   	nop
8010273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102740 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
}
80102743:	5d                   	pop    %ebp
80102744:	c3                   	ret    
80102745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102750:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102751:	ba 70 00 00 00       	mov    $0x70,%edx
80102756:	b8 0f 00 00 00       	mov    $0xf,%eax
8010275b:	89 e5                	mov    %esp,%ebp
8010275d:	53                   	push   %ebx
8010275e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102761:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102764:	ee                   	out    %al,(%dx)
80102765:	ba 71 00 00 00       	mov    $0x71,%edx
8010276a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010276f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102770:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102772:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102775:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010277b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010277d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102780:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102783:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102785:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102788:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010278e:	a1 dc 11 11 80       	mov    0x801111dc,%eax
80102793:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102799:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a6:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b3:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027bc:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c5:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ce:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027da:	5b                   	pop    %ebx
801027db:	5d                   	pop    %ebp
801027dc:	c3                   	ret    
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801027e0:	55                   	push   %ebp
801027e1:	ba 70 00 00 00       	mov    $0x70,%edx
801027e6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027eb:	89 e5                	mov    %esp,%ebp
801027ed:	57                   	push   %edi
801027ee:	56                   	push   %esi
801027ef:	53                   	push   %ebx
801027f0:	83 ec 4c             	sub    $0x4c,%esp
801027f3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f4:	ba 71 00 00 00       	mov    $0x71,%edx
801027f9:	ec                   	in     (%dx),%al
801027fa:	83 e0 04             	and    $0x4,%eax
801027fd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102800:	31 db                	xor    %ebx,%ebx
80102802:	88 45 b7             	mov    %al,-0x49(%ebp)
80102805:	bf 70 00 00 00       	mov    $0x70,%edi
8010280a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102810:	89 d8                	mov    %ebx,%eax
80102812:	89 fa                	mov    %edi,%edx
80102814:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102815:	b9 71 00 00 00       	mov    $0x71,%ecx
8010281a:	89 ca                	mov    %ecx,%edx
8010281c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010281d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102820:	89 fa                	mov    %edi,%edx
80102822:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102825:	b8 02 00 00 00       	mov    $0x2,%eax
8010282a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010282b:	89 ca                	mov    %ecx,%edx
8010282d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010282e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102831:	89 fa                	mov    %edi,%edx
80102833:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102836:	b8 04 00 00 00       	mov    $0x4,%eax
8010283b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283c:	89 ca                	mov    %ecx,%edx
8010283e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010283f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102842:	89 fa                	mov    %edi,%edx
80102844:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102847:	b8 07 00 00 00       	mov    $0x7,%eax
8010284c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284d:	89 ca                	mov    %ecx,%edx
8010284f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102850:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102853:	89 fa                	mov    %edi,%edx
80102855:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102858:	b8 08 00 00 00       	mov    $0x8,%eax
8010285d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285e:	89 ca                	mov    %ecx,%edx
80102860:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102861:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102864:	89 fa                	mov    %edi,%edx
80102866:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102869:	b8 09 00 00 00       	mov    $0x9,%eax
8010286e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286f:	89 ca                	mov    %ecx,%edx
80102871:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102872:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102875:	89 fa                	mov    %edi,%edx
80102877:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010287a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010287f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102880:	89 ca                	mov    %ecx,%edx
80102882:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102883:	84 c0                	test   %al,%al
80102885:	78 89                	js     80102810 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102887:	89 d8                	mov    %ebx,%eax
80102889:	89 fa                	mov    %edi,%edx
8010288b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288c:	89 ca                	mov    %ecx,%edx
8010288e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010288f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102892:	89 fa                	mov    %edi,%edx
80102894:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102897:	b8 02 00 00 00       	mov    $0x2,%eax
8010289c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289d:	89 ca                	mov    %ecx,%edx
8010289f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028a0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a3:	89 fa                	mov    %edi,%edx
801028a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028a8:	b8 04 00 00 00       	mov    $0x4,%eax
801028ad:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ae:	89 ca                	mov    %ecx,%edx
801028b0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801028b1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b4:	89 fa                	mov    %edi,%edx
801028b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028b9:	b8 07 00 00 00       	mov    $0x7,%eax
801028be:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028bf:	89 ca                	mov    %ecx,%edx
801028c1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028c2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c5:	89 fa                	mov    %edi,%edx
801028c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028ca:	b8 08 00 00 00       	mov    $0x8,%eax
801028cf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028d0:	89 ca                	mov    %ecx,%edx
801028d2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028d3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d6:	89 fa                	mov    %edi,%edx
801028d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028db:	b8 09 00 00 00       	mov    $0x9,%eax
801028e0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e1:	89 ca                	mov    %ecx,%edx
801028e3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028e4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028e7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801028ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028ed:	8d 45 b8             	lea    -0x48(%ebp),%eax
801028f0:	6a 18                	push   $0x18
801028f2:	56                   	push   %esi
801028f3:	50                   	push   %eax
801028f4:	e8 f7 1a 00 00       	call   801043f0 <memcmp>
801028f9:	83 c4 10             	add    $0x10,%esp
801028fc:	85 c0                	test   %eax,%eax
801028fe:	0f 85 0c ff ff ff    	jne    80102810 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102904:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102908:	75 78                	jne    80102982 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010290a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010290d:	89 c2                	mov    %eax,%edx
8010290f:	83 e0 0f             	and    $0xf,%eax
80102912:	c1 ea 04             	shr    $0x4,%edx
80102915:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102918:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010291b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010291e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102921:	89 c2                	mov    %eax,%edx
80102923:	83 e0 0f             	and    $0xf,%eax
80102926:	c1 ea 04             	shr    $0x4,%edx
80102929:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010292c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010292f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102932:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102935:	89 c2                	mov    %eax,%edx
80102937:	83 e0 0f             	and    $0xf,%eax
8010293a:	c1 ea 04             	shr    $0x4,%edx
8010293d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102940:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102943:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102946:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102949:	89 c2                	mov    %eax,%edx
8010294b:	83 e0 0f             	and    $0xf,%eax
8010294e:	c1 ea 04             	shr    $0x4,%edx
80102951:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102954:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102957:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010295a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010295d:	89 c2                	mov    %eax,%edx
8010295f:	83 e0 0f             	and    $0xf,%eax
80102962:	c1 ea 04             	shr    $0x4,%edx
80102965:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102968:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010296e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102971:	89 c2                	mov    %eax,%edx
80102973:	83 e0 0f             	and    $0xf,%eax
80102976:	c1 ea 04             	shr    $0x4,%edx
80102979:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102982:	8b 75 08             	mov    0x8(%ebp),%esi
80102985:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102988:	89 06                	mov    %eax,(%esi)
8010298a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010298d:	89 46 04             	mov    %eax,0x4(%esi)
80102990:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102993:	89 46 08             	mov    %eax,0x8(%esi)
80102996:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102999:	89 46 0c             	mov    %eax,0xc(%esi)
8010299c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010299f:	89 46 10             	mov    %eax,0x10(%esi)
801029a2:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029a5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029a8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029b2:	5b                   	pop    %ebx
801029b3:	5e                   	pop    %esi
801029b4:	5f                   	pop    %edi
801029b5:	5d                   	pop    %ebp
801029b6:	c3                   	ret    
801029b7:	66 90                	xchg   %ax,%ax
801029b9:	66 90                	xchg   %ax,%ax
801029bb:	66 90                	xchg   %ax,%ax
801029bd:	66 90                	xchg   %ax,%ax
801029bf:	90                   	nop

801029c0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029c0:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
801029c6:	85 c9                	test   %ecx,%ecx
801029c8:	0f 8e 85 00 00 00    	jle    80102a53 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029ce:	55                   	push   %ebp
801029cf:	89 e5                	mov    %esp,%ebp
801029d1:	57                   	push   %edi
801029d2:	56                   	push   %esi
801029d3:	53                   	push   %ebx
801029d4:	31 db                	xor    %ebx,%ebx
801029d6:	83 ec 0c             	sub    $0xc,%esp
801029d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029e0:	a1 14 12 11 80       	mov    0x80111214,%eax
801029e5:	83 ec 08             	sub    $0x8,%esp
801029e8:	01 d8                	add    %ebx,%eax
801029ea:	83 c0 01             	add    $0x1,%eax
801029ed:	50                   	push   %eax
801029ee:	ff 35 24 12 11 80    	pushl  0x80111224
801029f4:	e8 c7 d6 ff ff       	call   801000c0 <bread>
801029f9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029fb:	58                   	pop    %eax
801029fc:	5a                   	pop    %edx
801029fd:	ff 34 9d 2c 12 11 80 	pushl  -0x7feeedd4(,%ebx,4)
80102a04:	ff 35 24 12 11 80    	pushl  0x80111224
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a0a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a0d:	e8 ae d6 ff ff       	call   801000c0 <bread>
80102a12:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a14:	8d 47 18             	lea    0x18(%edi),%eax
80102a17:	83 c4 0c             	add    $0xc,%esp
80102a1a:	68 00 02 00 00       	push   $0x200
80102a1f:	50                   	push   %eax
80102a20:	8d 46 18             	lea    0x18(%esi),%eax
80102a23:	50                   	push   %eax
80102a24:	e8 27 1a 00 00       	call   80104450 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a29:	89 34 24             	mov    %esi,(%esp)
80102a2c:	e8 6f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a31:	89 3c 24             	mov    %edi,(%esp)
80102a34:	e8 97 d7 ff ff       	call   801001d0 <brelse>
    brelse(dbuf);
80102a39:	89 34 24             	mov    %esi,(%esp)
80102a3c:	e8 8f d7 ff ff       	call   801001d0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a41:	83 c4 10             	add    $0x10,%esp
80102a44:	39 1d 28 12 11 80    	cmp    %ebx,0x80111228
80102a4a:	7f 94                	jg     801029e0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a4f:	5b                   	pop    %ebx
80102a50:	5e                   	pop    %esi
80102a51:	5f                   	pop    %edi
80102a52:	5d                   	pop    %ebp
80102a53:	f3 c3                	repz ret 
80102a55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a60:	55                   	push   %ebp
80102a61:	89 e5                	mov    %esp,%ebp
80102a63:	53                   	push   %ebx
80102a64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a67:	ff 35 14 12 11 80    	pushl  0x80111214
80102a6d:	ff 35 24 12 11 80    	pushl  0x80111224
80102a73:	e8 48 d6 ff ff       	call   801000c0 <bread>
80102a78:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a7a:	a1 28 12 11 80       	mov    0x80111228,%eax
  for (i = 0; i < log.lh.n; i++) {
80102a7f:	83 c4 10             	add    $0x10,%esp
80102a82:	31 d2                	xor    %edx,%edx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a84:	89 43 18             	mov    %eax,0x18(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102a87:	a1 28 12 11 80       	mov    0x80111228,%eax
80102a8c:	85 c0                	test   %eax,%eax
80102a8e:	7e 16                	jle    80102aa6 <write_head+0x46>
    hb->block[i] = log.lh.block[i];
80102a90:	8b 0c 95 2c 12 11 80 	mov    -0x7feeedd4(,%edx,4),%ecx
80102a97:	89 4c 93 1c          	mov    %ecx,0x1c(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a9b:	83 c2 01             	add    $0x1,%edx
80102a9e:	39 15 28 12 11 80    	cmp    %edx,0x80111228
80102aa4:	7f ea                	jg     80102a90 <write_head+0x30>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102aa6:	83 ec 0c             	sub    $0xc,%esp
80102aa9:	53                   	push   %ebx
80102aaa:	e8 f1 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102aaf:	89 1c 24             	mov    %ebx,(%esp)
80102ab2:	e8 19 d7 ff ff       	call   801001d0 <brelse>
}
80102ab7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102aba:	c9                   	leave  
80102abb:	c3                   	ret    
80102abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ac0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	53                   	push   %ebx
80102ac4:	83 ec 2c             	sub    $0x2c,%esp
80102ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102aca:	68 ac 73 10 80       	push   $0x801073ac
80102acf:	68 e0 11 11 80       	push   $0x801111e0
80102ad4:	e8 77 16 00 00       	call   80104150 <initlock>
  readsb(dev, &sb);
80102ad9:	58                   	pop    %eax
80102ada:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102add:	5a                   	pop    %edx
80102ade:	50                   	push   %eax
80102adf:	53                   	push   %ebx
80102ae0:	e8 8b e8 ff ff       	call   80101370 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ae5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102aeb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102aec:	89 1d 24 12 11 80    	mov    %ebx,0x80111224

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102af2:	89 15 18 12 11 80    	mov    %edx,0x80111218
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102af8:	a3 14 12 11 80       	mov    %eax,0x80111214

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102afd:	5a                   	pop    %edx
80102afe:	50                   	push   %eax
80102aff:	53                   	push   %ebx
80102b00:	e8 bb d5 ff ff       	call   801000c0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b05:	8b 48 18             	mov    0x18(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b08:	83 c4 10             	add    $0x10,%esp
80102b0b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b0d:	89 0d 28 12 11 80    	mov    %ecx,0x80111228
  for (i = 0; i < log.lh.n; i++) {
80102b13:	7e 1c                	jle    80102b31 <initlog+0x71>
80102b15:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b1c:	31 d2                	xor    %edx,%edx
80102b1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b20:	8b 4c 10 1c          	mov    0x1c(%eax,%edx,1),%ecx
80102b24:	83 c2 04             	add    $0x4,%edx
80102b27:	89 8a 28 12 11 80    	mov    %ecx,-0x7feeedd8(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b2d:	39 da                	cmp    %ebx,%edx
80102b2f:	75 ef                	jne    80102b20 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b31:	83 ec 0c             	sub    $0xc,%esp
80102b34:	50                   	push   %eax
80102b35:	e8 96 d6 ff ff       	call   801001d0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b3a:	e8 81 fe ff ff       	call   801029c0 <install_trans>
  log.lh.n = 0;
80102b3f:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102b46:	00 00 00 
  write_head(); // clear the log
80102b49:	e8 12 ff ff ff       	call   80102a60 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b51:	c9                   	leave  
80102b52:	c3                   	ret    
80102b53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b66:	68 e0 11 11 80       	push   $0x801111e0
80102b6b:	e8 00 16 00 00       	call   80104170 <acquire>
80102b70:	83 c4 10             	add    $0x10,%esp
80102b73:	eb 18                	jmp    80102b8d <begin_op+0x2d>
80102b75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b78:	83 ec 08             	sub    $0x8,%esp
80102b7b:	68 e0 11 11 80       	push   $0x801111e0
80102b80:	68 e0 11 11 80       	push   $0x801111e0
80102b85:	e8 46 12 00 00       	call   80103dd0 <sleep>
80102b8a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b8d:	a1 20 12 11 80       	mov    0x80111220,%eax
80102b92:	85 c0                	test   %eax,%eax
80102b94:	75 e2                	jne    80102b78 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b96:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102b9b:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102ba1:	83 c0 01             	add    $0x1,%eax
80102ba4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ba7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102baa:	83 fa 1e             	cmp    $0x1e,%edx
80102bad:	7f c9                	jg     80102b78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102baf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bb2:	a3 1c 12 11 80       	mov    %eax,0x8011121c
      release(&log.lock);
80102bb7:	68 e0 11 11 80       	push   $0x801111e0
80102bbc:	e8 8f 17 00 00       	call   80104350 <release>
      break;
    }
  }
}
80102bc1:	83 c4 10             	add    $0x10,%esp
80102bc4:	c9                   	leave  
80102bc5:	c3                   	ret    
80102bc6:	8d 76 00             	lea    0x0(%esi),%esi
80102bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bd0:	55                   	push   %ebp
80102bd1:	89 e5                	mov    %esp,%ebp
80102bd3:	57                   	push   %edi
80102bd4:	56                   	push   %esi
80102bd5:	53                   	push   %ebx
80102bd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bd9:	68 e0 11 11 80       	push   $0x801111e0
80102bde:	e8 8d 15 00 00       	call   80104170 <acquire>
  log.outstanding -= 1;
80102be3:	a1 1c 12 11 80       	mov    0x8011121c,%eax
  if(log.committing)
80102be8:	8b 1d 20 12 11 80    	mov    0x80111220,%ebx
80102bee:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bf1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102bf4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bf6:	a3 1c 12 11 80       	mov    %eax,0x8011121c
  if(log.committing)
80102bfb:	0f 85 23 01 00 00    	jne    80102d24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c01:	85 c0                	test   %eax,%eax
80102c03:	0f 85 f7 00 00 00    	jne    80102d00 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c09:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c0c:	c7 05 20 12 11 80 01 	movl   $0x1,0x80111220
80102c13:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c16:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c18:	68 e0 11 11 80       	push   $0x801111e0
80102c1d:	e8 2e 17 00 00       	call   80104350 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c22:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80102c28:	83 c4 10             	add    $0x10,%esp
80102c2b:	85 c9                	test   %ecx,%ecx
80102c2d:	0f 8e 8a 00 00 00    	jle    80102cbd <end_op+0xed>
80102c33:	90                   	nop
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c38:	a1 14 12 11 80       	mov    0x80111214,%eax
80102c3d:	83 ec 08             	sub    $0x8,%esp
80102c40:	01 d8                	add    %ebx,%eax
80102c42:	83 c0 01             	add    $0x1,%eax
80102c45:	50                   	push   %eax
80102c46:	ff 35 24 12 11 80    	pushl  0x80111224
80102c4c:	e8 6f d4 ff ff       	call   801000c0 <bread>
80102c51:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c53:	58                   	pop    %eax
80102c54:	5a                   	pop    %edx
80102c55:	ff 34 9d 2c 12 11 80 	pushl  -0x7feeedd4(,%ebx,4)
80102c5c:	ff 35 24 12 11 80    	pushl  0x80111224
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c62:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c65:	e8 56 d4 ff ff       	call   801000c0 <bread>
80102c6a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c6c:	8d 40 18             	lea    0x18(%eax),%eax
80102c6f:	83 c4 0c             	add    $0xc,%esp
80102c72:	68 00 02 00 00       	push   $0x200
80102c77:	50                   	push   %eax
80102c78:	8d 46 18             	lea    0x18(%esi),%eax
80102c7b:	50                   	push   %eax
80102c7c:	e8 cf 17 00 00       	call   80104450 <memmove>
    bwrite(to);  // write the log
80102c81:	89 34 24             	mov    %esi,(%esp)
80102c84:	e8 17 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c89:	89 3c 24             	mov    %edi,(%esp)
80102c8c:	e8 3f d5 ff ff       	call   801001d0 <brelse>
    brelse(to);
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 37 d5 ff ff       	call   801001d0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c99:	83 c4 10             	add    $0x10,%esp
80102c9c:	3b 1d 28 12 11 80    	cmp    0x80111228,%ebx
80102ca2:	7c 94                	jl     80102c38 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ca4:	e8 b7 fd ff ff       	call   80102a60 <write_head>
    install_trans(); // Now install writes to home locations
80102ca9:	e8 12 fd ff ff       	call   801029c0 <install_trans>
    log.lh.n = 0;
80102cae:	c7 05 28 12 11 80 00 	movl   $0x0,0x80111228
80102cb5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cb8:	e8 a3 fd ff ff       	call   80102a60 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102cbd:	83 ec 0c             	sub    $0xc,%esp
80102cc0:	68 e0 11 11 80       	push   $0x801111e0
80102cc5:	e8 a6 14 00 00       	call   80104170 <acquire>
    log.committing = 0;
    wakeup(&log);
80102cca:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102cd1:	c7 05 20 12 11 80 00 	movl   $0x0,0x80111220
80102cd8:	00 00 00 
    wakeup(&log);
80102cdb:	e8 a0 12 00 00       	call   80103f80 <wakeup>
    release(&log.lock);
80102ce0:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102ce7:	e8 64 16 00 00       	call   80104350 <release>
80102cec:	83 c4 10             	add    $0x10,%esp
  }
}
80102cef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cf2:	5b                   	pop    %ebx
80102cf3:	5e                   	pop    %esi
80102cf4:	5f                   	pop    %edi
80102cf5:	5d                   	pop    %ebp
80102cf6:	c3                   	ret    
80102cf7:	89 f6                	mov    %esi,%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102d00:	83 ec 0c             	sub    $0xc,%esp
80102d03:	68 e0 11 11 80       	push   $0x801111e0
80102d08:	e8 73 12 00 00       	call   80103f80 <wakeup>
  }
  release(&log.lock);
80102d0d:	c7 04 24 e0 11 11 80 	movl   $0x801111e0,(%esp)
80102d14:	e8 37 16 00 00       	call   80104350 <release>
80102d19:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d1f:	5b                   	pop    %ebx
80102d20:	5e                   	pop    %esi
80102d21:	5f                   	pop    %edi
80102d22:	5d                   	pop    %ebp
80102d23:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d24:	83 ec 0c             	sub    $0xc,%esp
80102d27:	68 b0 73 10 80       	push   $0x801073b0
80102d2c:	e8 1f d6 ff ff       	call   80100350 <panic>
80102d31:	eb 0d                	jmp    80102d40 <log_write>
80102d33:	90                   	nop
80102d34:	90                   	nop
80102d35:	90                   	nop
80102d36:	90                   	nop
80102d37:	90                   	nop
80102d38:	90                   	nop
80102d39:	90                   	nop
80102d3a:	90                   	nop
80102d3b:	90                   	nop
80102d3c:	90                   	nop
80102d3d:	90                   	nop
80102d3e:	90                   	nop
80102d3f:	90                   	nop

80102d40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d40:	55                   	push   %ebp
80102d41:	89 e5                	mov    %esp,%ebp
80102d43:	53                   	push   %ebx
80102d44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d47:	8b 15 28 12 11 80    	mov    0x80111228,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d50:	83 fa 1d             	cmp    $0x1d,%edx
80102d53:	0f 8f 97 00 00 00    	jg     80102df0 <log_write+0xb0>
80102d59:	a1 18 12 11 80       	mov    0x80111218,%eax
80102d5e:	83 e8 01             	sub    $0x1,%eax
80102d61:	39 c2                	cmp    %eax,%edx
80102d63:	0f 8d 87 00 00 00    	jge    80102df0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d69:	a1 1c 12 11 80       	mov    0x8011121c,%eax
80102d6e:	85 c0                	test   %eax,%eax
80102d70:	0f 8e 87 00 00 00    	jle    80102dfd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d76:	83 ec 0c             	sub    $0xc,%esp
80102d79:	68 e0 11 11 80       	push   $0x801111e0
80102d7e:	e8 ed 13 00 00       	call   80104170 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d83:	8b 15 28 12 11 80    	mov    0x80111228,%edx
80102d89:	83 c4 10             	add    $0x10,%esp
80102d8c:	83 fa 00             	cmp    $0x0,%edx
80102d8f:	7e 50                	jle    80102de1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d91:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d94:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d96:	3b 0d 2c 12 11 80    	cmp    0x8011122c,%ecx
80102d9c:	75 0b                	jne    80102da9 <log_write+0x69>
80102d9e:	eb 38                	jmp    80102dd8 <log_write+0x98>
80102da0:	39 0c 85 2c 12 11 80 	cmp    %ecx,-0x7feeedd4(,%eax,4)
80102da7:	74 2f                	je     80102dd8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102da9:	83 c0 01             	add    $0x1,%eax
80102dac:	39 d0                	cmp    %edx,%eax
80102dae:	75 f0                	jne    80102da0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102db0:	89 0c 95 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102db7:	83 c2 01             	add    $0x1,%edx
80102dba:	89 15 28 12 11 80    	mov    %edx,0x80111228
  b->flags |= B_DIRTY; // prevent eviction
80102dc0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102dc3:	c7 45 08 e0 11 11 80 	movl   $0x801111e0,0x8(%ebp)
}
80102dca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dcd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dce:	e9 7d 15 00 00       	jmp    80104350 <release>
80102dd3:	90                   	nop
80102dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dd8:	89 0c 85 2c 12 11 80 	mov    %ecx,-0x7feeedd4(,%eax,4)
80102ddf:	eb df                	jmp    80102dc0 <log_write+0x80>
80102de1:	8b 43 08             	mov    0x8(%ebx),%eax
80102de4:	a3 2c 12 11 80       	mov    %eax,0x8011122c
  if (i == log.lh.n)
80102de9:	75 d5                	jne    80102dc0 <log_write+0x80>
80102deb:	eb ca                	jmp    80102db7 <log_write+0x77>
80102ded:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102df0:	83 ec 0c             	sub    $0xc,%esp
80102df3:	68 bf 73 10 80       	push   $0x801073bf
80102df8:	e8 53 d5 ff ff       	call   80100350 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102dfd:	83 ec 0c             	sub    $0xc,%esp
80102e00:	68 d5 73 10 80       	push   $0x801073d5
80102e05:	e8 46 d5 ff ff       	call   80100350 <panic>
80102e0a:	66 90                	xchg   %ax,%ax
80102e0c:	66 90                	xchg   %ax,%ax
80102e0e:	66 90                	xchg   %ax,%ax

80102e10 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	83 ec 10             	sub    $0x10,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80102e16:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80102e1c:	0f b6 00             	movzbl (%eax),%eax
80102e1f:	50                   	push   %eax
80102e20:	68 f0 73 10 80       	push   $0x801073f0
80102e25:	e8 16 d8 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102e2a:	e8 81 28 00 00       	call   801056b0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102e2f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e36:	b8 01 00 00 00       	mov    $0x1,%eax
80102e3b:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102e42:	e8 a9 0c 00 00       	call   80103af0 <scheduler>
80102e47:	89 f6                	mov    %esi,%esi
80102e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e50 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e56:	e8 f5 3a 00 00       	call   80106950 <switchkvm>
  seginit();
80102e5b:	e8 10 39 00 00       	call   80106770 <seginit>
  lapicinit();
80102e60:	e8 6b f7 ff ff       	call   801025d0 <lapicinit>
  mpmain();
80102e65:	e8 a6 ff ff ff       	call   80102e10 <mpmain>
80102e6a:	66 90                	xchg   %ax,%ax
80102e6c:	66 90                	xchg   %ax,%ax
80102e6e:	66 90                	xchg   %ax,%ax

80102e70 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e74:	83 e4 f0             	and    $0xfffffff0,%esp
80102e77:	ff 71 fc             	pushl  -0x4(%ecx)
80102e7a:	55                   	push   %ebp
80102e7b:	89 e5                	mov    %esp,%ebp
80102e7d:	53                   	push   %ebx
80102e7e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e7f:	83 ec 08             	sub    $0x8,%esp
80102e82:	68 00 00 40 80       	push   $0x80400000
80102e87:	68 68 42 11 80       	push   $0x80114268
80102e8c:	e8 0f f5 ff ff       	call   801023a0 <kinit1>
  kvmalloc();      // kernel page table
80102e91:	e8 9a 3a 00 00       	call   80106930 <kvmalloc>
  mpinit();        // detect other processors
80102e96:	e8 b5 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102e9b:	e8 30 f7 ff ff       	call   801025d0 <lapicinit>
  seginit();       // segment descriptors
80102ea0:	e8 cb 38 00 00       	call   80106770 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80102ea5:	58                   	pop    %eax
80102ea6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80102eac:	5a                   	pop    %edx
80102ead:	0f b6 00             	movzbl (%eax),%eax
80102eb0:	50                   	push   %eax
80102eb1:	68 01 74 10 80       	push   $0x80107401
80102eb6:	e8 85 d7 ff ff       	call   80100640 <cprintf>
  picinit();       // another interrupt controller
80102ebb:	e8 e0 03 00 00       	call   801032a0 <picinit>
  ioapicinit();    // another interrupt controller
80102ec0:	e8 fb f2 ff ff       	call   801021c0 <ioapicinit>
  consoleinit();   // console hardware
80102ec5:	e8 b6 da ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102eca:	e8 71 2b 00 00       	call   80105a40 <uartinit>
  pinit();         // process table
80102ecf:	e8 5c 09 00 00       	call   80103830 <pinit>
  tvinit();        // trap vectors
80102ed4:	e8 37 27 00 00       	call   80105610 <tvinit>
  binit();         // buffer cache
80102ed9:	e8 62 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ede:	e8 3d de ff ff       	call   80100d20 <fileinit>
  ideinit();       // disk
80102ee3:	e8 b8 f0 ff ff       	call   80101fa0 <ideinit>
  if(!ismp)
80102ee8:	8b 0d c4 12 11 80    	mov    0x801112c4,%ecx
80102eee:	83 c4 10             	add    $0x10,%esp
80102ef1:	85 c9                	test   %ecx,%ecx
80102ef3:	0f 84 c6 00 00 00    	je     80102fbf <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ef9:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102efc:	bb e0 12 11 80       	mov    $0x801112e0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f01:	68 8a 00 00 00       	push   $0x8a
80102f06:	68 8c a4 10 80       	push   $0x8010a48c
80102f0b:	68 00 70 00 80       	push   $0x80007000
80102f10:	e8 3b 15 00 00       	call   80104450 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f15:	69 05 c0 18 11 80 bc 	imul   $0xbc,0x801118c0,%eax
80102f1c:	00 00 00 
80102f1f:	83 c4 10             	add    $0x10,%esp
80102f22:	05 e0 12 11 80       	add    $0x801112e0,%eax
80102f27:	39 d8                	cmp    %ebx,%eax
80102f29:	76 78                	jbe    80102fa3 <main+0x133>
80102f2b:	90                   	nop
80102f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
80102f30:	e8 9b f7 ff ff       	call   801026d0 <cpunum>
80102f35:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102f3b:	05 e0 12 11 80       	add    $0x801112e0,%eax
80102f40:	39 c3                	cmp    %eax,%ebx
80102f42:	74 46                	je     80102f8a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f44:	e8 27 f5 ff ff       	call   80102470 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f49:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102f4e:	c7 05 f8 6f 00 80 50 	movl   $0x80102e50,0x80006ff8
80102f55:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f58:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f5f:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f62:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->id, V2P(code));
80102f67:	0f b6 03             	movzbl (%ebx),%eax
80102f6a:	83 ec 08             	sub    $0x8,%esp
80102f6d:	68 00 70 00 00       	push   $0x7000
80102f72:	50                   	push   %eax
80102f73:	e8 d8 f7 ff ff       	call   80102750 <lapicstartap>
80102f78:	83 c4 10             	add    $0x10,%esp
80102f7b:	90                   	nop
80102f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f80:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80102f86:	85 c0                	test   %eax,%eax
80102f88:	74 f6                	je     80102f80 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f8a:	69 05 c0 18 11 80 bc 	imul   $0xbc,0x801118c0,%eax
80102f91:	00 00 00 
80102f94:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
80102f9a:	05 e0 12 11 80       	add    $0x801112e0,%eax
80102f9f:	39 c3                	cmp    %eax,%ebx
80102fa1:	72 8d                	jb     80102f30 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fa3:	83 ec 08             	sub    $0x8,%esp
80102fa6:	68 00 00 00 8e       	push   $0x8e000000
80102fab:	68 00 00 40 80       	push   $0x80400000
80102fb0:	e8 5b f4 ff ff       	call   80102410 <kinit2>
  userinit();      // first user process
80102fb5:	e8 96 08 00 00       	call   80103850 <userinit>
  mpmain();        // finish this processor's setup
80102fba:	e8 51 fe ff ff       	call   80102e10 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80102fbf:	e8 ec 25 00 00       	call   801055b0 <timerinit>
80102fc4:	e9 30 ff ff ff       	jmp    80102ef9 <main+0x89>
80102fc9:	66 90                	xchg   %ax,%ax
80102fcb:	66 90                	xchg   %ax,%ax
80102fcd:	66 90                	xchg   %ax,%ax
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	73 48                	jae    8010302e <mpsearch1+0x5e>
80102fe6:	8d 76 00             	lea    0x0(%esi),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff0:	83 ec 04             	sub    $0x4,%esp
80102ff3:	8d 7e 10             	lea    0x10(%esi),%edi
80102ff6:	6a 04                	push   $0x4
80102ff8:	68 18 74 10 80       	push   $0x80107418
80102ffd:	56                   	push   %esi
80102ffe:	e8 ed 13 00 00       	call   801043f0 <memcmp>
80103003:	83 c4 10             	add    $0x10,%esp
80103006:	85 c0                	test   %eax,%eax
80103008:	75 1e                	jne    80103028 <mpsearch1+0x58>
8010300a:	8d 7e 10             	lea    0x10(%esi),%edi
8010300d:	89 f2                	mov    %esi,%edx
8010300f:	31 c9                	xor    %ecx,%ecx
80103011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103018:	0f b6 02             	movzbl (%edx),%eax
8010301b:	83 c2 01             	add    $0x1,%edx
8010301e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103020:	39 fa                	cmp    %edi,%edx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c9                	test   %cl,%cl
80103026:	74 10                	je     80103038 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103028:	39 fb                	cmp    %edi,%ebx
8010302a:	89 fe                	mov    %edi,%esi
8010302c:	77 c2                	ja     80102ff0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010302e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103031:	31 c0                	xor    %eax,%eax
}
80103033:	5b                   	pop    %ebx
80103034:	5e                   	pop    %esi
80103035:	5f                   	pop    %edi
80103036:	5d                   	pop    %ebp
80103037:	c3                   	ret    
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 c3                	mov    %eax,%ebx
8010309c:	0f 84 ae 01 00 00    	je     80103250 <mpinit+0x200>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a2:	8b 73 04             	mov    0x4(%ebx),%esi
801030a5:	85 f6                	test   %esi,%esi
801030a7:	0f 84 da 00 00 00    	je     80103187 <mpinit+0x137>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030ad:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801030b3:	83 ec 04             	sub    $0x4,%esp
801030b6:	6a 04                	push   $0x4
801030b8:	68 1d 74 10 80       	push   $0x8010741d
801030bd:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801030c1:	e8 2a 13 00 00       	call   801043f0 <memcmp>
801030c6:	83 c4 10             	add    $0x10,%esp
801030c9:	85 c0                	test   %eax,%eax
801030cb:	0f 85 b6 00 00 00    	jne    80103187 <mpinit+0x137>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030d1:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801030d8:	3c 01                	cmp    $0x1,%al
801030da:	74 08                	je     801030e4 <mpinit+0x94>
801030dc:	3c 04                	cmp    $0x4,%al
801030de:	0f 85 a3 00 00 00    	jne    80103187 <mpinit+0x137>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030e4:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030eb:	85 ff                	test   %edi,%edi
801030ed:	74 1e                	je     8010310d <mpinit+0xbd>
801030ef:	31 d2                	xor    %edx,%edx
801030f1:	31 c0                	xor    %eax,%eax
801030f3:	90                   	nop
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030f8:	0f b6 8c 06 00 00 00 	movzbl -0x80000000(%esi,%eax,1),%ecx
801030ff:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103100:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103103:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103105:	39 c7                	cmp    %eax,%edi
80103107:	75 ef                	jne    801030f8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103109:	84 d2                	test   %dl,%dl
8010310b:	75 7a                	jne    80103187 <mpinit+0x137>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010310d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103110:	85 c9                	test   %ecx,%ecx
80103112:	74 73                	je     80103187 <mpinit+0x137>
    return;
  ismp = 1;
80103114:	c7 05 c4 12 11 80 01 	movl   $0x1,0x801112c4
8010311b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010311e:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103124:	8d be 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edi
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010312a:	a3 dc 11 11 80       	mov    %eax,0x801111dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312f:	0f b7 b6 04 00 00 80 	movzwl -0x7ffffffc(%esi),%esi
80103136:	01 ce                	add    %ecx,%esi
80103138:	39 f7                	cmp    %esi,%edi
8010313a:	0f 83 e0 00 00 00    	jae    80103220 <mpinit+0x1d0>
    switch(*p){
80103140:	0f b6 07             	movzbl (%edi),%eax
80103143:	3c 04                	cmp    $0x4,%al
80103145:	0f 87 ad 00 00 00    	ja     801031f8 <mpinit+0x1a8>
8010314b:	ff 24 85 60 74 10 80 	jmp    *-0x7fef8ba0(,%eax,4)
80103152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103158:	83 c7 08             	add    $0x8,%edi

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010315b:	39 fe                	cmp    %edi,%esi
8010315d:	77 e1                	ja     80103140 <mpinit+0xf0>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
8010315f:	a1 c4 12 11 80       	mov    0x801112c4,%eax
80103164:	85 c0                	test   %eax,%eax
80103166:	0f 85 b4 00 00 00    	jne    80103220 <mpinit+0x1d0>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
8010316c:	c7 05 c0 18 11 80 01 	movl   $0x1,0x801118c0
80103173:	00 00 00 
    lapic = 0;
80103176:	c7 05 dc 11 11 80 00 	movl   $0x0,0x801111dc
8010317d:	00 00 00 
    ioapicid = 0;
80103180:	c6 05 c0 12 11 80 00 	movb   $0x0,0x801112c0
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103187:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010318a:	5b                   	pop    %ebx
8010318b:	5e                   	pop    %esi
8010318c:	5f                   	pop    %edi
8010318d:	5d                   	pop    %ebp
8010318e:	c3                   	ret    
8010318f:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid){
80103190:	0f b6 57 01          	movzbl 0x1(%edi),%edx
80103194:	a1 c0 18 11 80       	mov    0x801118c0,%eax
80103199:	39 c2                	cmp    %eax,%edx
8010319b:	74 21                	je     801031be <mpinit+0x16e>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
8010319d:	83 ec 04             	sub    $0x4,%esp
801031a0:	52                   	push   %edx
801031a1:	50                   	push   %eax
801031a2:	68 22 74 10 80       	push   $0x80107422
801031a7:	e8 94 d4 ff ff       	call   80100640 <cprintf>
801031ac:	a1 c0 18 11 80       	mov    0x801118c0,%eax
        ismp = 0;
801031b1:	c7 05 c4 12 11 80 00 	movl   $0x0,0x801112c4
801031b8:	00 00 00 
801031bb:	83 c4 10             	add    $0x10,%esp
      }
      cpus[ncpu].id = ncpu;
801031be:	69 d0 bc 00 00 00    	imul   $0xbc,%eax,%edx
      ncpu++;
      p += sizeof(struct mpproc);
801031c4:	83 c7 14             	add    $0x14,%edi
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid){
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
        ismp = 0;
      }
      cpus[ncpu].id = ncpu;
801031c7:	88 82 e0 12 11 80    	mov    %al,-0x7feeed20(%edx)
      ncpu++;
801031cd:	83 c0 01             	add    $0x1,%eax
801031d0:	a3 c0 18 11 80       	mov    %eax,0x801118c0
      p += sizeof(struct mpproc);
      continue;
801031d5:	eb 84                	jmp    8010315b <mpinit+0x10b>
801031d7:	89 f6                	mov    %esi,%esi
801031d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031e0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
      p += sizeof(struct mpioapic);
801031e4:	83 c7 08             	add    $0x8,%edi
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031e7:	a2 c0 12 11 80       	mov    %al,0x801112c0
      p += sizeof(struct mpioapic);
      continue;
801031ec:	e9 6a ff ff ff       	jmp    8010315b <mpinit+0x10b>
801031f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
801031f8:	83 ec 08             	sub    $0x8,%esp
801031fb:	50                   	push   %eax
801031fc:	68 40 74 10 80       	push   $0x80107440
80103201:	e8 3a d4 ff ff       	call   80100640 <cprintf>
      ismp = 0;
80103206:	c7 05 c4 12 11 80 00 	movl   $0x0,0x801112c4
8010320d:	00 00 00 
80103210:	83 c4 10             	add    $0x10,%esp
80103213:	e9 43 ff ff ff       	jmp    8010315b <mpinit+0x10b>
80103218:	90                   	nop
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
80103220:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103224:	0f 84 5d ff ff ff    	je     80103187 <mpinit+0x137>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010322a:	ba 22 00 00 00       	mov    $0x22,%edx
8010322f:	b8 70 00 00 00       	mov    $0x70,%eax
80103234:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103235:	ba 23 00 00 00       	mov    $0x23,%edx
8010323a:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010323b:	83 c8 01             	or     $0x1,%eax
8010323e:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010323f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103242:	5b                   	pop    %ebx
80103243:	5e                   	pop    %esi
80103244:	5f                   	pop    %edi
80103245:	5d                   	pop    %ebp
80103246:	c3                   	ret    
80103247:	89 f6                	mov    %esi,%esi
80103249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103250:	ba 00 00 01 00       	mov    $0x10000,%edx
80103255:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010325a:	e8 71 fd ff ff       	call   80102fd0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010325f:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103261:	89 c3                	mov    %eax,%ebx
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103263:	0f 85 39 fe ff ff    	jne    801030a2 <mpinit+0x52>
80103269:	e9 19 ff ff ff       	jmp    80103187 <mpinit+0x137>
8010326e:	66 90                	xchg   %ax,%ax

80103270 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103270:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103271:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103276:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010327b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010327d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103280:	d3 c0                	rol    %cl,%eax
80103282:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103289:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010328f:	ee                   	out    %al,(%dx)
80103290:	ba a1 00 00 00       	mov    $0xa1,%edx
80103295:	66 c1 e8 08          	shr    $0x8,%ax
80103299:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010329a:	5d                   	pop    %ebp
8010329b:	c3                   	ret    
8010329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032a0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801032a0:	55                   	push   %ebp
801032a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032a6:	89 e5                	mov    %esp,%ebp
801032a8:	57                   	push   %edi
801032a9:	56                   	push   %esi
801032aa:	53                   	push   %ebx
801032ab:	bb 21 00 00 00       	mov    $0x21,%ebx
801032b0:	89 da                	mov    %ebx,%edx
801032b2:	ee                   	out    %al,(%dx)
801032b3:	b9 a1 00 00 00       	mov    $0xa1,%ecx
801032b8:	89 ca                	mov    %ecx,%edx
801032ba:	ee                   	out    %al,(%dx)
801032bb:	bf 11 00 00 00       	mov    $0x11,%edi
801032c0:	be 20 00 00 00       	mov    $0x20,%esi
801032c5:	89 f8                	mov    %edi,%eax
801032c7:	89 f2                	mov    %esi,%edx
801032c9:	ee                   	out    %al,(%dx)
801032ca:	b8 20 00 00 00       	mov    $0x20,%eax
801032cf:	89 da                	mov    %ebx,%edx
801032d1:	ee                   	out    %al,(%dx)
801032d2:	b8 04 00 00 00       	mov    $0x4,%eax
801032d7:	ee                   	out    %al,(%dx)
801032d8:	b8 03 00 00 00       	mov    $0x3,%eax
801032dd:	ee                   	out    %al,(%dx)
801032de:	bb a0 00 00 00       	mov    $0xa0,%ebx
801032e3:	89 f8                	mov    %edi,%eax
801032e5:	89 da                	mov    %ebx,%edx
801032e7:	ee                   	out    %al,(%dx)
801032e8:	b8 28 00 00 00       	mov    $0x28,%eax
801032ed:	89 ca                	mov    %ecx,%edx
801032ef:	ee                   	out    %al,(%dx)
801032f0:	b8 02 00 00 00       	mov    $0x2,%eax
801032f5:	ee                   	out    %al,(%dx)
801032f6:	b8 03 00 00 00       	mov    $0x3,%eax
801032fb:	ee                   	out    %al,(%dx)
801032fc:	bf 68 00 00 00       	mov    $0x68,%edi
80103301:	89 f2                	mov    %esi,%edx
80103303:	89 f8                	mov    %edi,%eax
80103305:	ee                   	out    %al,(%dx)
80103306:	b9 0a 00 00 00       	mov    $0xa,%ecx
8010330b:	89 c8                	mov    %ecx,%eax
8010330d:	ee                   	out    %al,(%dx)
8010330e:	89 f8                	mov    %edi,%eax
80103310:	89 da                	mov    %ebx,%edx
80103312:	ee                   	out    %al,(%dx)
80103313:	89 c8                	mov    %ecx,%eax
80103315:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103316:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
8010331d:	66 83 f8 ff          	cmp    $0xffff,%ax
80103321:	74 10                	je     80103333 <picinit+0x93>
80103323:	ba 21 00 00 00       	mov    $0x21,%edx
80103328:	ee                   	out    %al,(%dx)
80103329:	ba a1 00 00 00       	mov    $0xa1,%edx
8010332e:	66 c1 e8 08          	shr    $0x8,%ax
80103332:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
80103333:	5b                   	pop    %ebx
80103334:	5e                   	pop    %esi
80103335:	5f                   	pop    %edi
80103336:	5d                   	pop    %ebp
80103337:	c3                   	ret    
80103338:	66 90                	xchg   %ax,%ax
8010333a:	66 90                	xchg   %ax,%ax
8010333c:	66 90                	xchg   %ax,%ax
8010333e:	66 90                	xchg   %ax,%ax

80103340 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	57                   	push   %edi
80103344:	56                   	push   %esi
80103345:	53                   	push   %ebx
80103346:	83 ec 0c             	sub    $0xc,%esp
80103349:	8b 75 08             	mov    0x8(%ebp),%esi
8010334c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010334f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103355:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010335b:	e8 e0 d9 ff ff       	call   80100d40 <filealloc>
80103360:	85 c0                	test   %eax,%eax
80103362:	89 06                	mov    %eax,(%esi)
80103364:	0f 84 a8 00 00 00    	je     80103412 <pipealloc+0xd2>
8010336a:	e8 d1 d9 ff ff       	call   80100d40 <filealloc>
8010336f:	85 c0                	test   %eax,%eax
80103371:	89 03                	mov    %eax,(%ebx)
80103373:	0f 84 87 00 00 00    	je     80103400 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103379:	e8 f2 f0 ff ff       	call   80102470 <kalloc>
8010337e:	85 c0                	test   %eax,%eax
80103380:	89 c7                	mov    %eax,%edi
80103382:	0f 84 b0 00 00 00    	je     80103438 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103388:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010338b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103392:	00 00 00 
  p->writeopen = 1;
80103395:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010339c:	00 00 00 
  p->nwrite = 0;
8010339f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033a6:	00 00 00 
  p->nread = 0;
801033a9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033b0:	00 00 00 
  initlock(&p->lock, "pipe");
801033b3:	68 74 74 10 80       	push   $0x80107474
801033b8:	50                   	push   %eax
801033b9:	e8 92 0d 00 00       	call   80104150 <initlock>
  (*f0)->type = FD_PIPE;
801033be:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033c0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801033c3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033c9:	8b 06                	mov    (%esi),%eax
801033cb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033cf:	8b 06                	mov    (%esi),%eax
801033d1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033d5:	8b 06                	mov    (%esi),%eax
801033d7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033da:	8b 03                	mov    (%ebx),%eax
801033dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033e2:	8b 03                	mov    (%ebx),%eax
801033e4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033e8:	8b 03                	mov    (%ebx),%eax
801033ea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033ee:	8b 03                	mov    (%ebx),%eax
801033f0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033f6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033f8:	5b                   	pop    %ebx
801033f9:	5e                   	pop    %esi
801033fa:	5f                   	pop    %edi
801033fb:	5d                   	pop    %ebp
801033fc:	c3                   	ret    
801033fd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103400:	8b 06                	mov    (%esi),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 1e                	je     80103424 <pipealloc+0xe4>
    fileclose(*f0);
80103406:	83 ec 0c             	sub    $0xc,%esp
80103409:	50                   	push   %eax
8010340a:	e8 f1 d9 ff ff       	call   80100e00 <fileclose>
8010340f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103412:	8b 03                	mov    (%ebx),%eax
80103414:	85 c0                	test   %eax,%eax
80103416:	74 0c                	je     80103424 <pipealloc+0xe4>
    fileclose(*f1);
80103418:	83 ec 0c             	sub    $0xc,%esp
8010341b:	50                   	push   %eax
8010341c:	e8 df d9 ff ff       	call   80100e00 <fileclose>
80103421:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103424:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103427:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010342c:	5b                   	pop    %ebx
8010342d:	5e                   	pop    %esi
8010342e:	5f                   	pop    %edi
8010342f:	5d                   	pop    %ebp
80103430:	c3                   	ret    
80103431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103438:	8b 06                	mov    (%esi),%eax
8010343a:	85 c0                	test   %eax,%eax
8010343c:	75 c8                	jne    80103406 <pipealloc+0xc6>
8010343e:	eb d2                	jmp    80103412 <pipealloc+0xd2>

80103440 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103440:	55                   	push   %ebp
80103441:	89 e5                	mov    %esp,%ebp
80103443:	56                   	push   %esi
80103444:	53                   	push   %ebx
80103445:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103448:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010344b:	83 ec 0c             	sub    $0xc,%esp
8010344e:	53                   	push   %ebx
8010344f:	e8 1c 0d 00 00       	call   80104170 <acquire>
  if(writable){
80103454:	83 c4 10             	add    $0x10,%esp
80103457:	85 f6                	test   %esi,%esi
80103459:	74 45                	je     801034a0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010345b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103461:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103464:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010346b:	00 00 00 
    wakeup(&p->nread);
8010346e:	50                   	push   %eax
8010346f:	e8 0c 0b 00 00       	call   80103f80 <wakeup>
80103474:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103477:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010347d:	85 d2                	test   %edx,%edx
8010347f:	75 0a                	jne    8010348b <pipeclose+0x4b>
80103481:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103487:	85 c0                	test   %eax,%eax
80103489:	74 35                	je     801034c0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010348b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010348e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103491:	5b                   	pop    %ebx
80103492:	5e                   	pop    %esi
80103493:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103494:	e9 b7 0e 00 00       	jmp    80104350 <release>
80103499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
801034a0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801034a6:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801034a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034b0:	00 00 00 
    wakeup(&p->nwrite);
801034b3:	50                   	push   %eax
801034b4:	e8 c7 0a 00 00       	call   80103f80 <wakeup>
801034b9:	83 c4 10             	add    $0x10,%esp
801034bc:	eb b9                	jmp    80103477 <pipeclose+0x37>
801034be:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801034c0:	83 ec 0c             	sub    $0xc,%esp
801034c3:	53                   	push   %ebx
801034c4:	e8 87 0e 00 00       	call   80104350 <release>
    kfree((char*)p);
801034c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034cc:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801034cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034d2:	5b                   	pop    %ebx
801034d3:	5e                   	pop    %esi
801034d4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801034d5:	e9 e6 ed ff ff       	jmp    801022c0 <kfree>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034e0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	57                   	push   %edi
801034e4:	56                   	push   %esi
801034e5:	53                   	push   %ebx
801034e6:	83 ec 28             	sub    $0x28,%esp
801034e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
801034ec:	57                   	push   %edi
801034ed:	e8 7e 0c 00 00       	call   80104170 <acquire>
  for(i = 0; i < n; i++){
801034f2:	8b 45 10             	mov    0x10(%ebp),%eax
801034f5:	83 c4 10             	add    $0x10,%esp
801034f8:	85 c0                	test   %eax,%eax
801034fa:	0f 8e c6 00 00 00    	jle    801035c6 <pipewrite+0xe6>
80103500:	8b 45 0c             	mov    0xc(%ebp),%eax
80103503:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103509:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010350f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103515:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103518:	03 45 10             	add    0x10(%ebp),%eax
8010351b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010351e:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
80103524:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010352a:	39 d1                	cmp    %edx,%ecx
8010352c:	0f 85 cf 00 00 00    	jne    80103601 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
80103532:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
80103538:	85 d2                	test   %edx,%edx
8010353a:	0f 84 a8 00 00 00    	je     801035e8 <pipewrite+0x108>
80103540:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103547:	8b 42 24             	mov    0x24(%edx),%eax
8010354a:	85 c0                	test   %eax,%eax
8010354c:	74 25                	je     80103573 <pipewrite+0x93>
8010354e:	e9 95 00 00 00       	jmp    801035e8 <pipewrite+0x108>
80103553:	90                   	nop
80103554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103558:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010355e:	85 c0                	test   %eax,%eax
80103560:	0f 84 82 00 00 00    	je     801035e8 <pipewrite+0x108>
80103566:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010356c:	8b 40 24             	mov    0x24(%eax),%eax
8010356f:	85 c0                	test   %eax,%eax
80103571:	75 75                	jne    801035e8 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103573:	83 ec 0c             	sub    $0xc,%esp
80103576:	56                   	push   %esi
80103577:	e8 04 0a 00 00       	call   80103f80 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010357c:	59                   	pop    %ecx
8010357d:	58                   	pop    %eax
8010357e:	57                   	push   %edi
8010357f:	53                   	push   %ebx
80103580:	e8 4b 08 00 00       	call   80103dd0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103585:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010358b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103591:	83 c4 10             	add    $0x10,%esp
80103594:	05 00 02 00 00       	add    $0x200,%eax
80103599:	39 c2                	cmp    %eax,%edx
8010359b:	74 bb                	je     80103558 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010359d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801035a0:	8d 4a 01             	lea    0x1(%edx),%ecx
801035a3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801035a7:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801035ad:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
801035b3:	0f b6 00             	movzbl (%eax),%eax
801035b6:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
801035ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801035bd:	3b 45 e0             	cmp    -0x20(%ebp),%eax
801035c0:	0f 85 58 ff ff ff    	jne    8010351e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035c6:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
801035cc:	83 ec 0c             	sub    $0xc,%esp
801035cf:	52                   	push   %edx
801035d0:	e8 ab 09 00 00       	call   80103f80 <wakeup>
  release(&p->lock);
801035d5:	89 3c 24             	mov    %edi,(%esp)
801035d8:	e8 73 0d 00 00       	call   80104350 <release>
  return n;
801035dd:	83 c4 10             	add    $0x10,%esp
801035e0:	8b 45 10             	mov    0x10(%ebp),%eax
801035e3:	eb 14                	jmp    801035f9 <pipewrite+0x119>
801035e5:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
801035e8:	83 ec 0c             	sub    $0xc,%esp
801035eb:	57                   	push   %edi
801035ec:	e8 5f 0d 00 00       	call   80104350 <release>
        return -1;
801035f1:	83 c4 10             	add    $0x10,%esp
801035f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801035f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035fc:	5b                   	pop    %ebx
801035fd:	5e                   	pop    %esi
801035fe:	5f                   	pop    %edi
801035ff:	5d                   	pop    %ebp
80103600:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103601:	89 ca                	mov    %ecx,%edx
80103603:	eb 98                	jmp    8010359d <pipewrite+0xbd>
80103605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103610 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	57                   	push   %edi
80103614:	56                   	push   %esi
80103615:	53                   	push   %ebx
80103616:	83 ec 18             	sub    $0x18,%esp
80103619:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010361c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010361f:	53                   	push   %ebx
80103620:	e8 4b 0b 00 00       	call   80104170 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103625:	83 c4 10             	add    $0x10,%esp
80103628:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010362e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103634:	75 6a                	jne    801036a0 <piperead+0x90>
80103636:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010363c:	85 f6                	test   %esi,%esi
8010363e:	0f 84 cc 00 00 00    	je     80103710 <piperead+0x100>
80103644:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010364a:	eb 2d                	jmp    80103679 <piperead+0x69>
8010364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103650:	83 ec 08             	sub    $0x8,%esp
80103653:	53                   	push   %ebx
80103654:	56                   	push   %esi
80103655:	e8 76 07 00 00       	call   80103dd0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010365a:	83 c4 10             	add    $0x10,%esp
8010365d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103663:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103669:	75 35                	jne    801036a0 <piperead+0x90>
8010366b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103671:	85 d2                	test   %edx,%edx
80103673:	0f 84 97 00 00 00    	je     80103710 <piperead+0x100>
    if(proc->killed){
80103679:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103680:	8b 4a 24             	mov    0x24(%edx),%ecx
80103683:	85 c9                	test   %ecx,%ecx
80103685:	74 c9                	je     80103650 <piperead+0x40>
      release(&p->lock);
80103687:	83 ec 0c             	sub    $0xc,%esp
8010368a:	53                   	push   %ebx
8010368b:	e8 c0 0c 00 00       	call   80104350 <release>
      return -1;
80103690:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103693:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
80103696:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010369b:	5b                   	pop    %ebx
8010369c:	5e                   	pop    %esi
8010369d:	5f                   	pop    %edi
8010369e:	5d                   	pop    %ebp
8010369f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036a0:	8b 45 10             	mov    0x10(%ebp),%eax
801036a3:	85 c0                	test   %eax,%eax
801036a5:	7e 69                	jle    80103710 <piperead+0x100>
    if(p->nread == p->nwrite)
801036a7:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801036ad:	31 c9                	xor    %ecx,%ecx
801036af:	eb 15                	jmp    801036c6 <piperead+0xb6>
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036b8:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801036be:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
801036c4:	74 5a                	je     80103720 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036c6:	8d 72 01             	lea    0x1(%edx),%esi
801036c9:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036cf:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801036d5:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
801036da:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036dd:	83 c1 01             	add    $0x1,%ecx
801036e0:	39 4d 10             	cmp    %ecx,0x10(%ebp)
801036e3:	75 d3                	jne    801036b8 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801036e5:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
801036eb:	83 ec 0c             	sub    $0xc,%esp
801036ee:	52                   	push   %edx
801036ef:	e8 8c 08 00 00       	call   80103f80 <wakeup>
  release(&p->lock);
801036f4:	89 1c 24             	mov    %ebx,(%esp)
801036f7:	e8 54 0c 00 00       	call   80104350 <release>
  return i;
801036fc:	8b 45 10             	mov    0x10(%ebp),%eax
801036ff:	83 c4 10             	add    $0x10,%esp
}
80103702:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103705:	5b                   	pop    %ebx
80103706:	5e                   	pop    %esi
80103707:	5f                   	pop    %edi
80103708:	5d                   	pop    %ebp
80103709:	c3                   	ret    
8010370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103710:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103717:	eb cc                	jmp    801036e5 <piperead+0xd5>
80103719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103720:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103723:	eb c0                	jmp    801036e5 <piperead+0xd5>
80103725:	66 90                	xchg   %ax,%ax
80103727:	66 90                	xchg   %ax,%ax
80103729:	66 90                	xchg   %ax,%ax
8010372b:	66 90                	xchg   %ax,%ax
8010372d:	66 90                	xchg   %ax,%ax
8010372f:	90                   	nop

80103730 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103734:	bb 14 19 11 80       	mov    $0x80111914,%ebx
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103739:	83 ec 04             	sub    $0x4,%esp
8010373c:	eb 10                	jmp    8010374e <allocproc+0x1e>
8010373e:	66 90                	xchg   %ax,%ax
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103740:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103746:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
8010374c:	74 7a                	je     801037c8 <allocproc+0x98>
    if(p->state == UNUSED)
8010374e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103751:	85 c0                	test   %eax,%eax
80103753:	75 eb                	jne    80103740 <allocproc+0x10>
      goto found;
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103755:	a1 08 a0 10 80       	mov    0x8010a008,%eax
    if(p->state == UNUSED)
      goto found;
  return 0;

found:
  p->state = EMBRYO;
8010375a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103761:	8d 50 01             	lea    0x1(%eax),%edx
80103764:	89 43 10             	mov    %eax,0x10(%ebx)
80103767:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010376d:	e8 fe ec ff ff       	call   80102470 <kalloc>
80103772:	85 c0                	test   %eax,%eax
80103774:	89 43 08             	mov    %eax,0x8(%ebx)
80103777:	74 56                	je     801037cf <allocproc+0x9f>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103779:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010377f:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103782:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103787:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010378a:	c7 40 14 fe 55 10 80 	movl   $0x801055fe,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103791:	6a 14                	push   $0x14
80103793:	6a 00                	push   $0x0
80103795:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103796:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103799:	e8 02 0c 00 00       	call   801043a0 <memset>
  p->context->eip = (uint)forkret;
8010379e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  // Set new variables for process (Lab3)
  p->priority = 1; //1 - highest; 0 - lowest
  p->timecpu = 0; //only counts to 2. 2 = bump down priority

  return p;
801037a1:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
801037a4:	c7 40 10 e0 37 10 80 	movl   $0x801037e0,0x10(%eax)

  // Set new variables for process (Lab3)
  p->priority = 1; //1 - highest; 0 - lowest
801037ab:	c7 43 7c 01 00 00 00 	movl   $0x1,0x7c(%ebx)
  p->timecpu = 0; //only counts to 2. 2 = bump down priority

  return p;
801037b2:	89 d8                	mov    %ebx,%eax
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  // Set new variables for process (Lab3)
  p->priority = 1; //1 - highest; 0 - lowest
  p->timecpu = 0; //only counts to 2. 2 = bump down priority
801037b4:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801037bb:	00 00 00 

  return p;
}
801037be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037c1:	c9                   	leave  
801037c2:	c3                   	ret    
801037c3:	90                   	nop
801037c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  return 0;
801037c8:	31 c0                	xor    %eax,%eax
  // Set new variables for process (Lab3)
  p->priority = 1; //1 - highest; 0 - lowest
  p->timecpu = 0; //only counts to 2. 2 = bump down priority

  return p;
}
801037ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037cd:	c9                   	leave  
801037ce:	c3                   	ret    
  p->state = EMBRYO;
  p->pid = nextpid++;

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801037cf:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037d6:	eb e6                	jmp    801037be <allocproc+0x8e>
801037d8:	90                   	nop
801037d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037e6:	68 e0 18 11 80       	push   $0x801118e0
801037eb:	e8 60 0b 00 00       	call   80104350 <release>

  if (first) {
801037f0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801037f5:	83 c4 10             	add    $0x10,%esp
801037f8:	85 c0                	test   %eax,%eax
801037fa:	75 04                	jne    80103800 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037fc:	c9                   	leave  
801037fd:	c3                   	ret    
801037fe:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103800:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103803:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
8010380a:	00 00 00 
    iinit(ROOTDEV);
8010380d:	6a 01                	push   $0x1
8010380f:	e8 1c dc ff ff       	call   80101430 <iinit>
    initlog(ROOTDEV);
80103814:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010381b:	e8 a0 f2 ff ff       	call   80102ac0 <initlog>
80103820:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103823:	c9                   	leave  
80103824:	c3                   	ret    
80103825:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103830 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103836:	68 79 74 10 80       	push   $0x80107479
8010383b:	68 e0 18 11 80       	push   $0x801118e0
80103840:	e8 0b 09 00 00       	call   80104150 <initlock>
}
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	c9                   	leave  
80103849:	c3                   	ret    
8010384a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103850 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	53                   	push   %ebx
80103854:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  acquire(&ptable.lock);
80103857:	68 e0 18 11 80       	push   $0x801118e0
8010385c:	e8 0f 09 00 00       	call   80104170 <acquire>

  p = allocproc();
80103861:	e8 ca fe ff ff       	call   80103730 <allocproc>
80103866:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103868:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
8010386d:	e8 4e 30 00 00       	call   801068c0 <setupkvm>
80103872:	83 c4 10             	add    $0x10,%esp
80103875:	85 c0                	test   %eax,%eax
80103877:	89 43 04             	mov    %eax,0x4(%ebx)
8010387a:	0f 84 b1 00 00 00    	je     80103931 <userinit+0xe1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103880:	83 ec 04             	sub    $0x4,%esp
80103883:	68 2c 00 00 00       	push   $0x2c
80103888:	68 60 a4 10 80       	push   $0x8010a460
8010388d:	50                   	push   %eax
8010388e:	e8 7d 31 00 00       	call   80106a10 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103893:	83 c4 0c             	add    $0xc,%esp
  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103896:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010389c:	6a 4c                	push   $0x4c
8010389e:	6a 00                	push   $0x0
801038a0:	ff 73 18             	pushl  0x18(%ebx)
801038a3:	e8 f8 0a 00 00       	call   801043a0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038a8:	8b 43 18             	mov    0x18(%ebx),%eax
801038ab:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038b0:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038b5:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038b8:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038bc:	8b 43 18             	mov    0x18(%ebx),%eax
801038bf:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038c3:	8b 43 18             	mov    0x18(%ebx),%eax
801038c6:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038ca:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038ce:	8b 43 18             	mov    0x18(%ebx),%eax
801038d1:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038d5:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038d9:	8b 43 18             	mov    0x18(%ebx),%eax
801038dc:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038e3:	8b 43 18             	mov    0x18(%ebx),%eax
801038e6:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038ed:	8b 43 18             	mov    0x18(%ebx),%eax
801038f0:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038f7:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038fa:	6a 10                	push   $0x10
801038fc:	68 99 74 10 80       	push   $0x80107499
80103901:	50                   	push   %eax
80103902:	e8 99 0c 00 00       	call   801045a0 <safestrcpy>
  p->cwd = namei("/");
80103907:	c7 04 24 a2 74 10 80 	movl   $0x801074a2,(%esp)
8010390e:	e8 7d e5 ff ff       	call   80101e90 <namei>

  p->state = RUNNABLE;
80103913:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
8010391a:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;

  release(&ptable.lock);
8010391d:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103924:	e8 27 0a 00 00       	call   80104350 <release>
}
80103929:	83 c4 10             	add    $0x10,%esp
8010392c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010392f:	c9                   	leave  
80103930:	c3                   	ret    
  acquire(&ptable.lock);

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103931:	83 ec 0c             	sub    $0xc,%esp
80103934:	68 80 74 10 80       	push   $0x80107480
80103939:	e8 12 ca ff ff       	call   80100350 <panic>
8010393e:	66 90                	xchg   %ax,%ax

80103940 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 08             	sub    $0x8,%esp
  uint sz;

  sz = proc->sz;
80103946:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010394d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80103950:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103952:	83 f9 00             	cmp    $0x0,%ecx
80103955:	7e 39                	jle    80103990 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103957:	83 ec 04             	sub    $0x4,%esp
8010395a:	01 c1                	add    %eax,%ecx
8010395c:	51                   	push   %ecx
8010395d:	50                   	push   %eax
8010395e:	ff 72 04             	pushl  0x4(%edx)
80103961:	e8 ea 31 00 00       	call   80106b50 <allocuvm>
80103966:	83 c4 10             	add    $0x10,%esp
80103969:	85 c0                	test   %eax,%eax
8010396b:	74 3b                	je     801039a8 <growproc+0x68>
8010396d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80103974:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103976:	83 ec 0c             	sub    $0xc,%esp
80103979:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103980:	e8 eb 2f 00 00       	call   80106970 <switchuvm>
  return 0;
80103985:	83 c4 10             	add    $0x10,%esp
80103988:	31 c0                	xor    %eax,%eax
}
8010398a:	c9                   	leave  
8010398b:	c3                   	ret    
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103990:	74 e2                	je     80103974 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103992:	83 ec 04             	sub    $0x4,%esp
80103995:	01 c1                	add    %eax,%ecx
80103997:	51                   	push   %ecx
80103998:	50                   	push   %eax
80103999:	ff 72 04             	pushl  0x4(%edx)
8010399c:	e8 af 32 00 00       	call   80106c50 <deallocuvm>
801039a1:	83 c4 10             	add    $0x10,%esp
801039a4:	85 c0                	test   %eax,%eax
801039a6:	75 c5                	jne    8010396d <growproc+0x2d>
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
801039a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
801039ad:	c9                   	leave  
801039ae:	c3                   	ret    
801039af:	90                   	nop

801039b0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 18             	sub    $0x18,%esp
  int i, pid;
  struct proc *np;

  acquire(&ptable.lock);
801039b9:	68 e0 18 11 80       	push   $0x801118e0
801039be:	e8 ad 07 00 00       	call   80104170 <acquire>

  // Allocate process.
  if((np = allocproc()) == 0){
801039c3:	e8 68 fd ff ff       	call   80103730 <allocproc>
801039c8:	83 c4 10             	add    $0x10,%esp
801039cb:	85 c0                	test   %eax,%eax
801039cd:	0f 84 cd 00 00 00    	je     80103aa0 <fork+0xf0>
801039d3:	89 c3                	mov    %eax,%ebx
    release(&ptable.lock);
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801039d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801039db:	83 ec 08             	sub    $0x8,%esp
801039de:	ff 30                	pushl  (%eax)
801039e0:	ff 70 04             	pushl  0x4(%eax)
801039e3:	e8 48 33 00 00       	call   80106d30 <copyuvm>
801039e8:	83 c4 10             	add    $0x10,%esp
801039eb:	85 c0                	test   %eax,%eax
801039ed:	89 43 04             	mov    %eax,0x4(%ebx)
801039f0:	0f 84 c1 00 00 00    	je     80103ab7 <fork+0x107>
    np->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }
  np->sz = proc->sz;
801039f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
801039fc:	8b 7b 18             	mov    0x18(%ebx),%edi
801039ff:	b9 13 00 00 00       	mov    $0x13,%ecx
    np->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }
  np->sz = proc->sz;
80103a04:	8b 00                	mov    (%eax),%eax
80103a06:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a08:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a0e:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103a11:	8b 70 18             	mov    0x18(%eax),%esi
80103a14:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a16:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a18:	8b 43 18             	mov    0x18(%ebx),%eax
80103a1b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a22:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103a30:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103a34:	85 c0                	test   %eax,%eax
80103a36:	74 17                	je     80103a4f <fork+0x9f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103a38:	83 ec 0c             	sub    $0xc,%esp
80103a3b:	50                   	push   %eax
80103a3c:	e8 6f d3 ff ff       	call   80100db0 <filedup>
80103a41:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103a45:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a4c:	83 c4 10             	add    $0x10,%esp
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a4f:	83 c6 01             	add    $0x1,%esi
80103a52:	83 fe 10             	cmp    $0x10,%esi
80103a55:	75 d9                	jne    80103a30 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103a57:	83 ec 0c             	sub    $0xc,%esp
80103a5a:	ff 72 68             	pushl  0x68(%edx)
80103a5d:	e8 6e db ff ff       	call   801015d0 <idup>
80103a62:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103a65:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a6b:	83 c4 0c             	add    $0xc,%esp
80103a6e:	6a 10                	push   $0x10
80103a70:	83 c0 6c             	add    $0x6c,%eax
80103a73:	50                   	push   %eax
80103a74:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a77:	50                   	push   %eax
80103a78:	e8 23 0b 00 00       	call   801045a0 <safestrcpy>

  pid = np->pid;
80103a7d:	8b 73 10             	mov    0x10(%ebx),%esi

  np->state = RUNNABLE;
80103a80:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a87:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103a8e:	e8 bd 08 00 00       	call   80104350 <release>

  return pid;
80103a93:	83 c4 10             	add    $0x10,%esp
80103a96:	89 f0                	mov    %esi,%eax
}
80103a98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a9b:	5b                   	pop    %ebx
80103a9c:	5e                   	pop    %esi
80103a9d:	5f                   	pop    %edi
80103a9e:	5d                   	pop    %ebp
80103a9f:	c3                   	ret    

  acquire(&ptable.lock);

  // Allocate process.
  if((np = allocproc()) == 0){
    release(&ptable.lock);
80103aa0:	83 ec 0c             	sub    $0xc,%esp
80103aa3:	68 e0 18 11 80       	push   $0x801118e0
80103aa8:	e8 a3 08 00 00       	call   80104350 <release>
    return -1;
80103aad:	83 c4 10             	add    $0x10,%esp
80103ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ab5:	eb e1                	jmp    80103a98 <fork+0xe8>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
80103ab7:	83 ec 0c             	sub    $0xc,%esp
80103aba:	ff 73 08             	pushl  0x8(%ebx)
80103abd:	e8 fe e7 ff ff       	call   801022c0 <kfree>
    np->kstack = 0;
80103ac2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103ac9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    release(&ptable.lock);
80103ad0:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103ad7:	e8 74 08 00 00       	call   80104350 <release>
    return -1;
80103adc:	83 c4 10             	add    $0x10,%esp
80103adf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ae4:	eb b2                	jmp    80103a98 <fork+0xe8>
80103ae6:	8d 76 00             	lea    0x0(%esi),%esi
80103ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103af0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
80103af7:	89 f6                	mov    %esi,%esi
80103af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b00:	fb                   	sti    
    // Enable interrupts on this processor.
    sti();


    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b01:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b04:	bb 14 19 11 80       	mov    $0x80111914,%ebx
    // Enable interrupts on this processor.
    sti();


    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b09:	68 e0 18 11 80       	push   $0x801118e0
80103b0e:	e8 5d 06 00 00       	call   80104170 <acquire>
80103b13:	83 c4 10             	add    $0x10,%esp
80103b16:	eb 16                	jmp    80103b2e <scheduler+0x3e>
80103b18:	90                   	nop
80103b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b20:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103b26:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
80103b2c:	74 52                	je     80103b80 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103b2e:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b32:	75 ec                	jne    80103b20 <scheduler+0x30>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103b34:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103b37:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103b3e:	53                   	push   %ebx
    sti();


    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b3f:	81 c3 84 00 00 00    	add    $0x84,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103b45:	e8 26 2e 00 00       	call   80106970 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103b4a:	58                   	pop    %eax
80103b4b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b51:	c7 43 88 04 00 00 00 	movl   $0x4,-0x78(%ebx)
      swtch(&cpu->scheduler, p->context);
80103b58:	5a                   	pop    %edx
80103b59:	ff 73 98             	pushl  -0x68(%ebx)
80103b5c:	83 c0 04             	add    $0x4,%eax
80103b5f:	50                   	push   %eax
80103b60:	e8 96 0a 00 00       	call   801045fb <swtch>
      switchkvm();
80103b65:	e8 e6 2d 00 00       	call   80106950 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103b6a:	83 c4 10             	add    $0x10,%esp
    sti();


    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b6d:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
      swtch(&cpu->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103b73:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103b7a:	00 00 00 00 
    sti();


    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b7e:	75 ae                	jne    80103b2e <scheduler+0x3e>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80103b80:	83 ec 0c             	sub    $0xc,%esp
80103b83:	68 e0 18 11 80       	push   $0x801118e0
80103b88:	e8 c3 07 00 00       	call   80104350 <release>

  }
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	e9 6b ff ff ff       	jmp    80103b00 <scheduler+0x10>
80103b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ba0 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 10             	sub    $0x10,%esp
  int intena;

  if(!holding(&ptable.lock))
80103ba7:	68 e0 18 11 80       	push   $0x801118e0
80103bac:	e8 ef 06 00 00       	call   801042a0 <holding>
80103bb1:	83 c4 10             	add    $0x10,%esp
80103bb4:	85 c0                	test   %eax,%eax
80103bb6:	74 4c                	je     80103c04 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103bb8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103bbf:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103bc6:	75 63                	jne    80103c2b <sched+0x8b>
    panic("sched locks");
  if(proc->state == RUNNING)
80103bc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bce:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103bd2:	74 4a                	je     80103c1e <sched+0x7e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103bd4:	9c                   	pushf  
80103bd5:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103bd6:	80 e5 02             	and    $0x2,%ch
80103bd9:	75 36                	jne    80103c11 <sched+0x71>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
80103bdb:	83 ec 08             	sub    $0x8,%esp
80103bde:	83 c0 1c             	add    $0x1c,%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
80103be1:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103be7:	ff 72 04             	pushl  0x4(%edx)
80103bea:	50                   	push   %eax
80103beb:	e8 0b 0a 00 00       	call   801045fb <swtch>
  cpu->intena = intena;
80103bf0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103bf6:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
80103bf9:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103bff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c02:	c9                   	leave  
80103c03:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	68 a4 74 10 80       	push   $0x801074a4
80103c0c:	e8 3f c7 ff ff       	call   80100350 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c11:	83 ec 0c             	sub    $0xc,%esp
80103c14:	68 d0 74 10 80       	push   $0x801074d0
80103c19:	e8 32 c7 ff ff       	call   80100350 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
80103c1e:	83 ec 0c             	sub    $0xc,%esp
80103c21:	68 c2 74 10 80       	push   $0x801074c2
80103c26:	e8 25 c7 ff ff       	call   80100350 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103c2b:	83 ec 0c             	sub    $0xc,%esp
80103c2e:	68 b6 74 10 80       	push   $0x801074b6
80103c33:	e8 18 c7 ff ff       	call   80100350 <panic>
80103c38:	90                   	nop
80103c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c40 <exit>:
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c40:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c47:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c4d:	55                   	push   %ebp
80103c4e:	89 e5                	mov    %esp,%ebp
80103c50:	56                   	push   %esi
80103c51:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c52:	0f 84 29 01 00 00    	je     80103d81 <exit+0x141>
80103c58:	31 db                	xor    %ebx,%ebx
80103c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103c60:	8d 73 08             	lea    0x8(%ebx),%esi
80103c63:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103c67:	85 c0                	test   %eax,%eax
80103c69:	74 1b                	je     80103c86 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103c6b:	83 ec 0c             	sub    $0xc,%esp
80103c6e:	50                   	push   %eax
80103c6f:	e8 8c d1 ff ff       	call   80100e00 <fileclose>
      proc->ofile[fd] = 0;
80103c74:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c7b:	83 c4 10             	add    $0x10,%esp
80103c7e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103c85:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c86:	83 c3 01             	add    $0x1,%ebx
80103c89:	83 fb 10             	cmp    $0x10,%ebx
80103c8c:	75 d2                	jne    80103c60 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c8e:	e8 cd ee ff ff       	call   80102b60 <begin_op>
  iput(proc->cwd);
80103c93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c99:	83 ec 0c             	sub    $0xc,%esp
80103c9c:	ff 70 68             	pushl  0x68(%eax)
80103c9f:	e8 cc da ff ff       	call   80101770 <iput>
  end_op();
80103ca4:	e8 27 ef ff ff       	call   80102bd0 <end_op>
  proc->cwd = 0;
80103ca9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103caf:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103cb6:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103cbd:	e8 ae 04 00 00       	call   80104170 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103cc2:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103cc9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ccc:	b8 14 19 11 80       	mov    $0x80111914,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103cd1:	8b 51 14             	mov    0x14(%ecx),%edx
80103cd4:	eb 16                	jmp    80103cec <exit+0xac>
80103cd6:	8d 76 00             	lea    0x0(%esi),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ce0:	05 84 00 00 00       	add    $0x84,%eax
80103ce5:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103cea:	74 1e                	je     80103d0a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
80103cec:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cf0:	75 ee                	jne    80103ce0 <exit+0xa0>
80103cf2:	3b 50 20             	cmp    0x20(%eax),%edx
80103cf5:	75 e9                	jne    80103ce0 <exit+0xa0>
      p->state = RUNNABLE;
80103cf7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cfe:	05 84 00 00 00       	add    $0x84,%eax
80103d03:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103d08:	75 e2                	jne    80103cec <exit+0xac>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d0a:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103d10:	ba 14 19 11 80       	mov    $0x80111914,%edx
80103d15:	eb 17                	jmp    80103d2e <exit+0xee>
80103d17:	89 f6                	mov    %esi,%esi
80103d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d20:	81 c2 84 00 00 00    	add    $0x84,%edx
80103d26:	81 fa 14 3a 11 80    	cmp    $0x80113a14,%edx
80103d2c:	74 3a                	je     80103d68 <exit+0x128>
    if(p->parent == proc){
80103d2e:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103d31:	75 ed                	jne    80103d20 <exit+0xe0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103d33:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d37:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d3a:	75 e4                	jne    80103d20 <exit+0xe0>
80103d3c:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103d41:	eb 11                	jmp    80103d54 <exit+0x114>
80103d43:	90                   	nop
80103d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d48:	05 84 00 00 00       	add    $0x84,%eax
80103d4d:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103d52:	74 cc                	je     80103d20 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80103d54:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d58:	75 ee                	jne    80103d48 <exit+0x108>
80103d5a:	3b 58 20             	cmp    0x20(%eax),%ebx
80103d5d:	75 e9                	jne    80103d48 <exit+0x108>
      p->state = RUNNABLE;
80103d5f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d66:	eb e0                	jmp    80103d48 <exit+0x108>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103d68:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103d6f:	e8 2c fe ff ff       	call   80103ba0 <sched>
  panic("zombie exit");
80103d74:	83 ec 0c             	sub    $0xc,%esp
80103d77:	68 f1 74 10 80       	push   $0x801074f1
80103d7c:	e8 cf c5 ff ff       	call   80100350 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103d81:	83 ec 0c             	sub    $0xc,%esp
80103d84:	68 e4 74 10 80       	push   $0x801074e4
80103d89:	e8 c2 c5 ff ff       	call   80100350 <panic>
80103d8e:	66 90                	xchg   %ax,%ax

80103d90 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d96:	68 e0 18 11 80       	push   $0x801118e0
80103d9b:	e8 d0 03 00 00       	call   80104170 <acquire>
  proc->state = RUNNABLE;
80103da0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103da6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103dad:	e8 ee fd ff ff       	call   80103ba0 <sched>
  release(&ptable.lock);
80103db2:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103db9:	e8 92 05 00 00       	call   80104350 <release>
}
80103dbe:	83 c4 10             	add    $0x10,%esp
80103dc1:	c9                   	leave  
80103dc2:	c3                   	ret    
80103dc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dd0 <sleep>:
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
80103dd0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103dd6:	55                   	push   %ebp
80103dd7:	89 e5                	mov    %esp,%ebp
80103dd9:	56                   	push   %esi
80103dda:	53                   	push   %ebx
  if(proc == 0)
80103ddb:	85 c0                	test   %eax,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103ddd:	8b 75 08             	mov    0x8(%ebp),%esi
80103de0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103de3:	0f 84 97 00 00 00    	je     80103e80 <sleep+0xb0>
    panic("sleep");

  if(lk == 0)
80103de9:	85 db                	test   %ebx,%ebx
80103deb:	0f 84 82 00 00 00    	je     80103e73 <sleep+0xa3>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103df1:	81 fb e0 18 11 80    	cmp    $0x801118e0,%ebx
80103df7:	74 57                	je     80103e50 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103df9:	83 ec 0c             	sub    $0xc,%esp
80103dfc:	68 e0 18 11 80       	push   $0x801118e0
80103e01:	e8 6a 03 00 00       	call   80104170 <acquire>
    release(lk);
80103e06:	89 1c 24             	mov    %ebx,(%esp)
80103e09:	e8 42 05 00 00       	call   80104350 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103e0e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e14:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e17:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e1e:	e8 7d fd ff ff       	call   80103ba0 <sched>

  // Tidy up.
  proc->chan = 0;
80103e23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e29:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103e30:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103e37:	e8 14 05 00 00       	call   80104350 <release>
    acquire(lk);
80103e3c:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103e3f:	83 c4 10             	add    $0x10,%esp
  }
}
80103e42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e45:	5b                   	pop    %ebx
80103e46:	5e                   	pop    %esi
80103e47:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103e48:	e9 23 03 00 00       	jmp    80104170 <acquire>
80103e4d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103e50:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e53:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e5a:	e8 41 fd ff ff       	call   80103ba0 <sched>

  // Tidy up.
  proc->chan = 0;
80103e5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e65:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103e6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e6f:	5b                   	pop    %ebx
80103e70:	5e                   	pop    %esi
80103e71:	5d                   	pop    %ebp
80103e72:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103e73:	83 ec 0c             	sub    $0xc,%esp
80103e76:	68 03 75 10 80       	push   $0x80107503
80103e7b:	e8 d0 c4 ff ff       	call   80100350 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103e80:	83 ec 0c             	sub    $0xc,%esp
80103e83:	68 fd 74 10 80       	push   $0x801074fd
80103e88:	e8 c3 c4 ff ff       	call   80100350 <panic>
80103e8d:	8d 76 00             	lea    0x0(%esi),%esi

80103e90 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	56                   	push   %esi
80103e94:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103e95:	83 ec 0c             	sub    $0xc,%esp
80103e98:	68 e0 18 11 80       	push   $0x801118e0
80103e9d:	e8 ce 02 00 00       	call   80104170 <acquire>
80103ea2:	83 c4 10             	add    $0x10,%esp
80103ea5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80103eab:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ead:	bb 14 19 11 80       	mov    $0x80111914,%ebx
80103eb2:	eb 12                	jmp    80103ec6 <wait+0x36>
80103eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103eb8:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103ebe:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
80103ec4:	74 22                	je     80103ee8 <wait+0x58>
      if(p->parent != proc)
80103ec6:	3b 43 14             	cmp    0x14(%ebx),%eax
80103ec9:	75 ed                	jne    80103eb8 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103ecb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ecf:	74 35                	je     80103f06 <wait+0x76>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed1:	81 c3 84 00 00 00    	add    $0x84,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80103ed7:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103edc:	81 fb 14 3a 11 80    	cmp    $0x80113a14,%ebx
80103ee2:	75 e2                	jne    80103ec6 <wait+0x36>
80103ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103ee8:	85 d2                	test   %edx,%edx
80103eea:	74 70                	je     80103f5c <wait+0xcc>
80103eec:	8b 50 24             	mov    0x24(%eax),%edx
80103eef:	85 d2                	test   %edx,%edx
80103ef1:	75 69                	jne    80103f5c <wait+0xcc>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103ef3:	83 ec 08             	sub    $0x8,%esp
80103ef6:	68 e0 18 11 80       	push   $0x801118e0
80103efb:	50                   	push   %eax
80103efc:	e8 cf fe ff ff       	call   80103dd0 <sleep>
  }
80103f01:	83 c4 10             	add    $0x10,%esp
80103f04:	eb 9f                	jmp    80103ea5 <wait+0x15>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f06:	83 ec 0c             	sub    $0xc,%esp
80103f09:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f0c:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f0f:	e8 ac e3 ff ff       	call   801022c0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f14:	59                   	pop    %ecx
80103f15:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f18:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f1f:	e8 5c 2d 00 00       	call   80106c80 <freevm>
        p->pid = 0;
80103f24:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f2b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f32:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f36:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f3d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f44:	c7 04 24 e0 18 11 80 	movl   $0x801118e0,(%esp)
80103f4b:	e8 00 04 00 00       	call   80104350 <release>
        return pid;
80103f50:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f53:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103f56:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f58:	5b                   	pop    %ebx
80103f59:	5e                   	pop    %esi
80103f5a:	5d                   	pop    %ebp
80103f5b:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103f5c:	83 ec 0c             	sub    $0xc,%esp
80103f5f:	68 e0 18 11 80       	push   $0x801118e0
80103f64:	e8 e7 03 00 00       	call   80104350 <release>
      return -1;
80103f69:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
80103f6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f74:	5b                   	pop    %ebx
80103f75:	5e                   	pop    %esi
80103f76:	5d                   	pop    %ebp
80103f77:	c3                   	ret    
80103f78:	90                   	nop
80103f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f80 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	53                   	push   %ebx
80103f84:	83 ec 10             	sub    $0x10,%esp
80103f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f8a:	68 e0 18 11 80       	push   $0x801118e0
80103f8f:	e8 dc 01 00 00       	call   80104170 <acquire>
80103f94:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f97:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103f9c:	eb 0e                	jmp    80103fac <wakeup+0x2c>
80103f9e:	66 90                	xchg   %ax,%ax
80103fa0:	05 84 00 00 00       	add    $0x84,%eax
80103fa5:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103faa:	74 1e                	je     80103fca <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
80103fac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fb0:	75 ee                	jne    80103fa0 <wakeup+0x20>
80103fb2:	3b 58 20             	cmp    0x20(%eax),%ebx
80103fb5:	75 e9                	jne    80103fa0 <wakeup+0x20>
      p->state = RUNNABLE;
80103fb7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fbe:	05 84 00 00 00       	add    $0x84,%eax
80103fc3:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
80103fc8:	75 e2                	jne    80103fac <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fca:	c7 45 08 e0 18 11 80 	movl   $0x801118e0,0x8(%ebp)
}
80103fd1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fd4:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fd5:	e9 76 03 00 00       	jmp    80104350 <release>
80103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fe0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
80103fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103fea:	68 e0 18 11 80       	push   $0x801118e0
80103fef:	e8 7c 01 00 00       	call   80104170 <acquire>
80103ff4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff7:	b8 14 19 11 80       	mov    $0x80111914,%eax
80103ffc:	eb 0e                	jmp    8010400c <kill+0x2c>
80103ffe:	66 90                	xchg   %ax,%ax
80104000:	05 84 00 00 00       	add    $0x84,%eax
80104005:	3d 14 3a 11 80       	cmp    $0x80113a14,%eax
8010400a:	74 3c                	je     80104048 <kill+0x68>
    if(p->pid == pid){
8010400c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010400f:	75 ef                	jne    80104000 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104011:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104015:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010401c:	74 1a                	je     80104038 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010401e:	83 ec 0c             	sub    $0xc,%esp
80104021:	68 e0 18 11 80       	push   $0x801118e0
80104026:	e8 25 03 00 00       	call   80104350 <release>
      return 0;
8010402b:	83 c4 10             	add    $0x10,%esp
8010402e:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104033:	c9                   	leave  
80104034:	c3                   	ret    
80104035:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104038:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010403f:	eb dd                	jmp    8010401e <kill+0x3e>
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104048:	83 ec 0c             	sub    $0xc,%esp
8010404b:	68 e0 18 11 80       	push   $0x801118e0
80104050:	e8 fb 02 00 00       	call   80104350 <release>
  return -1;
80104055:	83 c4 10             	add    $0x10,%esp
80104058:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010405d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104060:	c9                   	leave  
80104061:	c3                   	ret    
80104062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104070 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) //used for displaying content to screen when testing for lab3****
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	57                   	push   %edi
80104074:	56                   	push   %esi
80104075:	53                   	push   %ebx
80104076:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104079:	bb 80 19 11 80       	mov    $0x80111980,%ebx
8010407e:	83 ec 3c             	sub    $0x3c,%esp
80104081:	eb 36                	jmp    801040b9 <procdump+0x49>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf(" PP= %d\n", p->priority);
80104088:	83 ec 08             	sub    $0x8,%esp
8010408b:	ff 73 10             	pushl  0x10(%ebx)
8010408e:	68 21 75 10 80       	push   $0x80107521
80104093:	e8 a8 c5 ff ff       	call   80100640 <cprintf>
    cprintf("\n");
80104098:	c7 04 24 16 74 10 80 	movl   $0x80107416,(%esp)
8010409f:	e8 9c c5 ff ff       	call   80100640 <cprintf>
801040a4:	83 c4 10             	add    $0x10,%esp
801040a7:	81 c3 84 00 00 00    	add    $0x84,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ad:	81 fb 80 3a 11 80    	cmp    $0x80113a80,%ebx
801040b3:	0f 84 87 00 00 00    	je     80104140 <procdump+0xd0>
    if(p->state == UNUSED)
801040b9:	8b 43 a0             	mov    -0x60(%ebx),%eax
801040bc:	85 c0                	test   %eax,%eax
801040be:	74 e7                	je     801040a7 <procdump+0x37>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040c0:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801040c3:	ba 14 75 10 80       	mov    $0x80107514,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040c8:	77 11                	ja     801040db <procdump+0x6b>
801040ca:	8b 14 85 54 75 10 80 	mov    -0x7fef8aac(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801040d1:	b8 14 75 10 80       	mov    $0x80107514,%eax
801040d6:	85 d2                	test   %edx,%edx
801040d8:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040db:	53                   	push   %ebx
801040dc:	52                   	push   %edx
801040dd:	ff 73 a4             	pushl  -0x5c(%ebx)
801040e0:	68 18 75 10 80       	push   $0x80107518
801040e5:	e8 56 c5 ff ff       	call   80100640 <cprintf>
    if(p->state == SLEEPING){
801040ea:	83 c4 10             	add    $0x10,%esp
801040ed:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801040f1:	75 95                	jne    80104088 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040f3:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040f6:	83 ec 08             	sub    $0x8,%esp
801040f9:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040fc:	50                   	push   %eax
801040fd:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104100:	8b 40 0c             	mov    0xc(%eax),%eax
80104103:	83 c0 08             	add    $0x8,%eax
80104106:	50                   	push   %eax
80104107:	e8 34 01 00 00       	call   80104240 <getcallerpcs>
8010410c:	83 c4 10             	add    $0x10,%esp
8010410f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104110:	8b 17                	mov    (%edi),%edx
80104112:	85 d2                	test   %edx,%edx
80104114:	0f 84 6e ff ff ff    	je     80104088 <procdump+0x18>
        cprintf(" %p", pc[i]);
8010411a:	83 ec 08             	sub    $0x8,%esp
8010411d:	83 c7 04             	add    $0x4,%edi
80104120:	52                   	push   %edx
80104121:	68 35 6f 10 80       	push   $0x80106f35
80104126:	e8 15 c5 ff ff       	call   80100640 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
8010412b:	83 c4 10             	add    $0x10,%esp
8010412e:	39 f7                	cmp    %esi,%edi
80104130:	75 de                	jne    80104110 <procdump+0xa0>
80104132:	e9 51 ff ff ff       	jmp    80104088 <procdump+0x18>
80104137:	89 f6                	mov    %esi,%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        cprintf(" %p", pc[i]);
    }
    cprintf(" PP= %d\n", p->priority);
    cprintf("\n");
  }
}
80104140:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104143:	5b                   	pop    %ebx
80104144:	5e                   	pop    %esi
80104145:	5f                   	pop    %edi
80104146:	5d                   	pop    %ebp
80104147:	c3                   	ret    
80104148:	66 90                	xchg   %ax,%ax
8010414a:	66 90                	xchg   %ax,%ax
8010414c:	66 90                	xchg   %ax,%ax
8010414e:	66 90                	xchg   %ax,%ax

80104150 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104156:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104159:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010415f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104162:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104169:	5d                   	pop    %ebp
8010416a:	c3                   	ret    
8010416b:	90                   	nop
8010416c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104170 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	53                   	push   %ebx
80104174:	83 ec 04             	sub    $0x4,%esp
80104177:	9c                   	pushf  
80104178:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104179:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
8010417a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104180:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104186:	8d 5a 01             	lea    0x1(%edx),%ebx
80104189:	85 d2                	test   %edx,%edx
8010418b:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
80104191:	75 0c                	jne    8010419f <acquire+0x2f>
    cpu->intena = eflags & FL_IF;
80104193:	81 e1 00 02 00 00    	and    $0x200,%ecx
80104199:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
8010419f:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801041a2:	8b 0a                	mov    (%edx),%ecx
801041a4:	85 c9                	test   %ecx,%ecx
801041a6:	74 05                	je     801041ad <acquire+0x3d>
801041a8:	39 42 08             	cmp    %eax,0x8(%edx)
801041ab:	74 7b                	je     80104228 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801041ad:	b9 01 00 00 00       	mov    $0x1,%ecx
801041b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041b8:	89 c8                	mov    %ecx,%eax
801041ba:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801041bd:	85 c0                	test   %eax,%eax
801041bf:	75 f7                	jne    801041b8 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801041c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801041c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801041c9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041cf:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801041d1:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
801041d4:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801041d7:	31 c0                	xor    %eax,%eax
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801041e0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801041e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801041ec:	77 1a                	ja     80104208 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
801041ee:	8b 5a 04             	mov    0x4(%edx),%ebx
801041f1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801041f4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801041f7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801041f9:	83 f8 0a             	cmp    $0xa,%eax
801041fc:	75 e2                	jne    801041e0 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
801041fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104201:	c9                   	leave  
80104202:	c3                   	ret    
80104203:	90                   	nop
80104204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104208:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010420f:	83 c0 01             	add    $0x1,%eax
80104212:	83 f8 0a             	cmp    $0xa,%eax
80104215:	74 e7                	je     801041fe <acquire+0x8e>
    pcs[i] = 0;
80104217:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010421e:	83 c0 01             	add    $0x1,%eax
80104221:	83 f8 0a             	cmp    $0xa,%eax
80104224:	75 e2                	jne    80104208 <acquire+0x98>
80104226:	eb d6                	jmp    801041fe <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104228:	83 ec 0c             	sub    $0xc,%esp
8010422b:	68 6c 75 10 80       	push   $0x8010756c
80104230:	e8 1b c1 ff ff       	call   80100350 <panic>
80104235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104244:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010424a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010424d:	31 c0                	xor    %eax,%eax
8010424f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104250:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104256:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010425c:	77 1a                	ja     80104278 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010425e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104261:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104264:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104267:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104269:	83 f8 0a             	cmp    $0xa,%eax
8010426c:	75 e2                	jne    80104250 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010426e:	5b                   	pop    %ebx
8010426f:	5d                   	pop    %ebp
80104270:	c3                   	ret    
80104271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104278:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010427f:	83 c0 01             	add    $0x1,%eax
80104282:	83 f8 0a             	cmp    $0xa,%eax
80104285:	74 e7                	je     8010426e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104287:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010428e:	83 c0 01             	add    $0x1,%eax
80104291:	83 f8 0a             	cmp    $0xa,%eax
80104294:	75 e2                	jne    80104278 <getcallerpcs+0x38>
80104296:	eb d6                	jmp    8010426e <getcallerpcs+0x2e>
80104298:	90                   	nop
80104299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042a0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
801042a6:	8b 02                	mov    (%edx),%eax
801042a8:	85 c0                	test   %eax,%eax
801042aa:	74 14                	je     801042c0 <holding+0x20>
801042ac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801042b2:	39 42 08             	cmp    %eax,0x8(%edx)
}
801042b5:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801042b6:	0f 94 c0             	sete   %al
801042b9:	0f b6 c0             	movzbl %al,%eax
}
801042bc:	c3                   	ret    
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
801042c0:	31 c0                	xor    %eax,%eax
801042c2:	5d                   	pop    %ebp
801042c3:	c3                   	ret    
801042c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801042d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042d4:	9c                   	pushf  
801042d5:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801042d6:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
801042d7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801042dd:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801042e3:	8d 5a 01             	lea    0x1(%edx),%ebx
801042e6:	85 d2                	test   %edx,%edx
801042e8:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
801042ee:	75 0c                	jne    801042fc <pushcli+0x2c>
    cpu->intena = eflags & FL_IF;
801042f0:	81 e1 00 02 00 00    	and    $0x200,%ecx
801042f6:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
801042fc:	5b                   	pop    %ebx
801042fd:	5d                   	pop    %ebp
801042fe:	c3                   	ret    
801042ff:	90                   	nop

80104300 <popcli>:

void
popcli(void)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104306:	9c                   	pushf  
80104307:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104308:	f6 c4 02             	test   $0x2,%ah
8010430b:	75 2c                	jne    80104339 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
8010430d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104314:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010431b:	78 0f                	js     8010432c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010431d:	75 0b                	jne    8010432a <popcli+0x2a>
8010431f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104325:	85 c0                	test   %eax,%eax
80104327:	74 01                	je     8010432a <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104329:	fb                   	sti    
    sti();
}
8010432a:	c9                   	leave  
8010432b:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
8010432c:	83 ec 0c             	sub    $0xc,%esp
8010432f:	68 8b 75 10 80       	push   $0x8010758b
80104334:	e8 17 c0 ff ff       	call   80100350 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104339:	83 ec 0c             	sub    $0xc,%esp
8010433c:	68 74 75 10 80       	push   $0x80107574
80104341:	e8 0a c0 ff ff       	call   80100350 <panic>
80104346:	8d 76 00             	lea    0x0(%esi),%esi
80104349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104350 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	83 ec 08             	sub    $0x8,%esp
80104356:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104359:	8b 10                	mov    (%eax),%edx
8010435b:	85 d2                	test   %edx,%edx
8010435d:	74 0c                	je     8010436b <release+0x1b>
8010435f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104366:	39 50 08             	cmp    %edx,0x8(%eax)
80104369:	74 15                	je     80104380 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010436b:	83 ec 0c             	sub    $0xc,%esp
8010436e:	68 92 75 10 80       	push   $0x80107592
80104373:	e8 d8 bf ff ff       	call   80100350 <panic>
80104378:	90                   	nop
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
80104380:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104387:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both to not re-order.
  __sync_synchronize();
8010438e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock.
  lk->locked = 0;
80104393:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104399:	c9                   	leave  
  __sync_synchronize();

  // Release the lock.
  lk->locked = 0;

  popcli();
8010439a:	e9 61 ff ff ff       	jmp    80104300 <popcli>
8010439f:	90                   	nop

801043a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	53                   	push   %ebx
801043a5:	8b 55 08             	mov    0x8(%ebp),%edx
801043a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801043ab:	f6 c2 03             	test   $0x3,%dl
801043ae:	75 05                	jne    801043b5 <memset+0x15>
801043b0:	f6 c1 03             	test   $0x3,%cl
801043b3:	74 13                	je     801043c8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801043b5:	89 d7                	mov    %edx,%edi
801043b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801043ba:	fc                   	cld    
801043bb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801043bd:	5b                   	pop    %ebx
801043be:	89 d0                	mov    %edx,%eax
801043c0:	5f                   	pop    %edi
801043c1:	5d                   	pop    %ebp
801043c2:	c3                   	ret    
801043c3:	90                   	nop
801043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801043c8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801043cc:	c1 e9 02             	shr    $0x2,%ecx
801043cf:	89 fb                	mov    %edi,%ebx
801043d1:	89 f8                	mov    %edi,%eax
801043d3:	c1 e3 18             	shl    $0x18,%ebx
801043d6:	c1 e0 10             	shl    $0x10,%eax
801043d9:	09 d8                	or     %ebx,%eax
801043db:	09 f8                	or     %edi,%eax
801043dd:	c1 e7 08             	shl    $0x8,%edi
801043e0:	09 f8                	or     %edi,%eax
801043e2:	89 d7                	mov    %edx,%edi
801043e4:	fc                   	cld    
801043e5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801043e7:	5b                   	pop    %ebx
801043e8:	89 d0                	mov    %edx,%eax
801043ea:	5f                   	pop    %edi
801043eb:	5d                   	pop    %ebp
801043ec:	c3                   	ret    
801043ed:	8d 76 00             	lea    0x0(%esi),%esi

801043f0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	57                   	push   %edi
801043f4:	56                   	push   %esi
801043f5:	8b 45 10             	mov    0x10(%ebp),%eax
801043f8:	53                   	push   %ebx
801043f9:	8b 75 0c             	mov    0xc(%ebp),%esi
801043fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801043ff:	85 c0                	test   %eax,%eax
80104401:	74 29                	je     8010442c <memcmp+0x3c>
    if(*s1 != *s2)
80104403:	0f b6 13             	movzbl (%ebx),%edx
80104406:	0f b6 0e             	movzbl (%esi),%ecx
80104409:	38 d1                	cmp    %dl,%cl
8010440b:	75 2b                	jne    80104438 <memcmp+0x48>
8010440d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104410:	31 c0                	xor    %eax,%eax
80104412:	eb 14                	jmp    80104428 <memcmp+0x38>
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010441d:	83 c0 01             	add    $0x1,%eax
80104420:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104424:	38 ca                	cmp    %cl,%dl
80104426:	75 10                	jne    80104438 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104428:	39 f8                	cmp    %edi,%eax
8010442a:	75 ec                	jne    80104418 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010442c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010442d:	31 c0                	xor    %eax,%eax
}
8010442f:	5e                   	pop    %esi
80104430:	5f                   	pop    %edi
80104431:	5d                   	pop    %ebp
80104432:	c3                   	ret    
80104433:	90                   	nop
80104434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104438:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010443b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010443c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010443e:	5e                   	pop    %esi
8010443f:	5f                   	pop    %edi
80104440:	5d                   	pop    %ebp
80104441:	c3                   	ret    
80104442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104450 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	56                   	push   %esi
80104454:	53                   	push   %ebx
80104455:	8b 45 08             	mov    0x8(%ebp),%eax
80104458:	8b 75 0c             	mov    0xc(%ebp),%esi
8010445b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010445e:	39 c6                	cmp    %eax,%esi
80104460:	73 2e                	jae    80104490 <memmove+0x40>
80104462:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104465:	39 c8                	cmp    %ecx,%eax
80104467:	73 27                	jae    80104490 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104469:	85 db                	test   %ebx,%ebx
8010446b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010446e:	74 17                	je     80104487 <memmove+0x37>
      *--d = *--s;
80104470:	29 d9                	sub    %ebx,%ecx
80104472:	89 cb                	mov    %ecx,%ebx
80104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104478:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010447c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010447f:	83 ea 01             	sub    $0x1,%edx
80104482:	83 fa ff             	cmp    $0xffffffff,%edx
80104485:	75 f1                	jne    80104478 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104487:	5b                   	pop    %ebx
80104488:	5e                   	pop    %esi
80104489:	5d                   	pop    %ebp
8010448a:	c3                   	ret    
8010448b:	90                   	nop
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104490:	31 d2                	xor    %edx,%edx
80104492:	85 db                	test   %ebx,%ebx
80104494:	74 f1                	je     80104487 <memmove+0x37>
80104496:	8d 76 00             	lea    0x0(%esi),%esi
80104499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801044a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801044a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801044a7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801044aa:	39 d3                	cmp    %edx,%ebx
801044ac:	75 f2                	jne    801044a0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801044ae:	5b                   	pop    %ebx
801044af:	5e                   	pop    %esi
801044b0:	5d                   	pop    %ebp
801044b1:	c3                   	ret    
801044b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801044c3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801044c4:	eb 8a                	jmp    80104450 <memmove>
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	57                   	push   %edi
801044d4:	56                   	push   %esi
801044d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801044d8:	53                   	push   %ebx
801044d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801044dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801044df:	85 c9                	test   %ecx,%ecx
801044e1:	74 37                	je     8010451a <strncmp+0x4a>
801044e3:	0f b6 17             	movzbl (%edi),%edx
801044e6:	0f b6 1e             	movzbl (%esi),%ebx
801044e9:	84 d2                	test   %dl,%dl
801044eb:	74 3f                	je     8010452c <strncmp+0x5c>
801044ed:	38 d3                	cmp    %dl,%bl
801044ef:	75 3b                	jne    8010452c <strncmp+0x5c>
801044f1:	8d 47 01             	lea    0x1(%edi),%eax
801044f4:	01 cf                	add    %ecx,%edi
801044f6:	eb 1b                	jmp    80104513 <strncmp+0x43>
801044f8:	90                   	nop
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104500:	0f b6 10             	movzbl (%eax),%edx
80104503:	84 d2                	test   %dl,%dl
80104505:	74 21                	je     80104528 <strncmp+0x58>
80104507:	0f b6 19             	movzbl (%ecx),%ebx
8010450a:	83 c0 01             	add    $0x1,%eax
8010450d:	89 ce                	mov    %ecx,%esi
8010450f:	38 da                	cmp    %bl,%dl
80104511:	75 19                	jne    8010452c <strncmp+0x5c>
80104513:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104515:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104518:	75 e6                	jne    80104500 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010451a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010451b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010451d:	5e                   	pop    %esi
8010451e:	5f                   	pop    %edi
8010451f:	5d                   	pop    %ebp
80104520:	c3                   	ret    
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104528:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010452c:	0f b6 c2             	movzbl %dl,%eax
8010452f:	29 d8                	sub    %ebx,%eax
}
80104531:	5b                   	pop    %ebx
80104532:	5e                   	pop    %esi
80104533:	5f                   	pop    %edi
80104534:	5d                   	pop    %ebp
80104535:	c3                   	ret    
80104536:	8d 76 00             	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 45 08             	mov    0x8(%ebp),%eax
80104548:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010454b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010454e:	89 c2                	mov    %eax,%edx
80104550:	eb 19                	jmp    8010456b <strncpy+0x2b>
80104552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104558:	83 c3 01             	add    $0x1,%ebx
8010455b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010455f:	83 c2 01             	add    $0x1,%edx
80104562:	84 c9                	test   %cl,%cl
80104564:	88 4a ff             	mov    %cl,-0x1(%edx)
80104567:	74 09                	je     80104572 <strncpy+0x32>
80104569:	89 f1                	mov    %esi,%ecx
8010456b:	85 c9                	test   %ecx,%ecx
8010456d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104570:	7f e6                	jg     80104558 <strncpy+0x18>
    ;
  while(n-- > 0)
80104572:	31 c9                	xor    %ecx,%ecx
80104574:	85 f6                	test   %esi,%esi
80104576:	7e 17                	jle    8010458f <strncpy+0x4f>
80104578:	90                   	nop
80104579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104580:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104584:	89 f3                	mov    %esi,%ebx
80104586:	83 c1 01             	add    $0x1,%ecx
80104589:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010458b:	85 db                	test   %ebx,%ebx
8010458d:	7f f1                	jg     80104580 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010458f:	5b                   	pop    %ebx
80104590:	5e                   	pop    %esi
80104591:	5d                   	pop    %ebp
80104592:	c3                   	ret    
80104593:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
801045a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045a8:	8b 45 08             	mov    0x8(%ebp),%eax
801045ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801045ae:	85 c9                	test   %ecx,%ecx
801045b0:	7e 26                	jle    801045d8 <safestrcpy+0x38>
801045b2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801045b6:	89 c1                	mov    %eax,%ecx
801045b8:	eb 17                	jmp    801045d1 <safestrcpy+0x31>
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801045c0:	83 c2 01             	add    $0x1,%edx
801045c3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801045c7:	83 c1 01             	add    $0x1,%ecx
801045ca:	84 db                	test   %bl,%bl
801045cc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801045cf:	74 04                	je     801045d5 <safestrcpy+0x35>
801045d1:	39 f2                	cmp    %esi,%edx
801045d3:	75 eb                	jne    801045c0 <safestrcpy+0x20>
    ;
  *s = 0;
801045d5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801045d8:	5b                   	pop    %ebx
801045d9:	5e                   	pop    %esi
801045da:	5d                   	pop    %ebp
801045db:	c3                   	ret    
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045e0 <strlen>:

int
strlen(const char *s)
{
801045e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801045e1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801045e3:	89 e5                	mov    %esp,%ebp
801045e5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801045e8:	80 3a 00             	cmpb   $0x0,(%edx)
801045eb:	74 0c                	je     801045f9 <strlen+0x19>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
801045f0:	83 c0 01             	add    $0x1,%eax
801045f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801045f7:	75 f7                	jne    801045f0 <strlen+0x10>
    ;
  return n;
}
801045f9:	5d                   	pop    %ebp
801045fa:	c3                   	ret    

801045fb <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801045fb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801045ff:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104603:	55                   	push   %ebp
  pushl %ebx
80104604:	53                   	push   %ebx
  pushl %esi
80104605:	56                   	push   %esi
  pushl %edi
80104606:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104607:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104609:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010460b:	5f                   	pop    %edi
  popl %esi
8010460c:	5e                   	pop    %esi
  popl %ebx
8010460d:	5b                   	pop    %ebx
  popl %ebp
8010460e:	5d                   	pop    %ebp
  ret
8010460f:	c3                   	ret    

80104610 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104610:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104611:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104618:	89 e5                	mov    %esp,%ebp
8010461a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010461d:	8b 12                	mov    (%edx),%edx
8010461f:	39 c2                	cmp    %eax,%edx
80104621:	76 15                	jbe    80104638 <fetchint+0x28>
80104623:	8d 48 04             	lea    0x4(%eax),%ecx
80104626:	39 ca                	cmp    %ecx,%edx
80104628:	72 0e                	jb     80104638 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010462a:	8b 10                	mov    (%eax),%edx
8010462c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010462f:	89 10                	mov    %edx,(%eax)
  return 0;
80104631:	31 c0                	xor    %eax,%eax
}
80104633:	5d                   	pop    %ebp
80104634:	c3                   	ret    
80104635:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104638:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
8010463d:	5d                   	pop    %ebp
8010463e:	c3                   	ret    
8010463f:	90                   	nop

80104640 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104640:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104641:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104647:	89 e5                	mov    %esp,%ebp
80104649:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
8010464c:	39 08                	cmp    %ecx,(%eax)
8010464e:	76 2c                	jbe    8010467c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104650:	8b 55 0c             	mov    0xc(%ebp),%edx
80104653:	89 c8                	mov    %ecx,%eax
80104655:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104657:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010465e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104660:	39 d1                	cmp    %edx,%ecx
80104662:	73 18                	jae    8010467c <fetchstr+0x3c>
    if(*s == 0)
80104664:	80 39 00             	cmpb   $0x0,(%ecx)
80104667:	75 0c                	jne    80104675 <fetchstr+0x35>
80104669:	eb 1d                	jmp    80104688 <fetchstr+0x48>
8010466b:	90                   	nop
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104670:	80 38 00             	cmpb   $0x0,(%eax)
80104673:	74 13                	je     80104688 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104675:	83 c0 01             	add    $0x1,%eax
80104678:	39 c2                	cmp    %eax,%edx
8010467a:	77 f4                	ja     80104670 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
8010467c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
80104681:	5d                   	pop    %ebp
80104682:	c3                   	ret    
80104683:	90                   	nop
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
80104688:	29 c8                	sub    %ecx,%eax
  return -1;
}
8010468a:	5d                   	pop    %ebp
8010468b:	c3                   	ret    
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104690:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104697:	55                   	push   %ebp
80104698:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010469a:	8b 42 18             	mov    0x18(%edx),%eax
8010469d:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801046a0:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801046a2:	8b 40 44             	mov    0x44(%eax),%eax
801046a5:	8d 04 88             	lea    (%eax,%ecx,4),%eax
801046a8:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801046ab:	39 d1                	cmp    %edx,%ecx
801046ad:	73 19                	jae    801046c8 <argint+0x38>
801046af:	8d 48 08             	lea    0x8(%eax),%ecx
801046b2:	39 ca                	cmp    %ecx,%edx
801046b4:	72 12                	jb     801046c8 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
801046b6:	8b 50 04             	mov    0x4(%eax),%edx
801046b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801046bc:	89 10                	mov    %edx,(%eax)
  return 0;
801046be:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
801046c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801046cd:	5d                   	pop    %ebp
801046ce:	c3                   	ret    
801046cf:	90                   	nop

801046d0 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801046d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801046d6:	55                   	push   %ebp
801046d7:	89 e5                	mov    %esp,%ebp
801046d9:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801046da:	8b 50 18             	mov    0x18(%eax),%edx
801046dd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046e0:	8b 52 44             	mov    0x44(%edx),%edx
801046e3:	8d 0c 8a             	lea    (%edx,%ecx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801046e6:	8b 10                	mov    (%eax),%edx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
801046e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801046ed:	8d 59 04             	lea    0x4(%ecx),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801046f0:	39 d3                	cmp    %edx,%ebx
801046f2:	73 1e                	jae    80104712 <argptr+0x42>
801046f4:	8d 59 08             	lea    0x8(%ecx),%ebx
801046f7:	39 da                	cmp    %ebx,%edx
801046f9:	72 17                	jb     80104712 <argptr+0x42>
    return -1;
  *ip = *(int*)(addr);
801046fb:	8b 49 04             	mov    0x4(%ecx),%ecx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801046fe:	39 d1                	cmp    %edx,%ecx
80104700:	73 10                	jae    80104712 <argptr+0x42>
80104702:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104705:	01 cb                	add    %ecx,%ebx
80104707:	39 d3                	cmp    %edx,%ebx
80104709:	77 07                	ja     80104712 <argptr+0x42>
    return -1;
  *pp = (char*)i;
8010470b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010470e:	89 08                	mov    %ecx,(%eax)
  return 0;
80104710:	31 c0                	xor    %eax,%eax
}
80104712:	5b                   	pop    %ebx
80104713:	5d                   	pop    %ebp
80104714:	c3                   	ret    
80104715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104720:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104726:	55                   	push   %ebp
80104727:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104729:	8b 50 18             	mov    0x18(%eax),%edx
8010472c:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010472f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104731:	8b 52 44             	mov    0x44(%edx),%edx
80104734:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104737:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010473a:	39 c1                	cmp    %eax,%ecx
8010473c:	73 07                	jae    80104745 <argstr+0x25>
8010473e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104741:	39 c8                	cmp    %ecx,%eax
80104743:	73 0b                	jae    80104750 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104745:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104750:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104753:	39 c1                	cmp    %eax,%ecx
80104755:	73 ee                	jae    80104745 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
80104757:	8b 55 0c             	mov    0xc(%ebp),%edx
8010475a:	89 c8                	mov    %ecx,%eax
8010475c:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
8010475e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104765:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104767:	39 d1                	cmp    %edx,%ecx
80104769:	73 da                	jae    80104745 <argstr+0x25>
    if(*s == 0)
8010476b:	80 39 00             	cmpb   $0x0,(%ecx)
8010476e:	75 0d                	jne    8010477d <argstr+0x5d>
80104770:	eb 1e                	jmp    80104790 <argstr+0x70>
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	80 38 00             	cmpb   $0x0,(%eax)
8010477b:	74 13                	je     80104790 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010477d:	83 c0 01             	add    $0x1,%eax
80104780:	39 c2                	cmp    %eax,%edx
80104782:	77 f4                	ja     80104778 <argstr+0x58>
80104784:	eb bf                	jmp    80104745 <argstr+0x25>
80104786:	8d 76 00             	lea    0x0(%esi),%esi
80104789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(*s == 0)
      return s - *pp;
80104790:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104792:	5d                   	pop    %ebp
80104793:	c3                   	ret    
80104794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010479a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801047a0 <syscall>:
[SYS_getcount] sys_getcount, //getcount here
};

void
syscall(void)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = proc->tf->eax;
801047a7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047ae:	8b 5a 18             	mov    0x18(%edx),%ebx
801047b1:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801047b4:	8d 48 ff             	lea    -0x1(%eax),%ecx
801047b7:	83 f9 15             	cmp    $0x15,%ecx
801047ba:	77 24                	ja     801047e0 <syscall+0x40>
801047bc:	8b 0c 85 c0 75 10 80 	mov    -0x7fef8a40(,%eax,4),%ecx
801047c3:	85 c9                	test   %ecx,%ecx
801047c5:	74 19                	je     801047e0 <syscall+0x40>
    count++; //increments count every time a sys call is made
801047c7:	83 05 8c f7 10 80 01 	addl   $0x1,0x8010f78c
    proc->tf->eax = syscalls[num]();
801047ce:	ff d1                	call   *%ecx
801047d0:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
801047d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047d6:	c9                   	leave  
801047d7:	c3                   	ret    
801047d8:	90                   	nop
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    count++; //increments count every time a sys call is made
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801047e0:	50                   	push   %eax
            proc->pid, proc->name, num);
801047e1:	8d 42 6c             	lea    0x6c(%edx),%eax
  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    count++; //increments count every time a sys call is made
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801047e4:	50                   	push   %eax
801047e5:	ff 72 10             	pushl  0x10(%edx)
801047e8:	68 9a 75 10 80       	push   $0x8010759a
801047ed:	e8 4e be ff ff       	call   80100640 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801047f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047f8:	83 c4 10             	add    $0x10,%esp
801047fb:	8b 40 18             	mov    0x18(%eax),%eax
801047fe:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104808:	c9                   	leave  
80104809:	c3                   	ret    
8010480a:	66 90                	xchg   %ax,%ax
8010480c:	66 90                	xchg   %ax,%ax
8010480e:	66 90                	xchg   %ax,%ax

80104810 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104816:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104819:	83 ec 44             	sub    $0x44,%esp
8010481c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010481f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104822:	56                   	push   %esi
80104823:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104824:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104827:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010482a:	e8 81 d6 ff ff       	call   80101eb0 <nameiparent>
8010482f:	83 c4 10             	add    $0x10,%esp
80104832:	85 c0                	test   %eax,%eax
80104834:	0f 84 f6 00 00 00    	je     80104930 <create+0x120>
    return 0;
  ilock(dp);
8010483a:	83 ec 0c             	sub    $0xc,%esp
8010483d:	89 c7                	mov    %eax,%edi
8010483f:	50                   	push   %eax
80104840:	e8 bb cd ff ff       	call   80101600 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104845:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104848:	83 c4 0c             	add    $0xc,%esp
8010484b:	50                   	push   %eax
8010484c:	56                   	push   %esi
8010484d:	57                   	push   %edi
8010484e:	e8 1d d3 ff ff       	call   80101b70 <dirlookup>
80104853:	83 c4 10             	add    $0x10,%esp
80104856:	85 c0                	test   %eax,%eax
80104858:	89 c3                	mov    %eax,%ebx
8010485a:	74 54                	je     801048b0 <create+0xa0>
    iunlockput(dp);
8010485c:	83 ec 0c             	sub    $0xc,%esp
8010485f:	57                   	push   %edi
80104860:	e8 6b d0 ff ff       	call   801018d0 <iunlockput>
    ilock(ip);
80104865:	89 1c 24             	mov    %ebx,(%esp)
80104868:	e8 93 cd ff ff       	call   80101600 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010486d:	83 c4 10             	add    $0x10,%esp
80104870:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104875:	75 19                	jne    80104890 <create+0x80>
80104877:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
8010487c:	89 d8                	mov    %ebx,%eax
8010487e:	75 10                	jne    80104890 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104880:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104883:	5b                   	pop    %ebx
80104884:	5e                   	pop    %esi
80104885:	5f                   	pop    %edi
80104886:	5d                   	pop    %ebp
80104887:	c3                   	ret    
80104888:	90                   	nop
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104890:	83 ec 0c             	sub    $0xc,%esp
80104893:	53                   	push   %ebx
80104894:	e8 37 d0 ff ff       	call   801018d0 <iunlockput>
    return 0;
80104899:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010489c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010489f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801048a1:	5b                   	pop    %ebx
801048a2:	5e                   	pop    %esi
801048a3:	5f                   	pop    %edi
801048a4:	5d                   	pop    %ebp
801048a5:	c3                   	ret    
801048a6:	8d 76 00             	lea    0x0(%esi),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801048b0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801048b4:	83 ec 08             	sub    $0x8,%esp
801048b7:	50                   	push   %eax
801048b8:	ff 37                	pushl  (%edi)
801048ba:	e8 d1 cb ff ff       	call   80101490 <ialloc>
801048bf:	83 c4 10             	add    $0x10,%esp
801048c2:	85 c0                	test   %eax,%eax
801048c4:	89 c3                	mov    %eax,%ebx
801048c6:	0f 84 cc 00 00 00    	je     80104998 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
801048cc:	83 ec 0c             	sub    $0xc,%esp
801048cf:	50                   	push   %eax
801048d0:	e8 2b cd ff ff       	call   80101600 <ilock>
  ip->major = major;
801048d5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801048d9:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
801048dd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801048e1:	66 89 43 14          	mov    %ax,0x14(%ebx)
  ip->nlink = 1;
801048e5:	b8 01 00 00 00       	mov    $0x1,%eax
801048ea:	66 89 43 16          	mov    %ax,0x16(%ebx)
  iupdate(ip);
801048ee:	89 1c 24             	mov    %ebx,(%esp)
801048f1:	e8 5a cc ff ff       	call   80101550 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801048f6:	83 c4 10             	add    $0x10,%esp
801048f9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801048fe:	74 40                	je     80104940 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104900:	83 ec 04             	sub    $0x4,%esp
80104903:	ff 73 04             	pushl  0x4(%ebx)
80104906:	56                   	push   %esi
80104907:	57                   	push   %edi
80104908:	e8 c3 d4 ff ff       	call   80101dd0 <dirlink>
8010490d:	83 c4 10             	add    $0x10,%esp
80104910:	85 c0                	test   %eax,%eax
80104912:	78 77                	js     8010498b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104914:	83 ec 0c             	sub    $0xc,%esp
80104917:	57                   	push   %edi
80104918:	e8 b3 cf ff ff       	call   801018d0 <iunlockput>

  return ip;
8010491d:	83 c4 10             	add    $0x10,%esp
}
80104920:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104923:	89 d8                	mov    %ebx,%eax
}
80104925:	5b                   	pop    %ebx
80104926:	5e                   	pop    %esi
80104927:	5f                   	pop    %edi
80104928:	5d                   	pop    %ebp
80104929:	c3                   	ret    
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104930:	31 c0                	xor    %eax,%eax
80104932:	e9 49 ff ff ff       	jmp    80104880 <create+0x70>
80104937:	89 f6                	mov    %esi,%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104940:	66 83 47 16 01       	addw   $0x1,0x16(%edi)
    iupdate(dp);
80104945:	83 ec 0c             	sub    $0xc,%esp
80104948:	57                   	push   %edi
80104949:	e8 02 cc ff ff       	call   80101550 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010494e:	83 c4 0c             	add    $0xc,%esp
80104951:	ff 73 04             	pushl  0x4(%ebx)
80104954:	68 38 76 10 80       	push   $0x80107638
80104959:	53                   	push   %ebx
8010495a:	e8 71 d4 ff ff       	call   80101dd0 <dirlink>
8010495f:	83 c4 10             	add    $0x10,%esp
80104962:	85 c0                	test   %eax,%eax
80104964:	78 18                	js     8010497e <create+0x16e>
80104966:	83 ec 04             	sub    $0x4,%esp
80104969:	ff 77 04             	pushl  0x4(%edi)
8010496c:	68 37 76 10 80       	push   $0x80107637
80104971:	53                   	push   %ebx
80104972:	e8 59 d4 ff ff       	call   80101dd0 <dirlink>
80104977:	83 c4 10             	add    $0x10,%esp
8010497a:	85 c0                	test   %eax,%eax
8010497c:	79 82                	jns    80104900 <create+0xf0>
      panic("create dots");
8010497e:	83 ec 0c             	sub    $0xc,%esp
80104981:	68 2b 76 10 80       	push   $0x8010762b
80104986:	e8 c5 b9 ff ff       	call   80100350 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010498b:	83 ec 0c             	sub    $0xc,%esp
8010498e:	68 3a 76 10 80       	push   $0x8010763a
80104993:	e8 b8 b9 ff ff       	call   80100350 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104998:	83 ec 0c             	sub    $0xc,%esp
8010499b:	68 1c 76 10 80       	push   $0x8010761c
801049a0:	e8 ab b9 ff ff       	call   80100350 <panic>
801049a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049b0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
801049b5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801049b7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801049ba:	89 d3                	mov    %edx,%ebx
801049bc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801049bf:	50                   	push   %eax
801049c0:	6a 00                	push   $0x0
801049c2:	e8 c9 fc ff ff       	call   80104690 <argint>
801049c7:	83 c4 10             	add    $0x10,%esp
801049ca:	85 c0                	test   %eax,%eax
801049cc:	78 3a                	js     80104a08 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801049ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d1:	83 f8 0f             	cmp    $0xf,%eax
801049d4:	77 32                	ja     80104a08 <argfd.constprop.0+0x58>
801049d6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801049dd:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
801049e1:	85 d2                	test   %edx,%edx
801049e3:	74 23                	je     80104a08 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
801049e5:	85 f6                	test   %esi,%esi
801049e7:	74 02                	je     801049eb <argfd.constprop.0+0x3b>
    *pfd = fd;
801049e9:	89 06                	mov    %eax,(%esi)
  if(pf)
801049eb:	85 db                	test   %ebx,%ebx
801049ed:	74 11                	je     80104a00 <argfd.constprop.0+0x50>
    *pf = f;
801049ef:	89 13                	mov    %edx,(%ebx)
  return 0;
801049f1:	31 c0                	xor    %eax,%eax
}
801049f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049f6:	5b                   	pop    %ebx
801049f7:	5e                   	pop    %esi
801049f8:	5d                   	pop    %ebp
801049f9:	c3                   	ret    
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104a00:	31 c0                	xor    %eax,%eax
80104a02:	eb ef                	jmp    801049f3 <argfd.constprop.0+0x43>
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a0d:	eb e4                	jmp    801049f3 <argfd.constprop.0+0x43>
80104a0f:	90                   	nop

80104a10 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104a10:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104a11:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104a13:	89 e5                	mov    %esp,%ebp
80104a15:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104a16:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104a19:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104a1c:	e8 8f ff ff ff       	call   801049b0 <argfd.constprop.0>
80104a21:	85 c0                	test   %eax,%eax
80104a23:	78 1b                	js     80104a40 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104a2e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104a30:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104a34:	85 c9                	test   %ecx,%ecx
80104a36:	74 18                	je     80104a50 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104a38:	83 c3 01             	add    $0x1,%ebx
80104a3b:	83 fb 10             	cmp    $0x10,%ebx
80104a3e:	75 f0                	jne    80104a30 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104a45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a48:	c9                   	leave  
80104a49:	c3                   	ret    
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104a50:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104a53:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104a57:	52                   	push   %edx
80104a58:	e8 53 c3 ff ff       	call   80100db0 <filedup>
  return fd;
80104a5d:	89 d8                	mov    %ebx,%eax
80104a5f:	83 c4 10             	add    $0x10,%esp
}
80104a62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a65:	c9                   	leave  
80104a66:	c3                   	ret    
80104a67:	89 f6                	mov    %esi,%esi
80104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a70 <sys_read>:

int
sys_read(void)
{
80104a70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a71:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104a73:	89 e5                	mov    %esp,%ebp
80104a75:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a7b:	e8 30 ff ff ff       	call   801049b0 <argfd.constprop.0>
80104a80:	85 c0                	test   %eax,%eax
80104a82:	78 4c                	js     80104ad0 <sys_read+0x60>
80104a84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a87:	83 ec 08             	sub    $0x8,%esp
80104a8a:	50                   	push   %eax
80104a8b:	6a 02                	push   $0x2
80104a8d:	e8 fe fb ff ff       	call   80104690 <argint>
80104a92:	83 c4 10             	add    $0x10,%esp
80104a95:	85 c0                	test   %eax,%eax
80104a97:	78 37                	js     80104ad0 <sys_read+0x60>
80104a99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a9c:	83 ec 04             	sub    $0x4,%esp
80104a9f:	ff 75 f0             	pushl  -0x10(%ebp)
80104aa2:	50                   	push   %eax
80104aa3:	6a 01                	push   $0x1
80104aa5:	e8 26 fc ff ff       	call   801046d0 <argptr>
80104aaa:	83 c4 10             	add    $0x10,%esp
80104aad:	85 c0                	test   %eax,%eax
80104aaf:	78 1f                	js     80104ad0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ab1:	83 ec 04             	sub    $0x4,%esp
80104ab4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ab7:	ff 75 f4             	pushl  -0xc(%ebp)
80104aba:	ff 75 ec             	pushl  -0x14(%ebp)
80104abd:	e8 5e c4 ff ff       	call   80100f20 <fileread>
80104ac2:	83 c4 10             	add    $0x10,%esp
}
80104ac5:	c9                   	leave  
80104ac6:	c3                   	ret    
80104ac7:	89 f6                	mov    %esi,%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104ad5:	c9                   	leave  
80104ad6:	c3                   	ret    
80104ad7:	89 f6                	mov    %esi,%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ae0 <sys_write>:

int
sys_write(void)
{
80104ae0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ae1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104ae3:	89 e5                	mov    %esp,%ebp
80104ae5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ae8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104aeb:	e8 c0 fe ff ff       	call   801049b0 <argfd.constprop.0>
80104af0:	85 c0                	test   %eax,%eax
80104af2:	78 4c                	js     80104b40 <sys_write+0x60>
80104af4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104af7:	83 ec 08             	sub    $0x8,%esp
80104afa:	50                   	push   %eax
80104afb:	6a 02                	push   $0x2
80104afd:	e8 8e fb ff ff       	call   80104690 <argint>
80104b02:	83 c4 10             	add    $0x10,%esp
80104b05:	85 c0                	test   %eax,%eax
80104b07:	78 37                	js     80104b40 <sys_write+0x60>
80104b09:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b0c:	83 ec 04             	sub    $0x4,%esp
80104b0f:	ff 75 f0             	pushl  -0x10(%ebp)
80104b12:	50                   	push   %eax
80104b13:	6a 01                	push   $0x1
80104b15:	e8 b6 fb ff ff       	call   801046d0 <argptr>
80104b1a:	83 c4 10             	add    $0x10,%esp
80104b1d:	85 c0                	test   %eax,%eax
80104b1f:	78 1f                	js     80104b40 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104b21:	83 ec 04             	sub    $0x4,%esp
80104b24:	ff 75 f0             	pushl  -0x10(%ebp)
80104b27:	ff 75 f4             	pushl  -0xc(%ebp)
80104b2a:	ff 75 ec             	pushl  -0x14(%ebp)
80104b2d:	e8 7e c4 ff ff       	call   80100fb0 <filewrite>
80104b32:	83 c4 10             	add    $0x10,%esp
}
80104b35:	c9                   	leave  
80104b36:	c3                   	ret    
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104b45:	c9                   	leave  
80104b46:	c3                   	ret    
80104b47:	89 f6                	mov    %esi,%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b50 <sys_close>:

int
sys_close(void)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104b56:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104b59:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b5c:	e8 4f fe ff ff       	call   801049b0 <argfd.constprop.0>
80104b61:	85 c0                	test   %eax,%eax
80104b63:	78 2b                	js     80104b90 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80104b65:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104b68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104b6e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80104b71:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104b78:	00 
  fileclose(f);
80104b79:	ff 75 f4             	pushl  -0xc(%ebp)
80104b7c:	e8 7f c2 ff ff       	call   80100e00 <fileclose>
  return 0;
80104b81:	83 c4 10             	add    $0x10,%esp
80104b84:	31 c0                	xor    %eax,%eax
}
80104b86:	c9                   	leave  
80104b87:	c3                   	ret    
80104b88:	90                   	nop
80104b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104b95:	c9                   	leave  
80104b96:	c3                   	ret    
80104b97:	89 f6                	mov    %esi,%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <sys_fstat>:

int
sys_fstat(void)
{
80104ba0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ba1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ba3:	89 e5                	mov    %esp,%ebp
80104ba5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ba8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104bab:	e8 00 fe ff ff       	call   801049b0 <argfd.constprop.0>
80104bb0:	85 c0                	test   %eax,%eax
80104bb2:	78 2c                	js     80104be0 <sys_fstat+0x40>
80104bb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bb7:	83 ec 04             	sub    $0x4,%esp
80104bba:	6a 14                	push   $0x14
80104bbc:	50                   	push   %eax
80104bbd:	6a 01                	push   $0x1
80104bbf:	e8 0c fb ff ff       	call   801046d0 <argptr>
80104bc4:	83 c4 10             	add    $0x10,%esp
80104bc7:	85 c0                	test   %eax,%eax
80104bc9:	78 15                	js     80104be0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104bcb:	83 ec 08             	sub    $0x8,%esp
80104bce:	ff 75 f4             	pushl  -0xc(%ebp)
80104bd1:	ff 75 f0             	pushl  -0x10(%ebp)
80104bd4:	e8 f7 c2 ff ff       	call   80100ed0 <filestat>
80104bd9:	83 c4 10             	add    $0x10,%esp
}
80104bdc:	c9                   	leave  
80104bdd:	c3                   	ret    
80104bde:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104be5:	c9                   	leave  
80104be6:	c3                   	ret    
80104be7:	89 f6                	mov    %esi,%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bf0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	57                   	push   %edi
80104bf4:	56                   	push   %esi
80104bf5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104bf6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104bf9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104bfc:	50                   	push   %eax
80104bfd:	6a 00                	push   $0x0
80104bff:	e8 1c fb ff ff       	call   80104720 <argstr>
80104c04:	83 c4 10             	add    $0x10,%esp
80104c07:	85 c0                	test   %eax,%eax
80104c09:	0f 88 fb 00 00 00    	js     80104d0a <sys_link+0x11a>
80104c0f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104c12:	83 ec 08             	sub    $0x8,%esp
80104c15:	50                   	push   %eax
80104c16:	6a 01                	push   $0x1
80104c18:	e8 03 fb ff ff       	call   80104720 <argstr>
80104c1d:	83 c4 10             	add    $0x10,%esp
80104c20:	85 c0                	test   %eax,%eax
80104c22:	0f 88 e2 00 00 00    	js     80104d0a <sys_link+0x11a>
    return -1;

  begin_op();
80104c28:	e8 33 df ff ff       	call   80102b60 <begin_op>
  if((ip = namei(old)) == 0){
80104c2d:	83 ec 0c             	sub    $0xc,%esp
80104c30:	ff 75 d4             	pushl  -0x2c(%ebp)
80104c33:	e8 58 d2 ff ff       	call   80101e90 <namei>
80104c38:	83 c4 10             	add    $0x10,%esp
80104c3b:	85 c0                	test   %eax,%eax
80104c3d:	89 c3                	mov    %eax,%ebx
80104c3f:	0f 84 f3 00 00 00    	je     80104d38 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104c45:	83 ec 0c             	sub    $0xc,%esp
80104c48:	50                   	push   %eax
80104c49:	e8 b2 c9 ff ff       	call   80101600 <ilock>
  if(ip->type == T_DIR){
80104c4e:	83 c4 10             	add    $0x10,%esp
80104c51:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104c56:	0f 84 c4 00 00 00    	je     80104d20 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104c5c:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
80104c61:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104c64:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104c67:	53                   	push   %ebx
80104c68:	e8 e3 c8 ff ff       	call   80101550 <iupdate>
  iunlock(ip);
80104c6d:	89 1c 24             	mov    %ebx,(%esp)
80104c70:	e8 9b ca ff ff       	call   80101710 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104c75:	58                   	pop    %eax
80104c76:	5a                   	pop    %edx
80104c77:	57                   	push   %edi
80104c78:	ff 75 d0             	pushl  -0x30(%ebp)
80104c7b:	e8 30 d2 ff ff       	call   80101eb0 <nameiparent>
80104c80:	83 c4 10             	add    $0x10,%esp
80104c83:	85 c0                	test   %eax,%eax
80104c85:	89 c6                	mov    %eax,%esi
80104c87:	74 5b                	je     80104ce4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104c89:	83 ec 0c             	sub    $0xc,%esp
80104c8c:	50                   	push   %eax
80104c8d:	e8 6e c9 ff ff       	call   80101600 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104c92:	83 c4 10             	add    $0x10,%esp
80104c95:	8b 03                	mov    (%ebx),%eax
80104c97:	39 06                	cmp    %eax,(%esi)
80104c99:	75 3d                	jne    80104cd8 <sys_link+0xe8>
80104c9b:	83 ec 04             	sub    $0x4,%esp
80104c9e:	ff 73 04             	pushl  0x4(%ebx)
80104ca1:	57                   	push   %edi
80104ca2:	56                   	push   %esi
80104ca3:	e8 28 d1 ff ff       	call   80101dd0 <dirlink>
80104ca8:	83 c4 10             	add    $0x10,%esp
80104cab:	85 c0                	test   %eax,%eax
80104cad:	78 29                	js     80104cd8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104caf:	83 ec 0c             	sub    $0xc,%esp
80104cb2:	56                   	push   %esi
80104cb3:	e8 18 cc ff ff       	call   801018d0 <iunlockput>
  iput(ip);
80104cb8:	89 1c 24             	mov    %ebx,(%esp)
80104cbb:	e8 b0 ca ff ff       	call   80101770 <iput>

  end_op();
80104cc0:	e8 0b df ff ff       	call   80102bd0 <end_op>

  return 0;
80104cc5:	83 c4 10             	add    $0x10,%esp
80104cc8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104cca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ccd:	5b                   	pop    %ebx
80104cce:	5e                   	pop    %esi
80104ccf:	5f                   	pop    %edi
80104cd0:	5d                   	pop    %ebp
80104cd1:	c3                   	ret    
80104cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	56                   	push   %esi
80104cdc:	e8 ef cb ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104ce1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104ce4:	83 ec 0c             	sub    $0xc,%esp
80104ce7:	53                   	push   %ebx
80104ce8:	e8 13 c9 ff ff       	call   80101600 <ilock>
  ip->nlink--;
80104ced:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80104cf2:	89 1c 24             	mov    %ebx,(%esp)
80104cf5:	e8 56 c8 ff ff       	call   80101550 <iupdate>
  iunlockput(ip);
80104cfa:	89 1c 24             	mov    %ebx,(%esp)
80104cfd:	e8 ce cb ff ff       	call   801018d0 <iunlockput>
  end_op();
80104d02:	e8 c9 de ff ff       	call   80102bd0 <end_op>
  return -1;
80104d07:	83 c4 10             	add    $0x10,%esp
}
80104d0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104d0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d12:	5b                   	pop    %ebx
80104d13:	5e                   	pop    %esi
80104d14:	5f                   	pop    %edi
80104d15:	5d                   	pop    %ebp
80104d16:	c3                   	ret    
80104d17:	89 f6                	mov    %esi,%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104d20:	83 ec 0c             	sub    $0xc,%esp
80104d23:	53                   	push   %ebx
80104d24:	e8 a7 cb ff ff       	call   801018d0 <iunlockput>
    end_op();
80104d29:	e8 a2 de ff ff       	call   80102bd0 <end_op>
    return -1;
80104d2e:	83 c4 10             	add    $0x10,%esp
80104d31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d36:	eb 92                	jmp    80104cca <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104d38:	e8 93 de ff ff       	call   80102bd0 <end_op>
    return -1;
80104d3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d42:	eb 86                	jmp    80104cca <sys_link+0xda>
80104d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d50 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	57                   	push   %edi
80104d54:	56                   	push   %esi
80104d55:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104d56:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104d59:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104d5c:	50                   	push   %eax
80104d5d:	6a 00                	push   $0x0
80104d5f:	e8 bc f9 ff ff       	call   80104720 <argstr>
80104d64:	83 c4 10             	add    $0x10,%esp
80104d67:	85 c0                	test   %eax,%eax
80104d69:	0f 88 82 01 00 00    	js     80104ef1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104d6f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104d72:	e8 e9 dd ff ff       	call   80102b60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104d77:	83 ec 08             	sub    $0x8,%esp
80104d7a:	53                   	push   %ebx
80104d7b:	ff 75 c0             	pushl  -0x40(%ebp)
80104d7e:	e8 2d d1 ff ff       	call   80101eb0 <nameiparent>
80104d83:	83 c4 10             	add    $0x10,%esp
80104d86:	85 c0                	test   %eax,%eax
80104d88:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104d8b:	0f 84 6a 01 00 00    	je     80104efb <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104d91:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104d94:	83 ec 0c             	sub    $0xc,%esp
80104d97:	56                   	push   %esi
80104d98:	e8 63 c8 ff ff       	call   80101600 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104d9d:	58                   	pop    %eax
80104d9e:	5a                   	pop    %edx
80104d9f:	68 38 76 10 80       	push   $0x80107638
80104da4:	53                   	push   %ebx
80104da5:	e8 a6 cd ff ff       	call   80101b50 <namecmp>
80104daa:	83 c4 10             	add    $0x10,%esp
80104dad:	85 c0                	test   %eax,%eax
80104daf:	0f 84 fc 00 00 00    	je     80104eb1 <sys_unlink+0x161>
80104db5:	83 ec 08             	sub    $0x8,%esp
80104db8:	68 37 76 10 80       	push   $0x80107637
80104dbd:	53                   	push   %ebx
80104dbe:	e8 8d cd ff ff       	call   80101b50 <namecmp>
80104dc3:	83 c4 10             	add    $0x10,%esp
80104dc6:	85 c0                	test   %eax,%eax
80104dc8:	0f 84 e3 00 00 00    	je     80104eb1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104dce:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104dd1:	83 ec 04             	sub    $0x4,%esp
80104dd4:	50                   	push   %eax
80104dd5:	53                   	push   %ebx
80104dd6:	56                   	push   %esi
80104dd7:	e8 94 cd ff ff       	call   80101b70 <dirlookup>
80104ddc:	83 c4 10             	add    $0x10,%esp
80104ddf:	85 c0                	test   %eax,%eax
80104de1:	89 c3                	mov    %eax,%ebx
80104de3:	0f 84 c8 00 00 00    	je     80104eb1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104de9:	83 ec 0c             	sub    $0xc,%esp
80104dec:	50                   	push   %eax
80104ded:	e8 0e c8 ff ff       	call   80101600 <ilock>

  if(ip->nlink < 1)
80104df2:	83 c4 10             	add    $0x10,%esp
80104df5:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
80104dfa:	0f 8e 24 01 00 00    	jle    80104f24 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104e00:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104e05:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104e08:	74 66                	je     80104e70 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104e0a:	83 ec 04             	sub    $0x4,%esp
80104e0d:	6a 10                	push   $0x10
80104e0f:	6a 00                	push   $0x0
80104e11:	56                   	push   %esi
80104e12:	e8 89 f5 ff ff       	call   801043a0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e17:	6a 10                	push   $0x10
80104e19:	ff 75 c4             	pushl  -0x3c(%ebp)
80104e1c:	56                   	push   %esi
80104e1d:	ff 75 b4             	pushl  -0x4c(%ebp)
80104e20:	e8 fb cb ff ff       	call   80101a20 <writei>
80104e25:	83 c4 20             	add    $0x20,%esp
80104e28:	83 f8 10             	cmp    $0x10,%eax
80104e2b:	0f 85 e6 00 00 00    	jne    80104f17 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104e31:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104e36:	0f 84 9c 00 00 00    	je     80104ed8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104e3c:	83 ec 0c             	sub    $0xc,%esp
80104e3f:	ff 75 b4             	pushl  -0x4c(%ebp)
80104e42:	e8 89 ca ff ff       	call   801018d0 <iunlockput>

  ip->nlink--;
80104e47:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80104e4c:	89 1c 24             	mov    %ebx,(%esp)
80104e4f:	e8 fc c6 ff ff       	call   80101550 <iupdate>
  iunlockput(ip);
80104e54:	89 1c 24             	mov    %ebx,(%esp)
80104e57:	e8 74 ca ff ff       	call   801018d0 <iunlockput>

  end_op();
80104e5c:	e8 6f dd ff ff       	call   80102bd0 <end_op>

  return 0;
80104e61:	83 c4 10             	add    $0x10,%esp
80104e64:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104e66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e69:	5b                   	pop    %ebx
80104e6a:	5e                   	pop    %esi
80104e6b:	5f                   	pop    %edi
80104e6c:	5d                   	pop    %ebp
80104e6d:	c3                   	ret    
80104e6e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104e70:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
80104e74:	76 94                	jbe    80104e0a <sys_unlink+0xba>
80104e76:	bf 20 00 00 00       	mov    $0x20,%edi
80104e7b:	eb 0f                	jmp    80104e8c <sys_unlink+0x13c>
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi
80104e80:	83 c7 10             	add    $0x10,%edi
80104e83:	3b 7b 18             	cmp    0x18(%ebx),%edi
80104e86:	0f 83 7e ff ff ff    	jae    80104e0a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e8c:	6a 10                	push   $0x10
80104e8e:	57                   	push   %edi
80104e8f:	56                   	push   %esi
80104e90:	53                   	push   %ebx
80104e91:	e8 8a ca ff ff       	call   80101920 <readi>
80104e96:	83 c4 10             	add    $0x10,%esp
80104e99:	83 f8 10             	cmp    $0x10,%eax
80104e9c:	75 6c                	jne    80104f0a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104e9e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104ea3:	74 db                	je     80104e80 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104ea5:	83 ec 0c             	sub    $0xc,%esp
80104ea8:	53                   	push   %ebx
80104ea9:	e8 22 ca ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104eae:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104eb1:	83 ec 0c             	sub    $0xc,%esp
80104eb4:	ff 75 b4             	pushl  -0x4c(%ebp)
80104eb7:	e8 14 ca ff ff       	call   801018d0 <iunlockput>
  end_op();
80104ebc:	e8 0f dd ff ff       	call   80102bd0 <end_op>
  return -1;
80104ec1:	83 c4 10             	add    $0x10,%esp
}
80104ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104ec7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ecc:	5b                   	pop    %ebx
80104ecd:	5e                   	pop    %esi
80104ece:	5f                   	pop    %edi
80104ecf:	5d                   	pop    %ebp
80104ed0:	c3                   	ret    
80104ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104ed8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80104edb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104ede:	66 83 68 16 01       	subw   $0x1,0x16(%eax)
    iupdate(dp);
80104ee3:	50                   	push   %eax
80104ee4:	e8 67 c6 ff ff       	call   80101550 <iupdate>
80104ee9:	83 c4 10             	add    $0x10,%esp
80104eec:	e9 4b ff ff ff       	jmp    80104e3c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80104ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ef6:	e9 6b ff ff ff       	jmp    80104e66 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80104efb:	e8 d0 dc ff ff       	call   80102bd0 <end_op>
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f05:	e9 5c ff ff ff       	jmp    80104e66 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104f0a:	83 ec 0c             	sub    $0xc,%esp
80104f0d:	68 5c 76 10 80       	push   $0x8010765c
80104f12:	e8 39 b4 ff ff       	call   80100350 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104f17:	83 ec 0c             	sub    $0xc,%esp
80104f1a:	68 6e 76 10 80       	push   $0x8010766e
80104f1f:	e8 2c b4 ff ff       	call   80100350 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104f24:	83 ec 0c             	sub    $0xc,%esp
80104f27:	68 4a 76 10 80       	push   $0x8010764a
80104f2c:	e8 1f b4 ff ff       	call   80100350 <panic>
80104f31:	eb 0d                	jmp    80104f40 <sys_open>
80104f33:	90                   	nop
80104f34:	90                   	nop
80104f35:	90                   	nop
80104f36:	90                   	nop
80104f37:	90                   	nop
80104f38:	90                   	nop
80104f39:	90                   	nop
80104f3a:	90                   	nop
80104f3b:	90                   	nop
80104f3c:	90                   	nop
80104f3d:	90                   	nop
80104f3e:	90                   	nop
80104f3f:	90                   	nop

80104f40 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	57                   	push   %edi
80104f44:	56                   	push   %esi
80104f45:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104f46:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80104f49:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104f4c:	50                   	push   %eax
80104f4d:	6a 00                	push   $0x0
80104f4f:	e8 cc f7 ff ff       	call   80104720 <argstr>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	85 c0                	test   %eax,%eax
80104f59:	0f 88 9e 00 00 00    	js     80104ffd <sys_open+0xbd>
80104f5f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104f62:	83 ec 08             	sub    $0x8,%esp
80104f65:	50                   	push   %eax
80104f66:	6a 01                	push   $0x1
80104f68:	e8 23 f7 ff ff       	call   80104690 <argint>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	0f 88 85 00 00 00    	js     80104ffd <sys_open+0xbd>
    return -1;

  begin_op();
80104f78:	e8 e3 db ff ff       	call   80102b60 <begin_op>

  if(omode & O_CREATE){
80104f7d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104f81:	0f 85 89 00 00 00    	jne    80105010 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104f87:	83 ec 0c             	sub    $0xc,%esp
80104f8a:	ff 75 e0             	pushl  -0x20(%ebp)
80104f8d:	e8 fe ce ff ff       	call   80101e90 <namei>
80104f92:	83 c4 10             	add    $0x10,%esp
80104f95:	85 c0                	test   %eax,%eax
80104f97:	89 c7                	mov    %eax,%edi
80104f99:	0f 84 8e 00 00 00    	je     8010502d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
80104f9f:	83 ec 0c             	sub    $0xc,%esp
80104fa2:	50                   	push   %eax
80104fa3:	e8 58 c6 ff ff       	call   80101600 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104fa8:	83 c4 10             	add    $0x10,%esp
80104fab:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
80104fb0:	0f 84 d2 00 00 00    	je     80105088 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104fb6:	e8 85 bd ff ff       	call   80100d40 <filealloc>
80104fbb:	85 c0                	test   %eax,%eax
80104fbd:	89 c6                	mov    %eax,%esi
80104fbf:	74 2b                	je     80104fec <sys_open+0xac>
80104fc1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104fc8:	31 db                	xor    %ebx,%ebx
80104fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104fd0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
80104fd4:	85 c0                	test   %eax,%eax
80104fd6:	74 68                	je     80105040 <sys_open+0x100>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104fd8:	83 c3 01             	add    $0x1,%ebx
80104fdb:	83 fb 10             	cmp    $0x10,%ebx
80104fde:	75 f0                	jne    80104fd0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80104fe0:	83 ec 0c             	sub    $0xc,%esp
80104fe3:	56                   	push   %esi
80104fe4:	e8 17 be ff ff       	call   80100e00 <fileclose>
80104fe9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80104fec:	83 ec 0c             	sub    $0xc,%esp
80104fef:	57                   	push   %edi
80104ff0:	e8 db c8 ff ff       	call   801018d0 <iunlockput>
    end_op();
80104ff5:	e8 d6 db ff ff       	call   80102bd0 <end_op>
    return -1;
80104ffa:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104ffd:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105005:	5b                   	pop    %ebx
80105006:	5e                   	pop    %esi
80105007:	5f                   	pop    %edi
80105008:	5d                   	pop    %ebp
80105009:	c3                   	ret    
8010500a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105010:	83 ec 0c             	sub    $0xc,%esp
80105013:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105016:	31 c9                	xor    %ecx,%ecx
80105018:	6a 00                	push   $0x0
8010501a:	ba 02 00 00 00       	mov    $0x2,%edx
8010501f:	e8 ec f7 ff ff       	call   80104810 <create>
    if(ip == 0){
80105024:	83 c4 10             	add    $0x10,%esp
80105027:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105029:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010502b:	75 89                	jne    80104fb6 <sys_open+0x76>
      end_op();
8010502d:	e8 9e db ff ff       	call   80102bd0 <end_op>
      return -1;
80105032:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105037:	eb 43                	jmp    8010507c <sys_open+0x13c>
80105039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105040:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105043:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105047:	57                   	push   %edi
80105048:	e8 c3 c6 ff ff       	call   80101710 <iunlock>
  end_op();
8010504d:	e8 7e db ff ff       	call   80102bd0 <end_op>

  f->type = FD_INODE;
80105052:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105058:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010505b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010505e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105061:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105068:	89 d0                	mov    %edx,%eax
8010506a:	83 e0 01             	and    $0x1,%eax
8010506d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105070:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105073:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105076:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
8010507a:	89 d8                	mov    %ebx,%eax
}
8010507c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010507f:	5b                   	pop    %ebx
80105080:	5e                   	pop    %esi
80105081:	5f                   	pop    %edi
80105082:	5d                   	pop    %ebp
80105083:	c3                   	ret    
80105084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105088:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010508b:	85 d2                	test   %edx,%edx
8010508d:	0f 84 23 ff ff ff    	je     80104fb6 <sys_open+0x76>
80105093:	e9 54 ff ff ff       	jmp    80104fec <sys_open+0xac>
80105098:	90                   	nop
80105099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801050a0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801050a6:	e8 b5 da ff ff       	call   80102b60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801050ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050ae:	83 ec 08             	sub    $0x8,%esp
801050b1:	50                   	push   %eax
801050b2:	6a 00                	push   $0x0
801050b4:	e8 67 f6 ff ff       	call   80104720 <argstr>
801050b9:	83 c4 10             	add    $0x10,%esp
801050bc:	85 c0                	test   %eax,%eax
801050be:	78 30                	js     801050f0 <sys_mkdir+0x50>
801050c0:	83 ec 0c             	sub    $0xc,%esp
801050c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050c6:	31 c9                	xor    %ecx,%ecx
801050c8:	6a 00                	push   $0x0
801050ca:	ba 01 00 00 00       	mov    $0x1,%edx
801050cf:	e8 3c f7 ff ff       	call   80104810 <create>
801050d4:	83 c4 10             	add    $0x10,%esp
801050d7:	85 c0                	test   %eax,%eax
801050d9:	74 15                	je     801050f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801050db:	83 ec 0c             	sub    $0xc,%esp
801050de:	50                   	push   %eax
801050df:	e8 ec c7 ff ff       	call   801018d0 <iunlockput>
  end_op();
801050e4:	e8 e7 da ff ff       	call   80102bd0 <end_op>
  return 0;
801050e9:	83 c4 10             	add    $0x10,%esp
801050ec:	31 c0                	xor    %eax,%eax
}
801050ee:	c9                   	leave  
801050ef:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801050f0:	e8 db da ff ff       	call   80102bd0 <end_op>
    return -1;
801050f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801050fa:	c9                   	leave  
801050fb:	c3                   	ret    
801050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105100 <sys_mknod>:

int
sys_mknod(void)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105106:	e8 55 da ff ff       	call   80102b60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010510b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010510e:	83 ec 08             	sub    $0x8,%esp
80105111:	50                   	push   %eax
80105112:	6a 00                	push   $0x0
80105114:	e8 07 f6 ff ff       	call   80104720 <argstr>
80105119:	83 c4 10             	add    $0x10,%esp
8010511c:	85 c0                	test   %eax,%eax
8010511e:	78 60                	js     80105180 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105120:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105123:	83 ec 08             	sub    $0x8,%esp
80105126:	50                   	push   %eax
80105127:	6a 01                	push   $0x1
80105129:	e8 62 f5 ff ff       	call   80104690 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010512e:	83 c4 10             	add    $0x10,%esp
80105131:	85 c0                	test   %eax,%eax
80105133:	78 4b                	js     80105180 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105135:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105138:	83 ec 08             	sub    $0x8,%esp
8010513b:	50                   	push   %eax
8010513c:	6a 02                	push   $0x2
8010513e:	e8 4d f5 ff ff       	call   80104690 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105143:	83 c4 10             	add    $0x10,%esp
80105146:	85 c0                	test   %eax,%eax
80105148:	78 36                	js     80105180 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010514a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010514e:	83 ec 0c             	sub    $0xc,%esp
80105151:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105155:	ba 03 00 00 00       	mov    $0x3,%edx
8010515a:	50                   	push   %eax
8010515b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010515e:	e8 ad f6 ff ff       	call   80104810 <create>
80105163:	83 c4 10             	add    $0x10,%esp
80105166:	85 c0                	test   %eax,%eax
80105168:	74 16                	je     80105180 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010516a:	83 ec 0c             	sub    $0xc,%esp
8010516d:	50                   	push   %eax
8010516e:	e8 5d c7 ff ff       	call   801018d0 <iunlockput>
  end_op();
80105173:	e8 58 da ff ff       	call   80102bd0 <end_op>
  return 0;
80105178:	83 c4 10             	add    $0x10,%esp
8010517b:	31 c0                	xor    %eax,%eax
}
8010517d:	c9                   	leave  
8010517e:	c3                   	ret    
8010517f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105180:	e8 4b da ff ff       	call   80102bd0 <end_op>
    return -1;
80105185:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010518a:	c9                   	leave  
8010518b:	c3                   	ret    
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105190 <sys_chdir>:

int
sys_chdir(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	53                   	push   %ebx
80105194:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105197:	e8 c4 d9 ff ff       	call   80102b60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010519c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010519f:	83 ec 08             	sub    $0x8,%esp
801051a2:	50                   	push   %eax
801051a3:	6a 00                	push   $0x0
801051a5:	e8 76 f5 ff ff       	call   80104720 <argstr>
801051aa:	83 c4 10             	add    $0x10,%esp
801051ad:	85 c0                	test   %eax,%eax
801051af:	78 7f                	js     80105230 <sys_chdir+0xa0>
801051b1:	83 ec 0c             	sub    $0xc,%esp
801051b4:	ff 75 f4             	pushl  -0xc(%ebp)
801051b7:	e8 d4 cc ff ff       	call   80101e90 <namei>
801051bc:	83 c4 10             	add    $0x10,%esp
801051bf:	85 c0                	test   %eax,%eax
801051c1:	89 c3                	mov    %eax,%ebx
801051c3:	74 6b                	je     80105230 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801051c5:	83 ec 0c             	sub    $0xc,%esp
801051c8:	50                   	push   %eax
801051c9:	e8 32 c4 ff ff       	call   80101600 <ilock>
  if(ip->type != T_DIR){
801051ce:	83 c4 10             	add    $0x10,%esp
801051d1:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801051d6:	75 38                	jne    80105210 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051d8:	83 ec 0c             	sub    $0xc,%esp
801051db:	53                   	push   %ebx
801051dc:	e8 2f c5 ff ff       	call   80101710 <iunlock>
  iput(proc->cwd);
801051e1:	58                   	pop    %eax
801051e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051e8:	ff 70 68             	pushl  0x68(%eax)
801051eb:	e8 80 c5 ff ff       	call   80101770 <iput>
  end_op();
801051f0:	e8 db d9 ff ff       	call   80102bd0 <end_op>
  proc->cwd = ip;
801051f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801051fb:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
801051fe:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105201:	31 c0                	xor    %eax,%eax
}
80105203:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105206:	c9                   	leave  
80105207:	c3                   	ret    
80105208:	90                   	nop
80105209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105210:	83 ec 0c             	sub    $0xc,%esp
80105213:	53                   	push   %ebx
80105214:	e8 b7 c6 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105219:	e8 b2 d9 ff ff       	call   80102bd0 <end_op>
    return -1;
8010521e:	83 c4 10             	add    $0x10,%esp
80105221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105226:	eb db                	jmp    80105203 <sys_chdir+0x73>
80105228:	90                   	nop
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105230:	e8 9b d9 ff ff       	call   80102bd0 <end_op>
    return -1;
80105235:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010523a:	eb c7                	jmp    80105203 <sys_chdir+0x73>
8010523c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105240 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	57                   	push   %edi
80105244:	56                   	push   %esi
80105245:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105246:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010524c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105252:	50                   	push   %eax
80105253:	6a 00                	push   $0x0
80105255:	e8 c6 f4 ff ff       	call   80104720 <argstr>
8010525a:	83 c4 10             	add    $0x10,%esp
8010525d:	85 c0                	test   %eax,%eax
8010525f:	78 7f                	js     801052e0 <sys_exec+0xa0>
80105261:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105267:	83 ec 08             	sub    $0x8,%esp
8010526a:	50                   	push   %eax
8010526b:	6a 01                	push   $0x1
8010526d:	e8 1e f4 ff ff       	call   80104690 <argint>
80105272:	83 c4 10             	add    $0x10,%esp
80105275:	85 c0                	test   %eax,%eax
80105277:	78 67                	js     801052e0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105279:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010527f:	83 ec 04             	sub    $0x4,%esp
80105282:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105288:	68 80 00 00 00       	push   $0x80
8010528d:	6a 00                	push   $0x0
8010528f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105295:	50                   	push   %eax
80105296:	31 db                	xor    %ebx,%ebx
80105298:	e8 03 f1 ff ff       	call   801043a0 <memset>
8010529d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801052a0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801052a6:	83 ec 08             	sub    $0x8,%esp
801052a9:	57                   	push   %edi
801052aa:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801052ad:	50                   	push   %eax
801052ae:	e8 5d f3 ff ff       	call   80104610 <fetchint>
801052b3:	83 c4 10             	add    $0x10,%esp
801052b6:	85 c0                	test   %eax,%eax
801052b8:	78 26                	js     801052e0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801052ba:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801052c0:	85 c0                	test   %eax,%eax
801052c2:	74 2c                	je     801052f0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801052c4:	83 ec 08             	sub    $0x8,%esp
801052c7:	56                   	push   %esi
801052c8:	50                   	push   %eax
801052c9:	e8 72 f3 ff ff       	call   80104640 <fetchstr>
801052ce:	83 c4 10             	add    $0x10,%esp
801052d1:	85 c0                	test   %eax,%eax
801052d3:	78 0b                	js     801052e0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801052d5:	83 c3 01             	add    $0x1,%ebx
801052d8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801052db:	83 fb 20             	cmp    $0x20,%ebx
801052de:	75 c0                	jne    801052a0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801052e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801052e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801052e8:	5b                   	pop    %ebx
801052e9:	5e                   	pop    %esi
801052ea:	5f                   	pop    %edi
801052eb:	5d                   	pop    %ebp
801052ec:	c3                   	ret    
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801052f0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801052f6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801052f9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105300:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105304:	50                   	push   %eax
80105305:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010530b:	e8 c0 b6 ff ff       	call   801009d0 <exec>
80105310:	83 c4 10             	add    $0x10,%esp
}
80105313:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105316:	5b                   	pop    %ebx
80105317:	5e                   	pop    %esi
80105318:	5f                   	pop    %edi
80105319:	5d                   	pop    %ebp
8010531a:	c3                   	ret    
8010531b:	90                   	nop
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_pipe>:

int
sys_pipe(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	57                   	push   %edi
80105324:	56                   	push   %esi
80105325:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105326:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105329:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010532c:	6a 08                	push   $0x8
8010532e:	50                   	push   %eax
8010532f:	6a 00                	push   $0x0
80105331:	e8 9a f3 ff ff       	call   801046d0 <argptr>
80105336:	83 c4 10             	add    $0x10,%esp
80105339:	85 c0                	test   %eax,%eax
8010533b:	78 48                	js     80105385 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010533d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105340:	83 ec 08             	sub    $0x8,%esp
80105343:	50                   	push   %eax
80105344:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105347:	50                   	push   %eax
80105348:	e8 f3 df ff ff       	call   80103340 <pipealloc>
8010534d:	83 c4 10             	add    $0x10,%esp
80105350:	85 c0                	test   %eax,%eax
80105352:	78 31                	js     80105385 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105354:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105357:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010535e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105360:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105364:	85 d2                	test   %edx,%edx
80105366:	74 28                	je     80105390 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105368:	83 c0 01             	add    $0x1,%eax
8010536b:	83 f8 10             	cmp    $0x10,%eax
8010536e:	75 f0                	jne    80105360 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	53                   	push   %ebx
80105374:	e8 87 ba ff ff       	call   80100e00 <fileclose>
    fileclose(wf);
80105379:	58                   	pop    %eax
8010537a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010537d:	e8 7e ba ff ff       	call   80100e00 <fileclose>
    return -1;
80105382:	83 c4 10             	add    $0x10,%esp
80105385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538a:	eb 45                	jmp    801053d1 <sys_pipe+0xb1>
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105390:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105393:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105396:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105398:	89 5e 28             	mov    %ebx,0x28(%esi)
8010539b:	90                   	nop
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
801053a0:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
801053a5:	74 19                	je     801053c0 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801053a7:	83 c2 01             	add    $0x1,%edx
801053aa:	83 fa 10             	cmp    $0x10,%edx
801053ad:	75 f1                	jne    801053a0 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
801053af:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801053b6:	eb b8                	jmp    80105370 <sys_pipe+0x50>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801053c0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801053c4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801053c7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801053c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801053cc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801053cf:	31 c0                	xor    %eax,%eax
}
801053d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053d4:	5b                   	pop    %ebx
801053d5:	5e                   	pop    %esi
801053d6:	5f                   	pop    %edi
801053d7:	5d                   	pop    %ebp
801053d8:	c3                   	ret    
801053d9:	66 90                	xchg   %ax,%ax
801053db:	66 90                	xchg   %ax,%ax
801053dd:	66 90                	xchg   %ax,%ax
801053df:	90                   	nop

801053e0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801053e3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801053e4:	e9 c7 e5 ff ff       	jmp    801039b0 <fork>
801053e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053f0 <sys_exit>:
}

int
sys_exit(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801053f6:	e8 45 e8 ff ff       	call   80103c40 <exit>
  return 0;  // not reached
}
801053fb:	31 c0                	xor    %eax,%eax
801053fd:	c9                   	leave  
801053fe:	c3                   	ret    
801053ff:	90                   	nop

80105400 <sys_wait>:

int
sys_wait(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105403:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105404:	e9 87 ea ff ff       	jmp    80103e90 <wait>
80105409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_kill>:
}

int
sys_kill(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105416:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105419:	50                   	push   %eax
8010541a:	6a 00                	push   $0x0
8010541c:	e8 6f f2 ff ff       	call   80104690 <argint>
80105421:	83 c4 10             	add    $0x10,%esp
80105424:	85 c0                	test   %eax,%eax
80105426:	78 18                	js     80105440 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105428:	83 ec 0c             	sub    $0xc,%esp
8010542b:	ff 75 f4             	pushl  -0xc(%ebp)
8010542e:	e8 ad eb ff ff       	call   80103fe0 <kill>
80105433:	83 c4 10             	add    $0x10,%esp
}
80105436:	c9                   	leave  
80105437:	c3                   	ret    
80105438:	90                   	nop
80105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105445:	c9                   	leave  
80105446:	c3                   	ret    
80105447:	89 f6                	mov    %esi,%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105450:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105456:	55                   	push   %ebp
80105457:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105459:	8b 40 10             	mov    0x10(%eax),%eax
}
8010545c:	5d                   	pop    %ebp
8010545d:	c3                   	ret    
8010545e:	66 90                	xchg   %ax,%ax

80105460 <sys_getcount>:

// Counts number of sys calls made
int sys_getcount(void) {
    if(count < 0)
80105460:	a1 8c f7 10 80       	mov    0x8010f78c,%eax
{
  return proc->pid;
}

// Counts number of sys calls made
int sys_getcount(void) {
80105465:	55                   	push   %ebp
    if(count < 0)
        return -1;
80105466:	ba ff ff ff ff       	mov    $0xffffffff,%edx
{
  return proc->pid;
}

// Counts number of sys calls made
int sys_getcount(void) {
8010546b:	89 e5                	mov    %esp,%ebp
    if(count < 0)
        return -1;
8010546d:	85 c0                	test   %eax,%eax
8010546f:	0f 48 c2             	cmovs  %edx,%eax
    // Returns count
    return count;
}//end count
80105472:	5d                   	pop    %ebp
80105473:	c3                   	ret    
80105474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010547a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105480 <sys_sbrk>:

int
sys_sbrk(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105484:	8d 45 f4             	lea    -0xc(%ebp),%eax
    return count;
}//end count

int
sys_sbrk(void)
{
80105487:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010548a:	50                   	push   %eax
8010548b:	6a 00                	push   $0x0
8010548d:	e8 fe f1 ff ff       	call   80104690 <argint>
80105492:	83 c4 10             	add    $0x10,%esp
80105495:	85 c0                	test   %eax,%eax
80105497:	78 27                	js     801054c0 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105499:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
8010549f:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
801054a2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801054a4:	ff 75 f4             	pushl  -0xc(%ebp)
801054a7:	e8 94 e4 ff ff       	call   80103940 <growproc>
801054ac:	83 c4 10             	add    $0x10,%esp
801054af:	85 c0                	test   %eax,%eax
801054b1:	78 0d                	js     801054c0 <sys_sbrk+0x40>
    return -1;
  return addr;
801054b3:	89 d8                	mov    %ebx,%eax
}
801054b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054b8:	c9                   	leave  
801054b9:	c3                   	ret    
801054ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801054c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054c5:	eb ee                	jmp    801054b5 <sys_sbrk+0x35>
801054c7:	89 f6                	mov    %esi,%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054d0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801054d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801054d7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801054da:	50                   	push   %eax
801054db:	6a 00                	push   $0x0
801054dd:	e8 ae f1 ff ff       	call   80104690 <argint>
801054e2:	83 c4 10             	add    $0x10,%esp
801054e5:	85 c0                	test   %eax,%eax
801054e7:	0f 88 8a 00 00 00    	js     80105577 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801054ed:	83 ec 0c             	sub    $0xc,%esp
801054f0:	68 20 3a 11 80       	push   $0x80113a20
801054f5:	e8 76 ec ff ff       	call   80104170 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801054fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054fd:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105500:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  while(ticks - ticks0 < n){
80105506:	85 d2                	test   %edx,%edx
80105508:	75 27                	jne    80105531 <sys_sleep+0x61>
8010550a:	eb 54                	jmp    80105560 <sys_sleep+0x90>
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105510:	83 ec 08             	sub    $0x8,%esp
80105513:	68 20 3a 11 80       	push   $0x80113a20
80105518:	68 60 42 11 80       	push   $0x80114260
8010551d:	e8 ae e8 ff ff       	call   80103dd0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105522:	a1 60 42 11 80       	mov    0x80114260,%eax
80105527:	83 c4 10             	add    $0x10,%esp
8010552a:	29 d8                	sub    %ebx,%eax
8010552c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010552f:	73 2f                	jae    80105560 <sys_sleep+0x90>
    if(proc->killed){
80105531:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105537:	8b 40 24             	mov    0x24(%eax),%eax
8010553a:	85 c0                	test   %eax,%eax
8010553c:	74 d2                	je     80105510 <sys_sleep+0x40>
      release(&tickslock);
8010553e:	83 ec 0c             	sub    $0xc,%esp
80105541:	68 20 3a 11 80       	push   $0x80113a20
80105546:	e8 05 ee ff ff       	call   80104350 <release>
      return -1;
8010554b:	83 c4 10             	add    $0x10,%esp
8010554e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105553:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105556:	c9                   	leave  
80105557:	c3                   	ret    
80105558:	90                   	nop
80105559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	68 20 3a 11 80       	push   $0x80113a20
80105568:	e8 e3 ed ff ff       	call   80104350 <release>
  return 0;
8010556d:	83 c4 10             	add    $0x10,%esp
80105570:	31 c0                	xor    %eax,%eax
}
80105572:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105575:	c9                   	leave  
80105576:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105577:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557c:	eb d5                	jmp    80105553 <sys_sleep+0x83>
8010557e:	66 90                	xchg   %ax,%ax

80105580 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	53                   	push   %ebx
80105584:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105587:	68 20 3a 11 80       	push   $0x80113a20
8010558c:	e8 df eb ff ff       	call   80104170 <acquire>
  xticks = ticks;
80105591:	8b 1d 60 42 11 80    	mov    0x80114260,%ebx
  release(&tickslock);
80105597:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
8010559e:	e8 ad ed ff ff       	call   80104350 <release>
  return xticks;
}
801055a3:	89 d8                	mov    %ebx,%eax
801055a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055a8:	c9                   	leave  
801055a9:	c3                   	ret    
801055aa:	66 90                	xchg   %ax,%ax
801055ac:	66 90                	xchg   %ax,%ax
801055ae:	66 90                	xchg   %ax,%ax

801055b0 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801055b0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801055b1:	ba 43 00 00 00       	mov    $0x43,%edx
801055b6:	b8 34 00 00 00       	mov    $0x34,%eax
801055bb:	89 e5                	mov    %esp,%ebp
801055bd:	83 ec 14             	sub    $0x14,%esp
801055c0:	ee                   	out    %al,(%dx)
801055c1:	ba 40 00 00 00       	mov    $0x40,%edx
801055c6:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
801055cb:	ee                   	out    %al,(%dx)
801055cc:	b8 2e 00 00 00       	mov    $0x2e,%eax
801055d1:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
801055d2:	6a 00                	push   $0x0
801055d4:	e8 97 dc ff ff       	call   80103270 <picenable>
}
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	c9                   	leave  
801055dd:	c3                   	ret    

801055de <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801055de:	1e                   	push   %ds
  pushl %es
801055df:	06                   	push   %es
  pushl %fs
801055e0:	0f a0                	push   %fs
  pushl %gs
801055e2:	0f a8                	push   %gs
  pushal
801055e4:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801055e5:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801055e9:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801055eb:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801055ed:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801055f1:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801055f3:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801055f5:	54                   	push   %esp
  call trap
801055f6:	e8 e5 00 00 00       	call   801056e0 <trap>
  addl $4, %esp
801055fb:	83 c4 04             	add    $0x4,%esp

801055fe <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801055fe:	61                   	popa   
  popl %gs
801055ff:	0f a9                	pop    %gs
  popl %fs
80105601:	0f a1                	pop    %fs
  popl %es
80105603:	07                   	pop    %es
  popl %ds
80105604:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105605:	83 c4 08             	add    $0x8,%esp
  iret
80105608:	cf                   	iret   
80105609:	66 90                	xchg   %ax,%ax
8010560b:	66 90                	xchg   %ax,%ax
8010560d:	66 90                	xchg   %ax,%ax
8010560f:	90                   	nop

80105610 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105610:	31 c0                	xor    %eax,%eax
80105612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105618:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
8010561f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105624:	c6 04 c5 64 3a 11 80 	movb   $0x0,-0x7feec59c(,%eax,8)
8010562b:	00 
8010562c:	66 89 0c c5 62 3a 11 	mov    %cx,-0x7feec59e(,%eax,8)
80105633:	80 
80105634:	c6 04 c5 65 3a 11 80 	movb   $0x8e,-0x7feec59b(,%eax,8)
8010563b:	8e 
8010563c:	66 89 14 c5 60 3a 11 	mov    %dx,-0x7feec5a0(,%eax,8)
80105643:	80 
80105644:	c1 ea 10             	shr    $0x10,%edx
80105647:	66 89 14 c5 66 3a 11 	mov    %dx,-0x7feec59a(,%eax,8)
8010564e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010564f:	83 c0 01             	add    $0x1,%eax
80105652:	3d 00 01 00 00       	cmp    $0x100,%eax
80105657:	75 bf                	jne    80105618 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105659:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010565a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010565f:	89 e5                	mov    %esp,%ebp
80105661:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105664:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105669:	68 7d 76 10 80       	push   $0x8010767d
8010566e:	68 20 3a 11 80       	push   $0x80113a20
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105673:	66 89 15 62 3c 11 80 	mov    %dx,0x80113c62
8010567a:	c6 05 64 3c 11 80 00 	movb   $0x0,0x80113c64
80105681:	66 a3 60 3c 11 80    	mov    %ax,0x80113c60
80105687:	c1 e8 10             	shr    $0x10,%eax
8010568a:	c6 05 65 3c 11 80 ef 	movb   $0xef,0x80113c65
80105691:	66 a3 66 3c 11 80    	mov    %ax,0x80113c66

  initlock(&tickslock, "time");
80105697:	e8 b4 ea ff ff       	call   80104150 <initlock>
}
8010569c:	83 c4 10             	add    $0x10,%esp
8010569f:	c9                   	leave  
801056a0:	c3                   	ret    
801056a1:	eb 0d                	jmp    801056b0 <idtinit>
801056a3:	90                   	nop
801056a4:	90                   	nop
801056a5:	90                   	nop
801056a6:	90                   	nop
801056a7:	90                   	nop
801056a8:	90                   	nop
801056a9:	90                   	nop
801056aa:	90                   	nop
801056ab:	90                   	nop
801056ac:	90                   	nop
801056ad:	90                   	nop
801056ae:	90                   	nop
801056af:	90                   	nop

801056b0 <idtinit>:

void
idtinit(void)
{
801056b0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801056b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801056b6:	89 e5                	mov    %esp,%ebp
801056b8:	83 ec 10             	sub    $0x10,%esp
801056bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801056bf:	b8 60 3a 11 80       	mov    $0x80113a60,%eax
801056c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801056c8:	c1 e8 10             	shr    $0x10,%eax
801056cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801056cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801056d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    
801056d7:	89 f6                	mov    %esi,%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
801056e4:	83 ec 04             	sub    $0x4,%esp
801056e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801056ea:	8b 43 30             	mov    0x30(%ebx),%eax
801056ed:	83 f8 40             	cmp    $0x40,%eax
801056f0:	0f 84 da 00 00 00    	je     801057d0 <trap+0xf0>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801056f6:	8d 50 e0             	lea    -0x20(%eax),%edx
801056f9:	83 fa 1f             	cmp    $0x1f,%edx
801056fc:	77 5a                	ja     80105758 <trap+0x78>
801056fe:	ff 24 95 64 77 10 80 	jmp    *-0x7fef889c(,%edx,4)
80105705:	8d 76 00             	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80105708:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010570e:	80 38 00             	cmpb   $0x0,(%eax)
80105711:	0f 84 f9 01 00 00    	je     80105910 <trap+0x230>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105717:	e8 04 d0 ff ff       	call   80102720 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010571c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105722:	85 c0                	test   %eax,%eax
80105724:	74 29                	je     8010574f <trap+0x6f>
80105726:	8b 50 24             	mov    0x24(%eax),%edx
80105729:	85 d2                	test   %edx,%edx
8010572b:	75 7b                	jne    801057a8 <trap+0xc8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  // Code using priority/timecpu queue's added here(LAB3)
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER) {
8010572d:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105731:	0f 84 d1 00 00 00    	je     80105808 <trap+0x128>
      yield();
    }//end else if
  }//end modification for priority/timecpu(lab3)

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105737:	8b 40 24             	mov    0x24(%eax),%eax
8010573a:	85 c0                	test   %eax,%eax
8010573c:	74 11                	je     8010574f <trap+0x6f>
8010573e:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105742:	83 e0 03             	and    $0x3,%eax
80105745:	66 83 f8 03          	cmp    $0x3,%ax
80105749:	0f 84 ab 00 00 00    	je     801057fa <trap+0x11a>
    exit();
}
8010574f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105752:	c9                   	leave  
80105753:	c3                   	ret    
80105754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80105758:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010575f:	85 d2                	test   %edx,%edx
80105761:	0f 84 1e 02 00 00    	je     80105985 <trap+0x2a5>
80105767:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010576b:	0f 84 14 02 00 00    	je     80105985 <trap+0x2a5>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105771:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105774:	51                   	push   %ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip,
80105775:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010577c:	ff 73 38             	pushl  0x38(%ebx)
8010577f:	0f b6 09             	movzbl (%ecx),%ecx
80105782:	51                   	push   %ecx
80105783:	ff 73 34             	pushl  0x34(%ebx)
80105786:	50                   	push   %eax
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip,
80105787:	8d 42 6c             	lea    0x6c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010578a:	50                   	push   %eax
8010578b:	ff 72 10             	pushl  0x10(%edx)
8010578e:	68 20 77 10 80       	push   $0x80107720
80105793:	e8 a8 ae ff ff       	call   80100640 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip,
            rcr2());
    proc->killed = 1;
80105798:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010579e:	83 c4 20             	add    $0x20,%esp
801057a1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801057a8:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
801057ac:	83 e2 03             	and    $0x3,%edx
801057af:	66 83 fa 03          	cmp    $0x3,%dx
801057b3:	0f 85 74 ff ff ff    	jne    8010572d <trap+0x4d>
    exit();
801057b9:	e8 82 e4 ff ff       	call   80103c40 <exit>
801057be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  // Code using priority/timecpu queue's added here(LAB3)
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER) {
801057c4:	85 c0                	test   %eax,%eax
801057c6:	0f 85 61 ff ff ff    	jne    8010572d <trap+0x4d>
801057cc:	eb 81                	jmp    8010574f <trap+0x6f>
801057ce:	66 90                	xchg   %ax,%ax
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
801057d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057d6:	8b 50 24             	mov    0x24(%eax),%edx
801057d9:	85 d2                	test   %edx,%edx
801057db:	0f 85 1f 01 00 00    	jne    80105900 <trap+0x220>
      exit();
    proc->tf = tf;
801057e1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801057e4:	e8 b7 ef ff ff       	call   801047a0 <syscall>
    if(proc->killed)
801057e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057ef:	8b 48 24             	mov    0x24(%eax),%ecx
801057f2:	85 c9                	test   %ecx,%ecx
801057f4:	0f 84 55 ff ff ff    	je     8010574f <trap+0x6f>
  }//end modification for priority/timecpu(lab3)

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801057fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057fd:	c9                   	leave  
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
801057fe:	e9 3d e4 ff ff       	jmp    80103c40 <exit>
80105803:	90                   	nop
80105804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  // Code using priority/timecpu queue's added here(LAB3)
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER) {
80105808:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010580c:	0f 85 25 ff ff ff    	jne    80105737 <trap+0x57>
    // Increase timecpu for process
    proc->timecpu++;
80105812:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
    cprintf("priority = %d", proc->priority);
80105819:	83 ec 08             	sub    $0x8,%esp
8010581c:	ff 70 7c             	pushl  0x7c(%eax)
8010581f:	68 87 76 10 80       	push   $0x80107687
80105824:	e8 17 ae ff ff       	call   80100640 <cprintf>
    cprintf("timecpu = %d", proc->timecpu);
80105829:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010582f:	5a                   	pop    %edx
80105830:	59                   	pop    %ecx
80105831:	ff b0 80 00 00 00    	pushl  0x80(%eax)
80105837:	68 95 76 10 80       	push   $0x80107695
8010583c:	e8 ff ad ff ff       	call   80100640 <cprintf>
        if it's on the lowest priority and timecpu is 2, it will yield
        otherwise, it will not yield (if timecpu is 1 and on lowest priority)
        */

    // Highest Priority -> If timecpu is equal to 1, reduce priority
    if(proc->priority == 1 && proc->timecpu == 1) {
80105841:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105847:	83 c4 10             	add    $0x10,%esp
8010584a:	8b 50 7c             	mov    0x7c(%eax),%edx
8010584d:	83 fa 01             	cmp    $0x1,%edx
80105850:	0f 84 ee 00 00 00    	je     80105944 <trap+0x264>
      cprintf("Moving p down %d\n", proc->pid);
      yield();
    }//end if

    // Lowest Priority -> If timecpu is equal to 2 and already on lowest, give up cpu
    else if(proc->priority == 0 && proc->timecpu == 2) {
80105856:	85 d2                	test   %edx,%edx
80105858:	0f 85 d9 fe ff ff    	jne    80105737 <trap+0x57>
8010585e:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
80105865:	0f 85 cc fe ff ff    	jne    80105737 <trap+0x57>
      proc->timecpu = 0; //reset timecpu
      cprintf("Timecpu up for %d\n", proc->pid);
8010586b:	83 ec 08             	sub    $0x8,%esp
      yield();
    }//end if

    // Lowest Priority -> If timecpu is equal to 2 and already on lowest, give up cpu
    else if(proc->priority == 0 && proc->timecpu == 2) {
      proc->timecpu = 0; //reset timecpu
8010586e:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80105875:	00 00 00 
      cprintf("Timecpu up for %d\n", proc->pid);
80105878:	ff 70 10             	pushl  0x10(%eax)
8010587b:	68 b4 76 10 80       	push   $0x801076b4
80105880:	e8 bb ad ff ff       	call   80100640 <cprintf>
      yield();
80105885:	e8 06 e5 ff ff       	call   80103d90 <yield>
8010588a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105890:	83 c4 10             	add    $0x10,%esp
    }//end else if
  }//end modification for priority/timecpu(lab3)

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105893:	85 c0                	test   %eax,%eax
80105895:	0f 85 9c fe ff ff    	jne    80105737 <trap+0x57>
8010589b:	e9 af fe ff ff       	jmp    8010574f <trap+0x6f>
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801058a0:	e8 0b cd ff ff       	call   801025b0 <kbdintr>
    lapiceoi();
801058a5:	e8 76 ce ff ff       	call   80102720 <lapiceoi>
    break;
801058aa:	e9 6d fe ff ff       	jmp    8010571c <trap+0x3c>
801058af:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801058b0:	e8 7b 02 00 00       	call   80105b30 <uartintr>
801058b5:	e9 5d fe ff ff       	jmp    80105717 <trap+0x37>
801058ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801058c0:	ff 73 38             	pushl  0x38(%ebx)
801058c3:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801058c7:	50                   	push   %eax
            cpu->id, tf->cs, tf->eip);
801058c8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801058ce:	0f b6 00             	movzbl (%eax),%eax
801058d1:	50                   	push   %eax
801058d2:	68 c8 76 10 80       	push   $0x801076c8
801058d7:	e8 64 ad ff ff       	call   80100640 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
801058dc:	e8 3f ce ff ff       	call   80102720 <lapiceoi>
    break;
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	e9 33 fe ff ff       	jmp    8010571c <trap+0x3c>
801058e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801058f0:	e8 3b c7 ff ff       	call   80102030 <ideintr>
    lapiceoi();
801058f5:	e8 26 ce ff ff       	call   80102720 <lapiceoi>
    break;
801058fa:	e9 1d fe ff ff       	jmp    8010571c <trap+0x3c>
801058ff:	90                   	nop
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
80105900:	e8 3b e3 ff ff       	call   80103c40 <exit>
80105905:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010590b:	e9 d1 fe ff ff       	jmp    801057e1 <trap+0x101>
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
      acquire(&tickslock);
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	68 20 3a 11 80       	push   $0x80113a20
80105918:	e8 53 e8 ff ff       	call   80104170 <acquire>
      ticks++;
      wakeup(&ticks);
8010591d:	c7 04 24 60 42 11 80 	movl   $0x80114260,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
      acquire(&tickslock);
      ticks++;
80105924:	83 05 60 42 11 80 01 	addl   $0x1,0x80114260
      wakeup(&ticks);
8010592b:	e8 50 e6 ff ff       	call   80103f80 <wakeup>
      release(&tickslock);
80105930:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80105937:	e8 14 ea ff ff       	call   80104350 <release>
8010593c:	83 c4 10             	add    $0x10,%esp
8010593f:	e9 d3 fd ff ff       	jmp    80105717 <trap+0x37>
        if it's on the lowest priority and timecpu is 2, it will yield
        otherwise, it will not yield (if timecpu is 1 and on lowest priority)
        */

    // Highest Priority -> If timecpu is equal to 1, reduce priority
    if(proc->priority == 1 && proc->timecpu == 1) {
80105944:	83 b8 80 00 00 00 01 	cmpl   $0x1,0x80(%eax)
8010594b:	0f 85 e6 fd ff ff    	jne    80105737 <trap+0x57>
      proc->timecpu--;
      proc->priority--;
      cprintf("Moving p down %d\n", proc->pid);
80105951:	83 ec 08             	sub    $0x8,%esp
        otherwise, it will not yield (if timecpu is 1 and on lowest priority)
        */

    // Highest Priority -> If timecpu is equal to 1, reduce priority
    if(proc->priority == 1 && proc->timecpu == 1) {
      proc->timecpu--;
80105954:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010595b:	00 00 00 
      proc->priority--;
8010595e:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
      cprintf("Moving p down %d\n", proc->pid);
80105965:	ff 70 10             	pushl  0x10(%eax)
80105968:	68 a2 76 10 80       	push   $0x801076a2
8010596d:	e8 ce ac ff ff       	call   80100640 <cprintf>
      yield();
80105972:	e8 19 e4 ff ff       	call   80103d90 <yield>
80105977:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010597d:	83 c4 10             	add    $0x10,%esp
80105980:	e9 0e ff ff ff       	jmp    80105893 <trap+0x1b3>
80105985:	0f 20 d2             	mov    %cr2,%edx

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105988:	83 ec 0c             	sub    $0xc,%esp
8010598b:	52                   	push   %edx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010598c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105993:	ff 73 38             	pushl  0x38(%ebx)
80105996:	0f b6 12             	movzbl (%edx),%edx
80105999:	52                   	push   %edx
8010599a:	50                   	push   %eax
8010599b:	68 ec 76 10 80       	push   $0x801076ec
801059a0:	e8 9b ac ff ff       	call   80100640 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801059a5:	83 c4 14             	add    $0x14,%esp
801059a8:	68 82 76 10 80       	push   $0x80107682
801059ad:	e8 9e a9 ff ff       	call   80100350 <panic>
801059b2:	66 90                	xchg   %ax,%ax
801059b4:	66 90                	xchg   %ax,%ax
801059b6:	66 90                	xchg   %ax,%ax
801059b8:	66 90                	xchg   %ax,%ax
801059ba:	66 90                	xchg   %ax,%ax
801059bc:	66 90                	xchg   %ax,%ax
801059be:	66 90                	xchg   %ax,%ax

801059c0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801059c0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801059c5:	55                   	push   %ebp
801059c6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801059c8:	85 c0                	test   %eax,%eax
801059ca:	74 1c                	je     801059e8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801059cc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801059d1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801059d2:	a8 01                	test   $0x1,%al
801059d4:	74 12                	je     801059e8 <uartgetc+0x28>
801059d6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801059db:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801059dc:	0f b6 c0             	movzbl %al,%eax
}
801059df:	5d                   	pop    %ebp
801059e0:	c3                   	ret    
801059e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801059e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801059ed:	5d                   	pop    %ebp
801059ee:	c3                   	ret    
801059ef:	90                   	nop

801059f0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	57                   	push   %edi
801059f4:	56                   	push   %esi
801059f5:	53                   	push   %ebx
801059f6:	89 c7                	mov    %eax,%edi
801059f8:	bb 80 00 00 00       	mov    $0x80,%ebx
801059fd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a02:	83 ec 0c             	sub    $0xc,%esp
80105a05:	eb 1b                	jmp    80105a22 <uartputc.part.0+0x32>
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	6a 0a                	push   $0xa
80105a15:	e8 26 cd ff ff       	call   80102740 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	83 eb 01             	sub    $0x1,%ebx
80105a20:	74 07                	je     80105a29 <uartputc.part.0+0x39>
80105a22:	89 f2                	mov    %esi,%edx
80105a24:	ec                   	in     (%dx),%al
80105a25:	a8 20                	test   $0x20,%al
80105a27:	74 e7                	je     80105a10 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a29:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a2e:	89 f8                	mov    %edi,%eax
80105a30:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105a31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a34:	5b                   	pop    %ebx
80105a35:	5e                   	pop    %esi
80105a36:	5f                   	pop    %edi
80105a37:	5d                   	pop    %ebp
80105a38:	c3                   	ret    
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a40 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105a40:	55                   	push   %ebp
80105a41:	31 c9                	xor    %ecx,%ecx
80105a43:	89 c8                	mov    %ecx,%eax
80105a45:	89 e5                	mov    %esp,%ebp
80105a47:	57                   	push   %edi
80105a48:	56                   	push   %esi
80105a49:	53                   	push   %ebx
80105a4a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105a4f:	89 da                	mov    %ebx,%edx
80105a51:	83 ec 0c             	sub    $0xc,%esp
80105a54:	ee                   	out    %al,(%dx)
80105a55:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105a5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105a5f:	89 fa                	mov    %edi,%edx
80105a61:	ee                   	out    %al,(%dx)
80105a62:	b8 0c 00 00 00       	mov    $0xc,%eax
80105a67:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a6c:	ee                   	out    %al,(%dx)
80105a6d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105a72:	89 c8                	mov    %ecx,%eax
80105a74:	89 f2                	mov    %esi,%edx
80105a76:	ee                   	out    %al,(%dx)
80105a77:	b8 03 00 00 00       	mov    $0x3,%eax
80105a7c:	89 fa                	mov    %edi,%edx
80105a7e:	ee                   	out    %al,(%dx)
80105a7f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105a84:	89 c8                	mov    %ecx,%eax
80105a86:	ee                   	out    %al,(%dx)
80105a87:	b8 01 00 00 00       	mov    $0x1,%eax
80105a8c:	89 f2                	mov    %esi,%edx
80105a8e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a8f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105a94:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105a95:	3c ff                	cmp    $0xff,%al
80105a97:	74 5a                	je     80105af3 <uartinit+0xb3>
    return;
  uart = 1;
80105a99:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105aa0:	00 00 00 
80105aa3:	89 da                	mov    %ebx,%edx
80105aa5:	ec                   	in     (%dx),%al
80105aa6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aab:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105aac:	83 ec 0c             	sub    $0xc,%esp
80105aaf:	6a 04                	push   $0x4
80105ab1:	e8 ba d7 ff ff       	call   80103270 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105ab6:	59                   	pop    %ecx
80105ab7:	5b                   	pop    %ebx
80105ab8:	6a 00                	push   $0x0
80105aba:	6a 04                	push   $0x4
80105abc:	bb e4 77 10 80       	mov    $0x801077e4,%ebx
80105ac1:	e8 ba c7 ff ff       	call   80102280 <ioapicenable>
80105ac6:	83 c4 10             	add    $0x10,%esp
80105ac9:	b8 78 00 00 00       	mov    $0x78,%eax
80105ace:	eb 0a                	jmp    80105ada <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ad0:	83 c3 01             	add    $0x1,%ebx
80105ad3:	0f be 03             	movsbl (%ebx),%eax
80105ad6:	84 c0                	test   %al,%al
80105ad8:	74 19                	je     80105af3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105ada:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105ae0:	85 d2                	test   %edx,%edx
80105ae2:	74 ec                	je     80105ad0 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ae4:	83 c3 01             	add    $0x1,%ebx
80105ae7:	e8 04 ff ff ff       	call   801059f0 <uartputc.part.0>
80105aec:	0f be 03             	movsbl (%ebx),%eax
80105aef:	84 c0                	test   %al,%al
80105af1:	75 e7                	jne    80105ada <uartinit+0x9a>
    uartputc(*p);
}
80105af3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105af6:	5b                   	pop    %ebx
80105af7:	5e                   	pop    %esi
80105af8:	5f                   	pop    %edi
80105af9:	5d                   	pop    %ebp
80105afa:	c3                   	ret    
80105afb:	90                   	nop
80105afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b00 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105b00:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b06:	55                   	push   %ebp
80105b07:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105b09:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105b0e:	74 10                	je     80105b20 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105b10:	5d                   	pop    %ebp
80105b11:	e9 da fe ff ff       	jmp    801059f0 <uartputc.part.0>
80105b16:	8d 76 00             	lea    0x0(%esi),%esi
80105b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b20:	5d                   	pop    %ebp
80105b21:	c3                   	ret    
80105b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b30 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105b36:	68 c0 59 10 80       	push   $0x801059c0
80105b3b:	e8 90 ac ff ff       	call   801007d0 <consoleintr>
}
80105b40:	83 c4 10             	add    $0x10,%esp
80105b43:	c9                   	leave  
80105b44:	c3                   	ret    

80105b45 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105b45:	6a 00                	push   $0x0
  pushl $0
80105b47:	6a 00                	push   $0x0
  jmp alltraps
80105b49:	e9 90 fa ff ff       	jmp    801055de <alltraps>

80105b4e <vector1>:
.globl vector1
vector1:
  pushl $0
80105b4e:	6a 00                	push   $0x0
  pushl $1
80105b50:	6a 01                	push   $0x1
  jmp alltraps
80105b52:	e9 87 fa ff ff       	jmp    801055de <alltraps>

80105b57 <vector2>:
.globl vector2
vector2:
  pushl $0
80105b57:	6a 00                	push   $0x0
  pushl $2
80105b59:	6a 02                	push   $0x2
  jmp alltraps
80105b5b:	e9 7e fa ff ff       	jmp    801055de <alltraps>

80105b60 <vector3>:
.globl vector3
vector3:
  pushl $0
80105b60:	6a 00                	push   $0x0
  pushl $3
80105b62:	6a 03                	push   $0x3
  jmp alltraps
80105b64:	e9 75 fa ff ff       	jmp    801055de <alltraps>

80105b69 <vector4>:
.globl vector4
vector4:
  pushl $0
80105b69:	6a 00                	push   $0x0
  pushl $4
80105b6b:	6a 04                	push   $0x4
  jmp alltraps
80105b6d:	e9 6c fa ff ff       	jmp    801055de <alltraps>

80105b72 <vector5>:
.globl vector5
vector5:
  pushl $0
80105b72:	6a 00                	push   $0x0
  pushl $5
80105b74:	6a 05                	push   $0x5
  jmp alltraps
80105b76:	e9 63 fa ff ff       	jmp    801055de <alltraps>

80105b7b <vector6>:
.globl vector6
vector6:
  pushl $0
80105b7b:	6a 00                	push   $0x0
  pushl $6
80105b7d:	6a 06                	push   $0x6
  jmp alltraps
80105b7f:	e9 5a fa ff ff       	jmp    801055de <alltraps>

80105b84 <vector7>:
.globl vector7
vector7:
  pushl $0
80105b84:	6a 00                	push   $0x0
  pushl $7
80105b86:	6a 07                	push   $0x7
  jmp alltraps
80105b88:	e9 51 fa ff ff       	jmp    801055de <alltraps>

80105b8d <vector8>:
.globl vector8
vector8:
  pushl $8
80105b8d:	6a 08                	push   $0x8
  jmp alltraps
80105b8f:	e9 4a fa ff ff       	jmp    801055de <alltraps>

80105b94 <vector9>:
.globl vector9
vector9:
  pushl $0
80105b94:	6a 00                	push   $0x0
  pushl $9
80105b96:	6a 09                	push   $0x9
  jmp alltraps
80105b98:	e9 41 fa ff ff       	jmp    801055de <alltraps>

80105b9d <vector10>:
.globl vector10
vector10:
  pushl $10
80105b9d:	6a 0a                	push   $0xa
  jmp alltraps
80105b9f:	e9 3a fa ff ff       	jmp    801055de <alltraps>

80105ba4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ba4:	6a 0b                	push   $0xb
  jmp alltraps
80105ba6:	e9 33 fa ff ff       	jmp    801055de <alltraps>

80105bab <vector12>:
.globl vector12
vector12:
  pushl $12
80105bab:	6a 0c                	push   $0xc
  jmp alltraps
80105bad:	e9 2c fa ff ff       	jmp    801055de <alltraps>

80105bb2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105bb2:	6a 0d                	push   $0xd
  jmp alltraps
80105bb4:	e9 25 fa ff ff       	jmp    801055de <alltraps>

80105bb9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105bb9:	6a 0e                	push   $0xe
  jmp alltraps
80105bbb:	e9 1e fa ff ff       	jmp    801055de <alltraps>

80105bc0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105bc0:	6a 00                	push   $0x0
  pushl $15
80105bc2:	6a 0f                	push   $0xf
  jmp alltraps
80105bc4:	e9 15 fa ff ff       	jmp    801055de <alltraps>

80105bc9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105bc9:	6a 00                	push   $0x0
  pushl $16
80105bcb:	6a 10                	push   $0x10
  jmp alltraps
80105bcd:	e9 0c fa ff ff       	jmp    801055de <alltraps>

80105bd2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105bd2:	6a 11                	push   $0x11
  jmp alltraps
80105bd4:	e9 05 fa ff ff       	jmp    801055de <alltraps>

80105bd9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105bd9:	6a 00                	push   $0x0
  pushl $18
80105bdb:	6a 12                	push   $0x12
  jmp alltraps
80105bdd:	e9 fc f9 ff ff       	jmp    801055de <alltraps>

80105be2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105be2:	6a 00                	push   $0x0
  pushl $19
80105be4:	6a 13                	push   $0x13
  jmp alltraps
80105be6:	e9 f3 f9 ff ff       	jmp    801055de <alltraps>

80105beb <vector20>:
.globl vector20
vector20:
  pushl $0
80105beb:	6a 00                	push   $0x0
  pushl $20
80105bed:	6a 14                	push   $0x14
  jmp alltraps
80105bef:	e9 ea f9 ff ff       	jmp    801055de <alltraps>

80105bf4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105bf4:	6a 00                	push   $0x0
  pushl $21
80105bf6:	6a 15                	push   $0x15
  jmp alltraps
80105bf8:	e9 e1 f9 ff ff       	jmp    801055de <alltraps>

80105bfd <vector22>:
.globl vector22
vector22:
  pushl $0
80105bfd:	6a 00                	push   $0x0
  pushl $22
80105bff:	6a 16                	push   $0x16
  jmp alltraps
80105c01:	e9 d8 f9 ff ff       	jmp    801055de <alltraps>

80105c06 <vector23>:
.globl vector23
vector23:
  pushl $0
80105c06:	6a 00                	push   $0x0
  pushl $23
80105c08:	6a 17                	push   $0x17
  jmp alltraps
80105c0a:	e9 cf f9 ff ff       	jmp    801055de <alltraps>

80105c0f <vector24>:
.globl vector24
vector24:
  pushl $0
80105c0f:	6a 00                	push   $0x0
  pushl $24
80105c11:	6a 18                	push   $0x18
  jmp alltraps
80105c13:	e9 c6 f9 ff ff       	jmp    801055de <alltraps>

80105c18 <vector25>:
.globl vector25
vector25:
  pushl $0
80105c18:	6a 00                	push   $0x0
  pushl $25
80105c1a:	6a 19                	push   $0x19
  jmp alltraps
80105c1c:	e9 bd f9 ff ff       	jmp    801055de <alltraps>

80105c21 <vector26>:
.globl vector26
vector26:
  pushl $0
80105c21:	6a 00                	push   $0x0
  pushl $26
80105c23:	6a 1a                	push   $0x1a
  jmp alltraps
80105c25:	e9 b4 f9 ff ff       	jmp    801055de <alltraps>

80105c2a <vector27>:
.globl vector27
vector27:
  pushl $0
80105c2a:	6a 00                	push   $0x0
  pushl $27
80105c2c:	6a 1b                	push   $0x1b
  jmp alltraps
80105c2e:	e9 ab f9 ff ff       	jmp    801055de <alltraps>

80105c33 <vector28>:
.globl vector28
vector28:
  pushl $0
80105c33:	6a 00                	push   $0x0
  pushl $28
80105c35:	6a 1c                	push   $0x1c
  jmp alltraps
80105c37:	e9 a2 f9 ff ff       	jmp    801055de <alltraps>

80105c3c <vector29>:
.globl vector29
vector29:
  pushl $0
80105c3c:	6a 00                	push   $0x0
  pushl $29
80105c3e:	6a 1d                	push   $0x1d
  jmp alltraps
80105c40:	e9 99 f9 ff ff       	jmp    801055de <alltraps>

80105c45 <vector30>:
.globl vector30
vector30:
  pushl $0
80105c45:	6a 00                	push   $0x0
  pushl $30
80105c47:	6a 1e                	push   $0x1e
  jmp alltraps
80105c49:	e9 90 f9 ff ff       	jmp    801055de <alltraps>

80105c4e <vector31>:
.globl vector31
vector31:
  pushl $0
80105c4e:	6a 00                	push   $0x0
  pushl $31
80105c50:	6a 1f                	push   $0x1f
  jmp alltraps
80105c52:	e9 87 f9 ff ff       	jmp    801055de <alltraps>

80105c57 <vector32>:
.globl vector32
vector32:
  pushl $0
80105c57:	6a 00                	push   $0x0
  pushl $32
80105c59:	6a 20                	push   $0x20
  jmp alltraps
80105c5b:	e9 7e f9 ff ff       	jmp    801055de <alltraps>

80105c60 <vector33>:
.globl vector33
vector33:
  pushl $0
80105c60:	6a 00                	push   $0x0
  pushl $33
80105c62:	6a 21                	push   $0x21
  jmp alltraps
80105c64:	e9 75 f9 ff ff       	jmp    801055de <alltraps>

80105c69 <vector34>:
.globl vector34
vector34:
  pushl $0
80105c69:	6a 00                	push   $0x0
  pushl $34
80105c6b:	6a 22                	push   $0x22
  jmp alltraps
80105c6d:	e9 6c f9 ff ff       	jmp    801055de <alltraps>

80105c72 <vector35>:
.globl vector35
vector35:
  pushl $0
80105c72:	6a 00                	push   $0x0
  pushl $35
80105c74:	6a 23                	push   $0x23
  jmp alltraps
80105c76:	e9 63 f9 ff ff       	jmp    801055de <alltraps>

80105c7b <vector36>:
.globl vector36
vector36:
  pushl $0
80105c7b:	6a 00                	push   $0x0
  pushl $36
80105c7d:	6a 24                	push   $0x24
  jmp alltraps
80105c7f:	e9 5a f9 ff ff       	jmp    801055de <alltraps>

80105c84 <vector37>:
.globl vector37
vector37:
  pushl $0
80105c84:	6a 00                	push   $0x0
  pushl $37
80105c86:	6a 25                	push   $0x25
  jmp alltraps
80105c88:	e9 51 f9 ff ff       	jmp    801055de <alltraps>

80105c8d <vector38>:
.globl vector38
vector38:
  pushl $0
80105c8d:	6a 00                	push   $0x0
  pushl $38
80105c8f:	6a 26                	push   $0x26
  jmp alltraps
80105c91:	e9 48 f9 ff ff       	jmp    801055de <alltraps>

80105c96 <vector39>:
.globl vector39
vector39:
  pushl $0
80105c96:	6a 00                	push   $0x0
  pushl $39
80105c98:	6a 27                	push   $0x27
  jmp alltraps
80105c9a:	e9 3f f9 ff ff       	jmp    801055de <alltraps>

80105c9f <vector40>:
.globl vector40
vector40:
  pushl $0
80105c9f:	6a 00                	push   $0x0
  pushl $40
80105ca1:	6a 28                	push   $0x28
  jmp alltraps
80105ca3:	e9 36 f9 ff ff       	jmp    801055de <alltraps>

80105ca8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ca8:	6a 00                	push   $0x0
  pushl $41
80105caa:	6a 29                	push   $0x29
  jmp alltraps
80105cac:	e9 2d f9 ff ff       	jmp    801055de <alltraps>

80105cb1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105cb1:	6a 00                	push   $0x0
  pushl $42
80105cb3:	6a 2a                	push   $0x2a
  jmp alltraps
80105cb5:	e9 24 f9 ff ff       	jmp    801055de <alltraps>

80105cba <vector43>:
.globl vector43
vector43:
  pushl $0
80105cba:	6a 00                	push   $0x0
  pushl $43
80105cbc:	6a 2b                	push   $0x2b
  jmp alltraps
80105cbe:	e9 1b f9 ff ff       	jmp    801055de <alltraps>

80105cc3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105cc3:	6a 00                	push   $0x0
  pushl $44
80105cc5:	6a 2c                	push   $0x2c
  jmp alltraps
80105cc7:	e9 12 f9 ff ff       	jmp    801055de <alltraps>

80105ccc <vector45>:
.globl vector45
vector45:
  pushl $0
80105ccc:	6a 00                	push   $0x0
  pushl $45
80105cce:	6a 2d                	push   $0x2d
  jmp alltraps
80105cd0:	e9 09 f9 ff ff       	jmp    801055de <alltraps>

80105cd5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105cd5:	6a 00                	push   $0x0
  pushl $46
80105cd7:	6a 2e                	push   $0x2e
  jmp alltraps
80105cd9:	e9 00 f9 ff ff       	jmp    801055de <alltraps>

80105cde <vector47>:
.globl vector47
vector47:
  pushl $0
80105cde:	6a 00                	push   $0x0
  pushl $47
80105ce0:	6a 2f                	push   $0x2f
  jmp alltraps
80105ce2:	e9 f7 f8 ff ff       	jmp    801055de <alltraps>

80105ce7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105ce7:	6a 00                	push   $0x0
  pushl $48
80105ce9:	6a 30                	push   $0x30
  jmp alltraps
80105ceb:	e9 ee f8 ff ff       	jmp    801055de <alltraps>

80105cf0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105cf0:	6a 00                	push   $0x0
  pushl $49
80105cf2:	6a 31                	push   $0x31
  jmp alltraps
80105cf4:	e9 e5 f8 ff ff       	jmp    801055de <alltraps>

80105cf9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105cf9:	6a 00                	push   $0x0
  pushl $50
80105cfb:	6a 32                	push   $0x32
  jmp alltraps
80105cfd:	e9 dc f8 ff ff       	jmp    801055de <alltraps>

80105d02 <vector51>:
.globl vector51
vector51:
  pushl $0
80105d02:	6a 00                	push   $0x0
  pushl $51
80105d04:	6a 33                	push   $0x33
  jmp alltraps
80105d06:	e9 d3 f8 ff ff       	jmp    801055de <alltraps>

80105d0b <vector52>:
.globl vector52
vector52:
  pushl $0
80105d0b:	6a 00                	push   $0x0
  pushl $52
80105d0d:	6a 34                	push   $0x34
  jmp alltraps
80105d0f:	e9 ca f8 ff ff       	jmp    801055de <alltraps>

80105d14 <vector53>:
.globl vector53
vector53:
  pushl $0
80105d14:	6a 00                	push   $0x0
  pushl $53
80105d16:	6a 35                	push   $0x35
  jmp alltraps
80105d18:	e9 c1 f8 ff ff       	jmp    801055de <alltraps>

80105d1d <vector54>:
.globl vector54
vector54:
  pushl $0
80105d1d:	6a 00                	push   $0x0
  pushl $54
80105d1f:	6a 36                	push   $0x36
  jmp alltraps
80105d21:	e9 b8 f8 ff ff       	jmp    801055de <alltraps>

80105d26 <vector55>:
.globl vector55
vector55:
  pushl $0
80105d26:	6a 00                	push   $0x0
  pushl $55
80105d28:	6a 37                	push   $0x37
  jmp alltraps
80105d2a:	e9 af f8 ff ff       	jmp    801055de <alltraps>

80105d2f <vector56>:
.globl vector56
vector56:
  pushl $0
80105d2f:	6a 00                	push   $0x0
  pushl $56
80105d31:	6a 38                	push   $0x38
  jmp alltraps
80105d33:	e9 a6 f8 ff ff       	jmp    801055de <alltraps>

80105d38 <vector57>:
.globl vector57
vector57:
  pushl $0
80105d38:	6a 00                	push   $0x0
  pushl $57
80105d3a:	6a 39                	push   $0x39
  jmp alltraps
80105d3c:	e9 9d f8 ff ff       	jmp    801055de <alltraps>

80105d41 <vector58>:
.globl vector58
vector58:
  pushl $0
80105d41:	6a 00                	push   $0x0
  pushl $58
80105d43:	6a 3a                	push   $0x3a
  jmp alltraps
80105d45:	e9 94 f8 ff ff       	jmp    801055de <alltraps>

80105d4a <vector59>:
.globl vector59
vector59:
  pushl $0
80105d4a:	6a 00                	push   $0x0
  pushl $59
80105d4c:	6a 3b                	push   $0x3b
  jmp alltraps
80105d4e:	e9 8b f8 ff ff       	jmp    801055de <alltraps>

80105d53 <vector60>:
.globl vector60
vector60:
  pushl $0
80105d53:	6a 00                	push   $0x0
  pushl $60
80105d55:	6a 3c                	push   $0x3c
  jmp alltraps
80105d57:	e9 82 f8 ff ff       	jmp    801055de <alltraps>

80105d5c <vector61>:
.globl vector61
vector61:
  pushl $0
80105d5c:	6a 00                	push   $0x0
  pushl $61
80105d5e:	6a 3d                	push   $0x3d
  jmp alltraps
80105d60:	e9 79 f8 ff ff       	jmp    801055de <alltraps>

80105d65 <vector62>:
.globl vector62
vector62:
  pushl $0
80105d65:	6a 00                	push   $0x0
  pushl $62
80105d67:	6a 3e                	push   $0x3e
  jmp alltraps
80105d69:	e9 70 f8 ff ff       	jmp    801055de <alltraps>

80105d6e <vector63>:
.globl vector63
vector63:
  pushl $0
80105d6e:	6a 00                	push   $0x0
  pushl $63
80105d70:	6a 3f                	push   $0x3f
  jmp alltraps
80105d72:	e9 67 f8 ff ff       	jmp    801055de <alltraps>

80105d77 <vector64>:
.globl vector64
vector64:
  pushl $0
80105d77:	6a 00                	push   $0x0
  pushl $64
80105d79:	6a 40                	push   $0x40
  jmp alltraps
80105d7b:	e9 5e f8 ff ff       	jmp    801055de <alltraps>

80105d80 <vector65>:
.globl vector65
vector65:
  pushl $0
80105d80:	6a 00                	push   $0x0
  pushl $65
80105d82:	6a 41                	push   $0x41
  jmp alltraps
80105d84:	e9 55 f8 ff ff       	jmp    801055de <alltraps>

80105d89 <vector66>:
.globl vector66
vector66:
  pushl $0
80105d89:	6a 00                	push   $0x0
  pushl $66
80105d8b:	6a 42                	push   $0x42
  jmp alltraps
80105d8d:	e9 4c f8 ff ff       	jmp    801055de <alltraps>

80105d92 <vector67>:
.globl vector67
vector67:
  pushl $0
80105d92:	6a 00                	push   $0x0
  pushl $67
80105d94:	6a 43                	push   $0x43
  jmp alltraps
80105d96:	e9 43 f8 ff ff       	jmp    801055de <alltraps>

80105d9b <vector68>:
.globl vector68
vector68:
  pushl $0
80105d9b:	6a 00                	push   $0x0
  pushl $68
80105d9d:	6a 44                	push   $0x44
  jmp alltraps
80105d9f:	e9 3a f8 ff ff       	jmp    801055de <alltraps>

80105da4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105da4:	6a 00                	push   $0x0
  pushl $69
80105da6:	6a 45                	push   $0x45
  jmp alltraps
80105da8:	e9 31 f8 ff ff       	jmp    801055de <alltraps>

80105dad <vector70>:
.globl vector70
vector70:
  pushl $0
80105dad:	6a 00                	push   $0x0
  pushl $70
80105daf:	6a 46                	push   $0x46
  jmp alltraps
80105db1:	e9 28 f8 ff ff       	jmp    801055de <alltraps>

80105db6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105db6:	6a 00                	push   $0x0
  pushl $71
80105db8:	6a 47                	push   $0x47
  jmp alltraps
80105dba:	e9 1f f8 ff ff       	jmp    801055de <alltraps>

80105dbf <vector72>:
.globl vector72
vector72:
  pushl $0
80105dbf:	6a 00                	push   $0x0
  pushl $72
80105dc1:	6a 48                	push   $0x48
  jmp alltraps
80105dc3:	e9 16 f8 ff ff       	jmp    801055de <alltraps>

80105dc8 <vector73>:
.globl vector73
vector73:
  pushl $0
80105dc8:	6a 00                	push   $0x0
  pushl $73
80105dca:	6a 49                	push   $0x49
  jmp alltraps
80105dcc:	e9 0d f8 ff ff       	jmp    801055de <alltraps>

80105dd1 <vector74>:
.globl vector74
vector74:
  pushl $0
80105dd1:	6a 00                	push   $0x0
  pushl $74
80105dd3:	6a 4a                	push   $0x4a
  jmp alltraps
80105dd5:	e9 04 f8 ff ff       	jmp    801055de <alltraps>

80105dda <vector75>:
.globl vector75
vector75:
  pushl $0
80105dda:	6a 00                	push   $0x0
  pushl $75
80105ddc:	6a 4b                	push   $0x4b
  jmp alltraps
80105dde:	e9 fb f7 ff ff       	jmp    801055de <alltraps>

80105de3 <vector76>:
.globl vector76
vector76:
  pushl $0
80105de3:	6a 00                	push   $0x0
  pushl $76
80105de5:	6a 4c                	push   $0x4c
  jmp alltraps
80105de7:	e9 f2 f7 ff ff       	jmp    801055de <alltraps>

80105dec <vector77>:
.globl vector77
vector77:
  pushl $0
80105dec:	6a 00                	push   $0x0
  pushl $77
80105dee:	6a 4d                	push   $0x4d
  jmp alltraps
80105df0:	e9 e9 f7 ff ff       	jmp    801055de <alltraps>

80105df5 <vector78>:
.globl vector78
vector78:
  pushl $0
80105df5:	6a 00                	push   $0x0
  pushl $78
80105df7:	6a 4e                	push   $0x4e
  jmp alltraps
80105df9:	e9 e0 f7 ff ff       	jmp    801055de <alltraps>

80105dfe <vector79>:
.globl vector79
vector79:
  pushl $0
80105dfe:	6a 00                	push   $0x0
  pushl $79
80105e00:	6a 4f                	push   $0x4f
  jmp alltraps
80105e02:	e9 d7 f7 ff ff       	jmp    801055de <alltraps>

80105e07 <vector80>:
.globl vector80
vector80:
  pushl $0
80105e07:	6a 00                	push   $0x0
  pushl $80
80105e09:	6a 50                	push   $0x50
  jmp alltraps
80105e0b:	e9 ce f7 ff ff       	jmp    801055de <alltraps>

80105e10 <vector81>:
.globl vector81
vector81:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $81
80105e12:	6a 51                	push   $0x51
  jmp alltraps
80105e14:	e9 c5 f7 ff ff       	jmp    801055de <alltraps>

80105e19 <vector82>:
.globl vector82
vector82:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $82
80105e1b:	6a 52                	push   $0x52
  jmp alltraps
80105e1d:	e9 bc f7 ff ff       	jmp    801055de <alltraps>

80105e22 <vector83>:
.globl vector83
vector83:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $83
80105e24:	6a 53                	push   $0x53
  jmp alltraps
80105e26:	e9 b3 f7 ff ff       	jmp    801055de <alltraps>

80105e2b <vector84>:
.globl vector84
vector84:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $84
80105e2d:	6a 54                	push   $0x54
  jmp alltraps
80105e2f:	e9 aa f7 ff ff       	jmp    801055de <alltraps>

80105e34 <vector85>:
.globl vector85
vector85:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $85
80105e36:	6a 55                	push   $0x55
  jmp alltraps
80105e38:	e9 a1 f7 ff ff       	jmp    801055de <alltraps>

80105e3d <vector86>:
.globl vector86
vector86:
  pushl $0
80105e3d:	6a 00                	push   $0x0
  pushl $86
80105e3f:	6a 56                	push   $0x56
  jmp alltraps
80105e41:	e9 98 f7 ff ff       	jmp    801055de <alltraps>

80105e46 <vector87>:
.globl vector87
vector87:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $87
80105e48:	6a 57                	push   $0x57
  jmp alltraps
80105e4a:	e9 8f f7 ff ff       	jmp    801055de <alltraps>

80105e4f <vector88>:
.globl vector88
vector88:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $88
80105e51:	6a 58                	push   $0x58
  jmp alltraps
80105e53:	e9 86 f7 ff ff       	jmp    801055de <alltraps>

80105e58 <vector89>:
.globl vector89
vector89:
  pushl $0
80105e58:	6a 00                	push   $0x0
  pushl $89
80105e5a:	6a 59                	push   $0x59
  jmp alltraps
80105e5c:	e9 7d f7 ff ff       	jmp    801055de <alltraps>

80105e61 <vector90>:
.globl vector90
vector90:
  pushl $0
80105e61:	6a 00                	push   $0x0
  pushl $90
80105e63:	6a 5a                	push   $0x5a
  jmp alltraps
80105e65:	e9 74 f7 ff ff       	jmp    801055de <alltraps>

80105e6a <vector91>:
.globl vector91
vector91:
  pushl $0
80105e6a:	6a 00                	push   $0x0
  pushl $91
80105e6c:	6a 5b                	push   $0x5b
  jmp alltraps
80105e6e:	e9 6b f7 ff ff       	jmp    801055de <alltraps>

80105e73 <vector92>:
.globl vector92
vector92:
  pushl $0
80105e73:	6a 00                	push   $0x0
  pushl $92
80105e75:	6a 5c                	push   $0x5c
  jmp alltraps
80105e77:	e9 62 f7 ff ff       	jmp    801055de <alltraps>

80105e7c <vector93>:
.globl vector93
vector93:
  pushl $0
80105e7c:	6a 00                	push   $0x0
  pushl $93
80105e7e:	6a 5d                	push   $0x5d
  jmp alltraps
80105e80:	e9 59 f7 ff ff       	jmp    801055de <alltraps>

80105e85 <vector94>:
.globl vector94
vector94:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $94
80105e87:	6a 5e                	push   $0x5e
  jmp alltraps
80105e89:	e9 50 f7 ff ff       	jmp    801055de <alltraps>

80105e8e <vector95>:
.globl vector95
vector95:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $95
80105e90:	6a 5f                	push   $0x5f
  jmp alltraps
80105e92:	e9 47 f7 ff ff       	jmp    801055de <alltraps>

80105e97 <vector96>:
.globl vector96
vector96:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $96
80105e99:	6a 60                	push   $0x60
  jmp alltraps
80105e9b:	e9 3e f7 ff ff       	jmp    801055de <alltraps>

80105ea0 <vector97>:
.globl vector97
vector97:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $97
80105ea2:	6a 61                	push   $0x61
  jmp alltraps
80105ea4:	e9 35 f7 ff ff       	jmp    801055de <alltraps>

80105ea9 <vector98>:
.globl vector98
vector98:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $98
80105eab:	6a 62                	push   $0x62
  jmp alltraps
80105ead:	e9 2c f7 ff ff       	jmp    801055de <alltraps>

80105eb2 <vector99>:
.globl vector99
vector99:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $99
80105eb4:	6a 63                	push   $0x63
  jmp alltraps
80105eb6:	e9 23 f7 ff ff       	jmp    801055de <alltraps>

80105ebb <vector100>:
.globl vector100
vector100:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $100
80105ebd:	6a 64                	push   $0x64
  jmp alltraps
80105ebf:	e9 1a f7 ff ff       	jmp    801055de <alltraps>

80105ec4 <vector101>:
.globl vector101
vector101:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $101
80105ec6:	6a 65                	push   $0x65
  jmp alltraps
80105ec8:	e9 11 f7 ff ff       	jmp    801055de <alltraps>

80105ecd <vector102>:
.globl vector102
vector102:
  pushl $0
80105ecd:	6a 00                	push   $0x0
  pushl $102
80105ecf:	6a 66                	push   $0x66
  jmp alltraps
80105ed1:	e9 08 f7 ff ff       	jmp    801055de <alltraps>

80105ed6 <vector103>:
.globl vector103
vector103:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $103
80105ed8:	6a 67                	push   $0x67
  jmp alltraps
80105eda:	e9 ff f6 ff ff       	jmp    801055de <alltraps>

80105edf <vector104>:
.globl vector104
vector104:
  pushl $0
80105edf:	6a 00                	push   $0x0
  pushl $104
80105ee1:	6a 68                	push   $0x68
  jmp alltraps
80105ee3:	e9 f6 f6 ff ff       	jmp    801055de <alltraps>

80105ee8 <vector105>:
.globl vector105
vector105:
  pushl $0
80105ee8:	6a 00                	push   $0x0
  pushl $105
80105eea:	6a 69                	push   $0x69
  jmp alltraps
80105eec:	e9 ed f6 ff ff       	jmp    801055de <alltraps>

80105ef1 <vector106>:
.globl vector106
vector106:
  pushl $0
80105ef1:	6a 00                	push   $0x0
  pushl $106
80105ef3:	6a 6a                	push   $0x6a
  jmp alltraps
80105ef5:	e9 e4 f6 ff ff       	jmp    801055de <alltraps>

80105efa <vector107>:
.globl vector107
vector107:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $107
80105efc:	6a 6b                	push   $0x6b
  jmp alltraps
80105efe:	e9 db f6 ff ff       	jmp    801055de <alltraps>

80105f03 <vector108>:
.globl vector108
vector108:
  pushl $0
80105f03:	6a 00                	push   $0x0
  pushl $108
80105f05:	6a 6c                	push   $0x6c
  jmp alltraps
80105f07:	e9 d2 f6 ff ff       	jmp    801055de <alltraps>

80105f0c <vector109>:
.globl vector109
vector109:
  pushl $0
80105f0c:	6a 00                	push   $0x0
  pushl $109
80105f0e:	6a 6d                	push   $0x6d
  jmp alltraps
80105f10:	e9 c9 f6 ff ff       	jmp    801055de <alltraps>

80105f15 <vector110>:
.globl vector110
vector110:
  pushl $0
80105f15:	6a 00                	push   $0x0
  pushl $110
80105f17:	6a 6e                	push   $0x6e
  jmp alltraps
80105f19:	e9 c0 f6 ff ff       	jmp    801055de <alltraps>

80105f1e <vector111>:
.globl vector111
vector111:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $111
80105f20:	6a 6f                	push   $0x6f
  jmp alltraps
80105f22:	e9 b7 f6 ff ff       	jmp    801055de <alltraps>

80105f27 <vector112>:
.globl vector112
vector112:
  pushl $0
80105f27:	6a 00                	push   $0x0
  pushl $112
80105f29:	6a 70                	push   $0x70
  jmp alltraps
80105f2b:	e9 ae f6 ff ff       	jmp    801055de <alltraps>

80105f30 <vector113>:
.globl vector113
vector113:
  pushl $0
80105f30:	6a 00                	push   $0x0
  pushl $113
80105f32:	6a 71                	push   $0x71
  jmp alltraps
80105f34:	e9 a5 f6 ff ff       	jmp    801055de <alltraps>

80105f39 <vector114>:
.globl vector114
vector114:
  pushl $0
80105f39:	6a 00                	push   $0x0
  pushl $114
80105f3b:	6a 72                	push   $0x72
  jmp alltraps
80105f3d:	e9 9c f6 ff ff       	jmp    801055de <alltraps>

80105f42 <vector115>:
.globl vector115
vector115:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $115
80105f44:	6a 73                	push   $0x73
  jmp alltraps
80105f46:	e9 93 f6 ff ff       	jmp    801055de <alltraps>

80105f4b <vector116>:
.globl vector116
vector116:
  pushl $0
80105f4b:	6a 00                	push   $0x0
  pushl $116
80105f4d:	6a 74                	push   $0x74
  jmp alltraps
80105f4f:	e9 8a f6 ff ff       	jmp    801055de <alltraps>

80105f54 <vector117>:
.globl vector117
vector117:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $117
80105f56:	6a 75                	push   $0x75
  jmp alltraps
80105f58:	e9 81 f6 ff ff       	jmp    801055de <alltraps>

80105f5d <vector118>:
.globl vector118
vector118:
  pushl $0
80105f5d:	6a 00                	push   $0x0
  pushl $118
80105f5f:	6a 76                	push   $0x76
  jmp alltraps
80105f61:	e9 78 f6 ff ff       	jmp    801055de <alltraps>

80105f66 <vector119>:
.globl vector119
vector119:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $119
80105f68:	6a 77                	push   $0x77
  jmp alltraps
80105f6a:	e9 6f f6 ff ff       	jmp    801055de <alltraps>

80105f6f <vector120>:
.globl vector120
vector120:
  pushl $0
80105f6f:	6a 00                	push   $0x0
  pushl $120
80105f71:	6a 78                	push   $0x78
  jmp alltraps
80105f73:	e9 66 f6 ff ff       	jmp    801055de <alltraps>

80105f78 <vector121>:
.globl vector121
vector121:
  pushl $0
80105f78:	6a 00                	push   $0x0
  pushl $121
80105f7a:	6a 79                	push   $0x79
  jmp alltraps
80105f7c:	e9 5d f6 ff ff       	jmp    801055de <alltraps>

80105f81 <vector122>:
.globl vector122
vector122:
  pushl $0
80105f81:	6a 00                	push   $0x0
  pushl $122
80105f83:	6a 7a                	push   $0x7a
  jmp alltraps
80105f85:	e9 54 f6 ff ff       	jmp    801055de <alltraps>

80105f8a <vector123>:
.globl vector123
vector123:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $123
80105f8c:	6a 7b                	push   $0x7b
  jmp alltraps
80105f8e:	e9 4b f6 ff ff       	jmp    801055de <alltraps>

80105f93 <vector124>:
.globl vector124
vector124:
  pushl $0
80105f93:	6a 00                	push   $0x0
  pushl $124
80105f95:	6a 7c                	push   $0x7c
  jmp alltraps
80105f97:	e9 42 f6 ff ff       	jmp    801055de <alltraps>

80105f9c <vector125>:
.globl vector125
vector125:
  pushl $0
80105f9c:	6a 00                	push   $0x0
  pushl $125
80105f9e:	6a 7d                	push   $0x7d
  jmp alltraps
80105fa0:	e9 39 f6 ff ff       	jmp    801055de <alltraps>

80105fa5 <vector126>:
.globl vector126
vector126:
  pushl $0
80105fa5:	6a 00                	push   $0x0
  pushl $126
80105fa7:	6a 7e                	push   $0x7e
  jmp alltraps
80105fa9:	e9 30 f6 ff ff       	jmp    801055de <alltraps>

80105fae <vector127>:
.globl vector127
vector127:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $127
80105fb0:	6a 7f                	push   $0x7f
  jmp alltraps
80105fb2:	e9 27 f6 ff ff       	jmp    801055de <alltraps>

80105fb7 <vector128>:
.globl vector128
vector128:
  pushl $0
80105fb7:	6a 00                	push   $0x0
  pushl $128
80105fb9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105fbe:	e9 1b f6 ff ff       	jmp    801055de <alltraps>

80105fc3 <vector129>:
.globl vector129
vector129:
  pushl $0
80105fc3:	6a 00                	push   $0x0
  pushl $129
80105fc5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105fca:	e9 0f f6 ff ff       	jmp    801055de <alltraps>

80105fcf <vector130>:
.globl vector130
vector130:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $130
80105fd1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105fd6:	e9 03 f6 ff ff       	jmp    801055de <alltraps>

80105fdb <vector131>:
.globl vector131
vector131:
  pushl $0
80105fdb:	6a 00                	push   $0x0
  pushl $131
80105fdd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105fe2:	e9 f7 f5 ff ff       	jmp    801055de <alltraps>

80105fe7 <vector132>:
.globl vector132
vector132:
  pushl $0
80105fe7:	6a 00                	push   $0x0
  pushl $132
80105fe9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105fee:	e9 eb f5 ff ff       	jmp    801055de <alltraps>

80105ff3 <vector133>:
.globl vector133
vector133:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $133
80105ff5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105ffa:	e9 df f5 ff ff       	jmp    801055de <alltraps>

80105fff <vector134>:
.globl vector134
vector134:
  pushl $0
80105fff:	6a 00                	push   $0x0
  pushl $134
80106001:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106006:	e9 d3 f5 ff ff       	jmp    801055de <alltraps>

8010600b <vector135>:
.globl vector135
vector135:
  pushl $0
8010600b:	6a 00                	push   $0x0
  pushl $135
8010600d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106012:	e9 c7 f5 ff ff       	jmp    801055de <alltraps>

80106017 <vector136>:
.globl vector136
vector136:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $136
80106019:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010601e:	e9 bb f5 ff ff       	jmp    801055de <alltraps>

80106023 <vector137>:
.globl vector137
vector137:
  pushl $0
80106023:	6a 00                	push   $0x0
  pushl $137
80106025:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010602a:	e9 af f5 ff ff       	jmp    801055de <alltraps>

8010602f <vector138>:
.globl vector138
vector138:
  pushl $0
8010602f:	6a 00                	push   $0x0
  pushl $138
80106031:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106036:	e9 a3 f5 ff ff       	jmp    801055de <alltraps>

8010603b <vector139>:
.globl vector139
vector139:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $139
8010603d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106042:	e9 97 f5 ff ff       	jmp    801055de <alltraps>

80106047 <vector140>:
.globl vector140
vector140:
  pushl $0
80106047:	6a 00                	push   $0x0
  pushl $140
80106049:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010604e:	e9 8b f5 ff ff       	jmp    801055de <alltraps>

80106053 <vector141>:
.globl vector141
vector141:
  pushl $0
80106053:	6a 00                	push   $0x0
  pushl $141
80106055:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010605a:	e9 7f f5 ff ff       	jmp    801055de <alltraps>

8010605f <vector142>:
.globl vector142
vector142:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $142
80106061:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106066:	e9 73 f5 ff ff       	jmp    801055de <alltraps>

8010606b <vector143>:
.globl vector143
vector143:
  pushl $0
8010606b:	6a 00                	push   $0x0
  pushl $143
8010606d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106072:	e9 67 f5 ff ff       	jmp    801055de <alltraps>

80106077 <vector144>:
.globl vector144
vector144:
  pushl $0
80106077:	6a 00                	push   $0x0
  pushl $144
80106079:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010607e:	e9 5b f5 ff ff       	jmp    801055de <alltraps>

80106083 <vector145>:
.globl vector145
vector145:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $145
80106085:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010608a:	e9 4f f5 ff ff       	jmp    801055de <alltraps>

8010608f <vector146>:
.globl vector146
vector146:
  pushl $0
8010608f:	6a 00                	push   $0x0
  pushl $146
80106091:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106096:	e9 43 f5 ff ff       	jmp    801055de <alltraps>

8010609b <vector147>:
.globl vector147
vector147:
  pushl $0
8010609b:	6a 00                	push   $0x0
  pushl $147
8010609d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801060a2:	e9 37 f5 ff ff       	jmp    801055de <alltraps>

801060a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $148
801060a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801060ae:	e9 2b f5 ff ff       	jmp    801055de <alltraps>

801060b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801060b3:	6a 00                	push   $0x0
  pushl $149
801060b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801060ba:	e9 1f f5 ff ff       	jmp    801055de <alltraps>

801060bf <vector150>:
.globl vector150
vector150:
  pushl $0
801060bf:	6a 00                	push   $0x0
  pushl $150
801060c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801060c6:	e9 13 f5 ff ff       	jmp    801055de <alltraps>

801060cb <vector151>:
.globl vector151
vector151:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $151
801060cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801060d2:	e9 07 f5 ff ff       	jmp    801055de <alltraps>

801060d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801060d7:	6a 00                	push   $0x0
  pushl $152
801060d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801060de:	e9 fb f4 ff ff       	jmp    801055de <alltraps>

801060e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801060e3:	6a 00                	push   $0x0
  pushl $153
801060e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801060ea:	e9 ef f4 ff ff       	jmp    801055de <alltraps>

801060ef <vector154>:
.globl vector154
vector154:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $154
801060f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801060f6:	e9 e3 f4 ff ff       	jmp    801055de <alltraps>

801060fb <vector155>:
.globl vector155
vector155:
  pushl $0
801060fb:	6a 00                	push   $0x0
  pushl $155
801060fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106102:	e9 d7 f4 ff ff       	jmp    801055de <alltraps>

80106107 <vector156>:
.globl vector156
vector156:
  pushl $0
80106107:	6a 00                	push   $0x0
  pushl $156
80106109:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010610e:	e9 cb f4 ff ff       	jmp    801055de <alltraps>

80106113 <vector157>:
.globl vector157
vector157:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $157
80106115:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010611a:	e9 bf f4 ff ff       	jmp    801055de <alltraps>

8010611f <vector158>:
.globl vector158
vector158:
  pushl $0
8010611f:	6a 00                	push   $0x0
  pushl $158
80106121:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106126:	e9 b3 f4 ff ff       	jmp    801055de <alltraps>

8010612b <vector159>:
.globl vector159
vector159:
  pushl $0
8010612b:	6a 00                	push   $0x0
  pushl $159
8010612d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106132:	e9 a7 f4 ff ff       	jmp    801055de <alltraps>

80106137 <vector160>:
.globl vector160
vector160:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $160
80106139:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010613e:	e9 9b f4 ff ff       	jmp    801055de <alltraps>

80106143 <vector161>:
.globl vector161
vector161:
  pushl $0
80106143:	6a 00                	push   $0x0
  pushl $161
80106145:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010614a:	e9 8f f4 ff ff       	jmp    801055de <alltraps>

8010614f <vector162>:
.globl vector162
vector162:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $162
80106151:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106156:	e9 83 f4 ff ff       	jmp    801055de <alltraps>

8010615b <vector163>:
.globl vector163
vector163:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $163
8010615d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106162:	e9 77 f4 ff ff       	jmp    801055de <alltraps>

80106167 <vector164>:
.globl vector164
vector164:
  pushl $0
80106167:	6a 00                	push   $0x0
  pushl $164
80106169:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010616e:	e9 6b f4 ff ff       	jmp    801055de <alltraps>

80106173 <vector165>:
.globl vector165
vector165:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $165
80106175:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010617a:	e9 5f f4 ff ff       	jmp    801055de <alltraps>

8010617f <vector166>:
.globl vector166
vector166:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $166
80106181:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106186:	e9 53 f4 ff ff       	jmp    801055de <alltraps>

8010618b <vector167>:
.globl vector167
vector167:
  pushl $0
8010618b:	6a 00                	push   $0x0
  pushl $167
8010618d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106192:	e9 47 f4 ff ff       	jmp    801055de <alltraps>

80106197 <vector168>:
.globl vector168
vector168:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $168
80106199:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010619e:	e9 3b f4 ff ff       	jmp    801055de <alltraps>

801061a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $169
801061a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801061aa:	e9 2f f4 ff ff       	jmp    801055de <alltraps>

801061af <vector170>:
.globl vector170
vector170:
  pushl $0
801061af:	6a 00                	push   $0x0
  pushl $170
801061b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801061b6:	e9 23 f4 ff ff       	jmp    801055de <alltraps>

801061bb <vector171>:
.globl vector171
vector171:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $171
801061bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801061c2:	e9 17 f4 ff ff       	jmp    801055de <alltraps>

801061c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $172
801061c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801061ce:	e9 0b f4 ff ff       	jmp    801055de <alltraps>

801061d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801061d3:	6a 00                	push   $0x0
  pushl $173
801061d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801061da:	e9 ff f3 ff ff       	jmp    801055de <alltraps>

801061df <vector174>:
.globl vector174
vector174:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $174
801061e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801061e6:	e9 f3 f3 ff ff       	jmp    801055de <alltraps>

801061eb <vector175>:
.globl vector175
vector175:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $175
801061ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801061f2:	e9 e7 f3 ff ff       	jmp    801055de <alltraps>

801061f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801061f7:	6a 00                	push   $0x0
  pushl $176
801061f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801061fe:	e9 db f3 ff ff       	jmp    801055de <alltraps>

80106203 <vector177>:
.globl vector177
vector177:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $177
80106205:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010620a:	e9 cf f3 ff ff       	jmp    801055de <alltraps>

8010620f <vector178>:
.globl vector178
vector178:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $178
80106211:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106216:	e9 c3 f3 ff ff       	jmp    801055de <alltraps>

8010621b <vector179>:
.globl vector179
vector179:
  pushl $0
8010621b:	6a 00                	push   $0x0
  pushl $179
8010621d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106222:	e9 b7 f3 ff ff       	jmp    801055de <alltraps>

80106227 <vector180>:
.globl vector180
vector180:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $180
80106229:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010622e:	e9 ab f3 ff ff       	jmp    801055de <alltraps>

80106233 <vector181>:
.globl vector181
vector181:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $181
80106235:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010623a:	e9 9f f3 ff ff       	jmp    801055de <alltraps>

8010623f <vector182>:
.globl vector182
vector182:
  pushl $0
8010623f:	6a 00                	push   $0x0
  pushl $182
80106241:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106246:	e9 93 f3 ff ff       	jmp    801055de <alltraps>

8010624b <vector183>:
.globl vector183
vector183:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $183
8010624d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106252:	e9 87 f3 ff ff       	jmp    801055de <alltraps>

80106257 <vector184>:
.globl vector184
vector184:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $184
80106259:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010625e:	e9 7b f3 ff ff       	jmp    801055de <alltraps>

80106263 <vector185>:
.globl vector185
vector185:
  pushl $0
80106263:	6a 00                	push   $0x0
  pushl $185
80106265:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010626a:	e9 6f f3 ff ff       	jmp    801055de <alltraps>

8010626f <vector186>:
.globl vector186
vector186:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $186
80106271:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106276:	e9 63 f3 ff ff       	jmp    801055de <alltraps>

8010627b <vector187>:
.globl vector187
vector187:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $187
8010627d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106282:	e9 57 f3 ff ff       	jmp    801055de <alltraps>

80106287 <vector188>:
.globl vector188
vector188:
  pushl $0
80106287:	6a 00                	push   $0x0
  pushl $188
80106289:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010628e:	e9 4b f3 ff ff       	jmp    801055de <alltraps>

80106293 <vector189>:
.globl vector189
vector189:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $189
80106295:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010629a:	e9 3f f3 ff ff       	jmp    801055de <alltraps>

8010629f <vector190>:
.globl vector190
vector190:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $190
801062a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801062a6:	e9 33 f3 ff ff       	jmp    801055de <alltraps>

801062ab <vector191>:
.globl vector191
vector191:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $191
801062ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801062b2:	e9 27 f3 ff ff       	jmp    801055de <alltraps>

801062b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $192
801062b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801062be:	e9 1b f3 ff ff       	jmp    801055de <alltraps>

801062c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $193
801062c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801062ca:	e9 0f f3 ff ff       	jmp    801055de <alltraps>

801062cf <vector194>:
.globl vector194
vector194:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $194
801062d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801062d6:	e9 03 f3 ff ff       	jmp    801055de <alltraps>

801062db <vector195>:
.globl vector195
vector195:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $195
801062dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801062e2:	e9 f7 f2 ff ff       	jmp    801055de <alltraps>

801062e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $196
801062e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801062ee:	e9 eb f2 ff ff       	jmp    801055de <alltraps>

801062f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $197
801062f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801062fa:	e9 df f2 ff ff       	jmp    801055de <alltraps>

801062ff <vector198>:
.globl vector198
vector198:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $198
80106301:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106306:	e9 d3 f2 ff ff       	jmp    801055de <alltraps>

8010630b <vector199>:
.globl vector199
vector199:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $199
8010630d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106312:	e9 c7 f2 ff ff       	jmp    801055de <alltraps>

80106317 <vector200>:
.globl vector200
vector200:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $200
80106319:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010631e:	e9 bb f2 ff ff       	jmp    801055de <alltraps>

80106323 <vector201>:
.globl vector201
vector201:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $201
80106325:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010632a:	e9 af f2 ff ff       	jmp    801055de <alltraps>

8010632f <vector202>:
.globl vector202
vector202:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $202
80106331:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106336:	e9 a3 f2 ff ff       	jmp    801055de <alltraps>

8010633b <vector203>:
.globl vector203
vector203:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $203
8010633d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106342:	e9 97 f2 ff ff       	jmp    801055de <alltraps>

80106347 <vector204>:
.globl vector204
vector204:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $204
80106349:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010634e:	e9 8b f2 ff ff       	jmp    801055de <alltraps>

80106353 <vector205>:
.globl vector205
vector205:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $205
80106355:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010635a:	e9 7f f2 ff ff       	jmp    801055de <alltraps>

8010635f <vector206>:
.globl vector206
vector206:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $206
80106361:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106366:	e9 73 f2 ff ff       	jmp    801055de <alltraps>

8010636b <vector207>:
.globl vector207
vector207:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $207
8010636d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106372:	e9 67 f2 ff ff       	jmp    801055de <alltraps>

80106377 <vector208>:
.globl vector208
vector208:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $208
80106379:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010637e:	e9 5b f2 ff ff       	jmp    801055de <alltraps>

80106383 <vector209>:
.globl vector209
vector209:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $209
80106385:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010638a:	e9 4f f2 ff ff       	jmp    801055de <alltraps>

8010638f <vector210>:
.globl vector210
vector210:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $210
80106391:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106396:	e9 43 f2 ff ff       	jmp    801055de <alltraps>

8010639b <vector211>:
.globl vector211
vector211:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $211
8010639d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801063a2:	e9 37 f2 ff ff       	jmp    801055de <alltraps>

801063a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $212
801063a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801063ae:	e9 2b f2 ff ff       	jmp    801055de <alltraps>

801063b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $213
801063b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801063ba:	e9 1f f2 ff ff       	jmp    801055de <alltraps>

801063bf <vector214>:
.globl vector214
vector214:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $214
801063c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801063c6:	e9 13 f2 ff ff       	jmp    801055de <alltraps>

801063cb <vector215>:
.globl vector215
vector215:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $215
801063cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801063d2:	e9 07 f2 ff ff       	jmp    801055de <alltraps>

801063d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $216
801063d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801063de:	e9 fb f1 ff ff       	jmp    801055de <alltraps>

801063e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $217
801063e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801063ea:	e9 ef f1 ff ff       	jmp    801055de <alltraps>

801063ef <vector218>:
.globl vector218
vector218:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $218
801063f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801063f6:	e9 e3 f1 ff ff       	jmp    801055de <alltraps>

801063fb <vector219>:
.globl vector219
vector219:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $219
801063fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106402:	e9 d7 f1 ff ff       	jmp    801055de <alltraps>

80106407 <vector220>:
.globl vector220
vector220:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $220
80106409:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010640e:	e9 cb f1 ff ff       	jmp    801055de <alltraps>

80106413 <vector221>:
.globl vector221
vector221:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $221
80106415:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010641a:	e9 bf f1 ff ff       	jmp    801055de <alltraps>

8010641f <vector222>:
.globl vector222
vector222:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $222
80106421:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106426:	e9 b3 f1 ff ff       	jmp    801055de <alltraps>

8010642b <vector223>:
.globl vector223
vector223:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $223
8010642d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106432:	e9 a7 f1 ff ff       	jmp    801055de <alltraps>

80106437 <vector224>:
.globl vector224
vector224:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $224
80106439:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010643e:	e9 9b f1 ff ff       	jmp    801055de <alltraps>

80106443 <vector225>:
.globl vector225
vector225:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $225
80106445:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010644a:	e9 8f f1 ff ff       	jmp    801055de <alltraps>

8010644f <vector226>:
.globl vector226
vector226:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $226
80106451:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106456:	e9 83 f1 ff ff       	jmp    801055de <alltraps>

8010645b <vector227>:
.globl vector227
vector227:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $227
8010645d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106462:	e9 77 f1 ff ff       	jmp    801055de <alltraps>

80106467 <vector228>:
.globl vector228
vector228:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $228
80106469:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010646e:	e9 6b f1 ff ff       	jmp    801055de <alltraps>

80106473 <vector229>:
.globl vector229
vector229:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $229
80106475:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010647a:	e9 5f f1 ff ff       	jmp    801055de <alltraps>

8010647f <vector230>:
.globl vector230
vector230:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $230
80106481:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106486:	e9 53 f1 ff ff       	jmp    801055de <alltraps>

8010648b <vector231>:
.globl vector231
vector231:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $231
8010648d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106492:	e9 47 f1 ff ff       	jmp    801055de <alltraps>

80106497 <vector232>:
.globl vector232
vector232:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $232
80106499:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010649e:	e9 3b f1 ff ff       	jmp    801055de <alltraps>

801064a3 <vector233>:
.globl vector233
vector233:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $233
801064a5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801064aa:	e9 2f f1 ff ff       	jmp    801055de <alltraps>

801064af <vector234>:
.globl vector234
vector234:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $234
801064b1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801064b6:	e9 23 f1 ff ff       	jmp    801055de <alltraps>

801064bb <vector235>:
.globl vector235
vector235:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $235
801064bd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801064c2:	e9 17 f1 ff ff       	jmp    801055de <alltraps>

801064c7 <vector236>:
.globl vector236
vector236:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $236
801064c9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801064ce:	e9 0b f1 ff ff       	jmp    801055de <alltraps>

801064d3 <vector237>:
.globl vector237
vector237:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $237
801064d5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801064da:	e9 ff f0 ff ff       	jmp    801055de <alltraps>

801064df <vector238>:
.globl vector238
vector238:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $238
801064e1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801064e6:	e9 f3 f0 ff ff       	jmp    801055de <alltraps>

801064eb <vector239>:
.globl vector239
vector239:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $239
801064ed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801064f2:	e9 e7 f0 ff ff       	jmp    801055de <alltraps>

801064f7 <vector240>:
.globl vector240
vector240:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $240
801064f9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801064fe:	e9 db f0 ff ff       	jmp    801055de <alltraps>

80106503 <vector241>:
.globl vector241
vector241:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $241
80106505:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010650a:	e9 cf f0 ff ff       	jmp    801055de <alltraps>

8010650f <vector242>:
.globl vector242
vector242:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $242
80106511:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106516:	e9 c3 f0 ff ff       	jmp    801055de <alltraps>

8010651b <vector243>:
.globl vector243
vector243:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $243
8010651d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106522:	e9 b7 f0 ff ff       	jmp    801055de <alltraps>

80106527 <vector244>:
.globl vector244
vector244:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $244
80106529:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010652e:	e9 ab f0 ff ff       	jmp    801055de <alltraps>

80106533 <vector245>:
.globl vector245
vector245:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $245
80106535:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010653a:	e9 9f f0 ff ff       	jmp    801055de <alltraps>

8010653f <vector246>:
.globl vector246
vector246:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $246
80106541:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106546:	e9 93 f0 ff ff       	jmp    801055de <alltraps>

8010654b <vector247>:
.globl vector247
vector247:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $247
8010654d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106552:	e9 87 f0 ff ff       	jmp    801055de <alltraps>

80106557 <vector248>:
.globl vector248
vector248:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $248
80106559:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010655e:	e9 7b f0 ff ff       	jmp    801055de <alltraps>

80106563 <vector249>:
.globl vector249
vector249:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $249
80106565:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010656a:	e9 6f f0 ff ff       	jmp    801055de <alltraps>

8010656f <vector250>:
.globl vector250
vector250:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $250
80106571:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106576:	e9 63 f0 ff ff       	jmp    801055de <alltraps>

8010657b <vector251>:
.globl vector251
vector251:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $251
8010657d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106582:	e9 57 f0 ff ff       	jmp    801055de <alltraps>

80106587 <vector252>:
.globl vector252
vector252:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $252
80106589:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010658e:	e9 4b f0 ff ff       	jmp    801055de <alltraps>

80106593 <vector253>:
.globl vector253
vector253:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $253
80106595:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010659a:	e9 3f f0 ff ff       	jmp    801055de <alltraps>

8010659f <vector254>:
.globl vector254
vector254:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $254
801065a1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801065a6:	e9 33 f0 ff ff       	jmp    801055de <alltraps>

801065ab <vector255>:
.globl vector255
vector255:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $255
801065ad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801065b2:	e9 27 f0 ff ff       	jmp    801055de <alltraps>
801065b7:	66 90                	xchg   %ax,%ax
801065b9:	66 90                	xchg   %ax,%ax
801065bb:	66 90                	xchg   %ax,%ax
801065bd:	66 90                	xchg   %ax,%ax
801065bf:	90                   	nop

801065c0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	57                   	push   %edi
801065c4:	56                   	push   %esi
801065c5:	53                   	push   %ebx
801065c6:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801065c8:	c1 ea 16             	shr    $0x16,%edx
801065cb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801065ce:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801065d1:	8b 07                	mov    (%edi),%eax
801065d3:	a8 01                	test   $0x1,%al
801065d5:	74 29                	je     80106600 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801065d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801065dc:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801065e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801065e5:	c1 eb 0a             	shr    $0xa,%ebx
801065e8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801065ee:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801065f1:	5b                   	pop    %ebx
801065f2:	5e                   	pop    %esi
801065f3:	5f                   	pop    %edi
801065f4:	5d                   	pop    %ebp
801065f5:	c3                   	ret    
801065f6:	8d 76 00             	lea    0x0(%esi),%esi
801065f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106600:	85 c9                	test   %ecx,%ecx
80106602:	74 2c                	je     80106630 <walkpgdir+0x70>
80106604:	e8 67 be ff ff       	call   80102470 <kalloc>
80106609:	85 c0                	test   %eax,%eax
8010660b:	89 c6                	mov    %eax,%esi
8010660d:	74 21                	je     80106630 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010660f:	83 ec 04             	sub    $0x4,%esp
80106612:	68 00 10 00 00       	push   $0x1000
80106617:	6a 00                	push   $0x0
80106619:	50                   	push   %eax
8010661a:	e8 81 dd ff ff       	call   801043a0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010661f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106625:	83 c4 10             	add    $0x10,%esp
80106628:	83 c8 07             	or     $0x7,%eax
8010662b:	89 07                	mov    %eax,(%edi)
8010662d:	eb b3                	jmp    801065e2 <walkpgdir+0x22>
8010662f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106630:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106633:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106635:	5b                   	pop    %ebx
80106636:	5e                   	pop    %esi
80106637:	5f                   	pop    %edi
80106638:	5d                   	pop    %ebp
80106639:	c3                   	ret    
8010663a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106640 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	57                   	push   %edi
80106644:	56                   	push   %esi
80106645:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106646:	89 d3                	mov    %edx,%ebx
80106648:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010664e:	83 ec 1c             	sub    $0x1c,%esp
80106651:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106654:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106658:	8b 7d 08             	mov    0x8(%ebp),%edi
8010665b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106663:	8b 45 0c             	mov    0xc(%ebp),%eax
80106666:	29 df                	sub    %ebx,%edi
80106668:	83 c8 01             	or     $0x1,%eax
8010666b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010666e:	eb 15                	jmp    80106685 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106670:	f6 00 01             	testb  $0x1,(%eax)
80106673:	75 45                	jne    801066ba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106675:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106678:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010667b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010667d:	74 31                	je     801066b0 <mappages+0x70>
      break;
    a += PGSIZE;
8010667f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106685:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106688:	b9 01 00 00 00       	mov    $0x1,%ecx
8010668d:	89 da                	mov    %ebx,%edx
8010668f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106692:	e8 29 ff ff ff       	call   801065c0 <walkpgdir>
80106697:	85 c0                	test   %eax,%eax
80106699:	75 d5                	jne    80106670 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010669b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010669e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801066a3:	5b                   	pop    %ebx
801066a4:	5e                   	pop    %esi
801066a5:	5f                   	pop    %edi
801066a6:	5d                   	pop    %ebp
801066a7:	c3                   	ret    
801066a8:	90                   	nop
801066a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801066b3:	31 c0                	xor    %eax,%eax
}
801066b5:	5b                   	pop    %ebx
801066b6:	5e                   	pop    %esi
801066b7:	5f                   	pop    %edi
801066b8:	5d                   	pop    %ebp
801066b9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801066ba:	83 ec 0c             	sub    $0xc,%esp
801066bd:	68 ec 77 10 80       	push   $0x801077ec
801066c2:	e8 89 9c ff ff       	call   80100350 <panic>
801066c7:	89 f6                	mov    %esi,%esi
801066c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066d0:	55                   	push   %ebp
801066d1:	89 e5                	mov    %esp,%ebp
801066d3:	57                   	push   %edi
801066d4:	56                   	push   %esi
801066d5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801066d6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066dc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801066de:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801066e4:	83 ec 1c             	sub    $0x1c,%esp
801066e7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801066ea:	39 d3                	cmp    %edx,%ebx
801066ec:	73 60                	jae    8010674e <deallocuvm.part.0+0x7e>
801066ee:	89 d6                	mov    %edx,%esi
801066f0:	eb 3d                	jmp    8010672f <deallocuvm.part.0+0x5f>
801066f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
801066f8:	8b 10                	mov    (%eax),%edx
801066fa:	f6 c2 01             	test   $0x1,%dl
801066fd:	74 26                	je     80106725 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801066ff:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106705:	74 52                	je     80106759 <deallocuvm.part.0+0x89>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106707:	83 ec 0c             	sub    $0xc,%esp
8010670a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106710:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106713:	52                   	push   %edx
80106714:	e8 a7 bb ff ff       	call   801022c0 <kfree>
      *pte = 0;
80106719:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010671c:	83 c4 10             	add    $0x10,%esp
8010671f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106725:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010672b:	39 f3                	cmp    %esi,%ebx
8010672d:	73 1f                	jae    8010674e <deallocuvm.part.0+0x7e>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010672f:	31 c9                	xor    %ecx,%ecx
80106731:	89 da                	mov    %ebx,%edx
80106733:	89 f8                	mov    %edi,%eax
80106735:	e8 86 fe ff ff       	call   801065c0 <walkpgdir>
    if(!pte)
8010673a:	85 c0                	test   %eax,%eax
8010673c:	75 ba                	jne    801066f8 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
8010673e:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106744:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010674a:	39 f3                	cmp    %esi,%ebx
8010674c:	72 e1                	jb     8010672f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010674e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106751:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106754:	5b                   	pop    %ebx
80106755:	5e                   	pop    %esi
80106756:	5f                   	pop    %edi
80106757:	5d                   	pop    %ebp
80106758:	c3                   	ret    
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106759:	83 ec 0c             	sub    $0xc,%esp
8010675c:	68 42 71 10 80       	push   $0x80107142
80106761:	e8 ea 9b ff ff       	call   80100350 <panic>
80106766:	8d 76 00             	lea    0x0(%esi),%esi
80106769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106770 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106774:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106776:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106779:	e8 52 bf ff ff       	call   801026d0 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010677e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80106784:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106789:	8d 90 e0 12 11 80    	lea    -0x7feeed20(%eax),%edx
8010678f:	c6 80 5d 13 11 80 9a 	movb   $0x9a,-0x7feeeca3(%eax)
80106796:	c6 80 5e 13 11 80 cf 	movb   $0xcf,-0x7feeeca2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010679d:	c6 80 65 13 11 80 92 	movb   $0x92,-0x7feeec9b(%eax)
801067a4:	c6 80 66 13 11 80 cf 	movb   $0xcf,-0x7feeec9a(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067ab:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067af:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067b4:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067b8:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
801067bf:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067c1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067c6:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067cd:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
801067d4:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801067d6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067db:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801067e2:	31 db                	xor    %ebx,%ebx
801067e4:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801067eb:	8d 88 94 13 11 80    	lea    -0x7feeec6c(%eax),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801067f1:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801067f8:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801067fa:	c6 80 75 13 11 80 fa 	movb   $0xfa,-0x7feeec8b(%eax)
80106801:	c6 80 76 13 11 80 cf 	movb   $0xcf,-0x7feeec8a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106808:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
8010680f:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106816:	89 cb                	mov    %ecx,%ebx
80106818:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010681b:	c6 80 7d 13 11 80 f2 	movb   $0xf2,-0x7feeec83(%eax)
80106822:	c6 80 7e 13 11 80 cf 	movb   $0xcf,-0x7feeec82(%eax)

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106829:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
8010682f:	c6 80 6d 13 11 80 92 	movb   $0x92,-0x7feeec93(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106836:	b9 37 00 00 00       	mov    $0x37,%ecx
8010683b:	c6 80 6e 13 11 80 c0 	movb   $0xc0,-0x7feeec92(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80106842:	05 50 13 11 80       	add    $0x80111350,%eax
80106847:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010684b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
8010684e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106852:	c1 e8 10             	shr    $0x10,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106855:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106859:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010685d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106864:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010686b:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106872:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106879:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106880:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)

  // Map cpu and curproc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106887:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
8010688d:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106891:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106894:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
80106897:	b8 18 00 00 00       	mov    $0x18,%eax
8010689c:	8e e8                	mov    %eax,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
8010689e:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801068a5:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801068a9:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
801068b0:	83 c4 14             	add    $0x14,%esp
801068b3:	5b                   	pop    %ebx
801068b4:	5d                   	pop    %ebp
801068b5:	c3                   	ret    
801068b6:	8d 76 00             	lea    0x0(%esi),%esi
801068b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068c0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	56                   	push   %esi
801068c4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801068c5:	e8 a6 bb ff ff       	call   80102470 <kalloc>
801068ca:	85 c0                	test   %eax,%eax
801068cc:	74 52                	je     80106920 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
801068ce:	83 ec 04             	sub    $0x4,%esp
801068d1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801068d3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
801068d8:	68 00 10 00 00       	push   $0x1000
801068dd:	6a 00                	push   $0x0
801068df:	50                   	push   %eax
801068e0:	e8 bb da ff ff       	call   801043a0 <memset>
801068e5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801068e8:	8b 43 04             	mov    0x4(%ebx),%eax
801068eb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801068ee:	83 ec 08             	sub    $0x8,%esp
801068f1:	8b 13                	mov    (%ebx),%edx
801068f3:	ff 73 0c             	pushl  0xc(%ebx)
801068f6:	50                   	push   %eax
801068f7:	29 c1                	sub    %eax,%ecx
801068f9:	89 f0                	mov    %esi,%eax
801068fb:	e8 40 fd ff ff       	call   80106640 <mappages>
80106900:	83 c4 10             	add    $0x10,%esp
80106903:	85 c0                	test   %eax,%eax
80106905:	78 19                	js     80106920 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106907:	83 c3 10             	add    $0x10,%ebx
8010690a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106910:	75 d6                	jne    801068e8 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106912:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106915:	89 f0                	mov    %esi,%eax
80106917:	5b                   	pop    %ebx
80106918:	5e                   	pop    %esi
80106919:	5d                   	pop    %ebp
8010691a:	c3                   	ret    
8010691b:	90                   	nop
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106920:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106923:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106925:	5b                   	pop    %ebx
80106926:	5e                   	pop    %esi
80106927:	5d                   	pop    %ebp
80106928:	c3                   	ret    
80106929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106930 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106936:	e8 85 ff ff ff       	call   801068c0 <setupkvm>
8010693b:	a3 64 42 11 80       	mov    %eax,0x80114264
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106940:	05 00 00 00 80       	add    $0x80000000,%eax
80106945:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106948:	c9                   	leave  
80106949:	c3                   	ret    
8010694a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106950 <switchkvm>:
80106950:	a1 64 42 11 80       	mov    0x80114264,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106955:	55                   	push   %ebp
80106956:	89 e5                	mov    %esp,%ebp
80106958:	05 00 00 00 80       	add    $0x80000000,%eax
8010695d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106960:	5d                   	pop    %ebp
80106961:	c3                   	ret    
80106962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106970 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	53                   	push   %ebx
80106974:	83 ec 04             	sub    $0x4,%esp
80106977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010697a:	e8 51 d9 ff ff       	call   801042d0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
8010697f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106985:	b9 67 00 00 00       	mov    $0x67,%ecx
8010698a:	8d 50 08             	lea    0x8(%eax),%edx
8010698d:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106994:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
8010699b:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069a2:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
801069a9:	89 d1                	mov    %edx,%ecx
801069ab:	c1 ea 18             	shr    $0x18,%edx
801069ae:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
801069b4:	ba 10 00 00 00       	mov    $0x10,%edx
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069b9:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
801069bc:	66 89 50 10          	mov    %dx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801069c0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069c7:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
801069cd:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801069d2:	8b 52 08             	mov    0x8(%edx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
801069d5:	66 89 48 6e          	mov    %cx,0x6e(%eax)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801069d9:	81 c2 00 10 00 00    	add    $0x1000,%edx
801069df:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801069e2:	b8 30 00 00 00       	mov    $0x30,%eax
801069e7:	0f 00 d8             	ltr    %ax
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
801069ea:	8b 43 04             	mov    0x4(%ebx),%eax
801069ed:	85 c0                	test   %eax,%eax
801069ef:	74 11                	je     80106a02 <switchuvm+0x92>
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069f1:	05 00 00 00 80       	add    $0x80000000,%eax
801069f6:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801069f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801069fc:	c9                   	leave  
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801069fd:	e9 fe d8 ff ff       	jmp    80104300 <popcli>
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106a02:	83 ec 0c             	sub    $0xc,%esp
80106a05:	68 f2 77 10 80       	push   $0x801077f2
80106a0a:	e8 41 99 ff ff       	call   80100350 <panic>
80106a0f:	90                   	nop

80106a10 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
80106a14:	56                   	push   %esi
80106a15:	53                   	push   %ebx
80106a16:	83 ec 1c             	sub    $0x1c,%esp
80106a19:	8b 75 10             	mov    0x10(%ebp),%esi
80106a1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a1f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106a22:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106a28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106a2b:	77 49                	ja     80106a76 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106a2d:	e8 3e ba ff ff       	call   80102470 <kalloc>
  memset(mem, 0, PGSIZE);
80106a32:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106a35:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106a37:	68 00 10 00 00       	push   $0x1000
80106a3c:	6a 00                	push   $0x0
80106a3e:	50                   	push   %eax
80106a3f:	e8 5c d9 ff ff       	call   801043a0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106a44:	58                   	pop    %eax
80106a45:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a4b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106a50:	5a                   	pop    %edx
80106a51:	6a 06                	push   $0x6
80106a53:	50                   	push   %eax
80106a54:	31 d2                	xor    %edx,%edx
80106a56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a59:	e8 e2 fb ff ff       	call   80106640 <mappages>
  memmove(mem, init, sz);
80106a5e:	89 75 10             	mov    %esi,0x10(%ebp)
80106a61:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106a64:	83 c4 10             	add    $0x10,%esp
80106a67:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106a6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a6d:	5b                   	pop    %ebx
80106a6e:	5e                   	pop    %esi
80106a6f:	5f                   	pop    %edi
80106a70:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106a71:	e9 da d9 ff ff       	jmp    80104450 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106a76:	83 ec 0c             	sub    $0xc,%esp
80106a79:	68 06 78 10 80       	push   $0x80107806
80106a7e:	e8 cd 98 ff ff       	call   80100350 <panic>
80106a83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a90 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	57                   	push   %edi
80106a94:	56                   	push   %esi
80106a95:	53                   	push   %ebx
80106a96:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106a99:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106aa0:	0f 85 91 00 00 00    	jne    80106b37 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106aa6:	8b 75 18             	mov    0x18(%ebp),%esi
80106aa9:	31 db                	xor    %ebx,%ebx
80106aab:	85 f6                	test   %esi,%esi
80106aad:	75 1a                	jne    80106ac9 <loaduvm+0x39>
80106aaf:	eb 6f                	jmp    80106b20 <loaduvm+0x90>
80106ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ab8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106abe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ac4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ac7:	76 57                	jbe    80106b20 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ac9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106acc:	8b 45 08             	mov    0x8(%ebp),%eax
80106acf:	31 c9                	xor    %ecx,%ecx
80106ad1:	01 da                	add    %ebx,%edx
80106ad3:	e8 e8 fa ff ff       	call   801065c0 <walkpgdir>
80106ad8:	85 c0                	test   %eax,%eax
80106ada:	74 4e                	je     80106b2a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106adc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ade:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106ae1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106ae6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106aeb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106af1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106af4:	01 d9                	add    %ebx,%ecx
80106af6:	05 00 00 00 80       	add    $0x80000000,%eax
80106afb:	57                   	push   %edi
80106afc:	51                   	push   %ecx
80106afd:	50                   	push   %eax
80106afe:	ff 75 10             	pushl  0x10(%ebp)
80106b01:	e8 1a ae ff ff       	call   80101920 <readi>
80106b06:	83 c4 10             	add    $0x10,%esp
80106b09:	39 c7                	cmp    %eax,%edi
80106b0b:	74 ab                	je     80106ab8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106b15:	5b                   	pop    %ebx
80106b16:	5e                   	pop    %esi
80106b17:	5f                   	pop    %edi
80106b18:	5d                   	pop    %ebp
80106b19:	c3                   	ret    
80106b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106b23:	31 c0                	xor    %eax,%eax
}
80106b25:	5b                   	pop    %ebx
80106b26:	5e                   	pop    %esi
80106b27:	5f                   	pop    %edi
80106b28:	5d                   	pop    %ebp
80106b29:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106b2a:	83 ec 0c             	sub    $0xc,%esp
80106b2d:	68 20 78 10 80       	push   $0x80107820
80106b32:	e8 19 98 ff ff       	call   80100350 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106b37:	83 ec 0c             	sub    $0xc,%esp
80106b3a:	68 c4 78 10 80       	push   $0x801078c4
80106b3f:	e8 0c 98 ff ff       	call   80100350 <panic>
80106b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b50 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
80106b56:	83 ec 0c             	sub    $0xc,%esp
80106b59:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106b5c:	85 ff                	test   %edi,%edi
80106b5e:	0f 88 ca 00 00 00    	js     80106c2e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106b64:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106b6a:	0f 82 82 00 00 00    	jb     80106bf2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106b70:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106b76:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106b7c:	39 df                	cmp    %ebx,%edi
80106b7e:	77 43                	ja     80106bc3 <allocuvm+0x73>
80106b80:	e9 bb 00 00 00       	jmp    80106c40 <allocuvm+0xf0>
80106b85:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106b88:	83 ec 04             	sub    $0x4,%esp
80106b8b:	68 00 10 00 00       	push   $0x1000
80106b90:	6a 00                	push   $0x0
80106b92:	50                   	push   %eax
80106b93:	e8 08 d8 ff ff       	call   801043a0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106b98:	58                   	pop    %eax
80106b99:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106b9f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ba4:	5a                   	pop    %edx
80106ba5:	6a 06                	push   $0x6
80106ba7:	50                   	push   %eax
80106ba8:	89 da                	mov    %ebx,%edx
80106baa:	8b 45 08             	mov    0x8(%ebp),%eax
80106bad:	e8 8e fa ff ff       	call   80106640 <mappages>
80106bb2:	83 c4 10             	add    $0x10,%esp
80106bb5:	85 c0                	test   %eax,%eax
80106bb7:	78 47                	js     80106c00 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106bb9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bbf:	39 df                	cmp    %ebx,%edi
80106bc1:	76 7d                	jbe    80106c40 <allocuvm+0xf0>
    mem = kalloc();
80106bc3:	e8 a8 b8 ff ff       	call   80102470 <kalloc>
    if(mem == 0){
80106bc8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106bca:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106bcc:	75 ba                	jne    80106b88 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106bce:	83 ec 0c             	sub    $0xc,%esp
80106bd1:	68 3e 78 10 80       	push   $0x8010783e
80106bd6:	e8 65 9a ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106bdb:	83 c4 10             	add    $0x10,%esp
80106bde:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106be1:	76 4b                	jbe    80106c2e <allocuvm+0xde>
80106be3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106be6:	8b 45 08             	mov    0x8(%ebp),%eax
80106be9:	89 fa                	mov    %edi,%edx
80106beb:	e8 e0 fa ff ff       	call   801066d0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106bf0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106bf2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bf5:	5b                   	pop    %ebx
80106bf6:	5e                   	pop    %esi
80106bf7:	5f                   	pop    %edi
80106bf8:	5d                   	pop    %ebp
80106bf9:	c3                   	ret    
80106bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106c00:	83 ec 0c             	sub    $0xc,%esp
80106c03:	68 56 78 10 80       	push   $0x80107856
80106c08:	e8 33 9a ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106c0d:	83 c4 10             	add    $0x10,%esp
80106c10:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c13:	76 0d                	jbe    80106c22 <allocuvm+0xd2>
80106c15:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c18:	8b 45 08             	mov    0x8(%ebp),%eax
80106c1b:	89 fa                	mov    %edi,%edx
80106c1d:	e8 ae fa ff ff       	call   801066d0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106c22:	83 ec 0c             	sub    $0xc,%esp
80106c25:	56                   	push   %esi
80106c26:	e8 95 b6 ff ff       	call   801022c0 <kfree>
      return 0;
80106c2b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106c2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106c31:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106c33:	5b                   	pop    %ebx
80106c34:	5e                   	pop    %esi
80106c35:	5f                   	pop    %edi
80106c36:	5d                   	pop    %ebp
80106c37:	c3                   	ret    
80106c38:	90                   	nop
80106c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106c43:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106c45:	5b                   	pop    %ebx
80106c46:	5e                   	pop    %esi
80106c47:	5f                   	pop    %edi
80106c48:	5d                   	pop    %ebp
80106c49:	c3                   	ret    
80106c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c50 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c59:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106c5c:	39 d1                	cmp    %edx,%ecx
80106c5e:	73 10                	jae    80106c70 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106c60:	5d                   	pop    %ebp
80106c61:	e9 6a fa ff ff       	jmp    801066d0 <deallocuvm.part.0>
80106c66:	8d 76 00             	lea    0x0(%esi),%esi
80106c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c70:	89 d0                	mov    %edx,%eax
80106c72:	5d                   	pop    %ebp
80106c73:	c3                   	ret    
80106c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 0c             	sub    $0xc,%esp
80106c89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106c8c:	85 f6                	test   %esi,%esi
80106c8e:	74 59                	je     80106ce9 <freevm+0x69>
80106c90:	31 c9                	xor    %ecx,%ecx
80106c92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c97:	89 f0                	mov    %esi,%eax
80106c99:	e8 32 fa ff ff       	call   801066d0 <deallocuvm.part.0>
80106c9e:	89 f3                	mov    %esi,%ebx
80106ca0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ca6:	eb 0f                	jmp    80106cb7 <freevm+0x37>
80106ca8:	90                   	nop
80106ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cb0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cb3:	39 fb                	cmp    %edi,%ebx
80106cb5:	74 23                	je     80106cda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106cb7:	8b 03                	mov    (%ebx),%eax
80106cb9:	a8 01                	test   $0x1,%al
80106cbb:	74 f3                	je     80106cb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cc2:	83 ec 0c             	sub    $0xc,%esp
80106cc5:	83 c3 04             	add    $0x4,%ebx
80106cc8:	05 00 00 00 80       	add    $0x80000000,%eax
80106ccd:	50                   	push   %eax
80106cce:	e8 ed b5 ff ff       	call   801022c0 <kfree>
80106cd3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cd6:	39 fb                	cmp    %edi,%ebx
80106cd8:	75 dd                	jne    80106cb7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106cda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106cdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ce0:	5b                   	pop    %ebx
80106ce1:	5e                   	pop    %esi
80106ce2:	5f                   	pop    %edi
80106ce3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106ce4:	e9 d7 b5 ff ff       	jmp    801022c0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106ce9:	83 ec 0c             	sub    $0xc,%esp
80106cec:	68 72 78 10 80       	push   $0x80107872
80106cf1:	e8 5a 96 ff ff       	call   80100350 <panic>
80106cf6:	8d 76 00             	lea    0x0(%esi),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d00:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d01:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d03:	89 e5                	mov    %esp,%ebp
80106d05:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d08:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d0b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0e:	e8 ad f8 ff ff       	call   801065c0 <walkpgdir>
  if(pte == 0)
80106d13:	85 c0                	test   %eax,%eax
80106d15:	74 05                	je     80106d1c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106d17:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106d1a:	c9                   	leave  
80106d1b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106d1c:	83 ec 0c             	sub    $0xc,%esp
80106d1f:	68 83 78 10 80       	push   $0x80107883
80106d24:	e8 27 96 ff ff       	call   80100350 <panic>
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d30 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106d39:	e8 82 fb ff ff       	call   801068c0 <setupkvm>
80106d3e:	85 c0                	test   %eax,%eax
80106d40:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d43:	0f 84 b2 00 00 00    	je     80106dfb <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d4c:	85 c9                	test   %ecx,%ecx
80106d4e:	0f 84 9c 00 00 00    	je     80106df0 <copyuvm+0xc0>
80106d54:	31 f6                	xor    %esi,%esi
80106d56:	eb 4a                	jmp    80106da2 <copyuvm+0x72>
80106d58:	90                   	nop
80106d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d60:	83 ec 04             	sub    $0x4,%esp
80106d63:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106d69:	68 00 10 00 00       	push   $0x1000
80106d6e:	57                   	push   %edi
80106d6f:	50                   	push   %eax
80106d70:	e8 db d6 ff ff       	call   80104450 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106d75:	58                   	pop    %eax
80106d76:	5a                   	pop    %edx
80106d77:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d80:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d83:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d88:	52                   	push   %edx
80106d89:	89 f2                	mov    %esi,%edx
80106d8b:	e8 b0 f8 ff ff       	call   80106640 <mappages>
80106d90:	83 c4 10             	add    $0x10,%esp
80106d93:	85 c0                	test   %eax,%eax
80106d95:	78 3e                	js     80106dd5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d97:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d9d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106da0:	76 4e                	jbe    80106df0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106da2:	8b 45 08             	mov    0x8(%ebp),%eax
80106da5:	31 c9                	xor    %ecx,%ecx
80106da7:	89 f2                	mov    %esi,%edx
80106da9:	e8 12 f8 ff ff       	call   801065c0 <walkpgdir>
80106dae:	85 c0                	test   %eax,%eax
80106db0:	74 5a                	je     80106e0c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106db2:	8b 18                	mov    (%eax),%ebx
80106db4:	f6 c3 01             	test   $0x1,%bl
80106db7:	74 46                	je     80106dff <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106db9:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80106dbb:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80106dc1:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106dc4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106dca:	e8 a1 b6 ff ff       	call   80102470 <kalloc>
80106dcf:	85 c0                	test   %eax,%eax
80106dd1:	89 c3                	mov    %eax,%ebx
80106dd3:	75 8b                	jne    80106d60 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106dd5:	83 ec 0c             	sub    $0xc,%esp
80106dd8:	ff 75 e0             	pushl  -0x20(%ebp)
80106ddb:	e8 a0 fe ff ff       	call   80106c80 <freevm>
  return 0;
80106de0:	83 c4 10             	add    $0x10,%esp
80106de3:	31 c0                	xor    %eax,%eax
}
80106de5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de8:	5b                   	pop    %ebx
80106de9:	5e                   	pop    %esi
80106dea:	5f                   	pop    %edi
80106deb:	5d                   	pop    %ebp
80106dec:	c3                   	ret    
80106ded:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106df0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106df3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df6:	5b                   	pop    %ebx
80106df7:	5e                   	pop    %esi
80106df8:	5f                   	pop    %edi
80106df9:	5d                   	pop    %ebp
80106dfa:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106dfb:	31 c0                	xor    %eax,%eax
80106dfd:	eb e6                	jmp    80106de5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106dff:	83 ec 0c             	sub    $0xc,%esp
80106e02:	68 a7 78 10 80       	push   $0x801078a7
80106e07:	e8 44 95 ff ff       	call   80100350 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106e0c:	83 ec 0c             	sub    $0xc,%esp
80106e0f:	68 8d 78 10 80       	push   $0x8010788d
80106e14:	e8 37 95 ff ff       	call   80100350 <panic>
80106e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e20 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e20:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e21:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e23:	89 e5                	mov    %esp,%ebp
80106e25:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e28:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e2b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2e:	e8 8d f7 ff ff       	call   801065c0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106e33:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80106e35:	89 c2                	mov    %eax,%edx
80106e37:	83 e2 05             	and    $0x5,%edx
80106e3a:	83 fa 05             	cmp    $0x5,%edx
80106e3d:	75 11                	jne    80106e50 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80106e44:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e45:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106e4a:	c3                   	ret    
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106e50:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106e52:	c9                   	leave  
80106e53:	c3                   	ret    
80106e54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e60 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106e60:	55                   	push   %ebp
80106e61:	89 e5                	mov    %esp,%ebp
80106e63:	57                   	push   %edi
80106e64:	56                   	push   %esi
80106e65:	53                   	push   %ebx
80106e66:	83 ec 1c             	sub    $0x1c,%esp
80106e69:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106e6c:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106e72:	85 db                	test   %ebx,%ebx
80106e74:	75 40                	jne    80106eb6 <copyout+0x56>
80106e76:	eb 70                	jmp    80106ee8 <copyout+0x88>
80106e78:	90                   	nop
80106e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106e80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106e83:	89 f1                	mov    %esi,%ecx
80106e85:	29 d1                	sub    %edx,%ecx
80106e87:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106e8d:	39 d9                	cmp    %ebx,%ecx
80106e8f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106e92:	29 f2                	sub    %esi,%edx
80106e94:	83 ec 04             	sub    $0x4,%esp
80106e97:	01 d0                	add    %edx,%eax
80106e99:	51                   	push   %ecx
80106e9a:	57                   	push   %edi
80106e9b:	50                   	push   %eax
80106e9c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106e9f:	e8 ac d5 ff ff       	call   80104450 <memmove>
    len -= n;
    buf += n;
80106ea4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ea7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80106eaa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106eb0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106eb2:	29 cb                	sub    %ecx,%ebx
80106eb4:	74 32                	je     80106ee8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106eb6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106eb8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106ebb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106ebe:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106ec4:	56                   	push   %esi
80106ec5:	ff 75 08             	pushl  0x8(%ebp)
80106ec8:	e8 53 ff ff ff       	call   80106e20 <uva2ka>
    if(pa0 == 0)
80106ecd:	83 c4 10             	add    $0x10,%esp
80106ed0:	85 c0                	test   %eax,%eax
80106ed2:	75 ac                	jne    80106e80 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106ed4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106edc:	5b                   	pop    %ebx
80106edd:	5e                   	pop    %esi
80106ede:	5f                   	pop    %edi
80106edf:	5d                   	pop    %ebp
80106ee0:	c3                   	ret    
80106ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ee8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106eeb:	31 c0                	xor    %eax,%eax
}
80106eed:	5b                   	pop    %ebx
80106eee:	5e                   	pop    %esi
80106eef:	5f                   	pop    %edi
80106ef0:	5d                   	pop    %ebp
80106ef1:	c3                   	ret    
