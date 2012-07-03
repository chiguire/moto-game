package gameplay
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.osflash.signals.Signal;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Enemy extends FlxSprite
	{
		[Embed(source="/assets/enemy.png")]
		public var enemyGraphic : Class;
		
		public var player : Player;
		
		public var position : FlxPoint;
		
		public var fireBullet : Signal;
		
		public function Enemy(X:Number=0, Y:Number=0)
		{
			super(X, Y, enemyGraphic);
			
			position = new FlxPoint(X, Y);
			fireBullet = new Signal(Enemy);
		}
		
		override public function update():void {
			FlxVelocity.moveTowardsObject(this, player, 20);
			
			this.position.x = x;
			this.position.y = y;
			
			if (FlxU.getDistance(position, player.position) < 150) {
				if (FlxMath.rand(0, 10000) >= 9900) {
					fireBullet.dispatch(this);
				}
			}
		}
		
		
		
	}
}