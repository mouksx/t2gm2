draw_set_colour(c_white);
draw_set_font(MainFont)

draw_text(0,0,"Select Game To Load (1/3): " + Game)
draw_text(0,20,"Select Level To Load (Q/E): " + string(global.LevelSelected))
draw_text_colour(0,40,"FPS: " + string(fps) + "/" + string(fps_real),0x00ccff,0x00ccff,0x00ccff,0x00ccff,1)
draw_text(0,60,"Previewing Shape (Z/X): " + string(DebugShape))
draw_text(0,80,"Prim (C/V): " + string(DebugPrim))
draw_text(0,100,"Toggle Full Shape (T): " + string(!FullToggle))