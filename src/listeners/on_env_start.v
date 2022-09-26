module listeners

import x.json2 { Any }
import src.data { Api }

pub fn on_env_start(props map[string]Any, event map[string]Any, api Api) {
	eprintln('Listener{name: \'OnEnvStart\', props: $props, event: $event, api: $api}')
	api.create_document<Counter>(data.counter_collection, Counter{
		count: 0
		user: data.global_user
	})
}
