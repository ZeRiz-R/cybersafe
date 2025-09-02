shader_type canvas_item;

const float speed = 0.01;

void vertex() {
	// Called for every vertex the material is visible on.
	UV.x -= TIME * speed;
	// UV.y += TIME * speed;
}
