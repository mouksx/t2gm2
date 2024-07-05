buffer = buffer_load(string(global.LevelSelected)+".ngn")
buffer_seek(buffer, buffer_seek_start, ds_list_find_value(BlockHunter.BlockOffsets,ds_list_find_index(BlockHunter.BlockValues,515)));

Block = buffer_read(buffer,buffer_u32)
BlockLength = buffer_read(buffer,buffer_u32)
SubBlock = buffer_read(buffer,buffer_u32) //subblock 63
CharacterNameLength = buffer_read(buffer,buffer_u8) //5 7???? level1 11 characters


buffer_delete(buffer)