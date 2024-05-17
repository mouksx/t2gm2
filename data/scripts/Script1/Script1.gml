/// @param filename

function newvbuffer(argument0,argument1){
	vbuffer=vertex_create_buffer()
	poo=argument0
	vertex_begin(vbuffer,Camera.format)
	offset=0
	count=0
	vertcount=ds_list_size(argument0)/8
	
	repeat(vertcount){
		offset=count*8
		count+=1
		vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
		vertex_normal(vbuffer,ds_list_find_value(poo,offset+3),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
		vertex_color(vbuffer,c_white,1)
		vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+7),ds_list_find_value(poo,offset+6))
	}
	
	vertex_end(vbuffer)
	return([vbuffer,argument1])
}