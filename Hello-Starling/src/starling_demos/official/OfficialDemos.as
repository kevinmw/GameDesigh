package starling_demos.official
{
    [Suite(label="< starling-framework.org >")]
    public class OfficialDemos
    {
        public static function suite():Array
        {
            return [
                TextureDemo,
                TouchDemo,
                TextDemo,
                AnimationDemo,
                CustomHitTestDemo,
                MovieDemo,
                BenchmarkDemo,
                RenderTextureDemo,
            ];
        }
    }
}