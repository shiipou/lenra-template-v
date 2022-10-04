module data

pub struct Counter {
pub:
	count u32
	user  string
}

pub struct SavedCounter {
pub:
	id    string [json: _id]
	count u32
	user  string
}
