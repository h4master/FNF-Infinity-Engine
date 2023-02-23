package options;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import options.Option;
import flixel.util.FlxColor;

class OptionCata extends FlxSprite
{
	public var title:String;
	public var options:Array<Option>;

	public var optionObjects:FlxTypedGroup<FlxText>;

	public var titleObject:FlxText;

	public var middle:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		if (!middle)
			makeGraphic(295, 64, FlxColor.BLACK);
		alpha = 0.4;

		optionObjects = new FlxTypedGroup();

		titleObject = new FlxText((middle ? 1180 / 2 : x), y + (middle ? 0 : 16), 0, title);
		titleObject.setFormat(Paths.font("outline.ttf"), 35, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleObject.borderSize = 3;

		if (middle)
			titleObject.x = 50 + ((1180 / 2) - (titleObject.fieldWidth / 2));
		else
			titleObject.x += (width / 2) - (titleObject.fieldWidth / 2);

		titleObject.scrollFactor.set();

		scrollFactor.set();

		for (i in 0...options.length)
		{
			var opt = options[i];
			var text:FlxText = new FlxText((middle ? 1180 / 2 : 72), titleObject.y + 54 + (46 * i), 0, opt.getValue());
			if (middle) text.screenCenter(X);
			text.setFormat(Paths.font("outline.ttf"), 35, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.borderSize = 3;
			text.borderQuality = 1;
			text.scrollFactor.set();
			optionObjects.add(text);
		}
	}

	public function changeColor(color:FlxColor)
	{
		makeGraphic(295, 64, color);
	}

	public function addOption(option:Option) {
		if(options == null || options.length < 1) options = [];
		options.push(option);
	}
}
