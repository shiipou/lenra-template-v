module widgets

import x.json2 { Any }

pub fn root(data map[string]Any, props map[string]Any, context map[string]Any) Any {
	return {
		'type':               Any('flex')
		'direction':          'vertical'
		'scroll':             true
		'spacing':            4
		'crossAxisAlignment': 'center'
		'children':           [
			Any({
				'type': Any('widget')
				'name': 'menu'
			}),
			{
				'type': Any('widget')
				'name': 'home'
			},
		]
	}
}
