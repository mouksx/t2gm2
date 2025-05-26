gpu_set_alphatestenable(true)
gpu_set_ztestenable(true)
buffer = buffer_load(string(global.GameSelected)+"/"+string(global.LevelSelected)+".ngn")
buffer_seek(buffer, buffer_seek_start, array_get(par_BlockHunter.BlockOffsets,array_get_index(par_BlockHunter.BlockValues,256)));

Shapes = []

ShapeLoadTimer = get_timer()

vertex_format_begin()
vertex_format_add_position_3d()
vertex_format_add_normal()
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end()

buffer_seek(buffer,buffer_seek_relative,8) // Skips block/length
ShapeCount = buffer_read(buffer,buffer_u32)

for(var i=0;ShapeCount>i;i++){
	array_push(Shapes,[]) // Creates array for prims
	var CurrentShape = array_last(Shapes)
	TextureNames=[]
	MaterialIndexes=[]
	VertexData=[]
	
	// GET SHAPE NAME
	buffer_seek(buffer,buffer_seek_relative,8) // ShapeName/Length not used
	NameSize = buffer_read(buffer,buffer_u8)
	Name = ""
	for (var n = 0; n < NameSize; n++){
		var byte = buffer_read(buffer, buffer_u8);
		Name += chr(byte);
	}

	// GET TEXTURE NAMES
	buffer_seek(buffer,buffer_seek_relative,4) // Skips subblock
	TextureBlockLength = buffer_read(buffer,buffer_u32)
	Skip = buffer_tell(buffer)
	TextureCount = buffer_read(buffer,buffer_u16)
	buffer_seek(buffer,buffer_seek_relative,4) // second texture amount(2)/random
	for (var t=0;t<TextureCount;t++){
		TextureName = ""
		TextureNameSize = buffer_read(buffer,buffer_u8)
		for (var n = 0; n < TextureNameSize; n++){
			var byte = buffer_read(buffer, buffer_u8)
			TextureName += chr(byte)
		}
		array_push(TextureNames,TextureName)
	}
	buffer_seek(buffer,buffer_seek_start,TextureBlockLength+Skip)
	
	// GET MATERIAL INDEXES
	buffer_seek(buffer,buffer_seek_relative,8) // Skips subblock/length
	MaterialCount = buffer_read(buffer,buffer_u32)
	for (var m = 0; m < MaterialCount; m++) {
		buffer_seek(buffer,buffer_seek_relative,4) // skip mat id
		MaterialSize = buffer_read(buffer,buffer_u32)
		buffer_seek(buffer,buffer_seek_relative,3) // skip mat RGB
		if MaterialSize == 9{
			buffer_seek(buffer,buffer_seek_relative,4) // when size=9 skip metadata
		}
		TextureIndex = buffer_read(buffer,buffer_u16)
		if TextureIndex != 65535{
			array_push(MaterialIndexes,TextureIndex)
		}
		else {
			array_push(MaterialIndexes,-1)
		}
	}
	
	// GET RAW VERTEX DATA
	buffer_seek(buffer,buffer_seek_relative,16) // skips subblock/length/17/vertexdatalength
	VertexCount = buffer_read(buffer,buffer_u32)
	for (var v = 0; v<VertexCount; v++){
		array_push(VertexData,[]) // for each vertex create new array
		CurrentVertex = array_last(VertexData)
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //x
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //y
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //z
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //nx?
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //ny?
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //nz?
		array_push(CurrentVertex,buffer_read(buffer,buffer_u8)) //a
		array_push(CurrentVertex,buffer_read(buffer,buffer_u8)) //r
		array_push(CurrentVertex,buffer_read(buffer,buffer_u8)) //g
		array_push(CurrentVertex,buffer_read(buffer,buffer_u8)) //b
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //uvx
		array_push(CurrentVertex,buffer_read(buffer,buffer_f32)) //uvy
	}
	
	// GET PRIMITIVE DATA
	buffer_seek(buffer,buffer_seek_relative,8) // Skips subblock/length
	PrimitiveCount = buffer_read(buffer,buffer_u32)
	for (p = 0; p<PrimitiveCount; p++){
		PrimitiveType = buffer_read(buffer,buffer_u32)
		TextureIndex = buffer_read(buffer,buffer_u16)
		if array_get(MaterialIndexes,TextureIndex) != -1{
			Texture = array_get_index(par_TextureLoader.TextureNameList,array_get(TextureNames,array_get(MaterialIndexes,TextureIndex)))
		}
		else{
			Texture = -1	
		}
		VertexCount = buffer_read(buffer,buffer_u16)
		SortedVertexData = []
		
		
		if PrimitiveType == 4{
			for (var v=0;v<VertexCount/4;v++){
				v1 = array_get(VertexData,buffer_read(buffer,buffer_u16))
				v2 = array_get(VertexData,buffer_read(buffer,buffer_u16))
				v3 = array_get(VertexData,buffer_read(buffer,buffer_u16))
				v4 = array_get(VertexData,buffer_read(buffer,buffer_u16))
				// Triangle 1: v1, v2, v3
				for (var t = 0; t < array_length(v1); t++) array_push(SortedVertexData, v1[t]);
				for (var t = 0; t < array_length(v2); t++) array_push(SortedVertexData, v2[t]);
				for (var t = 0; t < array_length(v3); t++) array_push(SortedVertexData, v3[t]);
				// Triangle 2: v3, v4, v1
				for (var t = 0; t < array_length(v3); t++) array_push(SortedVertexData, v3[t]);
				for (var t = 0; t < array_length(v4); t++) array_push(SortedVertexData, v4[t]);
				for (var t = 0; t < array_length(v1); t++) array_push(SortedVertexData, v1[t]);
			}
		}
		else{
			for (var c=0;c<VertexCount;c++){
				Vertex = array_get(VertexData,buffer_read(buffer,buffer_u16))
				for (var v=0;v<array_length(Vertex);v++){
					array_push(SortedVertexData,array_get(Vertex,v))
				}
			}
		}
		if PrimitiveType != 5 && PrimitiveType != 6{
			array_push(CurrentShape,newvbuffer(SortedVertexData,PrimitiveType,Texture,i))
		}
	}
	buffer_seek(buffer,buffer_seek_relative,8) // skip padding
}

buffer_delete(buffer)
show_debug_message("Time Taken To Parse Shapes: " + string((get_timer() - ShapeLoadTimer)/1000000)+" Seconds")