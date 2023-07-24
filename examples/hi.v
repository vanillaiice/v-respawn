import os
import flag

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	names := fp.string_opt('name', `n`, '--name <NAME> or -n <NAME>') or {
		eprintln(err)
		exit(1)
	}
	names_arr := names.split(" ")
	
	for n in names_arr {
		greeting := 'Hi, ${n}\n'
		print(greeting)
		os.write_file("hi.${n}.txt", greeting)!
	}
}
