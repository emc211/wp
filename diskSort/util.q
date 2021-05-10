.util.xasc:{[colsToSortBy;handleToTable;opts]
    //perform iasc on table from of what we want to sort by
    order:iasc ?[handleToTable;();0b;{x!x}(),colsToSortBy];
    if[order~til count order;
        .log.info"already sorted:",string handleToTable;
        if[count opts`compressionSet;
            {.log.info"compressing :",string y;-19!y,y,x}[opts`compressionSet;] peach ` sv/:handleToTable,/:cols handleToTable;
        ];
        :();
    ];
    .util.applyNewOrderOnDisk[handleToTable;;order;opts`compressionSet]peach cols handleToTable
    }

.util.applyNewOrderOnDisk:{[handleToTable;column;order;compSet]
    handle:(` sv handleToTable,column);
    st:.z.p;
    /get data and apply sort
    data:handleToTable[column] order;
    .util.setMaintainCompression[handle;data;compSet];
    .log.info"sort of ",string[column]," in ",string[handleToTable]," took:",string .z.p-st;
    }

.util.setMaintainCompression:{[fh;data;compSet]
    /if compSet provided then just write data and exit
    if[3=count compSet;
        fh:fh,compSet;
        fh set data;
        :(::);
        ];
    /get existing settings with protected eval incase new fh
    cDict:.[!;(-21;fh);()];
    /make defaults 0s
    cDict:((1#`)!1#0),cDict;
    fh:fh,cDict`logicalBlockSize`algorithm`zipLevel;
    fh set data
    }
