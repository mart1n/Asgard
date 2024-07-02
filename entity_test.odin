package asgard

import "core:fmt"
import "core:testing"


@(test)
test_create_entity :: proc(t: ^testing.T) {

	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)

	e0 := create_entity(&w)
	e1 := create_entity(&w)

	fmt.printf("Entity 0: %v\n", e0)
	fmt.printf("Entity 1: %v\n", e1)
	testing.expect(t, int(e0) == 0, "Unexpected entity value")
	testing.expect(t, int(e1) == 1, "Unexpected entity value")
}

@(test)
test_entity_is_valid :: proc(t: ^testing.T) {

	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)

	e0 := create_entity(&w)
	fmt.printf("Slots: %v\n", w.entities.slots)
	testing.expect(t, is_entity_valid(&w, e0) == true, "Unexpected entity is not valid")
}

@(test)
test_destroy_entity :: proc(t: ^testing.T) {

	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)

	e0 := create_entity(&w)
	e1 := create_entity(&w)
	e2 := create_entity(&w)
	fmt.printf("Slots: %v\n", w.entities.slots)
	testing.expect(t, is_entity_valid(&w, e1) == true, "Unexpected entity is not valid")

	destroy_entity(&w, e1)
	testing.expect(t, is_entity_valid(&w, e1) == false, "Unexpected entity is not valid")
	fmt.printf("Slots: %v\n", w.entities.slots)

	// Verify it will fill the gap in slots left by destroying e1
	ex := create_entity(&w)
	testing.expect(t, w.entities.slots[1].entity == ex, "New entity didn't fill slot")
	testing.expect(t, e1 == ex, "New entity didn't fill slot")
	fmt.printf("Slots: %v\n", w.entities.slots)
}

@(test)
test_destroy_entity_with_components :: proc(t: ^testing.T) {

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

	testing.expect(t, is_entity_valid(&w, e1) == true, "Unexpected entity is not valid")

	destroy_entity(&w, e1)
	testing.expect(t, is_entity_valid(&w, e1) == false, "Unexpected entity is not valid")
	fmt.printf("Slots: %v\n", w.entities.slots)


	testing.expect(
		t,
		has_component(&w, e1, Position) == false,
		"After destroy entity has component",
	)
	testing.expect(t, has_component(&w, e1, Health) == false, "After destroy entity has component")
	testing.expect(t, has_component(&w, e1, NPC) == false, "After destroy entity has component")
	testing.expect(
		t,
		has_component(&w, e1, Velocity) == false,
		"After destroy entity has component",
	)

	// Verify it will fill the gap in slots left by destroying e1
	ex := create_entity(&w)
	testing.expect(t, w.entities.slots[1].entity == ex, "New entity didn't fill slot")
	testing.expect(t, e1 == ex, "New entity didn't fill slot")
	fmt.printf("Slots: %v\n", w.entities.slots)
}

@(test)
test_get_sparse_set :: proc(t: ^testing.T) {

	Position :: struct {
		x: int,
		y: int,
	}

	w: World
	w = init()
	defer deinit(&w)

	e0 := create_entity(&w)
	p0, _ := add_component(&w, e0, Position{100, 100})
}

@(test)
test_get_entities_with_components :: proc(t: ^testing.T) {

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
	e3 := create_entity(&w)
	e4 := create_entity(&w)
	e5 := create_entity(&w)

	p1, ok1 := add_component(&w, e1, Position{100, 100})
	p2, ok2 := add_component(&w, e2, Position{200, 200})
	p3, ok3 := add_component(&w, e3, Position{300, 300})
	p4, ok4 := add_component(&w, e4, Position{400, 400})
	fmt.println("Add compontent error 1: ", ok1)
	//fmt.println("Add compontent error 2: ", ok2)


	h0, _ := add_component(&w, e0, Health(0))
	h1, _ := add_component(&w, e1, Health(101))
	h3, _ := add_component(&w, e3, Health(103))

	n1, _ := add_component(&w, e1, NPC{})
	n4, _ := add_component(&w, e4, NPC{})
	n5, _ := add_component(&w, e5, NPC{})

	v1, _ := add_component(&w, e1, Velocity(25))
	v5, _ := add_component(&w, e5, Velocity(26))
	v4, _ := add_component(&w, e4, Velocity(27))
	v3, _ := add_component(&w, e3, Velocity(28))

	el := get_entities_with_components(&w, []typeid{Position, Health, Velocity})
	defer delete(el)
	fmt.printf("Entities: %v\n", el)
	testing.expect(t, len(el) == 2, "Unexpected number of enittes returned")
}
