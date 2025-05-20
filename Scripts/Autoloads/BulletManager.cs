using Godot;
using System;
public partial class BulletManager : Node
{
    private Bullet bullet;
    private BulletPool bulletPool;


    private struct BulletData
    {
        public Vector2 Position;
        public Vector2 Velocity;
        public bool Active;
    }

    private BulletData[] bullets = new BulletData[1000];
    private Node2D[] bulletNodes = new Node2D[1000];

    public override void _Ready()
    {
        bulletPool = GetNode<BulletPool>("/root/BulletPool");
    }
    public override void _PhysicsProcess(double delta)
    {
        for (int i = 0; i < bullets.Length; i++)
        {
            if (!bullets[i].Active) continue;
            bullets[i].Position += bullets[i].Velocity * (float)delta;
            bulletNodes[i].Position = bullets[i].Position;

            if (bullets[i].Position.X < 0 || bullets[i].Position.X > 1920)
            {
                bullets[i].Active = false;
                bulletNodes[i].Visible = false;
            }
        }
    }

}
