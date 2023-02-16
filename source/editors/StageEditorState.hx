package editors;

// Sprite control
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

import flixel.FlxCamera;
#if desktop
import Discord.DiscordClient;
#end

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
    var camEditor:FlxCamera;
    
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
    var texInputText:FlxUIInputText;

    var defaultCharacterOffsets:Array<Array<Float>> = [
        [400, 130], // gf
        [100, 100], // dad
        [770, 100] // boyfriend
    ];
    var gfOffsets:Array<Float> = [0, 0];
    var dadOffsets:Array<Float> = [0, 0];
    var boyfriendOffsets:Array<Float> = [0, 350];

    override function create()
    {
        FlxG.mouse.visible = true;

        #if desktop
        DiscordClient.changePresence("In Stage Editor", null);
        #end

        camEditor = new FlxCamera();
        camEditor.bgColor.alpha = 0;
        FlxG.cameras.add(camEditor, false);

        camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);
        FlxG.camera.follow(camFollow);

        var gf = new StageSprite();
        gf.tag = 'gf';
        gf.x = defaultCharacterOffsets[0][0] + gfOffsets[0];
        gf.y = defaultCharacterOffsets[0][1] + gfOffsets[1];
        gf.frames = Paths.getSparrowAtlas('characters/GF_assets');
        gf.animation.addByIndices('idle', 'GF Dancing Beat', [0], '');
        gf.animation.play('idle');
        gf.scrollFactor.set(0.95, 0.95);
        addSprite(gf);

        var dad = new StageSprite();
        dad.tag = 'dad';
        dad.x = defaultCharacterOffsets[1][0] + dadOffsets[0];
        dad.y = defaultCharacterOffsets[1][1] + dadOffsets[1];
        dad.frames = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
        dad.animation.addByIndices('idle', 'Dad idle dance', [0], '');
        dad.animation.play('idle');
        addSprite(dad);

        var boyfriend = new StageSprite();
        boyfriend.tag = 'boyfriend';
        boyfriend.x = defaultCharacterOffsets[2][0] + boyfriendOffsets[0];
        boyfriend.y = defaultCharacterOffsets[2][1] + boyfriendOffsets[1];
        boyfriend.frames = Paths.getSparrowAtlas('characters/BOYFRIEND');
        boyfriend.animation.addByIndices('idle', 'BF idle dance', [0], '');
        boyfriend.animation.play('idle');
        addSprite(boyfriend);

        var tabs = [
			{name: 'Sprites', label: 'Sprites'}
		];

		UI_box = new FlxUITabMenu(null, tabs, true);
		UI_box.resize(250, FlxG.height / 6);
		UI_box.x = FlxG.width - UI_box.width - 25;
		UI_box.y = FlxG.height - UI_box.height - 25;
		UI_box.scrollFactor.set();
        UI_box.cameras = [camEditor];
		add(UI_box);
        addSpriteUI();

        FlxG.camera.zoom = 1;
    }

    function addSpriteUI()
    {
		var tab_group = new FlxUI(null, UI_box);
		tab_group.name = "Sprites";
        texInputText = new FlxUIInputText(15, 30, 200, '', 8);
        tab_group.add(new FlxText(15, texInputText.y - 18, 0, 'Sprite Texture:'));
        tab_group.add(texInputText);

		UI_box.addGroup(tab_group);
	}

    override function update(elapsed:Float)
    {
        spriteControl();

        typing = texInputText.hasFocus;

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

        var mos = FlxG.mouse;
        if (mos.x > texInputText.x && mos.x < (texInputText.x + texInputText.width) &&
            mos.y > texInputText.y && mos.y < (texInputText.y + texInputText.height))
        {
            if (mos.justPressed)
                texInputText.hasFocus = true;
        }
        else
        {
            if (mos.justPressed)
                texInputText.hasFocus = false;
        }

        if (FlxG.keys.justPressed.R)
        {
            if (lastSprite != null)
            {
                lastSprite.loadGraphic(Paths.image(texInputText.text));
                lastSprite.texture = texInputText.text;
            }
        }

        if ((FlxG.keys.justPressed.CONTROL && FlxG.keys.pressed.S) || (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.S) && !typing)
        {
            for (i in 0...sprites.length)
            {
                if (sprites[i].tag != 'gf' && sprites[i].tag != 'dad' && sprites[i].tag != 'boyfriend')
                    script += '
                        makeLuaSprite("sprite-$i", "' + sprites[i].texture + '", ' + sprites[i].x + ', ' + sprites[i].y + ')
                        setScrollFactor("sprite-$i", ' + sprites[i].scrollFactor.x + ', ' + sprites[i].scrollFactor.y + ')
                        scaleObject("sprite-$i", ' + sprites[i].scale.x + ', ' + sprites[i].scale.y + ')
                        addLuaSprite("sprite-$i") \n
                    ';
            }

            trace(script + "end");
        }

        if (FlxG.keys.justPressed.ESCAPE && !typing)
        {
            MusicBeatState.switchState(new editors.MasterEditorMenu());
            FlxG.sound.music.play(Paths.music('freakymenu'));
        }
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

        if (FlxG.keys.justPressed.N && !typing)
        {
            var sprite = new StageSprite();
            sprite.loadGraphic(Paths.image(texInputText.text));
            sprite.texture = texInputText.text;
            /*
            sprite.scale.x = scaleNumericStepper.value;
            sprite.scale.y = scaleNumericStepper.value;
            */
            addSprite(sprite);
        }
        
        if (holdSprite[0] != null)
        {
            var spr = holdSprite[0];

            spr.x = mos.x - holdSprite[1];
            spr.y = mos.y - holdSprite[2];

            switch(spr.tag)
            {
                case 'gf':
                    defaultCharacterOffsets[0] = [
                        spr.x + gfOffsets[0],
                        spr.y + gfOffsets[1]
                    ];
                case 'dad':
                    defaultCharacterOffsets[1] = [
                        spr.x + dadOffsets[0],
                        spr.y + dadOffsets[1]
                    ];
                case 'boyfriend':
                    defaultCharacterOffsets[2] = [
                        spr.x + boyfriendOffsets[0],
                        spr.y + boyfriendOffsets[1]
                    ];
            }

            if (FlxG.mouse.wheel != 0)
            {
                if (spr.tag != 'gf' && spr.tag != 'dad' && spr.tag != 'boyfriend')
                {
                    if (FlxG.keys.pressed.ALT && !typing)
                    {
                        spr.scrollFactor.x += (FlxG.mouse.wheel * 0.05);
                        spr.scrollFactor.y += (FlxG.mouse.wheel * 0.05);
                    }
                    else if (FlxG.keys.pressed.SHIFT)
                    {
                        changeSpriteOrder(spr, spr.order + FlxG.mouse.wheel);
                    }
                    else
                    {
                        spr.scale.x += (FlxG.mouse.wheel * 0.05);
                        spr.scale.y += (FlxG.mouse.wheel * 0.05);
                    }
                }

                spr.updateHitbox();
            }

            if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.S && !typing)
            {
                if (spr.tag != 'gf' && spr.tag != 'dad' && spr.tag != 'boyfriend')
                {
                    if (FlxG.keys.justPressed.W && !typing)
                    {
                        
                        if (FlxG.keys.pressed.ALT && !typing)
                        {
                            spr.scrollFactor.x += 0.1;
                            spr.scrollFactor.y += 0.1;
                        }
                        else if (FlxG.keys.pressed.SHIFT && !typing)
                            changeSpriteOrder(spr, spr.order + 1);
                        else
                        {
                            spr.scale.x += 0.1;
                            spr.scale.y += 0.1;
                        }
                    }
                    if (FlxG.keys.justPressed.S && !typing)
                    {
                        if (FlxG.keys.pressed.ALT && !typing)
                        {
                            spr.scrollFactor.x -= 0.1;
                            spr.scrollFactor.y -= 0.1;
                        }
                        else if (FlxG.keys.pressed.SHIFT && !typing)
                            changeSpriteOrder(spr, spr.order - 1);
                        else
                        {
                            spr.scale.x -= 0.1;
                            spr.scale.y -= 0.1;
                        }
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

            if (FlxG.keys.justPressed.D)
                removeSprite(spr);
        }
    }

    function addSprite(spr:Dynamic)
    {
        trace('sprite added: ${spr.tag}');
        // add(spr);
        insert(StageSprite.curOrder, spr);
        sprites.push(spr);
    }

    function removeSprite(spr:Dynamic)
    {
        trace('sprite removed: ${spr.tag}');
        remove(spr);
        sprites.remove(spr);
    }

    function changeSpriteOrder(spr:Dynamic, order:Int)
    {
        if (order < 0) order = 0;
        trace('sprite ordered: ${spr.tag}, order: $order');
        remove(spr);
        insert(order, spr);
        spr.order = order;
    }
}

class StageSprite extends FlxSprite
{
    public var tag:String = "";
    public var texture:String = '';
    public var order:Int = 0;

    public static var curOrder:Int = 0;

    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
        curOrder += 1;
    }

    override function update(elapsed:Float) {
        antialiasing = ClientPrefs.globalAntialiasing;
    }
}
