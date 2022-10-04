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
		header: http.new_header_from_map({
			.authorization: 'Bearer $self.token',
			.content_type:  'application/json',
		})
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
	eprintln('CreateDocument: $collection, $document')

	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs'
		method: .post
		header: http.new_header_from_map({
			.authorization: 'Bearer $self.token',
			.content_type:  'application/json',
		})
		data: json.encode(document)
	) or { panic(err) }

	eprintln('CreateDocument<Response>: $response')

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
		header: http.new_header_from_map({
			.authorization: 'Bearer $self.token',
			.content_type:  'application/json',
		})
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
		header: http.new_header_from_map({
			.authorization: 'Bearer $self.token',
			.content_type:  'application/json',
		})
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

pub fn (self Api) execute_query<T>(collection string, query string) ?[]T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/find'
		method: .post
		header: http.new_header_from_map({
			.authorization: 'Bearer $self.token',
			.content_type:  'application/json',
		})
		data: query
	) or { panic(err) }

	return match response.status().is_success() {
		true {
			json.decode([]T, response.body)?
		}
		else {
			panic('Http code: $response.status_code $response.status_msg')
			[]T{}
		}
	}
}
