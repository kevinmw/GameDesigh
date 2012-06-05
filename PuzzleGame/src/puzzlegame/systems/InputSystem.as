package puzzlegame.systems
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	
	import puzzlegame.GameData;
	import puzzlegame.components.GameComponentConst;
	import puzzlegame.components.GameState;
	import puzzlegame.graphics.BlockView;
	import puzzlegame.input.MouseInput;
	import puzzlegame.nodes.RenderNode;
	import puzzlegame.utils.PositionUtil;
	
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
		
		[Inject]
		public var gameState:GameState;
		
		[Inject]
		public var game:Game;
		
		[Inject(nodeType="puzzlegame.nodes.RenderNode")]
		public var nodes : NodeList;
		
		public function InputSystem()
		{
			super();
		}
		
		override public function update(time:Number):void
		{
//			return;
			//鼠标输入
			var touch:Touch = mouseInput.touch;
			if(gameState.state != GameComponentConst.BLOCKS_MOVEBLE) return;
			if(touch && touch.target is Image)
			{
//				if(touch.target is Image)
//					trace(mouseInput.touch);
				var view:BlockView = (touch.target as Image).parent as BlockView;
				/*if(touch.phase == TouchPhase.BEGAN)
				{
					trace("_________mouseDown", touch.getLocation(view), view.dump());
				}*/
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
					if(Math.abs(point.x)>40 || Math.abs(point.y)>40)
					{
						var direct:Point;
						if(point.x>40)
						{
							direct = new Point(1, 0);
						}else if(point.y>40){
							direct = new Point(0, 1);							
						}else if(point.x<-40){
							direct = new Point(-1, 0);							
						}else if(point.y<-40){
							direct = new Point(0, -1);							
						}
						blockTweens(getMotionBlocks(view, direct));
					}					
				}				
			}
			
			//键盘输入
		}
		
		private function blockTweens(vector:Vector.<BlockView>):void
		{
			var view0:BlockView = vector[0];
			var view1:BlockView = vector[1];
			if(!view0.isTweening)
			{
				var tween0:Tween = new Tween(view0, 0.5, Transitions.LINEAR);
				tween0.moveTo(view1.x, view1.y);
				view0.isTweening = true;
				tween0.onComplete = function ():void{
					view0.isTweening = false;
				}
			}
			if(!view1.isTweening)
			{
				var tween1:Tween = new Tween(view1, 0.5, Transitions.LINEAR);
				tween1.moveTo(view0.x, view0.y);
				view1.isTweening = true;
				tween1.onComplete = function ():void{
					view1.isTweening = false;
				}
			}	
			Starling.juggler.add(tween0);
			Starling.juggler.add(tween1);
		}
		
		/**
		 * 得到需要移动的方块
		 * @param view 第一个点击的方块
		 * @param direct 移动方向，类似point(0,1) point(-1,0)这样的运动向量
		 * @param isAll 是否整排移动，后续扩展道具使用
		 * @return 
		 * 
		 */		
		private function getMotionBlocks(view:BlockView, direct:Point, isAll:Boolean=false):Vector.<BlockView>
		{
			var bvector:Vector.<BlockView> = new Vector.<BlockView>;
			bvector.push(view);
			var targetPosition:Point = view.currPosition.add(direct);
			if(PositionUtil.checkPositioValid(targetPosition))
			{
				var targetView:BlockView = GameData.blockTypeArray2.get(targetPosition.x, targetPosition.y) as BlockView;
			}
			bvector.push(targetView);
			return bvector;
		}
		
		/**
		 * 方块消失
		 * @param view 要消失的方块
		 * 
		 */		
		private function destroy(view:BlockView):void
		{
			var time:uint = getTimer();
			var node:RenderNode;
			var displayObject : DisplayObject;
			for ( node = nodes.head; node; node = node.next )
			{
				if(node.display.displayObject == view)
				{
					game.removeEntity(node.entity);
				}
			}
			trace("endTime", getTimer()-time);
		}
	}
}