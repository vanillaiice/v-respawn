import os
import flag
import time

const (
	dash_byte = u8(45)
	space_str = ' '
	empty_str = ''
)

fn parse_args(args string) []string {
	if args == empty_str {
		return [empty_str]
	}
	
	mut args_split := args.split(space_str)
	mut args_temp, mut args_parsed := []string{}, []string{}

	for i := 0; i < args_split.len; i++ {
		if args_split[i][0] == dash_byte {
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
	fp.description('Respawn a program after it gets killed')
	fp.usage_example('respawn --program foo --args "--bar baz -z fizz" --work-folder ../buzz --max-retry 5 --retry-time 60')
	program := fp.string('program', `p`, '', '--program <PATH> or -p <PATH>')
	args := fp.string('args', `a`, empty_str, '--args "<ARGS>" or -a "<ARGS>"')
	work_folder := fp.string('work-folder', `f`, empty_str, '--work-folder <FOLDER PATH> or -f <FOLDER PATH>')
	max_retry := fp.int('max-retry', `r`, 3, '--max-retry <MAX RETRY> or -r <MAX RETRY>')
	retry_time := fp.int('retry-time', `t`, 0, '--retry-time <RETRY TIME SECONDS> or -t <RETRY TIME SECONDS>')
	fp.finalize() or {
		eprintln(err)
		exit(1)
	}

	if program == empty_str {
		eprintln("ERROR: parameter 'program' not provided, exiting")
		exit(1)
	}

	args_arr := parse_args(args)

	for {
		mut process := os.new_process(program)
		
		process.set_args(args_arr)
		process.set_work_folder(work_folder)
		
		process.run()
		println('PID: ${process.pid}')
		process.wait()
		
		println('\nGot killed, respawning')
		
		if process.err != empty_str {
			eprintln("REASON: ${process.err}")
		}
		
		kill_count++
		
		println('KILL COUNT: ${kill_count}')
		if kill_count == max_retry {
			break
		}
		
		if retry_time != 0 {
			time.sleep(time.second * retry_time)
		}
	}
}
