package asgard

import "core:fmt"
import "core:testing"


@(test)
test_register_component :: proc(t: ^testing.T) {

	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)

	e := register_component(&w, Position)
	testing.expect(t, e == .NO_ERROR, "Register Component returned an Error value")

	//e1 := create_entity(&w)
	//e2 := create_entity(&w)

	//testing.expect(test, int(e1) == 1, "Unexpected entity value")
	//testing.expect(test, int(e2) == 2, "Unexpected entity value")


}

@(test)
test_set_and_get_component :: proc(t: ^testing.T) {
	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)
	e1 := create_entity(&w)

	v1 := Position{100, 100}
	v2 := Position{200, 200}
	p1, _ := add_component(&w, e1, v1)

	c1, err := get_component(&w, e1, Position)
	testing.expect(t, c1^ == v1, "Add & Get values don't match")
	set_component(&w, e1, v2)
	c2, _ := get_component(&w, e1, Position)
	testing.expect(t, c2^ == v2, "Set & Get values don't match")
}

test_has_component :: proc(t: ^testing.T) {
	Position :: struct {
		x: int,
		y: int,
	}

	Health :: distinct int
	Velocity :: distinct int
	NPC :: struct {}

	w: World
	w = init()
	defer deinit(&w)

	e0 := create_entity(&w)
	e1 := create_entity(&w)
	e2 := create_entity(&w)

	p1, _ := add_component(&w, e1, Position{100, 100})
	p2, _ := add_component(&w, e2, Position{200, 200})
	h0, _ := add_component(&w, e0, Health(0))
	h1, _ := add_component(&w, e1, Health(101))
	n1, _ := add_component(&w, e1, NPC{})
	v1, _ := add_component(&w, e1, Velocity(25))

	testing.expect(t, has_component(&w, e1, Health) == true, "Entity missing component")
	testing.expect(t, has_component_with_typeid(&w, e1, NPC) == true, "Entity missing component")
	testing.expect(t, !has_component(&w, e2, Health) == true, "Entity shouldn't have component")
}
