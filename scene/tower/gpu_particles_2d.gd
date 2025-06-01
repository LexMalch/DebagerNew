extends GPUParticles2D
var lightning_particles = GPUParticles2D.new()

func _ready():
	add_child(lightning_particles)


	lightning_particles.amount = 32
	lightning_particles.lifetime = 0.8
	lightning_particles.explosiveness = 0.1



	process_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	process_material.emission_sphere_radius = 5.0
