/
    Create auto complete file from given Q session to be used by rlwrap
    Author: Eoin Cunning, Kx Systems
\

// move into namespace Rlwrap Auto Complete
\d .rac

// Namespace exclusion list. Ignore this namespace by default
ign:enlist `.rac

// @desc Builds list of all variables/functions from root namespaces and writes to file
//
// @param x {symbol} Specifies the location of the filepath to write list of functions/variables to
//
writeRlwrapFileSubset:{
    //build list of variables/functions for all namespaces
    list:buildList x;
    //write to file
    y 0: string list;
    }

// wrapper of above to do all namespaces
writeRlwrapFile:{
    writeRlwrapFileSubset[`;x]
    }

// @ desc funtion to recursively build all functions variables (special handling for q functions and current namespace)
//
// @param x {symbol[]} List of namespaces
//
recSearch:{distinct x,raze @[;where x[b] in `.q,system"d";{raze 2 _/:` vs/:x}] ` sv/:/:x[b],/:'a@:b:where 11=type each a:key each x@:where 99=type each @[get;;`] each x}/;

// @desc Wrapper function that exlcudes any ignored namespacesnd current namespace in from list
//
// @param x {symbol[]} list of namespaces to build list of variables/functions for. ` or (::) does all namespaces
//
buildList:{
    //if x is ` or (::) overwrite will all namespaces other wise just ensure is list
    x:$[1b~null x;` sv/:`,/:key `;x,()];
    //recursives search ignoring exclusion list
    res:recSearch x except ign;
    //drop special namespaces and start of others and sort
    asc res except ``.q,x,system"d"
    }

\

Usage:

.rac.writeRlwrapFile ` sv (hsym `$system"echo $HOME"),`qRlwapAutoComplete.txt                                       /create a file in home directory that lists all the variables and functions in your given q session
.rac.writeRlwrapFileSubset[`.myNameSpace`.myNameSpace2;` sv (hsym `$system"echo $HOME"),`qRlwapAutoComplete.txt]    /only writes the variables and functions to the file name for nsamespaces provided
.rac.buildList `.myNameSpace`.myNameSpace2                                                                          /build the list to examine in memorary before writing to file

Next time starting q session start wih
rlwrap -f ~/qRlwapAutoComplete.txt q    /all function,variable names will be availible for auto complete by pressing tab while typing

Globals:

.rac.ign - namespaces to exclude from list .rac by default; assign to change
