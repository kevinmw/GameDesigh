package puzzlegame.systems
{
	import flash.geom.Point;
	
	import net.richardlord.ash.core.System;
	
	import puzzlegame.graphics.BlockView;
	import puzzlegame.input.MouseInput;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	/**
	 * 鼠标键盘的输入控制系统
	 * @author Kevin Ni
	 * 
	 */	
	public class InputSystem extends System
	{
		[Inject]
		public var mouseInput:MouseInput;
		
		public function InputSystem()
		{
			super();
		}
		
		override public function update(time:Number):void
		{
//			return;
			//鼠标输入
			var touch:Touch = mouseInput.touch;
			if(touch && touch.target is Image)
			{
//				if(touch.target is Image)
//					trace(mouseInput.touch);
				var view:BlockView = (touch.target as Image).parent as BlockView;
				if(touch.phase == TouchPhase.ENDED)
				{
					//					trace(e.currentTarget, e.target);
					view.addFrame();
				}
				if(touch.phase == TouchPhase.MOVED)
				{
					//				trace((e.target as Image).name);
					//				((e.target as Image).parent as BlockView).addFrame();
					//				trace(touch.getMovement(e.target as Image));
					var point:Point = touch.getLocation(view);
					trace(point);
					trace(touch.getMovement(view));
					trace(touch.getPreviousLocation(view));
					trace("--------------");
					if(!view.isTweening)
					{
						var tween:Tween = new Tween(view, 0.5, Transitions.LINEAR);
						tween.moveTo(view.x+point.x, view.y+point.y);
						view.isTweening = true;
						tween.onComplete = function ():void{
							view.isTweening = false;
						}
					}
					
					Starling.juggler.add(tween);
				}				
			}
			
			//键盘输入
		}
	}
}