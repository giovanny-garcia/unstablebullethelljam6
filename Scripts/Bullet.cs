using Godot;
using System;

public partial class Bullet : Area2D
{
	public Vector2 Velocity { get; set; }
	public override void _Ready()
	{
		// Initialize bullet properties if needed
	}
	public override void _PhysicsProcess(double delta)
	{
		Velocity = Velocity.Normalized() * 400; // Set the bullet speed
		Position += Velocity * (float)delta; // Move the bullet
		if (Position.X < 0 || Position.X > 1920 || Position.Y < 0 || Position.Y > 1080) // we need the position surrounding the player camera
		{
			// Return the bullet to the pool if it goes off-screen
			GetParent<BulletPool>().ReturnBullet(this);
		}
	}
}
