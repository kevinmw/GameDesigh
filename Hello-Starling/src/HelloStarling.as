package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    import starling.core.Starling;

    [SWF(width="800", height="600", backgroundColor="0xFFFFFF", frameRate="60")]
    public class HelloStarling extends flash.display.Sprite
    {
        public function HelloStarling()
        {
            super();

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            var starling:Starling = new Starling(StarlingRoot, stage);
            starling.simulateMultitouch = true;
            starling.enableErrorChecking = true;
            starling.start();
        }
    }
}
import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.display.Sprite;
import starling.events.Event;

import starling_demos.AllStarlingDemos;

import xface.XFace;

internal class StarlingRoot extends starling.display.Sprite
{
    public function StarlingRoot()
    {
        super();
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        var starling:Starling = Starling.current;

        XFace.setSelectorTitle("Starling Demos");
        XFace.setUnitPostfix("Demo");

        XFace.mapInjection(starling);
        XFace.mapInjection(this, Sprite, DisplayObjectContainer);

        XFace.addTearDownMethods(removeChildren);

        XFace.run(starling.nativeStage, AllStarlingDemos, 200);
    }
}