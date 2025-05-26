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
	DebugShape = 0
	DebugPrim = 0
	if instance_exists(obj_DebugShape){instance_destroy(obj_DebugShape)}
	if layer_exists("Render"){
		layer_destroy_instances("Render")
	}
	layer_create(0,"Render")
	instance_create_layer(0,0,"Render",par_BlockHunter)
	instance_create_layer(0,0,"Render",par_TextureLoader)
	instance_create_layer(0,0,"Render",par_GScaleLoader,{debug:true})
	instance_create_layer(0,0,"Render",par_ShapeLoader)
	instance_create_layer(0,0,"Render",obj_Camera)
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

if keyboard_check_pressed(ord("Z"))
{
	if DebugShape != 0 {DebugShape-=1}
	else {DebugShape = array_length(par_ShapeLoader.Shapes)-1}
	DebugPrim=0
	CreateShape()
}
if keyboard_check_pressed(ord("X"))
{
	if DebugShape+1 != array_length(par_ShapeLoader.Shapes){DebugShape+=1}
	else {DebugShape = 0}
	DebugPrim=0
	CreateShape()
}

if keyboard_check_pressed(ord("C"))
{
	if DebugPrim != 0 {DebugPrim-=1}
	else {DebugPrim = array_length(array_get(par_ShapeLoader.Shapes,DebugShape))-1}
	CreateShape()
}

if keyboard_check_pressed(ord("V"))
{
	if DebugPrim+1 != array_length(array_get(par_ShapeLoader.Shapes,DebugShape)){DebugPrim+=1}
	else {DebugPrim = 0}
	CreateShape()
}

if keyboard_check_pressed(ord("T"))
{
	FullToggle = !FullToggle
	CreateShape()
}