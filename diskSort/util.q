.util.xasc:{[sortCols;tblPath;opts]
    //opts
    compSet:opts`compSet;
    //perform iasc on table form of what we want to sort by
    order:iasc ?[tblPath;();0b;{x!x}(),sortCols];
    //if can succsesfully apply sorted attribute to order its already sorted
    if[@[{`s#x;1b};order;0b];
        .log.info"already sorted:",string tblPath;
        if[count compSet;
            {.log.info"compressing :",string y;-19!y,y,x}[compSet;] peach ` sv/:tblPath,/:cols tblPath;
        ];
        :();
    ];
    .util.applyNewOrderOnDisk[handleToTable;;order;compSet]peach cols handleToTable
    }

.util.applyNewOrderOnDisk:{[handleToTable;column;order;compSet;attrCols]
    handle:` sv handleToTable,column;
    st:.z.p;
    //get data and apply sort
    data:handleToTable[column] order;
    if[column in key attrCols;
        @[attrCols[column]#;data;{.log.error "failed to apply attribute to ",x," error: ",y}[column;]]
        ];
    .util.setMaintainCompression[handle;data;compSet];
    .log.info"sort of ",string[column]," in ",string[handleToTable]," took:",string .z.p-st;
    }

.util.setMaintainCompression:{[fh;data;compSet]
    //if compSet provided then just write data and exit
    if[3=count compSet;
        (fh,compSet) set data;
        :(::);
        ];
    //get existing settings with protected eval incase new fh
    compSet:@[{-3#0 0 0i,value -21!x};fh;0 0 0i];
    (fh,compSet) set data
    }
