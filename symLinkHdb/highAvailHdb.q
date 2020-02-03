/
    Tools to update high availbitily HDBs
    author  : E M Cunning, Kx Syss
    created : 2020.02.03
\


//
// @ param remoteServer
// @ param fromLocation
// @ param toLocation
// @ param part         partition
//
.util.movePartitionToHdb:{[remoteServer;fromLocation;toLocation;part]
    sPart:string[part];
    //
    permPartition:first .util.runRemoteSysCmd[remoteServer] "readlink -f ",toLocation,"/db/",sPart;
    //if result of readlink is not pointing to a segment then doesnt yet exist. write to latest
    if[permPartition like "*/db/*";
        //look for the latest segment to write into by default
        //If ever want to edit the logic where use to chose segments change line below. This selects segment as opposed to .Q.par
        segmentToWriteTo:first .util.runRemoteSysCmd[remoteServer]"ls -vd ",toLocation,"/seg*/ | tail -n 1";
        permPartition:segmentToWriteTo,sPart;
        ];
    //name of the tmp partition to move to
    tmpPartition:permPartition,"_tmp";
    //Chose different command based on whether local or across servers
    $[remoteServer=.z.h;
        cmd:"mv ",fromLocation,"/",sPart," ",tmpPartition;
        cmd:"rsync -rkv --progress -e \"ssh -o 'BatchMode yes'\" ",fromLocation,"/",sPart," ",string[.z.u],"@",string[remoteServer],":",tmpPartition;
        ];
    //Do copy of partition
    .util.runSysCmd[cmd];
    //
    tmpPartition:"../","/"sv -2#"/" vs tmpPartition;
    permPartition:"../","/"sv -2#"/" vs permPartition;
    //now switch link to _tmp
    .util.runRemoteSysCmd[remoteServer;"(cd ",toLocation," ; ln -sfn ",tmpPartition," ",sPart," )"];
    //now remove the perm location if it already exists;
    .util.runRemoteSysCmd[remoteServer;"(cd ",toLocation," ; rm -rf ",permPartition," )"];
    //now copy the tmpLocation to the perm location only creates harlinks of all the underlying files
    .util.runRemoteSysCmd[remoteServer;"(cd ",toLocation," ; cp -al ",tmpPartition," ",permPartition," )"];
    //now switch link to new
    .util.runRemoteSysCmd[remoteServer;"(cd ",toLocation," ; ln -sfn ",permPartition," ",toLocation,"/",sPart," )"];
    //remove the tmp location
    .util.runRemoteSysCmd[remoteServer;"(cd ",toLocation," ; rm -rf ",tmpPartition," )"];
    };

// @ desc Runs a system command with logging
//
// @ param cmd string command to be run
//
.util.runSysCmd:{[cmd]
    .log.info "Running system command ",cmd;
    system cmd
    };

.util.runRemoteSysCmd:{[remoteServer;cmd]
    if[remoteServer=.z.h;
        :.util.runSysCmd[cmd];
        ];
    cmd:"ssh ",string[.z.u],"@",string[remoteServer]," '",cmd,"'";
    .util.runSysCmd[cmd]
    }

//if no log.info function exist set basic ones
if[not `info in key `.log;
    .log.error:.log.info:-1
    ]
    ;