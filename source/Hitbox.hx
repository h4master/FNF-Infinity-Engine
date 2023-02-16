/*
я хотел использовать это в редакторе сцены, но передумал
если хотите - добавляйте, я не против
*/

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Hitbox extends FlxSpriteGroup
{
    var targetSprite:FlxSprite = null;

	public function new(spr:FlxSprite, clr:FlxColor = 0xFFFF0000, weight:Int = 3, invis:Bool = true)
	{
		super();
        targetSprite = spr;
        
        var up = new HitboxFrame(spr).makeGraphic(Std.int(spr.width), weight, clr);
		add(up);
		var right = new HitboxFrame(spr, spr.width - weight).makeGraphic(weight, Std.int(spr.height), clr);
		add(right);
		var down = new HitboxFrame(spr, 0, spr.height - weight).makeGraphic(Std.int(spr.width), weight, clr);
		add(down);
		var left = new HitboxFrame(spr).makeGraphic(weight, Std.int(spr.height), clr);
		add(left);

        if (invis) hide();
	}

    public function show()
    {
        for (frame in members)
            frame.visible = true;
    }

    public function hide()
    {
        for (frame in members)
            frame.visible = false;
    }

    override function update(elapsed:Float)
    {
        for (frame in members)
        {
            frame.x = targetSprite.x + frame.xAdd;
            frame.y = targetSprite.y + frame.yAdd;
        }
    }
}

class HitboxFrame extends FlxSprite
{
    var targetSprite:FlxSprite = null;
    public var xAdd:Float = 0;
    public var yAdd:Float = 0;

    public function new(target:FlxSprite, ?xAdd:Float = 0, ?xAdd:Float = 0)
    {
        super(target.x + xAdd, target.y + yAdd);
        targetSprite = target;
    }
}
