* Garbage collection with variables
cap pr drop gc
pr gc
	gettoken subcmd 0 : 0
	if ("`subcmd'" != "new" & c(stata_version) >= 14) {
		* -classname- is new in Stata 14
		mata: assert(classname(gc) == "GC")
	}

	if ("`subcmd'" == "new") {
		mata: gc = GC()
		mata: gc.init()
	}
	else if ("`subcmd'" == "report") {
		mata: gc.report()
	}
	else if ("`subcmd'" == "add") {
		syntax varlist
		mata: gc.add(tokens("`varlist'"))
	}
	else if ("`subcmd'" == "remove") {
		syntax varlist, [noCollect]
		mata: gc.remove(tokens("`varlist'"))
		if ("`collect'" != "nocollect") {
			mata: gc.collect()
		}
	}
	else if ("`subcmd'" == "collect") {
		mata: gc.collect()
	}
	else {
		di as error "invalid subcommand: `subcmd'"
		error 123
	}
end

mata:
mata set matastrict off
class GC
{
	counter
	void init()
	void add()
	void remove()
	void collect()
	void report()
}

void GC::init()
{
	counter = asarray_create("string", 1)
	asarray_notfound(counter, 0)
}

void GC::add(string rowvector vars)
{
	for (i = 1; i <= length(vars); i++) {
		val = asarray(counter, vars[i])
		asarray(counter, vars[i], val + 1)
	}
}

void GC::remove(string rowvector vars)
{
	for (i = 1; i <= length(vars); i++) {
		val = asarray(counter, vars[i])
		if (val == 0) {
			_error(123, "count already zero")
		}
		else {
			asarray(counter, vars[i], val - 1)
		}
	}
}

void GC::collect() {
	vars = asarray_keys(counter)
	for (i = 1; i <= length(vars); i++) {
		val = asarray(counter, vars[i])
		if (val == 0) {
			vars[i] = ""
		}
	}
	st_keepvar(tokens(invtokens(vars')))
}

void GC::report()
{
	vars = asarray_keys(counter)
	printf("Variable counter:\n")
	for (i = 1; i <= length(vars); i++) {
		val = asarray(counter, vars[i])
		if (val > 0) {
			printf(" - %s: %3.0f\n", vars[i], val)
		}
	}
}

end
