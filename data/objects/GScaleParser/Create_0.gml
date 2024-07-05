buffer = buffer_load(string(global.LevelSelected)+".ngn")
buffer_seek(buffer, buffer_seek_start, ds_list_find_value(BlockHunter.BlockOffsets,ds_list_find_index(BlockHunter.BlockValues,257)));

GScale = ds_list_create()

Timer2=get_timer()

Block = buffer_read(buffer,buffer_u32)
BlockLength = buffer_read(buffer,buffer_u32)
ShapeCount = buffer_read(buffer,buffer_u32)

for (i=0; ShapeCount > i; i++;){
	ds_list_add(GScale,ds_list_create())
	CurrentShape=ds_list_find_value(GScale,i)
	ShapeDataLength = buffer_read(buffer,buffer_u32)
	repeat(3){
		ds_list_add(CurrentShape,buffer_read(buffer,buffer_f32))//xyz trans
	}
	repeat(3){
		ds_list_add(CurrentShape,buffer_read(buffer,buffer_f32))//xyz rotation
	}
	repeat(3){
		ds_list_add(CurrentShape,buffer_read(buffer,buffer_f32))//xyz scale
	}
	buffer_read(buffer,buffer_u32)
}
buffer_delete(buffer)

show_debug_message("Time Taken To Parse GScale: "+string((get_timer() - Timer2)/1000000)+" Seconds")