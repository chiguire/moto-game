package gameplay
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Portal extends FlxSprite
	{
		[Embed(source="/assets/portal.png")]
		public var portalGraphic : Class;
		
		[Embed(source="/assets/snd/boot.mp3")]
		public static var bootSound : Class;
		
		[Embed(source="/assets/snd/portal.mp3")]
		public static var portalSound : Class;
		
		public var destination : Portal;
		
		public static const FRAME_DISTANCE : int = 42;
		
		public var position : FlxPoint;
		
		public function Portal(X:int = 0, Y:int = 0, angle:int = 0)
		{
			super(X, Y, null);
			loadRotatedGraphic(portalGraphic, 32, -1, true, false);
			
			position = new FlxPoint(X, Y);
			this.angle = angle;
		}
		
		public static function processCollision(a:*, b:*) : Boolean {
			var player : Player;
			var portal : Portal;
			
			if (a is Player && b is Portal) {
				portal = b;
				player = a;
			} else {
				return false;
			}
			
			var distance : Number = FlxU.getDistance(player.position, portal.position);
			
			var result : Boolean = distance < FRAME_DISTANCE/1.5;
			
			return result;
		}
		
		public static const EXIT_VECTOR : FlxPoint = new FlxPoint(0, 5);
		
		public static function notifyCollision(a:*, b:*) : void {
			var player : Player;
			var portal : Portal;
			
			if (a is Player && b is Portal && !a.justPortalled) {
				portal = b;
				player = a;
			} else {
				return;
			}
			
			var dest : Portal = portal.destination;
			
			var angleDifference : Number = portal.angle - player.angle;
			angleDifference = (3600000 + angleDifference)%360;
			trace("Angle difference is "+angleDifference);
			
			if (angleDifference >= 30 && angleDifference <= 150) {
				trace("Portalling");
				FlxU.rotatePoint(0, FRAME_DISTANCE/2+10, 0, 0, dest.angle+angleDifference, EXIT_VECTOR);
				
				player.angle = dest.angle+angleDifference;
				player.x = dest.x + EXIT_VECTOR.x;
				player.y = dest.y + EXIT_VECTOR.y;
				FlxG.flash(0x990000, 0.2);
				
				FlxG.play(portalSound, 1, false, true);
			} else {
				trace("Booted");
				player.angle += 180;
				
				FlxU.rotatePoint(0, 3, 0, 0, player.angle, EXIT_VECTOR);
				
				player.x = player.x + EXIT_VECTOR.x;
				player.y = player.y + EXIT_VECTOR.y;
				
				FlxG.shake(0.05, 0.1);
				
				FlxG.play(bootSound, 1, false, true);
			}
			player.justPortalled = true;
		}
		
		public static function link(p1:Portal, p2:Portal) : void {
			p1.destination = p2;
			p2.destination = p1;
		}
	}
}