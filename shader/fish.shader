shader_type canvas_item;


void vertex() {
	VERTEX.x += sin(TIME + VERTEX.x) * 10.0;
	VERTEX.y += cos(TIME + VERTEX.y) * 10.0;
}