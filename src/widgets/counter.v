module widgets

import x.json2 { Any }

pub fn counter(data map[string]Any, props map[string]Any, context map[string]Any) Any {
	return {
		'type':               Any('flex')
		'spacing':            2
		'mainAxisAlignment':  'spaceEvenly'
		'crossAxisAlignment': 'center'
		'children':           [
			Any({
				'type':  Any('text')
				'value': (data['text'] or { '' }).str() + ': ' + (data['count'] or { '' }).str()
			}),
			{
				'type':      Any('button')
				'text':      '+'
				'onPressed': {
					'action': Any('increment')
					'props':  {
						'id': data['id'] or { '' }
					}
				}
			},
		]
	}
}
