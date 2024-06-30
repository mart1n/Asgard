package asgard

import ss "sparse_set"

make_setptr :: proc($T: typeid, p: rawptr) -> Setptr {

	// Remove Entity from Sparse Set
	remove :: proc(data: rawptr, entity: Entity) -> bool {
		//data := data
		s := cast(^T)data
		return ss.remove(s, ss.Entity(entity))
	}

	size :: proc(data: rawptr) -> int {
		s := cast(^T)data
		return len(s.entities)
	}

	contains :: proc(data: rawptr, entity: Entity) -> bool {
		s := cast(^T)data
		return ss.contains(s, ss.Entity(entity))
	}

	entities :: proc(data: rawptr) -> [dynamic]Entity {
		s := cast(^T)data
		return s.entities
	}

	return(
		Setptr {
			ptr = p,
			remove_entity = remove,
			size = size,
			contains = contains,
			entities = entities,
		} \
	)
}
