




/*for (var k=0; k<ds_list_size(GeometryParser.GeometryData);k++){
	var currenttexture=ds_list_find_value(GeometryParser.GeometryData,k)
	tex=sprite_get_texture(ds_list_find_value(NGNTextureLoader.TextureSheet,k),0)
	for (var i=0; i<ds_list_size(currenttexture);i++){
		var currentbuffer=ds_list_find_value(currenttexture,i)
		if currentbuffer[1]==1 or 3{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
		else{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
	}
}*/

for (var k=0; k<ds_list_size(GeometryParser.GeometryData);k++){
	var currenttexture=ds_list_find_value(GeometryParser.GeometryData,k)
	if k!=ds_list_size(NGNTextureLoader.TextureSheet){
		tex=sprite_get_texture(ds_list_find_value(NGNTextureLoader.TextureSheet,k),0)
	}
	else{
		tex=-1
	}
	
	for (var i=0; i<ds_list_size(currenttexture);i++){
		var currentbuffer=ds_list_find_value(currenttexture,i)
		var transform=ds_list_find_value(GScaleParser.GScale,currentbuffer[2])
		var angleX = ds_list_find_value(transform, 3) * pi / 180;
		var angleY = ds_list_find_value(transform, 4) * pi / 180;
		var angleZ = ds_list_find_value(transform, 5) * pi / 180;
		
		matrix_set(matrix_world, matrix_build(-(x+ds_list_find_value(transform,0)), y+ds_list_find_value(transform,2), -(z+ds_list_find_value(transform,1)), angleX, angleY, angleZ, ds_list_find_value(transform,6),ds_list_find_value(transform,7), ds_list_find_value(transform,8)));
		
		if currentbuffer[1]==1||3{
			vertex_submit(currentbuffer[0], pr_trianglelist, tex)
		}
		else{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
	}
}

matrix_set(matrix_world, matrix_build_identity());