if Toggle==true{
	try{
		draw_sprite_ext(array_get(par_TextureLoader.TextureSheet,SheetFlipper),0,0,sprite_get_height(array_get(par_TextureLoader.TextureSheet,SheetFlipper))+110,1.25,-1,0,c_white,1)
		draw_set_colour(c_white);
		draw_text(0,60,"Previewing Texture (A/D): " + string(array_get(par_TextureLoader.TextureNameList,SheetFlipper)))
		draw_text(0,80,"Sprite Size: x" + string(sprite_get_height(array_get(par_TextureLoader.TextureSheet,SheetFlipper))) + " y" + string(sprite_get_width(array_get(par_TextureLoader.TextureSheet,SheetFlipper))) )
	}
	catch( _exception){
		//show_debug_message("ye nah")
	}
}