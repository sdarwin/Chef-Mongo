See README.md.orig

This is a Chef recipe to install MongoDB based on edelight.  

The original recipe has a restriction that the shard server, config server, and mongos server be on different machines.  That is actually quite a problem for many use cases.   It is fixed here and is the main difference between the recipes.  The change was of moderate complexity, neither trivial nor super difficult.


Copyright 2012 Sam Darwin samuel.d.darwin at gmail

