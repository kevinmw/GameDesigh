package 
{
	import com.junkbyte.console.Cc;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	/**
	 * ...
	 * @author focus | http://blog.codestage.ru
	 */
	public class MainNape extends Sprite 
	{
		private var space:Space;
		private var hand:PivotJoint;
		
		private function _enableCC(parent:DisplayObjectContainer, debug:Boolean = true):void
		{
			if (parent)
			{
				Cc.config.commandLineAllowed = debug;
				Cc.config.commandLineAutoScope = true;
				Cc.config.defaultStackDepth = 10;
				Cc.config.displayRollerEnabled = debug;
				Cc.config.maxRepeats = -1;
				if (debug) Cc.config.objectHardReferenceTimer = 120;
				Cc.config.sharedObjectName = 'com.junkbyte/Console/UserData/focus';
				Cc.config.tracing = false;
				Cc.config.useObjectLinking = debug;
				
				Cc.config.style.backgroundAlpha = 0.8;
				Cc.config.style.backgroundColor = 0x101010;
				Cc.config.style.panelSnapping = 10;
				Cc.config.style.roundBorder = 0;
				
				Cc.startOnStage(parent);
				
				Cc.fpsMonitor = debug;
				Cc.memoryMonitor = debug;
				Cc.remoting = false;
				Cc.commandLine = debug;
				Cc.width = 600;
				Cc.height = 100;
				Cc.listenUncaughtErrors(this.loaderInfo);
				if (debug) Cc.setRollerCaptureKey('s', false, true, false);
			}
		}
		
		public function MainNape():void 
		{
			_enableCC(this);
			
			Cc.instance.panels.mainPanel.visible = false;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener(Event.ACTIVATE, activate);
			stage.quality = StageQuality.LOW;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
//			new Boot();
			
			// touch or gesture?
//			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
		}
		
		private function deactivate(e:Event):void 
		{
			stage.removeEventListener(Event.DEACTIVATE, deactivate);
			// auto-close
//			NativeApplication.nativeApplication.exit();
		}
		
		private function activate(e:Event):void 
		{
			stage.removeEventListener(Event.ACTIVATE, activate);
			
			space = new Space(new Vec2(0,100));
			
			this.mouseEnabled = false;
			
			var border:Body = new Body(BodyType.STATIC);
			
			border.shapes.add(new Polygon(Polygon.rect(0, stage.stageHeight, stage.stageWidth, 10)));
			border.shapes.add(new Polygon(Polygon.rect(0, 0, -10, stage.stageHeight)));
			border.shapes.add(new Polygon(Polygon.rect(stage.stageWidth, 0, 10, stage.stageHeight)));
			
			border.space = space;
			
			var len:uint = 100;
			var i:uint;
			
			for (i=0; i < len; i++ )
			{
				var b:Sprite = new Sprite();
				b.graphics.beginFill(0x00FF00);
				b.graphics.drawRect(-10, -10, 20, 20);
				b.graphics.endFill();
				
				
				var box:Body = new Body();
				box.position.setxy(50 + Math.random() * (stage.stageWidth-100), Math.random() * (stage.stageHeight - 50));
				
				var square:Polygon = new Polygon(Polygon.box(20, 20));
				square.body = box;
				
				box.graphic = b;
				box.space = space;
				
				this.addChild(b);
			}
			
			hand = new PivotJoint(space.world,space.world,new Vec2(), new Vec2());
			hand.active = false;
            hand.space = space;
			
            //soften
            hand.stiff = false;
            hand.frequency = 4;
            hand.maxForce = 60000;
				
			stage.addEventListener(Event.ENTER_FRAME, _mainLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}
		
		private function _mainLoop(event:Event):void
		{
			space.step(1 / stage.frameRate,6,6);
			
			if (hand.active)
			{
				hand.anchor1.setxy(stage.mouseX, stage.mouseY);
			}
		}
		
		private function _onMouseDown(e:MouseEvent):void 
		{
			var mouse:Vec2 = new Vec2(e.stageX, e.stageY);
			var bodies:BodyList = space.bodiesUnderPoint(mouse);
			var grab:Body = null;
			
			var len:uint = bodies.length;
			var i:uint;
			
			hand.anchor1.setxy(stage.mouseX, stage.mouseY);
			
			for (i=0; i < len; i++ )
			{
				var b:Body = bodies.at(i);
				
				if (!b.isDynamic()) continue;
				
				grab = b;
				break;
			}
			
			if (grab)
			{
				hand.body2 = grab;
				hand.anchor2 = grab.worldToLocal(mouse);
				hand.active = true;
			}
		}
		
		private function _onMouseUp(e:MouseEvent):void 
		{
			hand.active = false;
		}
	}
}