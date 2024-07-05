gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
vertex_format_add_texcoord();
format = vertex_format_end();
pitch = 0;
direction = 0;
z = 32;
shapecount=0
tp=ds_list_create()


for (var k=0; k<ds_list_size(GeometryParser.GeometryData);k++){
	
	if k-10&&k<-10{
		shape=instance_create_depth(0, 0, depth, GhostPizzaPlanetToken)
				
		with (shape){
			Shape=k
		}
	}
	
	else{
		ended=false
		
		for (var p=0; p<ds_list_size(ds_list_find_value(GeometryParser.GeometryData,k));p++){
			thingo=ds_list_find_value(ds_list_find_value(GeometryParser.GeometryData,k),p)[3]
			
			if thingo=true{
				shape=instance_create_depth(0, 0, depth, StaticRender)
				
				with (shape){
					Shape=k
				}
				
				p=999
				ended=true
			}
			
		}
		
		if  ended==false{
			ds_list_add(tp,k)

		}
		
	}
	
}



for (var t=0;t<ds_list_size(tp);t++){
		shape=instance_create_depth(0, 0, depth, StaticRender)
		with (shape){
			Shape=ds_list_find_value(Camera.tp,t)
		}
}


shapecount=instance_number(StaticRender)+instance_number(GhostPizzaPlanetToken)