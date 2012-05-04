package
{
	import com.adobe.fms.events.PeerStatusEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="300", height="400")]	
	public class SharedMovements extends Sprite
	{
		
		private var game:P2PGame;
		private var txtLog:TextField
		private var txtUsers:TextField;
		
		private var myCursor:MyCursor;
		private var cursors:Object;
		
		private const SERVER:String = "rtmfp://p2p.rtmfp.net/";
		private const DEVKEY:String = "2a7a428602f7a3d0fbd8e6a7-ae76adcbc4b9";
		
		public function SharedMovements()
		{
			/*stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;*/
			
			initLog();
			init();
			
			Logger.log("init");
			
		}
		
		private function init():void{
			
			game = new P2PGame(SERVER+DEVKEY);
			game.addEventListener(Event.CONNECT, onGameConnect);
			game.addEventListener(Event.CHANGE, onUsersChange);
			
			var usr:String = "user"+(Math.round(Math.random()*1000));
			Logger.log(usr);
			game.connect(usr);
			
		}
		
		private function initLog():void{
			if(Logger.txtArea==null){
				// text field log
				txtLog = new TextField();
				txtLog.x = 300-120;
				txtLog.y = 10;
				txtLog.width = 120;
				txtLog.height = 380;
				txtLog.border = false;
				txtLog.borderColor = 0xFFFFFF;
				txtLog.defaultTextFormat = new TextFormat("Tahoma", 9, 0x999999); 
				txtLog.wordWrap = true;
				txtLog.selectable = false;
				addChild(txtLog);
				
				Logger.txtArea = txtLog;
			}
			
			// text field users
			txtUsers = new TextField();
			txtUsers.x = 10;
			txtUsers.y = 10;
			txtUsers.width = 70;
			txtUsers.height = 300;
			txtUsers.border = false;
			txtUsers.selectable = false
			txtUsers.borderColor = 0xFFFFFF;
			txtUsers.wordWrap = true;
			txtUsers.defaultTextFormat = new TextFormat("Tahoma", 9, 0xAAAAAA); 
			
			addChild(txtUsers);
		}
		
private function onGameConnect(event:Event):void{
Logger.log("onGameConnect");

game.session.mainChat.addEventListener(PeerStatusEvent.USER_ADDED, onUserAdded);
game.session.mainChat.addEventListener(PeerStatusEvent.USER_REMOVED, onUserRemoved);

cursors = new Object();

stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
game.setReceiveMousePositionCallback(onReceiveMousePosition);


}
		
private function onUsersChange(event:Event):void{
txtUsers.text = "Users: \n"+game.session.mainChat.userNamesString;

for each(var user:Object in game.session.mainChat.userList){
	addCursor(user)
}			
}
		
		private function onUserAdded(event:PeerStatusEvent):void{
			addCursor(event.info);
		}
		
		private function onUserRemoved(event:PeerStatusEvent):void{
			delete cursors[event.info.id];
		}
		
		private function addCursor(user:Object):void{
			if(user.id != game.session.myUser.id){
				if(cursors[user.id]==null){
					var cursor:MyCursor = new MyCursor();
					cursor.user = user;
					cursors[user.id] = cursor;
					
					addChild(cursor);
				
				}
			}
		}
		
		protected function onMouseMove(event:MouseEvent):void{
			//trace(event.stageX + ", " + event.stageY);
			
			game.sendMousePositions(this.mouseX, this.mouseY);
			
		}
		
		protected function onReceiveMousePosition(peerID:String,x:uint,y:uint):void{
			
			var cur:MyCursor = cursors[peerID];
			if(cur!=null){				
				// easing
				cur.destX = x;
				cur.destY = y;
			}
		}
	}
}