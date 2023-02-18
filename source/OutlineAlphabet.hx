package;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Bitmap;
import flixel.util.FlxColor;

class OutlineAlphabet extends FlxTypedGroup<Dynamic>
{
    var source:TextField;
    var bitmap:Bitmap;

    public var text:String = "";

    public function new(x:Float = 0, y:Float = 0, text:String = "", size:Int = 14, color:FlxColor = 0xFFFFFFFF)
    {
        super();
        this.text = text;

        source = new TextField();
        source.x = x;
        source.y = y;
        source.defaultTextFormat = new TextFormat(
            Paths.font('outline.ttf'),
            size,
            color
        );
        add(source);
    }

    override function update(elapsed:Float)
    {
        remove(bitmap);
        source.text = text;
        source.visible = true;

        source.text = '$text.';
        bitmap = ImageOutline.renderImage(source, 2, 0x000000, 1);
        add(bitmap);
        source.visible = false;
    }
}
