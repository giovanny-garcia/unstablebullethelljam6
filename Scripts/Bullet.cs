using Godot;

public partial class Bullet : Area2D
{
    public Vector2 Velocity { get; set; }
    private Vector2 startPosition;
    [Export] private float maxDistance = 500f; // Set your desired max distance

    public override void _Ready()
    {
        startPosition = GlobalPosition;
        Velocity = Velocity.Normalized() * 400;
        Connect("area_entered", new Callable(this, nameof(OnAreaEntered)));
        Connect("body_entered", new Callable(this, nameof(OnBodyEntered)));
    }

    public override void _PhysicsProcess(double delta)
    {
        Position += Velocity * (float)delta;
        Velocity = Velocity.Normalized() * 400;

        // Check distance traveled
        if (GlobalPosition.DistanceTo(startPosition) >= maxDistance)
        {
            GetParent<BulletPool>().ReturnBullet(this);
        }
    }

    public void ResetBullet(Vector2 position, Vector2 velocity)
    {
        GlobalPosition = position;
        startPosition = position;
        Velocity = velocity;
    }

    private void OnAreaEntered(Area2D area)
    {
        GetParent<BulletPool>().ReturnBullet(this);
    }

    private void OnBodyEntered(Node body)
    {
        GetParent<BulletPool>().ReturnBullet(this);
    }
}
