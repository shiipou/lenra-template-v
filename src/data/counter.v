module data

pub struct Counter {
pub:
	id    ?string [json: _id]
	count u32
	user  string
}
