class BuildData
{
    public static var curVersion:String = "0.1.0";

    private static var versions:Array<String> = [
        "0.0.6",
        "0.1.0"
    ];

    public static function checkVersion(type:String, needVersion:String):Bool
    {
        var curVerIndex:Int = 0;
        var needVerIndex:Int = 0;
        for (i in 0...versions.length)
        {
            if (versions[i] == curVersion)
                curVerIndex = i;
            else if (cersions[i] == needVersion)
                needVerIndex = i;
        }

        switch(type)
        {
            case '=':
                if (curVerIndex == needVerIndex)
                    return true;
            case '>':
                if (curVerIndex > needVerIndex)
                    return true;

            case '<':
                if (curVerIndex < needVerIndex)
                    return true;

            case '>=':
                if (curVerIndex >= needVerIndex)
                    return true;
            
            case '<=':
                if (curVerIndex <= needVerIndex)
                    return true;
        }

        return false;
    }
}