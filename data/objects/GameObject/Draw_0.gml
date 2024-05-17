
matrix_set(matrix_world, matrix_build(x, y, 64, 0, 0, 0, 1, 1, 1));

for (var k=0; k<ds_list_size(GeometryParser.GeometryData);k++){
	var currenttexture=ds_list_find_value(GeometryParser.GeometryData,k)
	tex=sprite_get_texture(ds_list_find_value(NGNTextureLoader.TextureSheet,k),0)
	for (var i=0; i<ds_list_size(currenttexture);i++){
		var currentbuffer=ds_list_find_value(currenttexture,i)
		if currentbuffer[1]==1 or 3{
			vertex_submit(currentbuffer[0], pr_trianglelist, tex)
		}
		else{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
	}
}

matrix_set(matrix_world, matrix_build_identity());