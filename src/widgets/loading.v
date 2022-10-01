module widgets

import x.json2 { Any }

pub fn loading(_data []Any, props map[string]Any, context map[string]Any) ?Any {
	return {
		'type':  Any('text')
		'value': 'Loading...'
	}
}
