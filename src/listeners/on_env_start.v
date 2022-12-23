module listeners

import x.json2 { Any }
import src.data { Api, Counter, SavedCounter }

pub fn on_env_start(props map[string]Any, event map[string]Any, api Api) ! {
	eprintln('Listener{name: \'OnEnvStart\', props: $props, event: $event, api: $api}')
	counters := api.execute_query<SavedCounter>(data.counter_collection, '{
		"user": "$data.global_user"
	}') or {
		panic(err)
	}

	if counters.len == 0 {
		api.create_document<Counter>(data.counter_collection, Counter{
			count: 0
			user: data.global_user
		}) or { panic(err) }
	}
}
