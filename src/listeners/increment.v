module listeners

import x.json2 { Any }
import src.data { Api, SavedCounter }

pub fn increment(props map[string]Any, event map[string]Any, api Api) ! {
	eprintln('Listener{name: \'increment\', props: $props, event: $event, api: $api}')
	counter := api.get_document<SavedCounter>(data.counter_collection, props['id']!.str()) or {
		panic(err)
	}
	api.update_document<SavedCounter>(data.counter_collection, SavedCounter{
		...counter
		count: counter.count + 1
	}) or { panic(err) }
}
