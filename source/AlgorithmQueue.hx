//package;
//
//import flash.display.InteractiveObject;
//import flixel.FlxSprite;
//import flixel.FlxObject;
//import flixel.system.FlxAssets.FlxGraphicAsset;
//import flixel.tweens.FlxTween;
//import ActionType;
//import flixel.util.FlxColor;
//import flixel.math.FlxRandom;
//import flixel.FlxG;
//import haxe.macro.Expr.ImportExpr;
//import haxe.macro.ExprTools.ExprArrayTools;
///**
 //* ...
 //* @author Andrzej
 //*/
//class AlgorithmQueue
//{
    //private static var codeMenu:CodeMenu;
    //private static var dataList:ItemList;
    //private static var queue:ActionQueue;
    //private static var MERGE_iterationCounter = 0;
    //private static var MERGE_depth = 0;
    //private static var QUICK_depth = -1;
    //public static function generateOperations(_data:ItemList, _codeMenu:CodeMenu):ActionQueue
    //{
        //dataList = _data;
        //codeMenu = _codeMenu;
        //queue = new ActionQueue();
        //return switch (Status.algorithm)
        //{
            //case AlgorithmType.BubbleSort:
                //bubbleSort();
            //case AlgorithmType.InsertionSort:
                //insertionSort();
            //case AlgorithmType.MergeSort:
                //mergeSort();
            //case AlgorithmType.QuickSort:
                //quickSort();
        //}
//
    //}
//
    ////T_SINGLE()
    ////T_MANY()
    ////queue.push(function() {
    ////  codeMenu.hilightLine(0);
    ////  return T_SINGLE(new Wait(0.5));
    ////});
    ////T_SINGLE -> dataList.setColorByItem(dataList.get(0), Status.doneColor)
    ////T_MANY -> dataList.swapItemsByItem(itemA, itemB)
//
//
//
   //
    //
//
    //static function Q_hilightLineAndWait(line:Int, waitTime:Float):Void->ActionType
    //{
        //return function()
        //{
            //codeMenu.hilightLine(line);
            //return T_SINGLE(new Wait(waitTime));
        //}
    //}
//
    //static function Q_setColorForItem(item:Item, colorType:FlxColor, waitTime:Float, colorSettingTime:Float ):Void->ActionType
    //{
        //return function()
        //{
            //return T_MANY([T_SINGLE(new Wait(waitTime)),
            //dataList.setColorForItem(item,colorType, colorSettingTime)]);
        //}
    //}
//
//}
//
//