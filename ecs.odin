package asgard

import "base:runtime"
import "core:container/queue"
import ss "sparse_set"

Error :: enum {
	NO_ERROR,
	ENTITY_DOES_NOT_HAVE_THIS_COMPONENT,
	ENTITY_DOES_NOT_MAP_TO_ANY_INDEX,
	ENTITY_ALREADY_HAS_THIS_COMPONENT,
	COMPONENT_NOT_REGISTERED,
	COMPONENT_IS_ALREADY_REGISTERED,
}

Entity :: ss.Entity

EntitySlot :: struct {
	entity:   Entity,
	is_valid: bool,
}

Entities :: struct {
	current_entity_id: uint,
	slots:             [dynamic]EntitySlot,
	available_slots:   queue.Queue(uint),
}

// Holds pointer to Sparse Set and some functionality.
Setptr :: struct {
	ptr:           rawptr,
	remove_entity: proc(data: rawptr, entity: Entity) -> bool,
	size:          proc(data: rawptr) -> int,
	contains:      proc(data: rawptr, entity: Entity) -> bool,
	entities:      proc(data: rawptr) -> [dynamic]Entity,
	deinit:        proc(data: rawptr),
}

World :: struct {
	entities:      Entities,
	//component_map: map[typeid]Component_List,
	component_map: map[typeid]Setptr,
}


init :: proc() -> (w: World) {
	init_entities :: proc(w: ^World) {
		w.entities.slots = make([dynamic]EntitySlot)
		queue.init(&w.entities.available_slots)
	}
	init_entities(&w)

	init_component_map :: proc(w: ^World) {
		w.component_map = make(map[typeid]Setptr)
	}

	init_component_map(&w)

	return w
}

deinit :: proc(w: ^World) {

	deinit_entities :: proc(w: ^World) {
		delete(w.entities.slots)
		w.entities.current_entity_id = 0
		queue.destroy(&w.entities.available_slots)
	}
	deinit_entities(w)

	deinit_component_map :: proc(w: ^World) {
		for key, value in w.component_map {
			value.deinit(value.ptr) // clean up the sparse set
			free(value.ptr)
		}

		//for key, value in w.component_map {
		//	delete(value.entity_indices)
		//}

		delete(w.component_map)
	}
	deinit_component_map(w)
}

@(private)
get_sparse_set :: proc(w: ^World, $T: typeid) -> (^ss.Set(T), bool) {
	if T in w.component_map {
		component_set := cast(^ss.Set(T))w.component_map[T].ptr
		return component_set, true
	}
	return nil, false
}
