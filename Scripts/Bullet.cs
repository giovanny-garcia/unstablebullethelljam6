using Godot;
using System;

public partial class Bullet : Area2D
{
	public Vector2 Velocity { get; set; }
	public override void _PhysicsProcess(float delta)
	{
		Position += Velocity * delta;
		if (Position.x < 0 || Position.x > 1920 || Position.Y < 0 || Position.y > 1080)
		{
			GetParent<BulletPool>().ReturnBullet(this);
		}
	}
}
