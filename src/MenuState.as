package {
	import org.flixel.*;	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class MenuState extends FlxState {		[Embed(source="assets/title.png")]		private var title : Class;		
		override public function create():void {			var g:FlxSprite = new FlxSprite(0, 0, title);			add(g);			
			var t:FlxText;
			t = new FlxText(20,FlxG.height-50,600,"Click to play");			t.size = 16;
			t.alignment = "center";
			add(t);			FlxG.mouse.show();
		}
		override public function update():void {
			super.update();
			if(FlxG.mouse.justPressed()) {
				FlxG.mouse.hide();
				FlxG.switchState(new PlayState());
			}
		}
	}
}
