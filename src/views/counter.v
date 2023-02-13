module views

import x.json2 { Any }
// import src.data

pub fn counter(data []Any, props map[string]Any, context map[string]Any) !Any {
	eprintln('data: $data, props: $props, context: $context')
	counter := data[0]!.as_map()

	return {
		'type':               Any('flex')
		'spacing':            16
		'mainAxisAlignment':  'spaceEvenly'
		'crossAxisAlignment': 'center'
		'children':           [
			Any({
				'type':  Any('text')
				'value': '${props['text']!}: ${counter['count']!}'
			}),
			{
				'type':      Any('button')
				'text':      '+'
				'onPressed': {
					'action': Any('increment')
					'props':  {
						'id': counter['_id']!
					}
				}
			},
		]
	}
}
