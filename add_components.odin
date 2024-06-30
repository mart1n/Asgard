package asgard

/*
NOTE:
I know, code duplication...

There is no way to take in an array of types, and it will not be added to the language.
The only reasonable solution is this...
*/

add_components_2 :: proc(w: ^World, entity: Entity, a: $A, b: $B) -> (^A, ^B, [2]Error) {
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	return _a, _b, {}
}

add_components_3 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
) -> (
	^A,
	^B,
	^C,
	[3]Error,
) {
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	return _a, _b, _c, {}
}

add_components_4 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
) -> (
	^A,
	^B,
	^C,
	^D,
	[4]Error,
) {
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	_d, err4 := add_component(w, entity, d)
	return _a, _b, _c, _d, {}
}

add_components_5 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	[5]Error,
) {
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	_d, err4 := add_component(w, entity, d)
	_e, err5 := add_component(w, entity, e)
	return _a, _b, _c, _d, _e, {}
}

add_components_6 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
) -> (
	^A,
	^B,
	^C,
	^D,
	^E,
	^F,
	[6]Error,
) {
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	_d, err4 := add_component(w, entity, d)
	_e, err5 := add_component(w, entity, e)
	_f, err6 := add_component(w, entity, f)
	return _a, _b, _c, _d, _e, _f, {}
}

add_components_7 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
	g: $G,
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
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	_d, err4 := add_component(w, entity, d)
	_e, err5 := add_component(w, entity, e)
	_f, err6 := add_component(w, entity, f)
	_g, err7 := add_component(w, entity, g)
	return _a, _b, _c, _d, _e, _f, _g, {}
}

add_components_8 :: proc(
	w: ^World,
	entity: Entity,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
	g: $G,
	h: $H,
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
	_a, err1 := add_component(w, entity, a)
	_b, err2 := add_component(w, entity, b)
	_c, err3 := add_component(w, entity, c)
	_d, err4 := add_component(w, entity, d)
	_e, err5 := add_component(w, entity, e)
	_f, err6 := add_component(w, entity, f)
	_g, err7 := add_component(w, entity, g)
	_h, err8 := add_component(w, entity, h)
	return _a, _b, _c, _d, _e, _f, _g, _h, {}
}

add_components :: proc {
	add_components_2,
	add_components_3,
	add_components_4,
	add_components_5,
	add_components_6,
	add_components_7,
	add_components_8,
}
