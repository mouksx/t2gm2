direction -= (display_mouse_get_x() - display_get_width() / 2) / 10;
pitch = clamp(pitch - (display_mouse_get_y() - display_get_height() / 2) / 10, -80, 80);

display_mouse_set(display_get_width() / 2, display_get_height() / 2);

if (keyboard_check(vk_escape)){
    game_end();
}

if (keyboard_check(ord("A"))){
	x -= dsin(direction) * 35;
	y -= dcos(direction) * 35;
}

if (keyboard_check(ord("1"))){
	z+=35;
}

if (keyboard_check(ord("3"))){
	z-=35;
}

if (keyboard_check(ord("S"))){
	x -= dcos(direction) * 35;
	y += dsin(direction) * 35;
}

if (keyboard_check(ord("D"))){
	x += dsin(direction) * 35;
	y += dcos(direction) * 35;
}

if (keyboard_check(ord("W"))){
	x += dcos(direction) * 100;
	y -= dsin(direction) * 100;
}