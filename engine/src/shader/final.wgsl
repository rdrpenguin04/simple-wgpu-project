struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) tex_coords: vec2<f32>,
};

@group(1) @binding(0) var<uniform> aspect: f32;

@vertex
fn vs_main(
    @builtin(vertex_index) in_vertex_index: u32,
) -> VertexOutput {
    var out: VertexOutput;
    let x = i32((in_vertex_index + 1u) / 3u & 1u);
    let y = i32(in_vertex_index & 1u);
    let x_scaled = f32(x * 2 - 1) / aspect * 16.0 / 9.0;
    let y_scaled = -f32(y * 2 - 1);
    out.clip_position = vec4<f32>(x_scaled, y_scaled, 0.0, 1.0);
    out.tex_coords = vec2<f32>(f32(x), f32(y));
    return out;
}

@group(0) @binding(0) var tex: texture_2d<f32>;
@group(0) @binding(1) var smp: sampler;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return textureSample(tex, smp, in.tex_coords);
}