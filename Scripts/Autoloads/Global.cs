using Godot;
using System;

public partial class Global : Node
{
    private CharacterBody2D player;

    // Singleton instance for easy access
    public static Global Instance { get; private set; }

  
}