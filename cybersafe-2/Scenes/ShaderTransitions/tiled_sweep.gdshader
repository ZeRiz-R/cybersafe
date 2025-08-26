shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0);
uniform bool reverse = true;
uniform vec2 numberOfTiles = vec2(16, 9);

void fragment() {
	// Called for every pixel the material is visible on.
	// Gets the tile the pixel is in, and the position within that tile
	vec2 positionInSquare = UV * numberOfTiles;
	vec2 frac = fract(positionInSquare); // Fractional part of the position
	vec2 direction = abs(frac - 0.5);

	if (direction.x + direction.y + UV.x + UV.y > progress * 4.0) {
		if (!reverse) {
			discard;
		}
	}
	else if (reverse) {
		discard;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
