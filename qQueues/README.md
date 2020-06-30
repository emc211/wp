#Queues in q
Queues are everywhere. There in shops, supermarkets, the DMV and queues are even present in many kdb systems.
In most kdb systems they're not called queues they're called gateways or balancers. But that name isnt anywhere near as clever for a blog post.
This post will explorer the different ideas behind queues rather than how to design the process that exectue them themselves.
If you want more information on gateway arcitecture look at white paper:

In each of the below 
co - is the list of checkouts (process) 
c - is a customer (query) 

##Priority boarding 

```
q)priortize:{[ps;co] (ps _ d),/:(d til ps),enlist ()}
q)
q)priortize[1;til 10]
3 4 5 6 7 8 9 0
3 4 5 6 7 8 9 1
3 4 5 6 7 8 9 2
3 4 5 6 7 8 9
```

##Shortest line - Typical Supermarket
mserve.q

##Whole foods
4 queues 
all resources round robin queues

##10 items or less
Identify small query and run it first on dedicated resouce

##Know the bouncer
Skip to the front of the line



