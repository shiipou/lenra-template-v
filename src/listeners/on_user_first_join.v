module listeners

import x.json2 { Any }
import src.data { Api, Counter }

pub fn on_user_first_join(props map[string]Any, event map[string]Any, api Api) ? {
	eprintln('Listener{name: \'OnUserFirstJoin\', props: $props, event: $event, api: $api}')
	api.create_document<Counter>(data.counter_collection, Counter{
		count: 0
		user: data.current_user
	}) or { panic(err) }
}
