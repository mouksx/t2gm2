if keyboard_check_pressed(ord("E"))
{
    global.LevelSelected+=1
}
if keyboard_check_pressed(ord("Q"))
{
    global.LevelSelected-=1
}
if keyboard_check_pressed(ord("3"))
{
    global.GameSelected+=1
}
if keyboard_check_pressed(ord("1"))
{
    global.GameSelected-=1
}
if keyboard_check_pressed(ord("0"))
{
    room_goto_previous()
}
if keyboard_check_pressed(ord("0"))
{
    if instance_exists(obj_Camera){instance_destroy(obj_Camera);show_debug_message("killed cam")}
}
if keyboard_check_pressed(vk_enter)
{
	if instance_exists(obj_DebugShape){instance_destroy(obj_DebugShape)}
	if layer_exists("Render"){
		layer_destroy_instances("Render")
	}
	layer_create(0,"Render")
	instance_create_layer(0,0,"Render",par_BlockHunter)
	instance_create_layer(0,0,"Render",par_TextureLoader)
	instance_create_layer(0,0,"Render",par_GScaleLoader)
	instance_create_layer(0,0,"Render",par_ShapeLoader)
	instance_create_layer(0,0,"Render",obj_Camera)
	ShapeCount=array_length(par_ShapeLoader.Shapes)-1
	CreateShape()
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