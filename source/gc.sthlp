{smcl}
{* *! version 1.0  11jul2016}{...}
{vieweralsosee "ftools" "help ftools"}{...}
{vieweralsosee "reghdfe" "help reghdfe"}{...}
{title:Title}

{p2colset 5 11 20 2}{...}
{p2col :{cmd:gc} {hline 2}}Garbage collection for Stata variables{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:gc new}

{p 8 16 2}
{cmd:gc add} {varlist}

{p 8 16 2}
{cmd:gc remove} {varlist}

{p 8 16 2}
{cmd:gc report}

{title:Description}

{pstd}
This command keeps counters for variables (in the mata object {it:gc}),
dropping the variables from the dataset once the counter reaches 0.

For example: {inp}

        sysuse auto, clear
        gc new
        gc add _all
        gc add price turn price
        gc remove _all
        gc report{txt}

{title:Author}

{pstd}Sergio Correia{break}
Fuqua School of Business, Duke University{break}
Email: {browse "mailto:sergio.correia@gmail.com":sergio.correia@gmail.com}{break}
Project URL: {browse "https://github.com/sergiocorreia/ftools"}{break}
{p_end}
