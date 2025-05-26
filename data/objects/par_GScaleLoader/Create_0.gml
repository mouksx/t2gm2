buffer = buffer_load(string(global.GameSelected)+"/"+string(global.LevelSelected)+".ngn")
buffer_seek(buffer, buffer_seek_start, array_get(par_BlockHunter.BlockOffsets,array_get_index(par_BlockHunter.BlockValues,257)));

if !variable_instance_exists(self, "debug") {
	debug = false
}

GScale = []

GScaleLoadTimer=get_timer()

buffer_seek(buffer,buffer_seek_relative,8) //skip sub-block/length
ShapeCount = buffer_read(buffer,buffer_u32)

for (i=0;i<ShapeCount;i++){
	array_push(GScale,[])
	CurrentShape=array_last(GScale)
	buffer_seek(buffer,buffer_seek_relative,4) //skip shapedatalength
	repeat(3){
		if debug == false{
			array_push(CurrentShape,buffer_read(buffer,buffer_f32)) //xyz trans
		}else{
			array_push(CurrentShape,0)
			buffer_seek(buffer,buffer_seek_relative,4)
		}
	}
	repeat(3){
		array_push(CurrentShape,buffer_read(buffer,buffer_u32)) //xyz rot
	}
	repeat(3){
		array_push(CurrentShape,buffer_read(buffer,buffer_f32)) //xyz scale
	}
	buffer_seek(buffer,buffer_seek_relative,4)
}
buffer_delete(buffer)

show_debug_message("Time Taken To Parse GScale: "+string((get_timer() - GScaleLoadTimer)/1000000)+" Seconds")