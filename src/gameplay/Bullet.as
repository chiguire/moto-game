package gameplay
{
	import org.flixel.FlxSprite;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source="/assets/fire.png")]
		public var fireGraphic : Class;
		
		public var time : Number;
		public static const MAX_TIME : Number = 1000;
		
		public function Bullet(X:Number=0, Y:Number=0)
		{
			super(X, Y, fireGraphic);
			time = 0;
		}
		
		public override function update():void {
			super.update();
			
			time++;
			
			if (time >= MAX_TIME) {
				this.kill();
			}
		}
	}
}