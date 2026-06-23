shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 1.0;
uniform vec4 screen_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float feather : hint_range(0.0, 0.1) = 0.005;

void fragment() {
	vec2 central_uv = UV - vec2(0.5);
	
	// Proporção exata da sua tela (648x1152)
	float width = 648.0;
	float height = 1152.0;
	float aspect_ratio = width / height;
	
	// Ajusta o UV para manter o círculo perfeito na vertical
	central_uv.y /= aspect_ratio;
	
	float dist = length(central_uv);
	
	// CORREÇÃO: Calcula o raio necessário para cobrir os cantos da tela vertical
	float max_radius = 0.5 * sqrt(1.0 + (1.0 / (aspect_ratio * aspect_ratio)));
	float current_radius = max_radius * progress;
	
	float alpha = smoothstep(current_radius, current_radius + feather, dist);
	
	COLOR = vec4(screen_color.rgb, alpha);
}