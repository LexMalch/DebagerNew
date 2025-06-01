shader_type canvas_item;

// Настройки молний
uniform float speed = 1.5;
uniform float branches = 5.0;
uniform float brightness = 1.8;
uniform vec3 core_color:source_color = vec3(0.3, 0.6, 1.0);
uniform vec3 edge_color:source_color = vec3(0.8, 0.9, 1.0);

// Генератор молниеподобных линий
float lightning(vec2 uv, float angle_offset) {
    // Создаем основную ветвь
    float angle = atan(uv.y, uv.x) + angle_offset;
    float branch = mod(angle, 5.28 / branches) * 0.1;
    
    // Добавляем хаотичные ответвления
    float t = TIME * speed;
    float distort = sin(uv.x * 50.0 + t * 2.0) * 0.01;
    
    // Формируем молнию
    float lightning = 1.1 - smoothstep(0.0, 0.2 + distort, 
        abs(length(uv) * 2.0 - 0.7 + branch));
    
    // Добавляем детализацию
    float details = sin(uv.x * 100.0 + t * 10.0) * .21;
    return lightning * (0.8 + details);
}

void fragment() {
    vec2 uv = UV - 0.5;
    float radius = length(uv);
    
    // Генерируем несколько молний
    float l1 = lightning(uv, TIME * 1.5);
    float l2 = lightning(uv * 1.3, TIME * 0.7);
    float l = max(l1, l2 * .7);
    
    // Цветовая градация от центра
    vec3 col = mix(core_color, edge_color, radius * 2.0);
    
    // Маска для плавного исчезновения
    float mask = 1.0 - smoothstep(.2, .9, radius);
    
    // Финальный эффект
    COLOR.rgb = col * l * brightness * mask;
    COLOR.a = l * mask;
}