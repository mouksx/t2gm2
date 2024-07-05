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
	layer_destroy_instances("Render")
	instance_create_layer(0,0,"Render",BlockHunter)
	instance_create_layer(0,0,"Render",NGNTextureLoader)
	layer_background_sprite(layer_background_get_id(layer_get_id("Background")),ds_list_find_value(NGNTextureLoader.TextureSheet,0))
	instance_create_layer(0,0,"Render",GScaleParser)
	instance_create_layer(0,0,"Render",GeometryParser)
	instance_create_layer(0,0,"Render",Camera)
	shapecount=Camera.shapecount
}