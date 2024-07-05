for (i=0; ShapeCount > i; i++;){
	ds_list_destroy(ds_list_find_value(GeometryData,i))
}
ds_list_destroy(GeometryData)