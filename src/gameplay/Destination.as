package gameplay
{
	import org.flixel.FlxSprite;
	
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class Destination extends FlxSprite
	{
		[Embed(source="/assets/email.gif")]
		public var email : Class;
		
		public function Destination(X:Number=0, Y:Number=0)
		{
			super(X, Y, email);
		}
	}
}