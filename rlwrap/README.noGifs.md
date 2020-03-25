# Unwrapping rlwrap
Sometimes developers have a choice, spend five minutes completing a menial task or spend three hours learning how to most optimally complete it....

A lot longer than three hours later and below is all I have to show for it, but hopefully it will help you get the most out of rlwrap with q.

Out of the box a kdb+ console does not support using arrow keys to edit the line of code you are writing or go back through the history of commands you have entered. Rlwrap is a small utility which enables these features.

If you aren’t already using rlwrap already here's how to install it.

mac: https://code.kx.com/q/learn/install/macos/#install-rlwrap 

linux: https://code.kx.com/q/learn/install/linux/#install-rlwrap 

Note rlwrap is only available for linux and mac os and not on windows.

Usually developers install rlwrap. Update their q alias and be happy that they no longer have to type entire lines of code left to right in an language read right to left without being able to use the arrow keys.

But there's actually some useful features of rlwrap that most developers don't seem to be aware of and that's what this post hopes to share.

## CTRL-r

### Problem
You have a cmd that you executed previously that you want to re-execute or edit slightly and execute without having to retype the whole thing. Or endlessly hitting the up arrow until you find it.

### Solution
Similarly to how you can search through your history in a bash shell. You can search through all your q history by first hitting CTRL-r then typing what you're searching for.

The latest match will then appear, You can use the up arrow to look at older lines that also match. Once you've found the one you were looking for hit the right or left arrow to edit before executing. Or enter to execute same line again.

```
q)
q)command_1:1+1
q)command_2:{1+x}
q)1+1
2
q)2+2
4
q)//type CTRL-r and start typing desired previously executed command
(reverse-i-search)`comm': command_2:{1+x}
```

## CTRL-l

### Problem
You're showing somebody something in q and you have a mess of code on your screen, or maybe while sharing your screen you can’t really see the bottom of the screen properly or just want to start from blank to make things clear.

### Solution
CTRL-l works as a short cut for 'clear' command. No one may ever need to know about that embarassing 'type error...

## rlwrap -f 

### Problem
Maybe you've just started learning kdb+ and you can’t remember this big list of all the q functions. You have https://code.kx.com/q/ref/ bookmarked but are just fed up having to keep checking

... or maybe you're an experienced developer that’s just started a new role and really can’t be bothered trying to remember all the new function names in the framework you are now going to be using

... or like me you just really struggle spelling recipricol reciprical ... "(%:)" . Seriously 10 letters for a q function?

### Solution

The -f, --file option:
```
  -f, --file file
         Split file into words and add them to the completion word list. 
         This option can be given more than once, and adds to the default completion list in 
         $RLWRAP_HOME or /usr/share/rlwrap/completions.

```

This will allow us to start typing a function and then hit ‘tab’ to auto-complete/show us all the options we have. Much like when you press tab in unix when writing out file paths.

Now we just need a way to populate this file. The tools in order to do this have been included in a script to accompany this blog.

Start your q session load in all the functions you want to be included in your auto complete list.

Then load in function above and run

```
.rac.buildRlwrapCompFile ` sv (hsym `$getenv `HOME),`qRlwapAutoComplete.txt
```

```
q)
q)//load some libaries you want to include in list
q)\l /Users/eoincunning/kdb/utils/dbmaint.q
q)
q)/load rlwrap autocomplete script
q)\l rlwrapAutoComp.q
q)
q)//run function to write file with desired file location as input
q).rac.writeRlwrapFile ` sv (hsym `$getenv `HOME),`qRlwrapAutoComplete.txt
```

Now start a new q session with (edit or add alias to your .bashrc)


```
rlwrap -f ~/qRlwapAutoComplete.txt q
```

Now when you hit 'tab' twice you will see all the options in ~/qRlwapAutoComplete.txt 
```
q)
Display all 376 possibilities? (y or n)
.Q.                  .Q.bv                .Q.gc                .Q.qd                .h.br                .h.sb                .h.xt                and                  hsym                 parse                trim
.Q.A                 .Q.chk               .Q.hap               .Q.qe                .h.c0                .h.sc                .j.                  any                  iasc                 peach                type
.Q.BP                .Q.cn                .Q.hdpf              .Q.qm                .h.c1                .h.td                .j.J                 asc                  idesc                pj                   uj
.Q.Cf                .Q.d0                .Q.hg                .Q.qp                .h.cd                .h.text              .j.e                 asof                 ij                   prds                 ujf
.Q.DL                .Q.dbg               .Q.hmb               .Q.qt                .h.code              .h.tx                .j.es                attr                 ijf                  prev                 ungroup
.Q.IN                .Q.dd                .Q.host              .Q.res               .h.data              .h.tx.csv            .j.j                 avgs                 inter                prior                union
.Q.K                 .Q.def               .Q.hp                .Q.s                 .h.eb                .h.tx.json           .j.k                 buildRlwrapCompFile  inv                  rand                 upper
.Q.L                 .Q.dpft              .Q.id                .Q.s1                .h.ec                .h.tx.raw            .j.q                 ceiling              key                  rank                 upsert
.Q.Ll                .Q.dpfts             .Q.ind               .Q.s2                .h.ed                .h.tx.txt            .j.s                 cols                 keys                 ratios               value
.Q.Lp                .Q.dpt               .Q.j10               .Q.sbt               .h.edsn              .h.tx.xls            .o.                  count                lj                   raze                 view
.Q.Ls                .Q.dpts              .Q.j12               .Q.sha1              .h.es                .h.tx.xml            .o.B0                cross                ljf                  read0                views
.Q.Lu                .Q.dr                .Q.jl8               .Q.srr               .h.ex                .h.ty                .o.C0                csv                  load                 read1                vs
.Q.Lx                .Q.dsftg             .Q.k                 .Q.sw                .h.fram              .h.ty.bmp            .o.Cols              cut                  lower                reciprocal           where
.Q.M                 .Q.dt                .Q.l                 .Q.t                 .h.ha                .h.ty.css            .o.Columns           deltas               lsq                  reval                wj
.Q.MAP               .Q.dw                .Q.lu                .Q.t0                .h.hb                .h.ty.csv            .o.FG                desc                 ltime                reverse              wj1
.Q.S                 .Q.en                .Q.n                 .Q.tab               .h.hc                .h.ty.doc            .o.Fkey              differ               ltrim                rload                ww
.Q.V                 .Q.ens               .Q.nA                .Q.trp               .h.he                .h.ty.gif            .o.Gkey              distinct             mavg                 rotate               xasc
.Q.Xf                .Q.enx               .Q.nct               .Q.ts                .h.hn                .h.ty.htm            .o.Key               dsave                maxs                 rsave                xbar
.Q.a                 .Q.enxs              .Q.nv                .Q.tt                .h.hp                .h.ty.html           .o.PS                each                 mcount               rtrim                xcol
.Q.a0                .Q.err               .Q.opt               .Q.tx                .h.hr                .h.ty.ico            .o.Special           ej                   md5                  save                 xcols
.Q.a1                .Q.f                 .Q.ord               .Q.ty                .h.ht                .h.ty.jpg            .o.Stats             ema                  mdev                 scan                 xdesc
.Q.a2                .Q.fc                .Q.p                 .Q.ua                .h.hta               .h.ty.js             .o.T                 eval                 med                  scov                 xgroup
.Q.addmonths         .Q.ff                .Q.p1                .Q.v                 .h.htac              .h.ty.json           .o.T0                except               meta                 sdev                 xkey
.Q.addr              .Q.fk                .Q.p2                .Q.view              .h.htc               .h.ty.pdf            .o.TI                fby                  mins                 set                  xlog
.Q.ajf0              .Q.fl                .Q.par               .Q.vt                .h.html              .h.ty.png            .o.Tables            fills                mmax                 show                 xprev
.Q.an                .Q.fmt               .Q.pcnt              .Q.vt.               .h.http              .h.ty.svg            .o.Ts                first                mmin                 signum               xrank
.Q.b6                .Q.foo               .Q.pl                .Q.w                 .h.hu                .h.ty.swf            .o.TypeInfo          fkeys                mmu                  ssr
.Q.bc                .Q.fp                .Q.pl0               .Q.x0                .h.hug               .h.ty.txt            .o.ex                flip                 mod                  string
.Q.bd                .Q.fpn               .Q.pm                .Q.x1                .h.hy                .h.ty.xls            .o.o                 floor                msum                 sublist
.Q.bp                .Q.fps               .Q.prr               .Q.x10               .h.iso8601           .h.ty.xml            .o.t                 get                  neg                  sums
.Q.bs                .Q.fqk               .Q.ps                .Q.x12               .h.jx                .h.ty.zip            aj                   group                next                 sv
.Q.bt                .Q.fs                .Q.pt                .Q.x2                .h.logo              .h.uh                aj0                  gtime                not                  svar
.Q.btoa              .Q.fsn               .Q.q0                .Q.xy                .h.nbr               .h.xd                ajf                  hclose               null                 system
.Q.btx               .Q.ft                .Q.qa                .h.                  .h.pre               .h.xmp               ajf0                 hcount               or                   tables
.Q.bu                .Q.fu                .Q.qb                .h.HOME              .h.sa                .h.xs                all                  hdel                 over                 til
//now type re <tab> <tab>. see what happens. Then type a c and <tab> again
q)re
read0       read1       reciprocal  reval       reverse
q)reciprocal
%:
```
You'll never have to spell reciprocal again.
