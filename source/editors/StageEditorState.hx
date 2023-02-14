package editors;

// Sprite control
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

// UI
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

class StageEditorState extends MusicBeatState
{
    var script:String = "function onCreatePost() \n";

    var camFollow:FlxObject;
    
    var holdSprite:Array<Dynamic> = [null, 0, 0]; // sprite, offsetX, offsetY
    var copySprite:StageSprite = null;

    var lastSprite:StageSprite = null;

    var typing:Bool = false;

    var sprites:Array<StageSprite> = [];

    // sprite shit
    var tag:String = "tag";
    var texture:String = "icons/icon-face";
    var x:Float = 0;
    var y:Float = 0;
    var scrollX:Float = 0;
    var scrollY:Float = 0;

    // ui
    var UI_box:FlxUITabMenu;
    
    var tagInputText:FlxUIInputText;
    var texInputText:FlxUIInputText;

    var xNumericStepper:FlxUINumericStepper;
    var yNumericStepper:FlxUINumericStepper;

    var scaleNumericStepper:FlxUINumericStepper;

    var scrollXNumericStepper:FlxUINumericStepper;
    var scrollYNumericStepper:FlxUINumericStepper;

    var spritesDropDownMenu:FlxUIDropDownMenuCustom; // Криптел, сделай ты, я не могу с этим разобраться

    override function create()
    {
        FlxG.mouse.visible = true;

        camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);
        FlxG.camera.follow(camFollow);
/*
        var tabs = [
			{name: 'Sprites', label: 'Sprites'}
		];

		UI_box = new FlxUITabMenu(null, tabs, true);
		UI_box.resize(250, FlxG.height / 2);
		UI_box.x = FlxG.width - UI_box.width - 25;
		UI_box.y = FlxG.height - UI_box.height - 25;
		UI_box.scrollFactor.set();
		add(UI_box);

        addSpriteUI();
*/
        FlxG.camera.zoom = 1;
    }

    function addSpriteUI()
    {
		var offsetX:Float = 15;
        
        var tab_group = new FlxUI(null, UI_box);
		tab_group.name = "Sprites";

        tagInputText = new FlxUIInputText(offsetX, 30, 200, 'sprite', 8);
/*
        var addSpriteButton:FlxButton = new FlxButton(texInputText.x + 210, texInputText.y - 3, "Add Sprite", function()
        {
            var spr:StageSprite = new StageSprite(xNumericStepper.value, yNumericStepper.value);
            spr.loadGraphic(Paths.image(texInputText.text));
            spr.lastScale = scaleNumericStepper.value;
            addSprite(spr);
        });
*/
        texInputText = new FlxUIInputText(offsetX, tagInputText.y + 35, 200, 'icons/icon-face', 8);
        var reloadImage:FlxButton = new FlxButton(texInputText.x + 210, texInputText.y - 3, "Reload Image", function() {
            if (lastSprite != null)
                lastSprite.loadGraphic(Paths.image(texInputText.text));
        });

        xNumericStepper = new FlxUINumericStepper(offsetX, texInputText.y + 35, 0.1, 4, 0, 9999, 1);
        yNumericStepper = new FlxUINumericStepper(xNumericStepper.x + 100, xNumericStepper.y, 0.1, 4, 0, 9999, 1);

        scaleNumericStepper = new FlxUINumericStepper(offsetX, yNumericStepper.y + 100, 0.1, 4, 0, 9999, 1);

        scrollXNumericStepper = new FlxUINumericStepper(offsetX, scaleNumericStepper.y + 35, 0.1, 4, 0, 9999, 1);
        scrollYNumericStepper = new FlxUINumericStepper(scrollXNumericStepper.x + 100, scrollXNumericStepper.y, 0.1, 4, 0, 9999, 1);

        tab_group.add(new FlxText(offsetX, tagInputText.y - 18, 0, 'Sprite Tag:'));
        tab_group.add(new FlxText(offsetX, texInputText.y - 18, 0, 'Sprite Texture:'));
        tab_group.add(new FlxText(offsetX, xNumericStepper.y - 18, 0, 'Sprite X:'));
        tab_group.add(new FlxText(yNumericStepper.x, yNumericStepper.y - 18, 0, 'Sprite Y:'));
        tab_group.add(new FlxText(offsetX, scaleNumericStepper.y - 18, 0, 'Sprite Scale:'));
        tab_group.add(new FlxText(offsetX, scrollXNumericStepper.y - 18, 0, 'Sprite Scroll X:'));
        tab_group.add(new FlxText(scrollYNumericStepper.x, scrollYNumericStepper.y - 18, 0, 'Sprite Scroll Y:'));

        tab_group.add(tagInputText);
        // tab_group.add(addSpriteButton);
        tab_group.add(texInputText);
        tab_group.add(xNumericStepper);
        tab_group.add(yNumericStepper);
        tab_group.add(scaleNumericStepper);
        tab_group.add(scrollXNumericStepper);
        tab_group.add(scrollYNumericStepper);

		UI_box.addGroup(tab_group);
	}

    override function update(elapsed:Float)
    {
        spriteControl();
/*
        typing = (
            tagInputText.hasFocus
            || texInputText.hasFocus
            || scaleNumericStepper.hasFocus 
        );
*/
        if ((FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L) && !typing)
		{
			var addToCam:Float = 500 * elapsed;
			if (FlxG.keys.pressed.SHIFT && !typing)
				addToCam *= 4;

			if (FlxG.keys.pressed.I && !typing)
				camFollow.y -= addToCam;
			else if (FlxG.keys.pressed.K && !typing)
				camFollow.y += addToCam;

			if (FlxG.keys.pressed.J && !typing)
				camFollow.x -= addToCam;
			else if (FlxG.keys.pressed.L && !typing)
				camFollow.x += addToCam;
		}

        if ((FlxG.keys.justPressed.CONTROL && FlxG.keys.pressed.S) || (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.S))
        {
            for (i in 0...sprites.length)
            {
                script += '
                    makeLuaSprite("sprite-$i", "' + sprites[i].texture + '", ' + sprites[i].x + ', ' + sprites[i].y + ')
                    setScrollFactor("sprite-$i", ' + sprites[i].scrollFactor.x + ', ' + sprites[i].scrollFactor.y + ')
                    scaleObject("sprite-$i", ' + sprites[i].lastScale + ', ' + sprites[i].lastScale + ')
                    addLuaSprite("sprite-$i") \n
                ';
            }

            trace(script + "end");
        }

        if (FlxG.keys.justPressed.ESCAPE && !typing)
            MusicBeatState.switchState(new editors.MasterEditorMenu());
    }

    function spriteControl()
    {
        var mos = FlxG.mouse;

        if (mos.justPressed)
        {
            holdSprite = [null, 0, 0];

            for (spr in sprites)
            {
                if (mos.x > spr.x && mos.x < (spr.x + spr.width) &&
                    mos.y > spr.y && mos.y < (spr.y + spr.height))
                {
                    holdSprite = [spr, (mos.x - spr.x), (mos.y - spr.y)];
                }
            }
        }
        if (mos.justReleased)
            holdSprite = [null, 0, 0];

        if (FlxG.keys.justPressed.N)
        {
            var sprite:StageSprite = new StageSprite();
            sprite.loadGraphic(Paths.image('icons/icon-face'));
            addSprite(sprite);
        }
        
        if (holdSprite[0] != null)
        {
            var spr = holdSprite[0];

            spr.x = mos.x - holdSprite[1];
            spr.y = mos.y - holdSprite[2];

            if (spr.x <= -spr.width)
                spr.x = 0;
            else if (spr.x >= FlxG.width + spr.width)
                spr.x = FlxG.width - spr.x;

            if (spr.y <= -spr.height)
                spr.y = 0;
            else if (spr.y >= FlxG.height + spr.height)
                spr.y = FlxG.height - spr.height;

            if (FlxG.mouse.wheel != 0)
            {
                if (FlxG.keys.pressed.ALT && !typing)
                {
                    spr.scrollFactor.x += (FlxG.mouse.wheel * 0.05);
                    spr.scrollFactor.y += (FlxG.mouse.wheel * 0.05);
                }
                else
                {
                    spr.lastScale += (FlxG.mouse.wheel * 0.05);
                }

                spr.updateHitbox();
            }

            if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.S && !typing)
            {
                if (FlxG.keys.justPressed.W && !typing)
                {
                    
                    if (FlxG.keys.pressed.ALT && !typing)
                        {
                        spr.scrollFactor.x += 0.1;
                        spr.scrollFactor.y += 0.1;
                    }
                    else
                    {
                        spr.lastScale += 0.1;
                    }
                }
                if (FlxG.keys.justPressed.S && !typing)
                {
                    if (FlxG.keys.pressed.ALT && !typing)
                    {
                        spr.scrollFactor.x -= 0.1;
                        spr.scrollFactor.y -= 0.1;
                    }
                    else
                    {
                        spr.lastScale -= 0.1;
                    }
                }

                spr.updateHitbox();
            }
            
            if (((FlxG.keys.justPressed.CONTROL && FlxG.keys.pressed.C) || (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.C)) && !typing)
            copySprite = holdSprite[0];

            if (((FlxG.keys.justPressed.CONTROL && FlxG.keys.pressed.V) || (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.V)) && !typing)
            {
                var spr = copySprite;
                if (!FlxG.keys.pressed.SHIFT && !typing)
                {
                    spr.x += (camFollow.x - spr.x);
                    spr.y += (camFollow.y - spr.y);
                }
                add(spr);
                sprites.push(spr);
            }
        }
    }

    function addSprite(spr:StageSprite)
    {
        trace('sprite added: ' + spr.tag);
        add(spr);
        sprites.push(spr);
    }

    function removeSprite(spr:StageSprite)
    {
        trace('sprite removed: ' + spr.tag);
        remove(spr);
        sprites.remove(spr);
    }
}

class StageSprite extends FlxSprite
{
    public var tag:String = "sprite";
    public var lastScale:Float = 1;
    public var texture:String = 'icons/icon-face';

    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
    }

    override function update(elapsed:Float)
    {
        scale.x = lastScale;
        scale.y = lastScale;
    }
}
