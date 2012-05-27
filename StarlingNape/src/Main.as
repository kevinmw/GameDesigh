package
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		[Embed(source="back.png")]
		private var back:Class;
		
		private var space:Space;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(event:Event):void
		{
			addChild(Image.fromBitmap(new back()));
			
			space = new Space(new Vec2(0, 800));
			
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(0, stage.stageHeight, stage.stageWidth, 20)));
			floor.shapes.add(new Polygon(Polygon.rect(0, 0, -10, stage.stageHeight)));
			floor.shapes.add(new Polygon(Polygon.rect(stage.stageWidth, 0, 10, stage.stageHeight)));
			floor.space = space;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(event:Event):void
		{
			space.step(1/60);
			
			if(Math.random() < 0.03)
				addBall();
		}
		
		private function addBall():void
		{
			var ball:Body = new Body(null, new Vec2(Math.random()*700, 100));
			ball.shapes.add(new Circle(51.5, null, new Material(20)));
			ball.space = space;
			ball.graphic = new BasketBall();
			ball.graphicUpdate = updateGraphics;
			addChild(ball.graphic);
		}
		
		private function updateGraphics(b:Body):void
		{
			trace(b.position.x, b.position.y, b.rotation);
			b.graphic.x = b.position.x;
			b.graphic.y = b.position.y;
			b.graphic.rotation = b.rotation;
		}
	}
}