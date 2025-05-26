global.LevelSelected=0;
global.GameSelected=0
global.shapecount= "N/A"

ShapeCount=0

Game=""
MainFont = font_add_sprite_ext(spr_MainFont,"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,:;?!/\\<>()'-~abcdefghijklmnopqrstuvwxyz",true,0)

function CreateShape(){
		var inst = instance_create_depth(0,0,0,obj_DebugShape,{Level:true})
}