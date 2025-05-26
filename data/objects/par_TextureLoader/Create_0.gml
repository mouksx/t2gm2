gpu_set_alphatestenable(false)
gpu_set_ztestenable(false)
buffer = buffer_load(string(global.GameSelected)+"/"+string(global.LevelSelected)+".ngn")
buffer_seek(buffer,buffer_seek_start,array_get(par_BlockHunter.BlockOffsets,array_get_index(par_BlockHunter.BlockValues,260)))
TextureSheet=[]
TextureNameList=[]

TextureLoadTimer=get_timer()

Block = buffer_read(buffer,buffer_u32)
BlockLength = buffer_read(buffer, buffer_u32)
TextureAmount = buffer_read(buffer, buffer_u32)

for (var m = 0; m < TextureAmount; m++) {
	TextureByteLength = buffer_read(buffer, buffer_u32)
	TextureNameByteLength = buffer_read(buffer, buffer_u32)
	TextureName = ""
	for (var i = 0; i < TextureNameByteLength; i++) {
		var byte = buffer_read(buffer, buffer_u8);
		TextureName += chr(byte);
	}
	array_push(TextureNameList,TextureName)
	buffer_seek(buffer, buffer_seek_relative, 18)
	TextureX = buffer_read(buffer,buffer_u32)
	TextureY = buffer_read(buffer,buffer_u32)
	buffer_seek(buffer, buffer_seek_relative, 28)
	surf = surface_create(TextureX,TextureY)
	surface_set_target(surf)
	for( var j=0; j < TextureY; j++ ){
	    for( var n = 0; n < TextureX; n++ ){
	        var b = buffer_read(buffer, buffer_u8);
	        var g = buffer_read(buffer, buffer_u8);
	        var r = buffer_read(buffer, buffer_u8);
			dotcolor = make_colour_rgb(r, g, b)
	        draw_set_color(dotcolor)
			if dotcolor == 65280{
				draw_set_alpha(0)
				}
			else{
				draw_set_alpha(255)
			}
	        draw_point(n, j);
	    }
	}
	array_push(TextureSheet,sprite_create_from_surface(surf, 0, 0, TextureX, TextureY, false, false, 0, 0))
	draw_clear_alpha(c_black,0)
	surface_reset_target()
	surface_free(surf)
}
show_debug_message("Time Taken To Load Textures: "+string((get_timer() - TextureLoadTimer)/1000000)+" Seconds")

buffer_delete(buffer)