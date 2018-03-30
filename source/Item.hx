package;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */

@:forward
abstract Item(ItemImpl) from ItemImpl to ItemImpl
{

    public inline function new(s:ItemImpl)
    {
        this = s;
    }
    
    @:op(A > B) 
    public static inline function gt(a:Item, b:Item):Bool
    {
        return a.value > b.value;
    }
    
    @:op(A < B)
    public static inline function lt(a:Item, b:Item):Bool
    {
        return a.value < b.value;
    }
    @:op(A <= B)
    public static inline function eq(a:Item, b:Item):Bool
    {
        return a.value <= b.value;
    }
    //@:op(A >= B)
    //public static inline function eq(a:Item, b:Item):Bool
    //{
        //return a.value >= b.value;
    //}
    //@:op(A == B)
    //public static inline function eq(a:Item, b:Item):Bool
    //{
        //return a.value == b.value;
    //}
    //@:op(A != B)
    //public static inline function eq(a:Item, b:Item):Bool
    //{
        //return a.value != b.value;
    //}
}