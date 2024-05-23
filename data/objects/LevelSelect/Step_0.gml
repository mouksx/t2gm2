if keyboard_check_pressed(ord("E"))
{
    global.LevelSelected+=1
}
if keyboard_check_pressed(ord("Q"))
{
    global.LevelSelected-=1
}
if keyboard_check_pressed(vk_enter)
{
    instance_destroy(NGNTextureLoader)
	instance_destroy(BlockHunter)
	instance_destroy(GeometryParser)
	instance_destroy(Camera)
	instance_destroy(GameObject)
	instance_destroy(GScaleParser)
	instance_create_layer(0,0,"instances",BlockHunter)
	instance_create_layer(0,0,"instances",NGNTextureLoader)
	instance_create_layer(0,0,"instances",Camera)
	instance_create_layer(0,0,"instances",GScaleParser)
	instance_create_layer(0,0,"instances",GeometryParser)
}