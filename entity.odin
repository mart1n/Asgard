package asgard

import "core:container/queue"
import ss "sparse_set"


create_entity :: proc(w: ^World) -> Entity {
	using w.entities

	if queue.len(available_slots) <= 0 {
		append_elem(&slots, EntitySlot{Entity(current_entity_id), true})
		current_entity_id += 1
		return Entity(current_entity_id - 1)
	} else {
		index := queue.pop_front(&available_slots)
		slots[index] = EntitySlot{Entity(index), true}
		return Entity(index)
	}

	return Entity(current_entity_id)
}

is_entity_valid :: proc(w: ^World, entity: Entity) -> bool {
	if uint(entity) > len(w.entities.slots) {
		return false
	}
	return w.entities.slots[uint(entity)].is_valid
}

destroy_entity :: proc(w: ^World, entity: Entity) {
	using w.entities

	for T, _ in &w.component_map {
		remove_component_with_typeid(w, entity, T)
	}

	slots[uint(entity)] = {}
	queue.push_back(&available_slots, uint(entity))
}

//TODO: Is the following still true?
//
// This is slow.
// This will be significantly faster when an archetype or sparse set ECS is implemented.
// We now have a Sparse Set!!
get_entities_with_components :: proc(
	w: ^World,
	components: []typeid,
) -> (
	results: [dynamic]Entity,
) {

	results = make([dynamic]Entity)
	if len(components) <= 0 {
		return results
	}

	smallest: typeid
	smallest_size: int
	for c in components {
		sptr, ok := w.component_map[c]
		if !ok {
			return results
		}
		if smallest == nil {
			smallest = c
			smallest_size = sptr.size(sptr.ptr)
			continue
		}

		current_size := sptr.size(sptr.ptr)
		if current_size < smallest_size {
			smallest = c
			smallest_size = current_size
		}
	}

	smallest_sptr, _ := w.component_map[smallest]
	for e in smallest_sptr.entities(smallest_sptr.ptr) {
		has_all_components := true
		for c in components {
			if !has_component_with_typeid(w, e, c) {
				has_all_components = false
				continue
			}
		}

		if has_all_components {
			append_elem(&results, e)
		}
	}
	return results
}
