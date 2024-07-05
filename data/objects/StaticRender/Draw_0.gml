





	var currentshape=ds_list_find_value(GeometryParser.GeometryData,Shape)
	
	for (var i=0; i<ds_list_size(currentshape);i++){
		
		var currentbuffer=ds_list_find_value(currentshape,i)
		tex=-1
		if currentbuffer[2]!=-1{
			tex=sprite_get_texture(ds_list_find_value(NGNTextureLoader.TextureSheet,currentbuffer[2]),0)
		}
		var transform=ds_list_find_value(GScaleParser.GScale,Shape)		
		matrix_set(matrix_world, matrix_build(-(ds_list_find_value(transform,0)), ds_list_find_value(transform,2), -(ds_list_find_value(transform,1)), ds_list_find_value(transform,3),ds_list_find_value(transform,5), ds_list_find_value(transform,4), ds_list_find_value(transform,6), ds_list_find_value(transform,8), ds_list_find_value(transform,7)));
		
		
		if currentbuffer[1]==1 or 3{
			vertex_submit(currentbuffer[0], pr_trianglelist, tex)
		}
		else{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
	}


matrix_set(matrix_world, matrix_build_identity());


/*
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
		//var angleX = ds_list_find_value(transform, 3) * pi / 180;
		//var angleY = ds_list_find_value(transform, 4) * pi / 180;
		//var angleZ = ds_list_find_value(transform, 5) * pi / 180;
		
		//matrix_set(matrix_world, matrix_build(-(x+ds_list_find_value(transform,0)), y+ds_list_find_value(transform,2), -(z+ds_list_find_value(transform,1)), angleX, angleY, angleZ, ds_list_find_value(transform,6),ds_list_find_value(transform,7), ds_list_find_value(transform,8)));
		var tx = ds_list_find_value(transform, 0);
		var ty = ds_list_find_value(transform, 2);
		var tz = -ds_list_find_value(transform, 1);

		var rx = ds_list_find_value(transform, 3)*pi/180;
		var ry = ds_list_find_value(transform, 4)*pi/180;
		var rz = ds_list_find_value(transform, 5)*pi/180;

		var sx = ds_list_find_value(transform, 6);
		var sy = ds_list_find_value(transform, 7);
		var sz = ds_list_find_value(transform, 8);
		
		var cosX = cos(rx), sinX = sin(rx);
		var cosY = cos(ry), sinY = sin(ry);
		var cosZ = cos(rz), sinZ = sin(rz);

		// Rotation matrix around X axis
		var rotX = matrix_build_identity();
		rotX[5] = cosX;  rotX[6] = -sinX;
		rotX[9] = sinX;  rotX[10] = cosX;

		// Rotation matrix around Y axis
		var rotY = matrix_build_identity();
		rotY[0] = cosY;  rotY[2] = sinY;
		rotY[8] = -sinY; rotY[10] = cosY;

		// Rotation matrix around Z axis
		var rotZ = matrix_build_identity();
		rotZ[0] = cosZ;  rotZ[1] = -sinZ;
		rotZ[4] = sinZ;  rotZ[5] = cosZ;

		// Combined rotation matrix
		var rotation_matrix = matrix_multiply(rotZ, matrix_multiply(rotY, rotX));

		// Apply scale to the rotation matrix elements
		rotation_matrix[0] *= sx;
		rotation_matrix[1] *= sy;
		rotation_matrix[2] *= sz;
		rotation_matrix[4] *= sx;
		rotation_matrix[5] *= sy;
		rotation_matrix[6] *= sz;
		rotation_matrix[8] *= sx;
		rotation_matrix[9] *= sy;
		rotation_matrix[10] *= sz;

		// Apply translation
		rotation_matrix[12] = tx;
		rotation_matrix[13] = ty;
		rotation_matrix[14] = tz;
		rotation_matrix[15] = 1;

		// Apply the transformation matrix
		matrix_set(matrix_world, rotation_matrix);
		
		
		
		
		
		if currentbuffer[1]==1||3{
			vertex_submit(currentbuffer[0], pr_trianglelist, tex)
		}
		else{
			vertex_submit(currentbuffer[0], pr_trianglestrip, tex)
		}
	}
}


matrix_set(matrix_world, matrix_build_identity());