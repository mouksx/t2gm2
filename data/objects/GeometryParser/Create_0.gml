buffer = buffer_load(string(global.LevelSelected)+".ngn")
buffer_seek(buffer, buffer_seek_start, ds_list_find_value(BlockHunter.BlockOffsets,ds_list_find_index(BlockHunter.BlockValues,256)));

GeometryData=ds_list_create()

Timer=get_timer()

Block = buffer_read(buffer,buffer_u32)
BlockLength = buffer_read(buffer,buffer_u32)
ShapeCount = buffer_read(buffer,buffer_u32)






for (i=0; ShapeCount > i; i++;){ //For Each Shape
	ds_list_add(GeometryData,ds_list_create())
	CurrentShape=ds_list_find_value(GeometryData,i)
	
	TempTexData=ds_list_create()
	TempMatData=ds_list_create()
	TempVertData=ds_list_create()
	TempPrimData=ds_list_create()
	
	for (k=0; 5>k; k++){ //ShapeName, ShapeTextures, ShapeMaterial, ShapeVertexData, ShapePrimatives
		SubBlock=buffer_read(buffer,buffer_u32)
		if SubBlock == 64{ //ShapeName (Not Being Used)
			ShapeNameLength = buffer_read(buffer,buffer_u32)
			ShapeNameByteLength = buffer_read(buffer,buffer_u8)
			ShapeName=""
			for (var l = 0; l < ShapeNameByteLength; l++) {
				var byte = buffer_read(buffer, buffer_u8);
				ShapeName += chr(byte);
			}
		}
		
		else if SubBlock == 65{ //ShapeTexture
			ShapeTextureBlockLength = buffer_read(buffer,buffer_u32)
			Skip = buffer_tell(buffer)
			ShapeTextureAmount = buffer_read(buffer,buffer_u16)
			ShapeTextureAmount2 = buffer_read(buffer,buffer_u16)
			buffer_read(buffer,buffer_u16)
			for (m = 0; m<ShapeTextureAmount; m++){
				TextureName=""
				TextureNameByteLength = buffer_read(buffer,buffer_u8)
				for (var n = 0; n < TextureNameByteLength; n++) {
					var byte = buffer_read(buffer, buffer_u8);
					TextureName += chr(byte);
				}
				ds_list_add(TempTexData,TextureName)
			}
			buffer_seek(buffer,buffer_seek_start,ShapeTextureBlockLength+Skip)
		}
		
		else if SubBlock == 66{ //ShapeMaterial
			ShapeMaterialBlockLength = buffer_read(buffer,buffer_u32)
			MaterialAmount = buffer_read(buffer,buffer_u32)
			for (o=0; o<MaterialAmount; o++){
				buffer_read(buffer,buffer_u32) //Material ID
				MaterialByteLength = buffer_read(buffer,buffer_u32)
				buffer_read(buffer,buffer_u8) //R
				buffer_read(buffer,buffer_u8) //G
				buffer_read(buffer,buffer_u8) //B
				if MaterialByteLength == 9{ //If MaterialByteLength = 9, write metadata too
					buffer_read(buffer,buffer_u32)
				}
				TextureIndex = buffer_read(buffer,buffer_u16)
				if TextureIndex != 65535{
					ds_list_add(TempMatData,TextureIndex)
				}
				else{
					ds_list_add(TempMatData,-1)
				}
			}
		}
		
		else if SubBlock == 67{ //ShapeVertex
			ShapeVertexBlockLength = buffer_read(buffer,buffer_u32)
			SevenTeen = buffer_read(buffer,buffer_u32)
			VertexDataLength = buffer_read(buffer,buffer_u32)
			VertexAmount = buffer_read(buffer,buffer_u32)
			for (v=0; v<VertexAmount; v++){
				ds_list_add(TempVertData,ds_list_create())
				CurrentVert=ds_list_find_value(TempVertData,v)
				//Order = x y z ? ? ? alpha r g b uvX uvY
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //x
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //y
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //z
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //nx?
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //ny?
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //nz?
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_u8)) //a
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_u8)) //r
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_u8)) //g
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_u8)) //b
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //uvx
				ds_list_add(CurrentVert,buffer_read(buffer,buffer_f32)) //uvy
			}
		}
		
		else if SubBlock == 68{ //ShapePrimatives
			ShapePrimativeBlockLength = buffer_read(buffer,buffer_u32)
			PrimativeAmount = buffer_read(buffer,buffer_u32)
			for (p=0; p<PrimativeAmount; p++){
				PrimativeType = buffer_read(buffer,buffer_u32)
				TIndex=buffer_read(buffer,buffer_u16)
				if ds_list_find_value(TempMatData,TIndex) != -1{
					CurrentTexture = ds_list_find_index(NGNTextureLoader.TextureNameList,ds_list_find_value(TempTexData,ds_list_find_value(TempMatData,TIndex)))
				}
				else{
					CurrentTexture = -1
				}
				PrimativeVertexCount = buffer_read(buffer,buffer_u16)
				TempSortedVert=ds_list_create()
				index=0
				
				
				
				
				if PrimativeType==5{
					PrimativeType=9
					check=0
					DoubleTemp=ds_list_create()
					for (c=0;c<PrimativeVertexCount;c++){
						check+=1
						VertPos=buffer_read(buffer,buffer_u16)
						if check==1{
							v1=VertPos	
						}
						if check==2{
							v2=VertPos
						}
						if check==3{
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
						}
						ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
						if check==5{
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v1))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v2))
							check=0
						}
						
					}
					plswork=ds_list_size(DoubleTemp)
						for (d=0; d<plswork;d++){
							CurrentVert=ds_list_find_value(DoubleTemp,d)
							for (g=0;g<ds_list_size(CurrentVert);g++){
									ds_list_add(TempSortedVert,ds_list_find_value(CurrentVert,g))
							}
						}
						ds_list_destroy(DoubleTemp)
				}
				
				else if PrimativeType==6{
					PrimativeType=9
					check=0
					DoubleTemp=ds_list_create()
					for (c=0;c<PrimativeVertexCount;c++){
						check+=1
						VertPos=buffer_read(buffer,buffer_u16)
						if check==1{
							v1=VertPos	
						}
						if check==2{
							v2=VertPos
						}
						if check==3{
							v3=VertPos
						}
						if check==4{
							v4=VertPos
						}
						if check==5{
							v5=VertPos
						}
						if check==6{
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v1))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v2))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v3))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v3))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v1))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v3))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v4))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v4))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v5))
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
							check=0
						}
						
					}
					plswork=ds_list_size(DoubleTemp)
						for (d=0; d<plswork;d++){
							CurrentVert=ds_list_find_value(DoubleTemp,d)
							for (g=0;g<ds_list_size(CurrentVert);g++){
									ds_list_add(TempSortedVert,ds_list_find_value(CurrentVert,g))
							}
						}
						ds_list_destroy(DoubleTemp)
				}
				
				
				else if PrimativeType==4{
					PrimativeType=9
					check=0
					DoubleTemp=ds_list_create()
					for (c=0; c<PrimativeVertexCount; c++){
						check+=1
						VertPos=buffer_read(buffer,buffer_u16)
						if check==1{
							v1=VertPos
						}
						if check==3{
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
						}
						
						ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,VertPos))
						
						if check==4{
							ds_list_add(DoubleTemp,ds_list_find_value(TempVertData,v1))
							check=0
						}
					}
					plswork=ds_list_size(DoubleTemp)
					for (d=0; d<plswork;d++){
						CurrentVert=ds_list_find_value(DoubleTemp,d)
						for (g=0;g<ds_list_size(CurrentVert);g++){
								ds_list_add(TempSortedVert,ds_list_find_value(CurrentVert,g))
						}
					}
					ds_list_destroy(DoubleTemp)
				}
				else{
					for (c=0; c<PrimativeVertexCount; c++){
						CurrentVert=ds_list_find_value(TempVertData,buffer_read(buffer,buffer_u16))
						for (g=0;g<ds_list_size(CurrentVert);g++){
								ds_list_add(TempSortedVert,ds_list_find_value(CurrentVert,g))
						}		
					}
				}
				
				ds_list_add(CurrentShape,newvbuffer(TempSortedVert,PrimativeType,CurrentTexture))
				ds_list_destroy(TempSortedVert)
			}
			buffer_read(buffer,buffer_u64) //8 Byte Padding at the end of a Shape
			ds_list_destroy(TempTexData)
			ds_list_destroy(TempMatData)
			ds_list_destroy(TempVertData)
			ds_list_destroy(TempPrimData)
		}
	}
}
buffer_delete(buffer)

show_debug_message("Time Taken To Parse Geometry: "+string((get_timer() - Timer)/1000000)+" Seconds")