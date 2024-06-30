package asgard

/*
NOTE:
I know, code duplication...

There is no way to take in an array of types, and it will not be added to the language.
The only reasonable solution is this...
*/

remove_components_2 :: proc(w: ^World, entity: Entity, $A, $B: typeid) -> (^A, ^B, [2]Error) {
	a, err1 := remove_component(w, entity, A)
	b, err2 := remove_component(w, entity, B)
	return a, b, {}
}

remove_components_3 :: proc(
	w: ^World,
	entity: Entity,
	$A, $B, $C: typeid,
) -> (
	^A,
	^B,
	^C,
	[3]Error,
) {
	a, err1 := remove_component(w, entity, A)
	b, err2 := remove_component(w, entity, B)
	c, err3 := remove_component(w, entity, C)
	return a, b, c, {}
}

remove_components_4 :: proc(
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
	a, err1 := remove_component(w, entity, A)
	b, err2 := remove_component(w, entity, B)
	c, err3 := remove_component(w, entity, C)
	d, err4 := remove_component(w, entity, D)
	return a, b, c, d, {}
}

remove_components_5 :: proc(
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
	a, err1 := remove_component(w, entity, A)
	b, err2 := remove_component(w, entity, B)
	c, err3 := remove_component(w, entity, C)
	d, err4 := remove_component(w, entity, D)
	e, err5 := remove_component(w, entity, E)
	return a, b, c, d, e, {}
}

remove_components :: proc {
	remove_components_2,
	remove_components_3,
	remove_components_4,
	remove_components_5,
}
