module main

import os
import json
import x.json2 { Any }
import src.data { Api }
import src.listeners
import src.views

const (
	root_view = 'main'
	view_list = {
		'main':    views.main
		'menu':    views.menu
		'home':    views.home
		'counter': views.counter
		'loading': views.loading
	}
	listener_list = {
		'increment':       listeners.increment
		'onSessionStart':      listeners.on_session_start
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
			json_manifest_value := json.encode(handle_manifest())
			manifest := '{"manifest": $json_manifest_value}'
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
	eprintln('parse_request: $str_input')
	json_str := json2.fast_raw_decode(str_input) or {
		map[string]Any{}
	}

	request := json_str.as_map()
	eprintln('request: $request')

	match true {
		'view' in request {
			view := request['view'] or { panic(error('View not defined')) }
			eprintln('view: ${view.str()}')
			data := request['data'] or { panic(error('Data not defined')) }
			eprintln('data: ${data.arr()}')
			props := request['props'] or { panic(error('Props not defined')) }
			eprintln('props: ${props.as_map()}')
			context := request['context'] or { panic(error('Context not defined')) }
			eprintln('context: ${context.as_map()}')
			
			result := handle_view(view.str(), data.arr(),
				props.as_map(), context.as_map()) or {
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
	view := view_list[name]
	return view(data, props, context)
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
