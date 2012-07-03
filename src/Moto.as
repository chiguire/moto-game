package {
	
	import org.flixel.*;
	
	[SWF(width="696", height="696", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 *  Required libraries (included): Flixel 2.5, as3signals
	 * 
	 *  Playing instructions: Use up/down to accelerate/decelerate. 
	 *                        Left/right to steer.
	 * 
	 *  Objective: Get emails that pop up in the middle of the field. Avoid 
	 *             enemies that shoot you on sight. Beware of portals that
	 *             might transport you anywhere in the world.
	 */
	public class Moto extends FlxGame {
		
		public function Moto() {
			super(174,174,MenuState,4);
			FlxG.debug = true;
		}
	}
}

