module main

import os
import json
import x.json2 { Any }
import src.data { Api }
import src.listeners
import src.widgets

const (
	root_widget = 'root'
	widget_list = {
		'root':    widgets.root
		'home':    widgets.home
		'counter': widgets.counter
		'loading': widgets.loading
	}
	listener_list = {
		'increment':       listeners.increment
		'OnEnvStart':      listeners.on_env_start
		'OnUserFirstJoin': listeners.on_user_first_join
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

fn parse_request(str_input string) ? {
	json_str := json2.fast_raw_decode(str_input) or {
		map[string]Any{}
	}

	request := json_str.as_map()

	// request := json2.fast_raw_decode('{ "widget": "home", "data": [{ "id": "6330881dd1391d00018a730e", "count": 2, "user": "e83d5cee-4d24-420d-8052-b79e55241520" }], "props": { "text": "My personnal counter" }, "context": { "screen_size": {"width": 1503, "height": 885 } } }')?.as_map()
	match true {
		'widget' in request {
			result := handle_widget(request['widget']?.str(), request['data']?.arr(),
				request['props']?.as_map(), request['context']?.as_map()) or {
				panic(error('Error during parsing widget $str_input'))
			}
			$if debug {
				eprintln('Output: $result.prettify_json_str()')
			}
			println(result.json_str())
		}
		'action' in request {
			handle_listener(request['action']?.str(), request['props']?.as_map(), request['event']?.as_map(),
				request['api']?.as_map()) or {
				panic(error('Error during parsing listener $str_input'))
			}
		}
		'resource' in request {
			handle_resource(request['resource']?.str()) or {
				panic(error('Error during parsing resource $str_input'))
			}
		}
		else {}
	}
}

struct Manifest {
	widgets   []string [required]
	listeners []string [required]
	root      string   [json: rootWidget; required]
}

fn handle_manifest() Manifest {
	return Manifest{
		widgets: widget_list.keys()
		listeners: listener_list.keys()
		root: root_widget
	}
}

fn handle_widget(name string, data []Any, props map[string]Any, context map[string]Any) ?Any {
	return widget_list[name](data, props, context)
}

fn handle_listener(name string, props map[string]Any, event map[string]Any, api map[string]Any) ? {
	listener := listener_list[name]
	listener(props, event, Api{
		url: api['url']?.str()
		token: api['token']?.str()
	}) or { panic(err) }
}

fn handle_resource(name string) ?Any {
	return resource_list[name]?.str()
}
