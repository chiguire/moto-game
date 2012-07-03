package gameplay
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Minimap extends FlxSprite
	{
		public var player : Player;
		public var portals : FlxGroup;
		public var enemies : FlxGroup;
		public var destination : FlxPoint;
		
		public static const BACKGROUND : int = 0x99110000;
		public static const BORDER : int = 0x99330000;
		public static const PLAYER : int = 0xffffffff;
		public static const PORTAL : int = 0xff660000;
		public static const DESTINATION : int = 0xffff6600;
		public static const ENEMY : int = 0xff660000;
		
		public static const OFFSET : Number = 3*60; 
		public static const RATIO : Number = 50/(194*60);
		
		public static const SEE_PORTALS : Boolean = false;
		public static const SEE_ENEMIES : Boolean = true;
		
		public function Minimap(X:Number=0, Y:Number=0)
		{
			super(X, Y);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			makeGraphic(50, 50, BACKGROUND, true, "minimap");
			solid = false;
		}
		
		override public function draw():void {
			super.draw();
			
			fill(BACKGROUND);
			drawLine(0,  0,  49,  0, BORDER, 1);
			drawLine(49, 0,  49, 49, BORDER, 1);
			drawLine(49, 49,  0, 49, BORDER, 1);
			drawLine(0,  49,  0,  0, BORDER, 1);
			
			if (SEE_PORTALS) {
				for each (var m : Portal in portals.members) {
					pixels.setPixel(tr(m.x), tr(m.y), PORTAL);
				}
			}
			
			if (SEE_ENEMIES) {
				for each (var e : Enemy in enemies.members) {
					pixels.setPixel(tr(e.x), tr(e.y), ENEMY);
				}
			}
			
			pixels.setPixel(tr(player.x), tr(player.y), PLAYER);
			pixels.setPixel(tr(destination.x), tr(destination.y), DESTINATION);
		}
		
		private function tr(value:Number) : Number {
			return (value-OFFSET)*RATIO;
		}
	}
}