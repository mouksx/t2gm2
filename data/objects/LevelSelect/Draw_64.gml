draw_set_colour(c_white);
draw_set_font(MainFont)
draw_text(0,0,"Select Level To Load (Press ENTER to select): " + string(global.LevelSelected))
draw_text_colour(0, 20, "FPS: " + string(fps) + "/" + string(fps_real), 0x00ccff, 0x00ccff, 0x00ccff, 0x00ccff, 1);
draw_text_colour(0,40,"Shapes Rendering: " + string(shapecount),0x00ccff,0x00ccff,0x00ccff,0x00ccff,1)