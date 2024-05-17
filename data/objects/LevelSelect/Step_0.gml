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
	instance_destroy(0,0,0,Camera)
	instance_create_layer(0,0,0,BlockHunter)
	instance_create_layer(0,0,0,NGNTextureLoader)
	instance_create_layer(0,0,0,Camera)
	instance_create_layer(0,0,0,GeometryParser)
}