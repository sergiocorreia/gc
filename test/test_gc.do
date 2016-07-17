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

sysuse auto, clear
gc new
gc add _all
gc add price turn
gc remove _all
gc report

exit
