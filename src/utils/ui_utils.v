module utils

import x.json2 { Any }

pub fn get_str(self map[string]Any, key string) ?string {
	return (self[key] or { none }).str()
}
pub fn get_int(self map[string]Any, key string) ?string {
	return (self[key] or { none }).str()
}

pub fn get_map(self map[string]Any, key string) ?map[string]Any {
	return (self[key] or {
		none
	}).as_map()
}

pub fn padding_symmetric(vertical int, horizontal int) Any {
	return {
		'top':    Any(vertical)
		'bottom': vertical
		'left':   horizontal
		'right':  horizontal
	}
}
