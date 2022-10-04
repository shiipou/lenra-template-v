module widgets

import x.json2 { Any }
import src.utils { padding_symmetric }

pub fn menu(_data []Any, props map[string]Any, context map[string]Any) ?Any {
	return {
		'type':       Any('container')
		'decoration': {
			'color':     Any(0xFFFFFFFF)
			'boxShadow': {
				'blurRadius': Any(8)
				'color':      0x1A000000
				'offset':     {
					'dx': Any(0)
					'dy': 1
				}
			}
		}
		'padding':    padding_symmetric(2, 4)
		'child':      {
			'type':               Any('flex')
			'fillParent':         true
			'mainAxisAlignment':  'spaceBetween'
			'crossAxisAlignment': 'center'
			'padding':            {
				'right': Any(4)
			}
			'children':           [
				Any({
					'type':        Any('container')
					'constraints': {
						'minWidth':  Any(32)
						'minHeight': 32
						'maxWidth':  32
						'maxHeight': 32
					}
					'child':       {
						'type': Any('image')
						'src':  'logo.png'
					}
				}),
				{
					'type':  Any('flexible')
					'child': {
						'type':  Any('container')
						'child': {
							'type':      Any('text')
							'value':     'Hello World'
							'textAlign': 'center'
							'style':     {
								'fontWeight': Any('bold')
								'fontSize':   24
							}
						}
					}
				},
			]
		}
	}
}
