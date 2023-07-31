import os
import flag

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.description('Simple greeter')
	names := fp.string_opt('name', `n`, '--name <NAME> or -n <NAME>') or {
		eprintln(err)
		exit(1)
	}
	fp.finalize()!
	
	names_arr := names.split(" ")
	
	for n in names_arr {
		greeting := 'Hi, ${n}\n'
		print(greeting)
		os.write_file("hi.${n}.txt", greeting)!
	}
}
