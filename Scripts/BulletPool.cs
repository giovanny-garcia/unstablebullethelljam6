using Godot;
using System;
using System.Collections.Generic;

public partial class BulletPool : Node
{
    private List<Bullet> pool = new List<Bullet>();
    private int poolSize = 100;
    private PackedScene bulletScene;

    public override void _Ready()
    {
        // Load the Bullet scene
        bulletScene = GD.Load<PackedScene>("res://Scenes/Bullet/Bullet.tscn");

        // Pre-instantiate bullets and add them to the pool
        for (int i = 0; i < poolSize; i++)
        {
            var bullet = (Node2D)bulletScene.Instantiate();
            bullet.Visible = false;
            bullet.SetProcess(false);
            AddChild(bullet);
            pool.Add((Bullet)bullet);
        }
    }
    
    public Bullet GetBullet()
    {
        foreach (var bullet in pool)
        {
            if (!bullet.Visible)
            {
                bullet.Visible = true;
                bullet.SetProcess(true);
                return (Bullet)bullet;
            }
        }
        GD.Print("Warning: Expanding bullet pool");

        // Expand the pool if no bullets are available
        for (int i = 0; i < 100; i++)
        {
            var bullet = (Bullet)bulletScene.Instantiate();
            bullet.Visible = false;
            bullet.SetProcess(false);
            AddChild(bullet);
            pool.Add(bullet);
        }
        //maybe we could add some logic to remove bullets 
        // that are not used for a while
        // or to limit the pool size
        
        return GetBullet();
    }
    
    public void ReturnBullet(Bullet bullet)
    {
        bullet.Visible = false;
        bullet.SetProcess(false);
        bullet.Position = Vector2.Zero;
    }
}
