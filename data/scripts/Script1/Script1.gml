/// @param filename

function newvbuffer(argument0,argument1,argument2){
	vbuffer=vertex_create_buffer()
	poo=argument0
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	format = vertex_format_end();
	vertex_begin(vbuffer,format)
	offset=0
	count=0
	count2=0
	vertcount=ds_list_size(argument0)/12
	trans=false
	
	/*repeat(vertcount){
		if count==0 and vertcount!=1{
			offset=0
			vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
			vertex_normal(vbuffer,ds_list_find_value(poo,offset+3),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
			vertex_color(vbuffer,c_white,1)
			vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),ds_list_find_value(poo,offset+7))
			offset=8
			vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
			vertex_normal(vbuffer,ds_list_find_value(poo,offset+3),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
			vertex_color(vbuffer,c_white,1)
			vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),ds_list_find_value(poo,offset+7))
			count=2
			vertcount-=1
		}
		else{
			if count!=vertcount{
				offset=count*8
				count+=1
				vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
				vertex_normal(vbuffer,ds_list_find_value(poo,offset+3),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
				vertex_color(vbuffer,c_white,1)
				vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),ds_list_find_value(poo,offset+7))
			}
		}
	}*/
	
	/*repeat(vertcount){
		offset=count*8
		count+=1
		count2+=1
		
		
		if argument1!=1 or 3{
			if count2%3==0{
			show_debug_message("repeat v3")
			vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
			vertex_normal(vbuffer,ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
			vertex_color(vbuffer,c_white,1)
			vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),1-ds_list_find_value(poo,offset+7))
			}
		}
		show_debug_message(count2)
		vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
		vertex_normal(vbuffer,ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
		vertex_color(vbuffer,c_white,1)
		vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),1-ds_list_find_value(poo,offset+7))
		if argument1!=1 or 3{
			if count2%4==0{
				offset-=24
				show_debug_message("add v1")
				vertex_position_3d(vbuffer,ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+1),ds_list_find_value(poo,offset+2))
				vertex_normal(vbuffer,ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
				vertex_color(vbuffer,c_white,1)
				vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+6),1-ds_list_find_value(poo,offset+7))
				count2=0
			}
		}
	}*/
	
	repeat(vertcount){
		offset=count*12
		count+=1
		colour=make_color_rgb(ds_list_find_value(poo,offset+7),ds_list_find_value(poo,offset+8),ds_list_find_value(poo,offset+9))
		vertex_position_3d(vbuffer,-ds_list_find_value(poo,offset),ds_list_find_value(poo,offset+2),-ds_list_find_value(poo,offset+1))
		vertex_normal(vbuffer,ds_list_find_value(poo,offset+3),ds_list_find_value(poo,offset+4),ds_list_find_value(poo,offset+5))
		vertex_color(vbuffer,colour,ds_list_find_value(poo,offset+6)/255)
		if ds_list_find_value(poo,offset+6)!=255{
			trans=true
		}
		vertex_texcoord(vbuffer,ds_list_find_value(poo,offset+10),1-ds_list_find_value(poo,offset+11))
	}
	
	
	
	
	
	vertex_end(vbuffer)
	return([vbuffer,argument1,argument2,trans])
}