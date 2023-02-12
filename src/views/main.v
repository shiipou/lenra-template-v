module views

import x.json2 { Any }

pub fn main(data []Any, props map[string]Any, context map[string]Any) !Any {
	return {
		'type':               Any('flex')
		'direction':          'vertical'
		'scroll':             true
		'spacing':            4
		'crossAxisAlignment': 'center'
		'children':           [
			Any({
				'type': Any('view')
				'name': 'menu'
			}),
			{
				'type': Any('view')
				'name': 'home'
			},
		]
	}
}
