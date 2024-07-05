buffer = buffer_load(string(global.LevelSelected)+".ngn")

cursor = 0

BlockOffsets = ds_list_create()
BlockValues = ds_list_create()
BlockLengths = ds_list_create()

piss = get_timer();

do{
	ds_list_add(BlockOffsets,cursor)
	ds_list_add(BlockValues,buffer_peek(buffer,cursor,buffer_u32))
	cursor+=4
	ds_list_add(BlockLengths,buffer_peek(buffer,cursor,buffer_u32))
	cursor+=buffer_peek(buffer,cursor,buffer_u32)
	cursor+=4
}
until (buffer_peek(buffer,cursor,buffer_u32) == undefined)
show_debug_message("Time Taken To Hunt Blocks: "+string((get_timer() - piss)/1000000)+" Seconds")
show_debug_message(ds_list_find_value(BlockOffsets,ds_list_find_index(BlockValues,"257")))
buffer_delete(buffer)