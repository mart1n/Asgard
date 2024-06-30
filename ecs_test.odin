package asgard

import "core:fmt"
import "core:testing"

@(test)
test_init_deinit :: proc(t: ^testing.T) {
	w: World
	w = init()
	deinit(&w)
}
