using Godot;
using System;

public partial class Player : CharacterBody2D
{
    private float speed = 50.0f;
    private int health = 100;
    private int damage = 10;

    public override void _Ready()
    {
        // Initialize player properties
    }
    public override void _Process(double delta)
    {
        /*
        
        */
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Velocity;
        Vector2 input_vector = Input.GetVector("LEFT", "RIGHT", "UP", "DOWN");
        if (input_vector != Vector2.Zero)
        {
            velocity.X = input_vector.X * speed;
            velocity.Y = input_vector.Y * speed;
        }
        else
        {
            velocity.X = Mathf.MoveToward(Velocity.X, 0, speed);
            velocity.Y = Mathf.MoveToward(Velocity.Y, 0, speed);
        }
        Velocity = velocity;
        MoveAndSlide();
    }
}
