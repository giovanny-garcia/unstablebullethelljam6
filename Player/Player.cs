using Godot;
using System;

public partial class Player : CharacterBody2D
{
    [Export] private NodePath bulletPoolPath;
    private BulletPool bulletPool;
    private float speed = 50.0f;
    private int health = 100;
    private int damage = 10;
    private Bullet bullet;
    private int bulletSpeed = 400;
    private AnimationPlayer animationPlayer;
    private Node2D shootinDirection;
    private Timer attackCooldownTimer;
    private bool canShoot = true;
    [Export] private int attackSpeed = 5;
    
    

    public override void _Ready()
    {
        //bullet = GetNode<Node2D>("Bullet");
        bulletPool = GetNode<BulletPool>("BulletPool");
        animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
        shootinDirection = GetNode<Node2D>("ShootingDirection");
        animationPlayer.Active = true;
        attackCooldownTimer = GetNode<Timer>("AttackCooldownTimer");
        attackCooldownTimer.WaitTime = UpdateAttackSpeed(attackSpeed);
        animationPlayer.Active = true;

        // Initialize player properties
    }
    public override void _Process(double delta)
    {
        if (Velocity != Vector2.Zero)
        {
            animationPlayer.Play("walk");
        }
        else
        {
            animationPlayer.Pause();
        }
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

        if (Input.IsActionPressed("ATTACK") && canShoot)
        {
            // Play attack animation
            //animationPlayer.Play("attack");
            // Call the Attack function
            Attack();
        }
    }
    private void Attack()
    {
       var bullet = bulletPool.GetBullet();
        bullet.Position = GlobalPosition;
        bullet.Rotation = shootinDirection.Rotation;
        bullet.Velocity = new Vector2(Mathf.Cos(bullet.Rotation), Mathf.Sin(bullet.Rotation)) * bulletSpeed;

        canShoot = false;
        attackCooldownTimer.Start();
    }
    private void _on_AttackCooldownTimer_timeout()
    {
        // Reset the cooldown
        canShoot = true;
    }

    private float UpdateAttackSpeed(int attackSpeed)
    {
        return (float)(2.225 * Math.Exp(-0.04 * attackSpeed));
    }
}
