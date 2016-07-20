*ado uninstall gc
*net install gc, from(c:/git/gc/source)

clear all
pr drop _all
set more off
set trace off
cls

* Test

sysuse auto

gc new
gc add price gear
gc add turn price trunk price
gc remove trunk price
gc report
ds
assert "`r(varlist)'" == "price turn gear_ratio"

sysuse auto, clear
gc new
gc add _all
gc add price turn
gc remove _all
gc report
ds
assert "`r(varlist)'" == "price turn"

sysuse auto, clear
gc new
gc add price gear
gc collect
gc report
ds
assert "`r(varlist)'" == "price gear_ratio"

sysuse auto, clear
gc new
gc add _all
gc remove gear , nocollect
gc remove price , nocollect
gc remove mpg-turn , noc
gc collect
gc remove disp, noco
gc report
ds
assert "`r(varlist)'" == "make displacement foreign"

exit
