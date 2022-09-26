module listeners

import x.json2 { Any }
import src.data { Api }
import src.utils { get_str, get_map }

pub fn increment(props map[string]Any, event map[string]Any, api Api) {
	eprintln('Listener{name: \'increment\', props: $props, event: $event, api: $api}')
	counter := api.get_document<Counter>(data.counter_collection, get_str(props, 'id')) or { panic(err) }
	api.update_document<Counter>(data.counter_collection, Counter{
		id: counter.id
		count: counter.count
		user: counter.user
	})
}
