if Level==true{
	/*for (var l=0;l<array_length(par_ShapeLoader.Shapes)-1;l++){
		for (var p=0;p<array_length(par_ShapeLoader.Shapes[l]);p++){
			var Prim = par_ShapeLoader.Shapes[l][p]
			Texture = -1
			if Prim[2] != -1{
				Texture = sprite_get_texture(par_TextureLoader.TextureSheet[Prim[2]],0)
			}
			vertex_submit(Prim[0], pr_trianglelist, Texture)
			matrix_set(matrix_world, matrix_build_identity());	
		}
	}*/
	for (var i = 0; i < array_length(opaque_prims); i++) {
    var Prim = opaque_prims[i];
    var Texture = -1;
    if (Prim[2] != -1) {
        Texture = sprite_get_texture(par_TextureLoader.TextureSheet[Prim[2]], 0);
    }
    vertex_submit(Prim[0], pr_trianglelist, Texture);
    matrix_set(matrix_world, matrix_build_identity());
	}
	for (var i = 0; i < array_length(translucent_prims); i++) {
    var Prim = translucent_prims[i];
    var Texture = -1;
    if (Prim[2] != -1) {
        Texture = sprite_get_texture(par_TextureLoader.TextureSheet[Prim[2]], 0);
    }
    vertex_submit(Prim[0], pr_trianglelist, Texture);
    matrix_set(matrix_world, matrix_build_identity());
	}
	
}else{
	if Full == false{
		var Prim = par_ShapeLoader.Shapes[CurrentShape][CurrentPrim]
		if Prim[2] != -1{
			Texture = sprite_get_texture(par_TextureLoader.TextureSheet[Prim[2]],0)
		}
		vertex_submit(Prim[0], pr_trianglelist, Texture)
		matrix_set(matrix_world, matrix_build_identity());
	}
	else{
		for (var p=0;p<array_length(par_ShapeLoader.Shapes[CurrentShape]);p++){
			var Prim = par_ShapeLoader.Shapes[CurrentShape][p]
			Texture = -1
			if Prim[2] != -1{
				Texture = sprite_get_texture(par_TextureLoader.TextureSheet[Prim[2]],0)
			}
			vertex_submit(Prim[0], pr_trianglelist, Texture)
			matrix_set(matrix_world, matrix_build_identity());	
		}
	}	
}