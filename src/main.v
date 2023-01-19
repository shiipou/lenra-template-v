module main

import os
import json
import x.json2 { Any }
import src.data { Api }
import src.listeners
import src.views

const (
	root_view = 'root'
	view_list = {
		'root':    views.root
		'menu':    views.menu
		'home':    views.home
		'counter': views.counter
		'loading': views.loading
	}
	listener_list = {
		'increment':       listeners.increment
		'onEnvStart':      listeners.on_env_start
		'onUserFirstJoin': listeners.on_user_first_join
	}
	resource_list = {
		'logo': $embed_file('resources/logo.png')
	}
)

fn main() {
	$if debug {
		eprintln('Started')
	}
	//? Reading from input stream
	str_input := os.get_lines_joined()
	$if debug {
		eprintln('Input: $str_input')
	}
	match str_input.len {
		0 {
			manifest := '{"manifest": ${json.encode(handle_manifest())}}'
			$if debug {
				eprintln('Output: $manifest')
			}
			println(manifest)
		}
		else {
			parse_request(str_input) or { panic(err) }
		}
	}
}

fn parse_request(str_input string) ! {
	json_str := json2.fast_raw_decode(str_input) or {
		map[string]Any{}
	}

	request := json_str.as_map()

	match true {
		'view' in request {
			result := handle_view(request['view']!.str(), request['data']!.arr(),
				request['props']!.as_map(), request['context']!.as_map()) or {
				panic(error('Error during parsing view $str_input\n$err'))
			}
			$if debug {
				eprintln('Output: $result.prettify_json_str()')
			}
			println(result.json_str())
		}
		'action' in request {
			action := request['action']!.str()
			props := request['props']!.as_map()
			event := request['event']!.as_map()
			api := request['api']!.as_map()

			handle_listener(action, props, event, api) or {
				panic(error('Error during parsing listener $str_input\n$err'))
			}
		}
		'resource' in request {
			handle_resource(request['resource']!.str()) or {
				panic(error('Error during parsing resource $str_input\n$err'))
			}
		}
		else {}
	}
}

struct Manifest {
	views   []string [required]
	listeners []string [required]
	root      string   [json: rootView; required]
}

fn handle_manifest() Manifest {
	return Manifest{
		views: view_list.keys()
		listeners: listener_list.keys()
		root: root_view
	}
}

fn handle_view(name string, data []Any, props map[string]Any, context map[string]Any) !Any {
	return (view_list[name])(data, props, context)
}

fn handle_listener(name string, props map[string]Any, event map[string]Any, api map[string]Any) ! {
	match name in listener_list {
		true {
	  	listener := listener_list[name]

			api_instance := Api{
				url: api['url']!.str()
				token: api['token']!.str()
			}

			listener(props, event, api_instance) or { panic(err) }
		}
		else {
			eprintln('Listener $name not defined')
		}
	}
}

fn handle_resource(name string) !Any {
	return resource_list[name]!.str()
}
