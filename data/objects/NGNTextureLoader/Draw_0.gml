try{
	draw_sprite_ext(ds_list_find_value(TextureSheet,SheetFlipper),0,0,sprite_get_height(ds_list_find_value(TextureSheet,SheetFlipper))+50,1,-1,0,c_white,1)
	draw_set_colour(c_white);
	draw_text(0,25,"Previewing Texture: " + string(ds_list_find_value(TextureNameList,SheetFlipper)))
}
catch( _exception){
	show_debug_message("ye nah")
}