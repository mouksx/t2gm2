/// @param VertexData
/// @param PrimativeType
/// @param Texture
/// @param ShapeNumber



function newvbuffer(argument0,argument1,argument2,argument3){
	var vbuffer = vertex_create_buffer()
	var VertexData = argument0
	var PrimitiveType = argument1
	var TextureIndex = argument2
	
	var offset, colour, alpha;
	var trans = false
	var VertexCount = array_length(VertexData) div 12;
	
	GScale = par_GScaleLoader.GScale[argument3]
	//var to_rad = 2 * pi / 65536;
    var pitch_rad = GScale[3] /2048*pi;
    var yaw_rad    = GScale[5] /2048*pi;
    var roll_rad = GScale[4] /2048*pi;
	
	//var sinx = sin(rx), cosx = cos(rx);
    //var siny = sin(ry), cosy = cos(ry);
    //var sinz = sin(rz), cosz = cos(rz);
	
	format = par_ShapeLoader.format
	
	vertex_begin(vbuffer,format)
	for (var i = 0; i < VertexCount; i++){
		offset = i*12
		
		var x0 = -VertexData[offset];
	    var y0 = VertexData[offset + 2];
	    var z0 = -VertexData[offset + 1];

	    // Roll (Z)
	    var x1 = x0 * cos(roll_rad) - y0 * sin(roll_rad);
	    var y1 = x0 * sin(roll_rad) + y0 * cos(roll_rad);
	    var z1 = z0;

	    // Pitch (X)
	    var x2 = x1;
	    var y2 = y1 * cos(pitch_rad) - z1 * sin(pitch_rad);
	    var z2 = y1 * sin(pitch_rad) + z1 * cos(pitch_rad);

	    // Yaw (Y)
	    var x3 = x2 * cos(yaw_rad) + z2 * sin(yaw_rad);
	    var y3 = y2;
	    var z3 = -x2 * sin(yaw_rad) + z2 * cos(yaw_rad);
		
		x3 = x3*GScale[6]+-GScale[0]
		y3 = y3*GScale[8]+GScale[2]
		z3 = z3*GScale[7]+-GScale[1]
		
		var nx = VertexData[offset + 3]
		var ny = VertexData[offset + 4]
		var nz = VertexData[offset + 5]
		
		alpha = VertexData[offset + 6]
		
		colour = make_color_rgb(VertexData[offset + 7],VertexData[offset + 8],VertexData[offset + 9])
		
		var u = VertexData[offset + 10]
		var v = 1 - VertexData[offset + 11]
		
		vertex_position_3d(vbuffer, x3, y3, z3);
		vertex_normal(vbuffer, nx, ny, nz);
		vertex_color(vbuffer, colour, alpha / 255);
		vertex_texcoord(vbuffer, u, v);
		
		if (alpha != 255) trans = true;
	}
	vertex_end(vbuffer)
	return [vbuffer, PrimitiveType, TextureIndex, trans]
}