package starling_demos
{
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    import xface.XFace;
    public class StarlingDemoBase
    {
        [Inject]
        public var root:DisplayObjectContainer;
        [Inject]
        public var starling:Starling;

        [Before]
        public function setUp():void
        {
            XFace.addLabel(getTopLabel());
        }

        protected function getTopLabel():String
        {
            return "This is part of the official demo collection ( http://Starling-Framework.org/demo/index.html ).";
        }

        protected function display(child:DisplayObject, x:Number = 0, y:Number = 0):void
        {
            child.x = x;
            child.y = y;
            root.addChild(child);
        }
    }
}