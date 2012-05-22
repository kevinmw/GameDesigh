package starling_demos
{
    import starling_demos.jamesli.JamesliDemos;
    import starling_demos.official.OfficialDemos;

    [Suite]
    public class AllStarlingDemos
    {
        public static function suite():Array
        {
            return [
                JamesliDemos,
                OfficialDemos,
            ];
        }
    }
}