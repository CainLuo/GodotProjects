# Godot 笔记

## 生命周期方法

```C#
// 节点进入树的时候会调用
public override void _EnterTree() {}
// 调用完_EnterTree()之后会调用
public override void _Ready() {}
// 每一帧更新都会调用
public override void _Process(double delta) {}
// 每次物理计算都会调用
public override void _PhysicsProcess(double delta) {}
// 节点从树中移除的时候会调用
public override void _ExitTree() {}
```

## 监听输入事件

### 监听键盘输入事件

```c#
public override void _Input(InputEvent @event)
	{
		base._Input(@event);
		// 如果是键盘事件
		if (@event is InputEventKey)
		{
			var key = @event as InputEventKey;
			// 判断我们当前是否按下的是 V 键
			if (key.Keycode == Key.V)
			{
				// 判断当前是否是按压
				if (key.IsEcho())
				{
					GD.Print("持续按 V 键");
				}
				// 判断当前是否是按下瞬间
				else if (key.IsPressed())
				{
					GD.Print(" 按下了 V 键");
				}
				// 判断当前是否是抬起瞬间
				else if (key.IsReleased())
				{
					GD.Print(" 抬起了 V 键");
				}
			}
		}
	}
```

### 监听鼠标输入事件

```C#
public override void _Input(InputEvent @event)
	{
		base._Input(@event);
		// 如果是键盘事件
		if (@event is InputEventMouse)
		{
			var mouse = @event as InputEventMouse;
			if (mouse.IsPressed())
			{
				GD.Print("鼠标点击的位置：", mouse.Position);
				GD.Print("鼠标点击的按键：", mouse.ButtonMask);
			}
		}
	}
```

## 节点的管理

### 获取父/子节点
```C#
public override void _Ready()
{
    // 获取父节点
    Node2D node1 = this.GetParent() as Node2D;
    // 获取泛型节点
    Node2D node2 = this.GetParent<Node2D>();

    GD.Print("Player _Ready", node1, node2);
}
```

### 在当前场景下查询子节点

#### 获取当前场景下的节点
```C#
public override void _Pricess(double delta) 
{
    // 按下键盘左键
    if (Input.IsActionJustPressed("左")) {
        // 获取当前场景的根节点
        Node root = this.GetTree().CurrentScene;
        // 寻找 test 节点
        Node test = root.FindChild("Test");
        // 释放 test 节点
        test.QueueFree();
        GD.Print("test 节点已释放");

        // 将 test 节点添加到当前节点下
        root.RemoveChild(test);

        this.AddChild(test);
    }

    // 添加子节点
    if (Input.IsActionJustPressed("右")) {	
        Node root = this.GetTree().CurrentScene;

        Node2D node2D = new Node2D();
        node2D.Name = "New";

        this.AddChild(node2D);
    }
}
```

#### 根据路径查询节点

```C#
public override void _Ready()
{
	// 获取子节点：相对路径
	Node2D node1 = this.GetNode<Node2D>("CharacterBody2D/Sprite2D");

    // 获取子节点：绝对路径
    Node2D node2 = this.GetNode<Node2D>("/root/World/CharacterBody2D/Sprite2D");

    GD.Print("Player _Ready", node1, node2);
}
```

## 场景管理
### 创建场景
```C#
/*
 新场景：跳转场景 2，需要在 Godot 里将 game.tscn 拖入到资源管理器里:
 比如下面的这段代码写在某个 Node 里的，那就需要在 Godot 里找到该 Node，然后将 game.tscn 拖入到该 Node 的资源管理器里
*/

[Export]
public PackedScene scene;

public override void _Process(double delta)
{
	if (Input.IsActionJustPressed("左"))
	{
		// 获取场景树
		SceneTree tree = this.GetTree();
		// 跳转场景 1：路径切换场景
		// tree.ChangeSceneToFile("res://Scenes/game.tscn");
		// 跳转场景 2
		tree.ChangeSceneToPacked(scene);
	}
}
```

### 添加场景的Node到当前场景

```C#
public override void _Process(double delta)
{
	if (Input.IsActionJustPressed("右"))
	{
		// 实例化新场景，并返回一个根节点
		Node node = scene.Instantiate();
		// 添加进来
		this.GetTree().CurrentScene.AddChild(node);
	}
}
```

## 全局脚本

* Godot -> 项目 -> 项目管理 -> 全局，找到你想要添加的单例脚本添加，即使是更换场景，这些脚本也不会被 Released，并且也只会执行一次。

```C#
using Godot;
using System;

// 对游戏做一些管理设定
public partial class GameManager : Node
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("GameManager 执行了一次");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
```

## 向量与标量

* 标量：只有大小的量，比如数值 1，85，888，999。
* 向量：有方向和数量的量，比如车站在前面走 100 米后左拐再走 10 米。
* 向量的模：向量的大小。
* 单位向量：大小为 1 的向量。
* 单位化，归一化：把向量转为单位向量的过程。

### 向量的运算：加法

* 比如向量 A 的点是(x1, y1)，B 的点是(x2, y2)，根据平行四边形的法则，最终的结果是(x1 + x2, y1 + y2) = (x3, y3)。

### 向量的运算：减法

* 比如向量 A 的点是(x1, y1)，B 的点是(x2, y2)，最终的结果是(x1 - x2, y1 - y2) = (x-1, y-1)。

### 向量的运算：乘法

* 乘法不会改变向量的方向，只会改变向量的长度。比如 A(x1, y1) * 2 点，最终的结果就是(x2, y2)。

### 向量的运算：点乘(得到两个向量之间的夹角)
θ(读音：xita)

* 比如 A x B = x1x2 + y1y2 = n = |A||B|cosθ(A 跟 B 的夹角) = cosθ, n = cosθ