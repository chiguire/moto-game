package gameplay
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Arrow extends FlxSprite
	{
		[Embed(source="/assets/destination-arrow.png")]
		public var arrow : Class;
		
		public var horizontalPadding : int = 3;
		public var verticalPadding : int = 3;
		
		public static const CENTER_POINT : FlxPoint = new FlxPoint();
		public static var VECTOR_LENGTH : Number = 0;
		
		public static const HORIZONTAL_PADDING : int = 20;
		public static const VERTICAL_PADDING : int = 20;
		
		public function Arrow()
		{
			super();
			
			loadRotatedGraphic(arrow, 16, -1, true, false);
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
		}
		
		public override function update():void {
			
			CENTER_POINT.x = FlxG.width/2;
			CENTER_POINT.y = FlxG.height/2;
			
			VECTOR_LENGTH = FlxMath.vectorLength(CENTER_POINT.x, CENTER_POINT.y);
			
			x = FlxU.bound(CENTER_POINT.x+(Math.cos(FlxMath.asRadians(this.angle))*VECTOR_LENGTH), HORIZONTAL_PADDING, FlxG.width - HORIZONTAL_PADDING)-HORIZONTAL_PADDING/2; 
			y = FlxU.bound(CENTER_POINT.y+(Math.sin(FlxMath.asRadians(this.angle))*VECTOR_LENGTH), VERTICAL_PADDING, FlxG.height - VERTICAL_PADDING)-VERTICAL_PADDING/2; 
		}
	}
}