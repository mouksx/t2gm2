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
if keyboard_check_pressed(vk_enter)
{
	layer_destroy_instances("Render")
	layer_create(0,"Render")
	instance_create_layer(0,0,"Render",par_BlockHunter)
	instance_create_layer(0,0,"Render",par_TextureLoader)
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

if keyboard_check_pressed(ord("A"))
{
	if SheetFlipper != 0{
		SheetFlipper-=1
	}
	else
	SheetFlipper = array_length(par_TextureLoader.TextureSheet)-1
}
if keyboard_check_pressed(ord("D"))
{
	if SheetFlipper+1 != array_length(par_TextureLoader.TextureSheet){
		SheetFlipper+=1
	}
	else
	SheetFlipper = 0
}
if keyboard_check_pressed(ord("X"))
{
    Toggle=!Toggle
}