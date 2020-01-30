# The Problem 

Maybe you've just started learning KDB and you cant remember this big list of all the q functions.
You have https://code.kx.com/q/ref/ bookmarked but are just feed up having to keep checking

... or maybe you're an experience developer thats just started everywhere and really cant be bother trying to remember all the new function names in the framework you are now going to be using

... or like me you just really struggle spelling ~~recipricol~~ ~~reciprical~~ ... "(%:)" . Seriously 10 letters for a Q function? 

# The solution

Theres actually a really cool feature of rlwrap that can help with this. The -f, --file option:
```
  -f, --file file
         Split file into words and add them to the completion word list. This option can be given more than once, and adds to the default completion list in  $RLWRAP_HOME or /usr/share/rlwrap/completions.
```

This will allow us to start typing a function and then tab to auto-complete/show us all the options we have.
Much like when you press tab in unix when writing out file paths.

Now we just need a way to populate this file...
```
buildRlwrapCompFile:{[filePath]
    exceptlist:(),`; //always ignore null
/   exceptlist,:`.Q``.h`.j`.o`.cf; //edit this line to customise what namespaces to exclude
    f:{distinct x,raze ` sv/:/:a[c],/:'b@:c:where 11h=type each b:key each a@:where 99=type each @[value;;`] each a:x except y}[;exceptlist]/;
    //q functions and
    list:`$raze {1_(1+count string x)_/:string y enlist x}[;f]each `.q,system"d"; // uncomment for auto complete standard q funcs
    list:list except `;
    //
    exceptlist,:`.q;
    //name spaces from root
    nss:` sv/:`,/:key `; //namespaces
    nss:nss except exceptlist;
    //starting,:`; //uncomment to include global variables
    list,:f nss;
    //get rid of the starting namespaces
    list:list except nss;
    filePath 0: string list;
    }
```

Start your q session load in all the functions you want to be included in your auto complete list. 

Then load in function above and run 
```
buildRlwrapCompFile ` sv (hsym `$system"echo $HOME"),`qRlwapAutoComplete.txt
```

Now start a new q session with (edit or add alias to your .bashrc)
```
rlwrap -f ~/qRlwapAutoComplete.txt q
```

Now hit tab twice <tab> <tab>... 
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
