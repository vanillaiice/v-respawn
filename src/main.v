import os
import flag

const (
	dash      = u8(45)
	space_str = ' '
	empty_str = ''
)

fn parse_args(args string) []string {
	mut args_split := args.split(space_str)
	mut args_temp := []string{}
	mut args_parsed := []string{}

	for i := 0; i < args_split.len; i++ {
		if args_split[i][0] == dash {
			if args_temp.len != 0 {
				args_parsed << args_temp.join(space_str)
				args_temp.clear()
			}
			args_parsed << args_split[i]
		} else {
			args_temp << args_split[i]
		}
	}

	if args_temp.len != 0 {
		args_parsed << args_temp.join(space_str)
	}

	return args_parsed
}

fn main() {
	mut kill_count := 0
	mut fp := flag.new_flag_parser(os.args)
	fp.version('v0.1.0')
	fp.description('Run a program forever')
	fp.usage_example('infini --program foo --args "--bar baz -z fizz"')
	program := fp.string('program', `p`, '', '--program <PATH> or -p <PATH>')
	args := fp.string('args', `a`, empty_str, '--args "<ARGS>" or -a "<ARGS>"')
	work_folder := fp.string('workfolder', `f`, empty_str, '--workfolder <FOLDER PATH> or -f <FOLDER PATH>')
	max_retry := fp.int('maxretry', `r`, 5, '--maxretry <MAX RETRY INT> or -r <MAX RETRY INT>')
	fp.finalize()!

	if program == empty_str {
		eprintln("ERROR: parameter 'program' not provided")
		exit(1)
	}

	args_arr := parse_args(args)

	for {
		mut p := os.new_process(program)
		p.set_args(args_arr)
		p.set_work_folder(work_folder)
		p.run()
		println('PID: ${p.pid}\n')
		p.wait()
		println('\nGot killed, respawning')
		if p.err != empty_str {
			eprintln("REASON: ${p.err}")
		}
		kill_count++
		println('KILL COUNT: ${kill_count}\n')
		if kill_count == max_retry {
			break
		}
	}
}
