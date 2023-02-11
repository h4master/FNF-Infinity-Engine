package newoptions;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.util.FlxColor;

class Option extends FlxTypedGroup<Dynamic>;
{
    private var bitmap:Bitmap;
    private var option:TextField;
    public var description:String = "";
    
    public function new() {
        super();

        option = new TextField();
        option.defaultTextFormat = new TextFormat(
            Paths.font('options.ttf'),
            35,
            FlxColor.WHITE
        )
        add(option);
        display = updateDisplay();

        bitmap = ImageOutline.renderImage(this, 1, 0x000000, 1, true);
        add(bitmap);
    }

    public function update(elapsed:Float) {
        option.text = "";
    }

    public function press() {
    }

    public function left() {
    }

    public function right() {
    }

    private #if !flash override #end function __enterFrame(deltaTime:Float):Void {
        update(deltaTime);
    }
}

