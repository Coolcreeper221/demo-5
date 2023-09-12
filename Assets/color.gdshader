shader_type canvas_item;
uniform vec4 Original:source_color;
uniform vec4 Replace:source_color;
void fragment() {
	if (distance(texture(TEXTURE,UV),Original)<= 0.1){
		COLOR = Replace;
	}
	else{
		COLOR =texture(TEXTURE,UV);
	}
}
