package;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;

import sys.FileSystem;
#end
import haxe.io.Path;
import algorithms.*;
using StringTools;
/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
@:keep
@:expose
class AlgorithmFactory 
{
    public static inline var ALGPATH = 'source/algorithms';
    
    #if !macro
    public static var availivable:Array<String> = _build();
    #end
    //ExprOf<Map<String, Class<SortingAlgorithm>>>

    macro public static function _build():Expr
    {
        var path = Context.resolvePath(ALGPATH);
        var every:Array<String> = [];
        var files = FileSystem.readDirectory(path).length;
        trace(files + ' files in algorithms folder');
        for (entry in FileSystem.readDirectory(path))
        {
            var name = entry.split('.')[0];
            if (name == 'Template' || name == 'SortingAlgorithm') {
                continue;
            }
            
            var fullPath = name;
            
            trace('Adding Algorithm: $fullPath');
            every.push(fullPath);
            
        }
        return macro $v{every};
    }
    
    #if !macro
    public static function getAlgorithmClass(name:String):Class<SortingAlgorithm>
    {
        for (alg in availivable)
        {
            if (alg == name)
            {
                return cast Type.resolveClass(['algorithms', name].join('.'));
            }
        }
        
        return null;
    }
    #end
    
}