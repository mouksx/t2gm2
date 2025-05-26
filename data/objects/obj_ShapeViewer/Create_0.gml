global.LevelSelected=0;
global.GameSelected=0
global.shapecount= "N/A"

DebugShape=0
DebugPrim=0
FullToggle=false



Game=""
MainFont = font_add_sprite_ext(spr_MainFont,"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,:;?!/\\<>()'-~abcdefghijklmnopqrstuvwxyz",true,0)

function CreateShape(){
	if FullToggle == true{
		if instance_exists(obj_DebugShape){instance_destroy(obj_DebugShape)}
		if instance_exists(obj_DebugShape){instance_destroy(Level)}
		var inst = instance_create_depth(0,0,0,obj_DebugShape,{CurrentShape:DebugShape,CurrentPrim:DebugPrim})
	}
	if FullToggle == false{
		if instance_exists(obj_DebugShape){instance_destroy(obj_DebugShape)}
		if instance_exists(obj_DebugShape){instance_destroy(Level)}
		var inst = instance_create_depth(0,0,0,obj_DebugShape,{CurrentShape:DebugShape,Full:true})
	}
}