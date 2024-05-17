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


var merry = instance_create_depth(500, 500, depth, GameObject);
merry.z = -32;