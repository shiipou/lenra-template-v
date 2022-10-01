module data

import net.http
import json

pub const (
	counter_collection = 'counter'
	global_user        = 'global'
	current_user       = '@me'
)

pub struct Api {
pub:
	url   string
	token string
}

pub fn (self Api) get_document<T>(collection string, id string) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$id'
		method: .get
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	return match response.status().is_success() {
		true {
			json.decode(T, response.body)?
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			T{}
		}
	}
}

pub fn (self Api) create_document<T>(collection string, document T) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs'
		method: .post
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
		data: json.encode(document)
	) or { panic(err) }

	return match response.status().is_success() {
		true {
			json.decode(T, response.body)?
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			T{}
		}
	}
}

pub fn (self Api) update_document<T>(collection string, document T) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$document.id'
		method: .put
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
		data: json.encode(document)
	) or { panic(err) }

	return match response.status().is_success() {
		true {
			json.decode(T, response.body)?
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			T{}
		}
	}
}

pub fn (self Api) delete_document<T>(collection string, document T) {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$document.id'
		method: .delete
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	match response.status().is_success() {
		true {
			eprintln(response.body)
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			T{}
		}
	}
}

pub fn (self Api) execute_query<T, Q>(collection string, query map[string]Any) []T {
	response := http.fetch(
		url: '$url/app/colls/$collection/docs/find'
		method: .delete
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
		data: json2.encode(query)
	) or { panic(err) }

	match response.status().is_success() {
		true {
			json.decode(T, response.body)?
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			T{}
		}
	}
}

pub interface Document {
	id ?string
}

pub fn (self Document) test() ? {
	eprintln('test')
}
