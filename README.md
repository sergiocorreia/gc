# GC - Garbage Collection for Stata variables _(programmer command)_

`gc` is just a simple counter based on -asarray()- that drops
a variable once its counter reaches zero.
Thus, it can be used for simple garbage collection,
when trying to be careful with memory usage.

## Example usage

```stata
sysuse auto

gc new
gc add price gear
gc add turn price trunk price
gc remove trunk price
gc report

sysuse auto, clear
gc new
gc add _all
gc add price turn
gc remove _all
gc report
```

# Installation

With Stata 13+, type:

```
cap ado uninstall gc
net install gc, from(https://github.com/sergiocorreia/gc/raw/master/source/)
```

For older versions, first download and extract the [zip file](https://github.com/sergiocorreia/gc/archive/master.zip), and then run

```
ado uninstall gc
net install gc, from(SOME_FOLDER)
```

Where *SOME_FOLDER* is the folder that contains the *stata.toc* and related files.
