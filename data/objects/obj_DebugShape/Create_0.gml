if !variable_instance_exists(self, "CurrentShape") {
	CurrentShape = 0
}else
CurrentShape=CurrentShape

if !variable_instance_exists(self, "CurrentPrim") {
	CurrentPrim = 0
}

if !variable_instance_exists(self, "Full") {
	Full = false
}

if !variable_instance_exists(self, "Level") {
	Level = false
}


Texture = -1
self.depth = -1

opaque_prims = [];
translucent_prims = [];

for (var l = 0; l < array_length(par_ShapeLoader.Shapes); l++) {
    for (var p = 0; p < array_length(par_ShapeLoader.Shapes[l]); p++) {
        var Prim = par_ShapeLoader.Shapes[l][p];
        if (Prim[3]) {
            array_push(translucent_prims, Prim);
        } else {
            array_push(opaque_prims, Prim);
        }
    }
}

show_debug_message("sorted prims")