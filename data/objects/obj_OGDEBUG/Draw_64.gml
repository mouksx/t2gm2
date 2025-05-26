draw_set_colour(c_white);
draw_set_font(MainFont)

draw_text(0,0,"Select Game To Load: " + Game)
draw_text(0,20,"Select Level To Load: " + string(global.LevelSelected))
draw_text(0,60,"Press \"R\" To Restart Room! Press \"V\" To Restart Game!")
draw_text_colour(0,40,"Shapes Rendering: " + string(global.shapecount)+" / FPS: " + string(fps) + "/" + string(fps_real),0x00ccff,0x00ccff,0x00ccff,0x00ccff,1)
if instance_exists(obj_Camera){
	draw_text(0,80,"Camera Co-Ordinates: "+string(obj_Camera.x)+" , "+string(obj_Camera.y)+" , "+string(obj_Camera.z))
}else{
	exit
}