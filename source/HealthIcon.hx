package;

import flixel.FlxSprite;
import flash.display.BlendMode;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			switch(char)
			{
				case 'fliqpy':
					var name:String = 'icons/' + char;
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
					var file:Dynamic = Paths.image(name);
		
					loadGraphic(file); //Load stupidly first for getting the file size
					loadGraphic(file, true, Math.floor(width / 1), Math.floor(height)); //Then load it fr
					iconOffsets[0] = (width - 150) / 1;
					iconOffsets[1] = (width - 150) / 1;
					updateHitbox();
		
					animation.add("losing", [1], 0, false, isPlayer);
				    animation.add("idle", [0], 0, false, isPlayer);
				    animation.play("idle");
					animation.play(char);
					this.char = char;
		
					antialiasing = ClientPrefs.globalAntialiasing;
				case 'fliqpy-crazy':
					frames = Paths.getSparrowAtlas('icons/anim-mads');

					blend = BlendMode.SHADER;

				    animation.addByPrefix("losing", "crazy_loss", 28, true, isPlayer);
				    animation.addByPrefix("idle", "crazy_idle", 24, true, isPlayer);
				    animation.play("idle");
				    this.char = char;

				    updateHitbox();

				    antialiasing = ClientPrefs.globalAntialiasing;
				case 'fliqpy-psych':
					frames = Paths.getSparrowAtlas('icons/anim-mads');

					blend = BlendMode.SHADER;

				    animation.addByPrefix("losing", "psycho_idle", 28, true, isPlayer);
				    animation.addByPrefix("idle", "psycho_idle", 28, true, isPlayer);
				    animation.play("idle");
				    this.char = char;

				    updateHitbox();

				    antialiasing = ClientPrefs.globalAntialiasing;
				case 'flippy':
					var name:String = 'icons/' + char;
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
					var file:Dynamic = Paths.image(name);
		
					loadGraphic(file); //Load stupidly first for getting the file size
					loadGraphic(file, true, Math.floor(width / 1), Math.floor(height)); //Then load it fr
					iconOffsets[0] = (width - 150) / 1;
					iconOffsets[1] = (width - 150) / 1;
					updateHitbox();
		
					animation.add("losing", [1], 0, false, isPlayer);
				    animation.add("idle", [0], 0, false, isPlayer);
				    animation.play("idle");
					this.char = char;
		
					antialiasing = ClientPrefs.globalAntialiasing;
				default:
					var name:String = 'icons/' + char;
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
					var file:Dynamic = Paths.image(name);
		
					loadGraphic(file); //Load stupidly first for getting the file size
					loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr
					iconOffsets[0] = (width - 150) / 2;
					iconOffsets[1] = (width - 150) / 2;
					updateHitbox();
		
					animation.add("losing", [1], 0, false, isPlayer);
				    animation.add("idle", [0], 0, false, isPlayer);
				    animation.play("idle");
					this.char = char;
		
					antialiasing = ClientPrefs.globalAntialiasing;
					if(char.endsWith('-pixel')) {
						antialiasing = false;
					}
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();

		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
