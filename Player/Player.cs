using Godot;
using System;


public partial class Player : CharacterBody2D
{
	[Export] private NodePath bulletPoolPath;
	private BulletPool bulletPool;
	[Export] private float speed = 100.0f;
	private int health = 100;
	private int damage = 10;
	private Bullet bullet;
	private int bulletSpeed = 400;
	private AnimationPlayer animationPlayer;
	private Node2D shootinDirection;
	private Timer attackCooldownTimer;
	private bool canShoot = true;
	private Node healthComponent;
	private Node healthBar;
	private Node audioManager;
	private Node gameStateManager;
	private Node portalManager;
	[Export] private int attackSpeed = 5;
	private string parentNodeName;



	public override void _Ready()
	{
		//Global variables
		audioManager = GetNode("/root/AudioManager");
		gameStateManager = GetNode("/root/GameStateManager");
		portalManager = GetNode("/root/PortalManager");
		//
		//healthComponent = GetNode("Components/HealthComponent");
		//healthComponent.Connect("health_changed", new Callable(this, nameof(OnHealthChanged)));
		//healthComponent.Connect("died", new Callable(this, nameof(OnDied)));




		//bullet = GetNode<Node2D>("Bullet");
		bulletPool = GetNode<BulletPool>("BulletPool");
		animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
		shootinDirection = GetNode<Node2D>("ShootingDirection");
		animationPlayer.Active = true;
		attackCooldownTimer = GetNode<Timer>("AttackCooldownTimer");
		attackCooldownTimer.WaitTime = UpdateAttackSpeed(attackSpeed);
		animationPlayer.Active = true;
		/*This is used specifically for dealing with scipts that use c# and gdscripts in combination*/
		healthBar = GetNode("Camera2D/HealthBar");
		healthBar.Call("init_health", health);

		parentNodeName = GetParent().Name;
		GD.Print("Parent node name: " + parentNodeName);

		// Initialize player properties
	}
	public override void _Process(double delta)
	{
		gameStateManager.Call("set_player_position", GlobalPosition);
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
			Attack();
			audioManager.Call("play_sfx", "shoot", 0.1f);
		}
	}
	private void Attack()
	{
		var bullet = bulletPool.GetBullet();
		bullet.GlobalPosition = GlobalPosition;
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
	private void OnHealthChanged(int current, int max)
	{
		GD.Print($"Health: {current}/{max}");
		// Update health UI or effects here
	}
	private void OnDied()
	{
		//gameStateManager changes state to game over. 
		GD.Print("Player has died!");
		// Handle death (e.g., respawn or game over logic)
	}
	private void OnArea2DAreaEntered(Area2D _area)
	{
		damage_handler(1);
		GD.Print("Bullet hit on player");
		// Your logic here
	}
	private void damage_handler(int damage)
	{
		health -= damage;
		if (health < 0)
		{
			healthBar.Call("_set_health", health);
		}
		else
		{
			OnDied();
		}
		
	}
}
