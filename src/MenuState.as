package {
	import org.flixel.*;
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class MenuState extends FlxState {
		override public function create():void {
			var t:FlxText;
			t = new FlxText(20,FlxG.height-50,600,"Click to play");
			t.alignment = "center";
			add(t);
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