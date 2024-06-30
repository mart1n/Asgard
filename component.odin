package asgard

import "core:container/queue"
import "core:runtime"
import "core:slice"
import ss "sparse_set"

@(private)
register_component :: proc(w: ^World, $T: typeid) -> Error {
	is_type_a_key := T in w.component_map
	if is_type_a_key {
		return .COMPONENT_IS_ALREADY_REGISTERED
	}
	component_set := new(ss.Set(T))
	//component_set = ss.create(T)
	ss.init(component_set)
	sptr := make_setptr(ss.Set(T), rawptr(component_set))
	w.component_map[T] = sptr
	return .NO_ERROR
}

add_component :: proc(w: ^World, entity: Entity, component: $T) -> (^T, Error) {
	register_component(w, T)

	if has_component(w, entity, T) {
		return nil, .ENTITY_ALREADY_HAS_THIS_COMPONENT
	}
	// We're not checking the return bool, because we just registered a few
	// lines before this.
	component_set, ok := get_sparse_set(w, T)
	if !ss.insert(component_set, entity, component) {
		return nil, .ENTITY_ALREADY_HAS_THIS_COMPONENT
	}

	v, _ := ss.get(component_set, entity)
	return v, .NO_ERROR
}

has_component :: proc(w: ^World, entity: Entity, $T: typeid) -> bool {
	component_set := get_sparse_set(w, T) or_return
	return ss.contains(component_set, entity)
}

has_component_with_typeid :: proc(w: ^World, entity: Entity, T: typeid) -> bool {
	sptr := w.component_map[T] or_return
	return sptr.contains(sptr.ptr, entity)
}

@(private)
remove_component_with_typeid :: proc(w: ^World, entity: Entity, T: typeid) -> Error {
	if sptr, ok := w.component_map[T]; ok {
		if !sptr.remove_entity(sptr.ptr, entity) {
			return .ENTITY_DOES_NOT_HAVE_THIS_COMPONENT
		}
		return .NO_ERROR
	}

	return .COMPONENT_NOT_REGISTERED
}

remove_component :: proc(w: ^World, entity: Entity, $T: typeid) -> Error {
	if component_set, ok := get_sparse_set(w, T); ok {
		if !ss.remove(component_set, entity) {
			return .ENTITY_DOES_NOT_HAVE_THIS_COMPONENT
		}
		return .NO_ERROR
	}
	return nil, .COMPONENT_NOT_REGISTERED
}

get_component :: proc(w: ^World, entity: Entity, $T: typeid) -> (component: ^T, error: Error) {
	if component_set, ok := get_sparse_set(w, T); ok {
		if component, ok = ss.get(component_set, entity); ok {
			error = .NO_ERROR
			return
		}
		return nil, .ENTITY_DOES_NOT_HAVE_THIS_COMPONENT
	}
	return nil, .COMPONENT_NOT_REGISTERED
}

get_component_list :: proc(w: ^World, $T: typeid) -> ([]T, Error) {
	if component_set, ok := get_sparse_set(w, T); ok {
		return ss.iterate(component_set), .NO_ERROR
	}
	return nil, .COMPONENT_NOT_REGISTERED
}

set_component :: proc(w: ^World, entity: Entity, component: $T) -> Error {
	if component_set, ok := get_sparse_set(w, T); ok {
		ss.set(component_set, entity, component)
		return .NO_ERROR
	}
	return .COMPONENT_NOT_REGISTERED
}
