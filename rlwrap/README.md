# Unwrapping rlwrap
Sometimes developers have a choice, spend five minutes completing a menial task or spend three hours learning how to most optimially compelete it....

Alot more than three hours later and below is all i have to show for it, but hopefully will help you get the most out of rlwrap with Q.

Rlwrap is a readline wrapper, a small utility that uses the GNU readline library to allow the editing of keyboard input for any other command. Essentailly rlwap is used to allow users the ability to use the arrow keys to move left to write to edit and up and down to cycle through historical commands.

If you arent already using rlwrap already here's how to install it. 

mac:    https://code.kx.com/q/learn/install/macos/#install-rlwrap
linux:  https://code.kx.com/q/learn/install/linux/#install-rlwrap

Note rlwrap is only available for linux and mac os and not on windows.

Usually developers install rlwrap. Update their q alias and be happy that they no longer have to type entire lines of code left to right in an language read right to left without being able to use the arrow keys.

But theres actually some useful features of rlwrap that most developers don't seem to be aware of and thats what this post hopes to share.

## CTRL-r

### Problem
You have a cmd that you executed previously that you want to re execute or edit slightly and execute without having to re typing the whole thing. Or endlessly hitting up until you find it. 

### Solution
You can search through all your q history by first hitting CTRL-r then typing what you're searching for.

The lastest match will then appear, You an use up to look at older lines that also match.
Once you've found the one you were looking for hit right arrow to edit before executing. Or enter to excute same line again.

![Demonstration of ctrl-r](ctrlr.gif)

## CTRL-l

### Problem
Your showing somebody something on q and you have a mess of code on your screen, or maybe your while sharing your screen you cant really see the bottom of the screen properly or just want to start from blank to make things clear.

### Solution
CTRL-l works as a short cut for 'clear' command. No one may ever need to know about that embarassing 'type error...

![Demonstration of ctrl-r](ctrll.gif)

## rlwrap -f 

### Problem
Maybe you've just started learning KDB and you cant remember this big list of all the q functions.
You have https://code.kx.com/q/ref/ bookmarked but are just feed up having to keep checking

... or maybe you're an experience developer thats just started everywhere and really cant be bother trying to remember all the new function names in the framework you are now going to be using

... or like me you just really struggle spelling ~~recipricol~~ ~~reciprical~~ ... "(%:)" . Seriously 10 letters for a Q function?

### Solution

The -f, --file option:
```
  -f, --file file
         Split file into words and add them to the completion word list. This option can be given more than once, and adds to the default completion list in  $RLWRAP_HOME or /usr/share/rlwrap/completions.
```

This will allow us to start typing a function and then tab to auto-complete/show us all the options we have.
Much like when you press tab in unix when writing out file paths.

Now we just need a way to populate this file. The tools in order to do this have been included in a script to accompony this blog.

Start your q session load in all the functions you want to be included in your auto complete list. 

Then load in function above and run
```
.rac.buildRlwrapCompFile ` sv (hsym `$system"echo $HOME"),`qRlwapAutoComplete.txt
```

```
|20:37:38|eoincunning@Eoins-Air:[rlwrap]> q
KDB+ 3.6 2018.12.24 Copyright (C) 1993-2018 Kx Systems
m32/ 4()core 4096MB eoincunning eoins-air.home 192.168.1.10 NONEXPIRE  

q)//load some libaries you want to include in list
q)\l /Users/eoincunning/kdb/utils/dbmaint.q 
q)
q)/load rlwarp auto complete script 
q)\l rlwrapAutoComp.q
q)
q).rac.writeRlwrapFile ` sv (hsym `$system"echo $HOME"),`qRlwapAutoComplete.txt  
q)\\
https://medium.com/@pczarkowski/how-to-make-an-animated-gif-of-your-terminal-commands-62b08dfb6089
```
![Demonstration of running build script](buildFile.gif)

Now start a new q session with (edit or add alias to your .bashrc)


```
rlwrap -f ~/qRlwapAutoComplete.txt q
```

Now when you hit tab twice <tab> <tab> you will see all the options in ~/qRlwapAutoComplete.txt 
![Demonstration of rlwrap -f ](demoFile.gif)

You'll never have to spell reciprocal again.

