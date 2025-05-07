using Godot;

public partial class Bullet : Area2D
{
	public Vector2 Velocity { get; set; }
	public override void _Ready()
	
	{
		Velocity = Velocity.Normalized() * 400; // Set the bullet speed
		// We could change the velocity with a function or something...
	}
	public override void _PhysicsProcess(double delta)
	{
		Position += Velocity * (float)delta; // Move the bullet
		Velocity = Velocity.Normalized() * 400;
	
		var viewportRect = GetViewportRect();
		if(!viewportRect.HasPoint(GlobalPosition)) // we need the position surrounding the player camera
		{
			// Return the bullet to the pool if it goes off-screen
			GetParent<BulletPool>().ReturnBullet(this);
		}
	}
}
