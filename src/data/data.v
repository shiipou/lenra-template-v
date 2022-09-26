module data

import net.http
import json
import x.json2 { Any }
import src.utils { get_str }

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

pub fn (self Api) from_json(input map[string]Any) Api {
	return Api{
		url: get_str(input, 'url')
		token: get_str(input, 'token')
	}
}

pub fn (self Api) get_document<T>(collection string, id string) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$id'
		method: .get
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	return match response.status().is_success() {
		true { json.raw_decode(response.body)?.as_map() }
		else { panic('Http code: $response.status_code $response.status_msg') }
	}
}

pub fn (self Api) create_document<T>(collection string, document T) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs'
		method: .post
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	return match response.status().is_success() {
		true { json.raw_decode(response.body)? }
		else { panic('Http code: $response.status_code $response.status_msg') }
	}
}

pub fn (self Api) update_document<T>(collection string, document T) ?T {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$document.id'
		method: .put
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	return match response.status().is_success() {
		true { json.raw_decode(response.body)? }
		else { panic('Http code: $response.status_code $response.status_msg') }
	}
}

pub fn (self Api) delete_document<T>(collection string, document T) {
	response := http.fetch(
		url: '$self.url/app/colls/$collection/docs/$document.id'
		method: .delete
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	match response.status().is_success() {
		true { json.raw_decode(response.body)? }
		else { panic('Http code: $response.status_code $response.status_msg') }
	}
}

pub fn (self Api) execute_query<T, Q>(collection string, query Q) []T {
	response := http.fetch(
		url: '$url/app/colls/$collection/docs/find'
		method: .delete
		header: http.new_header(key: .authorization, value: 'Bearer $self.token')
	) or { panic(err) }

	match response.status().is_success() {
		true { json.raw_decode(response.body)? }
		else { panic('Http code: $response.status_code $response.status_msg') }
	}
}

pub interface Document {
	id ?string
}
