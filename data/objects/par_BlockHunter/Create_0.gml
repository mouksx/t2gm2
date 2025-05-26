buffer=buffer_load(string(global.GameSelected)+"/"+string(global.LevelSelected)+".ngn")

BlockOffsets=[]
BlockValues=[]
BlockLengths=[]

HuntTimer=get_timer()

try{
	repeat(999){
		array_push(BlockOffsets,buffer_tell(buffer))
		array_push(BlockValues,buffer_read(buffer,buffer_u32))
		BlockLength=buffer_read(buffer,buffer_u32)
		array_push(BlockLengths,BlockLength)
		buffer_seek(buffer,buffer_seek_relative,BlockLength)
	}
}

catch(_exception){
	show_debug_message("Time Taken To Hunt Blocks: "+string((get_timer() - HuntTimer)/1000000)+" Seconds")
	buffer_delete(buffer)
}