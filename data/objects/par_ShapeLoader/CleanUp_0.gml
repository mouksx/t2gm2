for(var i=0;i<array_length(Shapes);i++){
for (var p=0;p<array_length(Shapes[i]);p++){
	vertex_delete_buffer(Shapes[i][p][0])
	}
}
show_debug_message("Successfully deleted vbuffers")