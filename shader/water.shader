shader_type canvas_item;

void vertex() {
	VERTEX.x += sin(TIME + VERTEX.x + VERTEX.y) * 3.0;
	VERTEX.y += sin(TIME + VERTEX.y + VERTEX.x) * 5.0;
}