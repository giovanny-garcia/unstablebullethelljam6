using Godot;
using System;

public partial class BulletPool : Node
{
	//private List<Bullet> pool = new List<Bullet>();
	/*private int poolSize = 1000;
	
	public override void _Ready()
	{
		for (int i = 0; i < poolSize; i++)
		{
			var bullet = new Bullet();
			bullet.Visible = false;
			bullet.SetProcess(false);
			AddChild(bullet);
			//pool.Add(bullet);
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
				return bullet;
			}
		}
		return null;
	}
	
	public void ReturnBullet(Bullet bullet)
	{
		bullet.Visible = false;
		bullet.SetProcess(false);
		bullet.Position = Vector2.Zero;
	}
	*/
}
