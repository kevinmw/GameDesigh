package
{
	import aerys.minko.render.Viewport;
	import aerys.minko.scene.controller.camera.ArcBallController;
	import aerys.minko.scene.node.Camera;
	import aerys.minko.scene.node.Scene;
	import aerys.monitor.Monitor;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class MinkoExampleApplication extends Sprite
	{
		private var _viewport			: Viewport			= new Viewport();
		private var _camera				: Camera			= null;
		private var _cameraController	: ArcBallController	= null;
		private var _scene				: Scene				= new Scene();
		
		private var _cursor				: Point				= new Point();
		
		protected function get viewport() : Viewport
		{
			return _viewport;
		}
		
		protected function get scene() : Scene
		{
			return _scene;
		}
		
		protected function get camera() : Camera
		{
			return _camera;
		}

		protected function get cameraController() : ArcBallController
		{
			return _cameraController;
		}
		
		public function MinkoExampleApplication()
		{
			if (stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(event : Event = null) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			addChild(_viewport);
			_viewport.backgroundColor = 0x666666ff;
			
			_camera = new Camera(_viewport);
			_camera.lookAt.set(0., 0., 0.);
			_camera.position.set(0., 0., -5.);
			
			_cameraController = new ArcBallController();
			_cameraController.bindDefaultControls(stage);
			_camera.addController(_cameraController);
			_scene.addChild(_camera);
			
			initializeScene();
			initializeUI();
			
			stage.addChild(Monitor.monitor.watch(_scene, ['numDescendants', 'numTriangles']));
			stage.frameRate = 60;
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		protected function initializeScene() : void
		{
			// nothing
		}
		
		protected function initializeUI() : void
		{
			// nothing
		}
		
		protected function enterFrameHandler(event : Event) : void
		{
			_scene.render(_viewport);
		}
	}
}