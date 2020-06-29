### High Avail Ability Hdb tools

Common issue when editing historical data in a hdb is that if the hdb queries the partition as it is being written to this can result in a `'length` error 

```
TODO DEMO of such an error
```

One method to make this error less likely to be encountered by a user is to take a copy of the data and place into a staging area. Edit/update the data here then replace again once finished.

```
TODO sample code
```

This method is more robust, also protects the hdb copy incase there are errors in the edit/updating process.
However there is still the potential to encounteer a length error as the OS takes time to delete the files and then mv the new files in.

```
TODO DEMO
```

So for a truely high availability HDB we need a better method for this replacement.

One way this can be accomplished is by making our partitions symlinks instead of directories.
By doing so, we can simply point the symlink of a partiion to a new directory instead of doing the rm and mv.
Below is what such an implementation might look like.

TODO include sample code and show hdb layout. Also display how errors in 1 and 2 are avoided
