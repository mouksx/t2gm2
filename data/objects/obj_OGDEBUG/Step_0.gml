if keyboard_check_pressed(ord("E"))
{
    global.LevelSelected+=1
}
if keyboard_check_pressed(ord("Q"))
{
    global.LevelSelected-=1
}
if keyboard_check_pressed(ord("C"))
{
    global.GameSelected+=1
}
if keyboard_check_pressed(ord("Z"))
{
    global.GameSelected-=1
}
if keyboard_check_pressed(vk_enter)
{
	layer_destroy_instances("Render")
	layer_create(0,"Render")
	instance_create_layer(0,0,"Render",par_BlockHunter)
	instance_create_layer(0,0,"Render",obj_Camera)
}
if keyboard_check_pressed(ord("R")){
	room_restart()
}
if keyboard_check_pressed(ord("V")){
	game_restart()
}

if global.GameSelected == 1{
	Game="Toy Story 2: Buzz Lightyear To The Rescue!"
}
else if global.GameSelected == 2{
	Game="Buzz Lightyear of Star Command"
}
else if global.GameSelected == 3{
	Game="The Weakest Link"
}
else{
	global.GameSelected=1
}