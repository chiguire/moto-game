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
	public class Player extends FlxSprite
	{
		[Embed(source="/assets/moto.png")]
		public var playerSprite : Class;
		
		public var polarVelocity : Number;
		
		public var position : FlxPoint;
		
		public var nextDestination : FlxPoint;
		
		public var justPortalled : Boolean;
		
		public function Player(X:Number=0, Y:Number=0)
		{
			super(X, Y, null);
			
			polarVelocity = 0;
			
			position = new FlxPoint(X, Y);
			
			loadRotatedGraphic(playerSprite, 32, -1,true, false);
			
			justPortalled = false;
		}
		
		override public function update() : void {
			if (FlxG.keys.LEFT) {
				angle -= 1*FlxU.bound(polarVelocity, 0, 10)/10;
			} else if (FlxG.keys.RIGHT) {
				angle += 1*FlxU.bound(polarVelocity, 0, 10)/10;
			}
			
			if (FlxG.keys.UP) {
				polarVelocity = FlxU.bound(polarVelocity+2, 0, 300);
			} else if (FlxG.keys.DOWN) {
				polarVelocity = FlxU.bound(polarVelocity-4, 0, 300);
			}
			
			FlxU.rotatePoint(0, polarVelocity, 0, 0, angle, velocity);
			
			position.x = x;
			position.y = y;
			
			//trace("Position ("+x+", "+y+")");
			super.update();
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			justPortalled = false;
		}
		
		public function get destinationDistance() : Number {
			return FlxU.getDistance(this.position, this.nextDestination);
		}
	}
}