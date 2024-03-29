module views

import x.json2 { Any }
import src.data

pub fn home(_data []Any, props map[string]Any, context map[string]Any) !Any {
	return {
		'type':               Any('flex')
		'direction':          'vertical'
		'spacing':            16
		'mainAxisAlignment':  'spaceEvenly'
		'crossAxisAlignment': 'center'
		'children':           [
			Any({
				'type':  Any('view')
				'name':  'counter'
				'coll':  data.counter_collection
				'query': {
					'user': Any(data.current_user)
				}
				'props': {
					'text': Any('My personnal counter')
				}
			}),
			{
				'type':  Any('view')
				'name':  'counter'
				'coll':  data.counter_collection
				'query': {
					'user': Any(data.global_user)
				}
				'props': {
					'text': Any('The common counter')
				}
			},
		]
	}
}
