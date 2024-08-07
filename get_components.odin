package asgard

/*
NOTE:
I know, code duplication...

There is no way to take in an array of types, and it will not be added to the language.
The only reasonable solution is this...
*/

get_components_2 :: proc(w: ^World, entity: Entity, $A, $B: typeid) -> (^A, ^B, [2]Error) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	return a, b, {}
}

get_components_3 :: proc(w: ^World, entity: Entity, $A, $B, $C: typeid) -> (^A, ^B, ^C, [3]Error) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	return a, b, c, {}
}

get_components_4 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C, $D: typeid,
) -> (
	^A,
	^B,
	^C,
	^D,
	[4]Error,
) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	d, err4 := get_component(w, entity, D)
	return a, b, c, d, {}
}

get_components_5 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C, $D, $E: typeid,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	[5]Error,
) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	d, err4 := get_component(w, entity, D)
	e, err5 := get_component(w, entity, E)
	return a, b, c, d, e, {}
}

get_components_6 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C, $D, $E, $F: typeid,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	^F,
	[6]Error,
) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	d, err4 := get_component(w, entity, D)
	e, err5 := get_component(w, entity, E)
	f, err6 := get_component(w, entity, F)
	return a, b, c, d, e, f, {}
}

get_components_7 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C, $D, $E, $F, $G: typeid,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	^F,
	^G,
	[7]Error,
) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	d, err4 := get_component(w, entity, D)
	e, err5 := get_component(w, entity, E)
	f, err6 := get_component(w, entity, F)
	g, err7 := get_component(w, entity, G)
	return a, b, c, d, e, f, g, {}
}

get_components_8 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C, $D, $E, $F, $G, $H: typeid,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	^F,
	^G,
	^H,
	[8]Error,
) {
	a, err1 := get_component(w, entity, A)
	b, err2 := get_component(w, entity, B)
	c, err3 := get_component(w, entity, C)
	d, err4 := get_component(w, entity, D)
	e, err5 := get_component(w, entity, E)
	f, err6 := get_component(w, entity, F)
	g, err7 := get_component(w, entity, G)
	h, err8 := get_component(w, entity, H)
	return a, b, c, d, e, f, g, h, {}
}
get_components :: proc {
	get_components_2,
	get_components_3,
	get_components_4,
	get_components_5,
	get_components_6,
	get_components_7,
	get_components_8,
}

get_component_slice_from_entities :: proc(
	w: ^World,
	entities: []Entity,
	$T: typeid,
	allocator := context.allocator,
) -> []^T {
	context.user_ptr = w
	get_t_proc :: proc(h: Entity) -> ^T {
		e, err := get_component(cast(^World)context.user_ptr, h, T) or_else nil
		return e
	}
	return slice.mapper(entities, get_t_proc)
}
