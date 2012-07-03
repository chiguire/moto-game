package {

	import flash.utils.getTimer;
	
	import gameplay.Arrow;
	import gameplay.Bullet;
	import gameplay.Destination;
	import gameplay.Enemy;
	import gameplay.Minimap;
	import gameplay.Player;
	import gameplay.Portal;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;

	/**
	 *  Moto.as
	 * 
	 *  Created by: Ciro Durán <ciro@elchiguireliterario.com>
	 *  Date: August 14th, 2011.
	 */
	public class PlayState extends FlxState {
		
		public static const X_OUTERBOUND : uint = 12000;
		public static const Y_OUTERBOUND : uint = 12000;
		
		public static const X_INNERBOUND : uint = 3*60;
		public static const Y_INNERBOUND : uint = 3*60;
		
		public static var elapsedTime:Number = 0;
		private static var lastTime:uint = 0
		
		private var camera : FlxCamera;
		
		private var player : Player;
		
		private var arrow : Arrow;
		
		private var destinationPoint : FlxPoint;
		
		private var destination : Destination;
		
		private var portals : FlxGroup;
		private var enemies : FlxGroup;
		private var bullets : FlxGroup;
		
		private var score : int = 0;
		
		private var scoreText : FlxText;
		
		private var minimap : Minimap;
		
		private var deathDelay : FlxDelay;
		
		[Embed(source="/assets/map.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="/assets/grid.png")] public var Img_Group1Map1:Class;
		
		[Embed(source="/assets/snd/generate.mp3")]
		public var generateSound : Class;
		
		[Embed(source="/assets/snd/pickup.mp3")]
		public var pickupSound : Class;
		
		[Embed(source="/assets/snd/hit.mp3")]
		public var hitSound : Class;
		
		[Embed(source="/assets/snd/die.mp3")]
		public var dieSound : Class;
		
		public var map1:FlxTilemap;
		
		public function PlayState(): void {
			super();
		}
		
		override public function create():void {
			
			map1 = new FlxTilemap();
			map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 60,60, FlxTilemap.OFF, 0, 0, 1 );
			map1.x = 0.000000;
			map1.y = 0.000000;
			map1.scrollFactor.x = 1.000000;
			map1.scrollFactor.y = 1.000000;
			add(map1);
			
			getDestination();
			
			destination = new Destination(destinationPoint.x, destinationPoint.y);
			add(destination);
			
			portals = new FlxGroup();
			for (var i : uint = 0; i != 150; i++) {
				var p1 : Portal = createPortal(X_INNERBOUND+Math.random()*(X_OUTERBOUND-2*X_INNERBOUND), Y_INNERBOUND+Math.random()*(Y_OUTERBOUND-2*Y_INNERBOUND), Math.floor(Math.random()*360));
				var p2 : Portal = createPortal(X_INNERBOUND+Math.random()*(X_OUTERBOUND-2*X_INNERBOUND), Y_INNERBOUND+Math.random()*(Y_OUTERBOUND-2*Y_INNERBOUND), Math.floor(Math.random()*360));
				Portal.link(p1, p2);
				portals.add(p1);
				portals.add(p2);
			}
			add(portals);
			
			player = new Player(6000, 6000);
			add(player);
			FlxG.play(generateSound, 1, false, true);
			
			bullets = new FlxGroup();
			add(bullets);
			
			enemies = new FlxGroup();
			for (i = 0; i != 50; i++) {
				var e : Enemy = new Enemy(X_INNERBOUND+Math.random()*(X_OUTERBOUND-2*X_INNERBOUND), Y_INNERBOUND+Math.random()*(Y_OUTERBOUND-2*Y_INNERBOUND));
				e.fireBullet.add(bulletFired);
				e.player = player;
				enemies.add(e);
			}
			add(enemies);
			
			arrow = new Arrow();
			add(arrow);
			
			scoreText = new FlxText(10, FlxG.height-16, 200, "Score: 0 / Health : "+player.health*100, true);
			scoreText.scrollFactor.x = 0;
			scoreText.scrollFactor.y = 0;
			add(scoreText);
			
			minimap = new Minimap(174-52, 2);
			minimap.player = player;
			minimap.portals = portals;
			minimap.destination = destinationPoint;
			minimap.enemies = enemies;
			add(minimap);
			
			player.nextDestination = destinationPoint;
			
			FlxG.watch(player.position, "x", "Player Position x: ");
			FlxG.watch(player.position, "y", "Player Position y: ");
			FlxG.watch(player, "destinationDistance");
			FlxG.watch(destination, "x", "Destination x: ");
			FlxG.watch(destination, "y", "Destination y: ");
			//FlxG.watch(arrow, "angle", "Destination angle: ");
			
			FlxG.worldBounds.width = 12000;
			FlxG.worldBounds.height = 12000;
			
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			camera.follow(player, FlxCamera.STYLE_LOCKON);
			
			deathDelay = new FlxDelay(5000);
			
			super.create();
		}
		
		private function getDestination() : FlxPoint {
			if (!Boolean(destinationPoint)) {
				destinationPoint = new FlxPoint();
			}
			
			destinationPoint.x = X_INNERBOUND+Math.random()*(X_OUTERBOUND-2*X_INNERBOUND);
			destinationPoint.y = Y_INNERBOUND+Math.random()*(Y_OUTERBOUND-2*Y_INNERBOUND);
			
			return destinationPoint;
		}
		
		private function createPortal(X:int, Y:int, angle:Number) : Portal {
			var p : Portal = new Portal(X, Y, angle);
			//trace("Creating portal at (", X, ", ",Y, ") angle: ", angle);
			return p;
		}
		
		private function bulletFired(e:Enemy) : void {
			trace("bullet fired");
			var b : Bullet = new Bullet(e.x+e.origin.x, e.y+e.origin.y);
			FlxVelocity.moveTowardsObject(b, player, 120);
			bullets.add(b);
		}
		
		private function notifyBullet(a:FlxObject, b:FlxObject) : void {
			if (a is Bullet) a.kill();
			if (b is Bullet) b.kill();
		}
		
		override public function update():void {
			super.update();
			
			var time:uint = getTimer();
			elapsedTime = (time - lastTime) / 1000;
			lastTime = time;
			
			//trace("Camera pos ("+camera.x+", "+camera.y+")");
			arrow.angle = FlxU.getAngle(player.position, destinationPoint)-90;
			//arrow.angle = FlxU.getAngle(player.position, new FlxPoint(portals[0].x, portals[0].y))-90;
				
			if (player.x < X_INNERBOUND) {
				player.x = X_OUTERBOUND - X_INNERBOUND;
			} else if (player.x > X_OUTERBOUND - X_INNERBOUND) {
				player.x = X_INNERBOUND;
			}
			
			if (player.y < Y_INNERBOUND) {
				player.y = Y_OUTERBOUND - Y_INNERBOUND;
			} else if (player.y > Y_OUTERBOUND - Y_INNERBOUND) {
				player.y = Y_INNERBOUND;
			}
			
			if (player.alive) {
				if (FlxG.overlap(player, destination)) {
					getDestination();
					destination.x = destinationPoint.x;
					destination.y = destinationPoint.y;
					
					FlxG.play(pickupSound, 1, false, true);
					
					score++;
					scoreText.text = "Score: "+score + " / Health : "+Math.floor(player.health*100);
				}
				
				if (FlxG.collide(player, enemies)) {
					if (!player.flickering) {
						FlxG.flash(0xff990000, 0.5);
						player.health -= 0.1;
						player.flicker(3);
						FlxG.play(hitSound);
						scoreText.text = "Score: "+score + " / Health : "+Math.floor(player.health*100);
					}
				}
				
				if (FlxG.collide(player, bullets, notifyBullet)) {
					if (!player.flickering) {
						FlxG.flash(0xff990000, 0.5);
						player.health -= 0.1;
						player.flicker(3);
						FlxG.play(hitSound);
						scoreText.text = "Score: "+score + " / Health : "+Math.floor(player.health*100);
					}
				}
				
				if (player.health <= 0.05) {
					player.kill();
					FlxG.play(dieSound);
					deathDelay.start();
				}
				
				FlxG.overlap(player, portals, Portal.notifyCollision, Portal.processCollision);
			}
			
			if (deathDelay.hasExpired) {
				FlxG.resetState();
			}
			
			FlxG.collide(enemies);
			
			if (FlxG.keys.pressed("ESCAPE")) {
				FlxG.switchState(new MenuState());
			}
			
		}
	}
}

