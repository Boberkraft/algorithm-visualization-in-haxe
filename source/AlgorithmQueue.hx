package;

import flash.display.InteractiveObject;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import ItemList.PythonRange;
import flixel.tweens.FlxTween;
import ActionType;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.FlxG;
import haxe.macro.Expr.ImportExpr;
import haxe.macro.ExprTools.ExprArrayTools;
/**
 * ...
 * @author Andrzej
 */
class AlgorithmQueue
{
    private static var codeMenu:CodeMenu;
    private static var dataList:ItemList;
    private static var queue:ActionQueue;
    private static var MERGE_iterationCounter = 0;
    private static var MERGE_depth = 0;
    private static var QUICK_depth = -1;
    public static function generateOperations(_data:ItemList, _codeMenu:CodeMenu):ActionQueue
    {
        dataList = _data;
        codeMenu = _codeMenu;
        queue = new ActionQueue();
        return switch (Status.algorithm)
        {
            case AlgorithmType.BubbleSort:
                bubbleSort();
            case AlgorithmType.InsertionSort:
                insertionSort();
            case AlgorithmType.MergeSort:
                mergeSort();
            case AlgorithmType.QuickSort:
                quickSort();
        }

    }

    //T_SINGLE()
    //T_MANY()
    //queue.push(function() {
    //  codeMenu.hilightLine(0);
    //  return T_SINGLE(new Wait(0.5));
    //});
    //T_SINGLE -> dataList.setColorByItem(dataList.get(0), Status.doneColor)
    //T_MANY -> dataList.swapItemsByItem(itemA, itemB)

    private static function bubbleSort():ActionQueue
    {
        trace('Starting Bubble Sort');
        //
        var queue = new ActionQueue();
        var data:Array<Item> = dataList._ItemList;
        //
        var S_ColorSettingTime = 0.2;
        var S_MovingItemTime = 0.2;

        //for passnum in range(1, len(data)):
        //for i in range(0, len(data) - passnum):
        //print('range 0 to',format(len(data) - passnum))
        //if data[i] > data[i+1]:
        //data[i], data[i+1] = data[i+1], data[i]
        //data.swapItemsByIndex(0, 2);

        queue.push(Q_hilightLineAndWait(0, 0.5));

        for (passnum in new PythonRange(0, data.length))
        {
            queue.push(Q_hilightLineAndWait(1, 0.5));

            passnum += 1;
            for (i in new PythonRange(0, data.length - passnum))
            {
                var itemA:Item = dataList.get(i);
                var itemB:Item = dataList.get(i + 1);
                var lastItem = itemB;

                queue.push(function()
                {
                    codeMenu.hilightLine(2);
                    return T_MANY([
                        T_SINGLE(new Wait(0.5)),
                        dataList.setColorForItem(itemA, Status.pickColor, S_ColorSettingTime),
                        dataList.setColorForItem(itemB, Status.pickColor, S_ColorSettingTime)]);
                });

                if (itemA > itemB)
                {
                    var action:Void->ActionType = function()
                    {
                        trace('swaping $i and ${i+1}');
                        codeMenu.hilightLine(3);
                        return T_MANY([
                                          T_SINGLE(new Wait(0.5)),
                                          dataList.moveItemToIndex(itemA, i + 1, S_MovingItemTime),
                                          dataList.moveItemToIndex(itemB, i, S_MovingItemTime)]);
                    }
                    queue.push(action);
                    var temp = data[i];
                    data[i] = data[i + 1];
                    data[i + 1] = temp;

                    queue.push(Q_setColorForItem(itemB, Status.idleColor, 0, S_ColorSettingTime));
                    lastItem = itemA;
                }
                else
                {
                    queue.push(Q_setColorForItem(itemA, Status.idleColor, 0, S_ColorSettingTime));
                }
                if (i == data.length - passnum - 1)
                {
                    queue.push(Q_setColorForItem(lastItem,Status.doneColor, 0, S_ColorSettingTime));
                }
            }
        }
        // fix first element
        if (data.length > 0)

            queue.push(Q_setColorForItem(dataList.get(0), Status.doneColor, 0, S_ColorSettingTime));

        queue.push(function()
        {
            codeMenu.stopLineHilighting();
            return T_SINGLE(new Wait(0.1));
        });
        return queue;
    }
    private static function insertionSort():ActionQueue
    {
        trace('Starting Insertion Sort');
        //
        var queue = new ActionQueue();
        var data:Array<Item> = dataList._ItemList;
        //
        var S_ColorSettingTime = 0.2;
        var S_MovingItemTime = 0.2;

        // hilight line (for every element)
        queue.push(Q_hilightLineAndWait(0, 0.5));
        for (i in 0...data.length)
        {
            var offset:Int = i;
            var pickedItem:Item = dataList.get(i);

            //hilight line while (LewyElement < Element)

            if (i == 0)
            {
                queue.push(function ()
                {
                    codeMenu.hilightLine(1);
                    return T_MANY([T_SINGLE(new Wait(0.5)),
                    dataList.setColorForItem(pickedItem, Status.pickColor, S_ColorSettingTime)]);
                });
            }
            else
            {
                var leftItem = dataList.get(i - 1);
                queue.push(function ()
                {
                    codeMenu.hilightLine(1);
                    return T_MANY([T_SINGLE(new Wait(0.5)),
                                   dataList.setColorForItem(pickedItem, Status.pickColor, S_ColorSettingTime),
                                   dataList.setColorForItem(leftItem, Status.pickColorSecondary, S_ColorSettingTime)]);
                });
            }

            while (offset - 1 >= 0 && data[offset - 1] > data[offset])
            {
                var leftItem:Item = dataList.get(offset - 1);
                var rightItem:Item = dataList.get(offset);

                if (offset != i) // if it was hilighted at index i, dont do it again
                {
                    queue.push(function ()
                    {
                        codeMenu.hilightLine(2);
                        return T_MANY([T_SINGLE(new Wait(0.5)),
                                       dataList.setColorForItem(leftItem, Status.pickColorSecondary, S_ColorSettingTime)]);
                    });
                }

                // hilight swap()
                var index = offset;
                queue.push(function ()
                {
                    codeMenu.hilightLine(2);
                    return T_MANY([dataList.moveItemToIndex(leftItem, index, S_MovingItemTime),
                                   dataList.moveItemToIndex(rightItem, index - 1, S_MovingItemTime)]);
                });

                // hilight element = LeftElement
                queue.push(function ()
                {
                    codeMenu.hilightLine(3);
                    return T_MANY([T_SINGLE(new Wait(0.5)),
                                   dataList.setColorForItem(leftItem, Status.doneColor, S_ColorSettingTime)]);
                });

                // swap alright
                var temp = data[offset];
                data[offset] = data[offset - 1];
                data[offset - 1] = temp;
                offset -= 1;
            }
            if (i != 0)
            {
                var leftItem = dataList.get(i - 1);

                queue.push(Q_setColorForItem(leftItem, Status.doneColor, 0, S_ColorSettingTime));
            }

            queue.push(Q_setColorForItem(pickedItem, Status.doneColor, 0, S_ColorSettingTime));
        }
        trace([for (el in data) el.value]);

        queue.push(function()
        {
            codeMenu.stopLineHilighting();
            return T_SINGLE(new Wait(0.1));
        });
        return queue;
    }

    private static function mergeSort():ActionQueue
    {
        trace('Starting Merge Sort');
        var S_ColorSettingTime = 0.2;
        var queue = new ActionQueue();
        var data:Array<Item> = dataList._ItemList;
        trace('Unsorted');
        trace([for (el in data) el.value]);

        var ans:Array<Item> = _mergeSort(data, queue, 0);
        

        queue.push(function () {
            return T_MANY([for (el in ans) dataList.setColorForItem(el, Status.doneColor, S_ColorSettingTime)]);
        });
        trace('Sorted:');
        queue.push(function () {
            codeMenu.stopLineHilighting();
            return T_SINGLE(new Wait(1));
            
        });
        trace([for (el in ans) el.value]);
        return queue;

    }
    private static function _mergeSort(data, queue, left_side):Array<Item>
    {
        var S_ColorSettingTime = 0.2;
        var S_MovingItemTime = 0.2;
        var S_LineSelectTime = 0.5;
        queue.push(Q_hilightLineAndWait(0, S_LineSelectTime));
        var sort = function (left:Array<Item>, right:Array<Item>):Array<Item>
        {
            MERGE_iterationCounter += Std.int(800/12) ;
            //var colorForSubArray = FlxG.random.color(0xff333333, 0xffffffff);
            var colorForSubArray = FlxColor.fromHSB(MERGE_iterationCounter % 360, 1, 1);
            var i = 0;
            var j = 0;
            var ans = [];
            while (left.length > i && right.length > j)
            {
                queue.push(Q_hilightLineAndWait(11, S_LineSelectTime));
                var index:Int = 0; // null
                if (left[i] < right[j])
                {
                    queue.push(Q_hilightLineAndWait(13, S_LineSelectTime));
                    ans.push(left[i]);
                    index = i;
                    i += 1;
                }
                else
                {
                    queue.push(Q_hilightLineAndWait(15, S_LineSelectTime));
                    ans.push(right[j]);
                    index = j;
                    j += 1;
                }
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColorForItem(item, Status.pickColor, 0, S_ColorSettingTime));
                queue.push(function ()
                    { return T_MANY([dataList.moveItemDown(item, -1, S_MovingItemTime),
                            dataList.moveItemToIndex(item, left_side+index, S_MovingItemTime),
                            dataList.setColorForItem(item, colorForSubArray, S_ColorSettingTime)]); });
            }

            for (_i in i ... left.length)
            {
                ans.push(left[_i]);
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColorForItem(item, Status.pickColor, 0, S_ColorSettingTime));
                queue.push(function ()
                    { return T_MANY([dataList.moveItemDown(item, -1, S_MovingItemTime),
                            dataList.moveItemToIndex(item, left_side+index, S_MovingItemTime),
                            dataList.setColorForItem(item, colorForSubArray, S_ColorSettingTime)]); });
            }

            for (_j in j ... right.length)
            {
                ans.push(right[_j]);
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColorForItem(item, Status.pickColor, 0, S_ColorSettingTime));
                queue.push(function ()
                    { return T_MANY([dataList.moveItemDown(item, -1, S_MovingItemTime),
                            dataList.moveItemToIndex(item, left_side+index, S_MovingItemTime),
                            dataList.setColorForItem(item, colorForSubArray, S_ColorSettingTime)]); });
                //queue.push(Q_setColorForItem(item, Status.doneColor, 0, S_ColorSettingTime));
            }

            return ans;
        }

        if (data.length >= 2)
        {
            var middle:Int = Std.int(data.length / 2);
            var l:Array<Item> = data.slice(0, middle);
            var r:Array<Item> = data.slice(middle, data.length);
            var depth = MERGE_depth;
            queue.push(function () {
                codeMenu.hilightLine(4);
                return T_MANY([dataList.addBracket(left_side + 0, l.length, depth),
                               dataList.addBracket(left_side + middle, r.length, depth)]);
            });

            MERGE_depth += 1;
            queue.push(Q_hilightLineAndWait(5, S_LineSelectTime));
            var ll:Array<Item> = _mergeSort(l, queue, left_side);
            queue.push(Q_hilightLineAndWait(6, S_LineSelectTime));
            var rr:Array<Item> = _mergeSort(r, queue, left_side + middle);
            MERGE_depth -= 1;
            queue.push(Q_hilightLineAndWait(7, S_LineSelectTime));
            var sorted:Array<Item> = sort(ll, rr);
            
            queue.push(Q_hilightLineAndWait(8, S_LineSelectTime));
            queue.push(function ()
            {
                var moves:Array<ActionType> = [];
                var leftside = left_side;
                for (item in sorted)
                {
                    //moves.push(dataList.setColorForItem(item, Status.doneColor, S_MovingItemTime));
                    moves.push(dataList.moveItemDown(item, 1, S_MovingItemTime));
                }
                return T_MANY(moves);
            });
            
            
            queue.push(function () {
                return T_MANY([dataList.removeBracket(left_side, depth),
                               dataList.removeBracket(left_side + middle, depth)]);
            });
            
            return sorted;
        }
        if (data.length >= 1)
        {
            MERGE_iterationCounter += Std.int(80000/10) ;
            //var colorForSubArray = FlxG.random.color(0xff333333, 0xffffffff);
            var colorForSubArray = FlxColor.fromHSB(MERGE_iterationCounter % 360, 1, 1);
            var itemData:Array<Item> = cast data;
            var item = itemData[0];
            queue.push(function () {
                codeMenu.hilightLine(2);
                return T_MANY([dataList.setColorForItem(item, colorForSubArray, S_ColorSettingTime),
                               T_SINGLE(new Wait(0.5))]);
            });
        }
       
        
        return cast data;

    }
    
    private static function quickSort():ActionQueue
    {
        trace('Starting Quick Sort');
        //
        var data:Array<Item> = dataList._ItemList;
        trace('Unsorted elements');
        //trace([for (el in data) el.y]);
        //trace([for (el in data) dataList.addLineForItem(el)]);

        _quickSort(data, 0, data.length);
        queue.push(function (){
            codeMenu.stopLineHilighting();
            return T_SINGLE(new Wait(0.1));
        });
        trace('sorted elements');
        trace([for (el in data) el.value]);
        return queue;

    }
    private static function _quickSort(data:Array<Item>, start:Int, end:Int)
    {
        QUICK_depth += 1; 
        queue.push(Q_hilightLineAndWait(0, 0.5));
        var S_ColorSettingTime = 0.2;
        var S_MovingItemTime = 0.2;
        if (start < end) 
        {
            queue.push(Q_hilightLineAndWait(2, 0.5));
            var pivot = _quickSortPartiton(data, start, end - 1);
            queue.push(Q_hilightLineAndWait(3, 0.5));
            var depth = QUICK_depth;
            
            var leftSpan = pivot - start;
            
            queue.push(Q_hilightLineAndWait(4, 0.5));
            if (leftSpan > 0)
            {
                queue.push(function () {
                    return dataList.addBracket(start, pivot - start, depth);
                });  
            }
            
            
            _quickSort(data, start, pivot);
            
            
            if (leftSpan > 0)
            {
               queue.push(function () {
                return dataList.removeBracket(start, depth);
                }); 
            }
            
            var rightSpan = end - pivot - 1;
            if (rightSpan > 0)
            {
                queue.push(function () {
                    return dataList.addBracket(pivot + 1,rightSpan , depth);
                }); 
            }

            
            queue.push(Q_hilightLineAndWait(5, 0.5));
            _quickSort(data, pivot + 1, end);
            
            if (rightSpan > 0)
            {
                queue.push(function () {
                    return dataList.removeBracket(pivot + 1, depth);
                }); 
            }
            
        }
        else if (end == start+ 1)
        {
            var item:Item = dataList.get(start);
            queue.push(Q_setColorForItem(item, Status.doneColor, 0, S_ColorSettingTime));
        }
        QUICK_depth -= 1; 
    }
    private static function _quickSortPartiton(data:Array<Item>, start:Int, end:Int):Int
    {
        var S_ColorSettingTime = 0.2;
        var S_MovingItemTime = 0.2;
        //
        
        queue.push(Q_hilightLineAndWait(7, 0.5));
        var pivot = data[end];
        
        queue.push(function () {
            codeMenu.hilightLine(8);
            return T_MANY([T_SINGLE(new Wait(0.5)),
                           dataList.addLineForItem(pivot),
                           dataList.setColorForItem(pivot, Status.pickColor, S_ColorSettingTime)]);
        });
        //color the pivot Item
        
        queue.push(Q_hilightLineAndWait(9, 0.5));
        var i = start; // left pointer -> smallest item
        var leftItem:Item = data[i];
        
        //queue.push(Q_setColorForItem(leftItem, Status.pickColorTertiary, 1, S_ColorSettingTime));
        for (j in start...end)
        {
            queue.push(Q_hilightLineAndWait(10, 0));
            var leftItem:Item = data[i];
            var rightItem:Item = data[j];

            var jIndex = j;
            var iIndex = i;
            if (i != j)
            {
                queue.push(Q_setColorForItem(rightItem, Status.pickColorSecondary, 0, S_ColorSettingTime));
            }
            else 
            {
                queue.push(Q_setColorForItem(leftItem, Status.pickColorTertiary, 0, S_ColorSettingTime));
            }
            
            if (data[j] < pivot)
            {
                data[i] = rightItem;
                data[j] = leftItem;
                
                i += 1;
                var newLeft:Item = dataList.get(i);
                
                queue.push(function () {
                    codeMenu.hilightLine(12);
                    return T_MANY([T_SINGLE(new Wait(0.5)),
                                   dataList.moveItemToIndex(leftItem, jIndex, S_MovingItemTime),
                                   dataList.moveItemToIndex(rightItem, iIndex, S_MovingItemTime),
                                   dataList.setColorForItem(leftItem, Status.idleColor, S_ColorSettingTime),
                                   dataList.setColorForItem(rightItem, Status.idleColor, S_ColorSettingTime),
                                   dataList.setColorForItem(newLeft, Status.pickColorTertiary, S_ColorSettingTime)]);
                });
                queue.push(Q_hilightLineAndWait(13, 0.5));
                
            }
            else if (i != j)
            {
                queue.push(Q_setColorForItem(rightItem, Status.idleColor, 0, S_ColorSettingTime));
                
            }
            
        }

        var middleItem:Item = data[i];
        data[end] = middleItem;
        data[i] = pivot;
        queue.push(function () {
            codeMenu.hilightLine(14);
            return T_MANY([T_SINGLE(new Wait(0.5)),
                           dataList.moveItemToIndex(pivot, i, S_MovingItemTime),
                           dataList.moveItemToIndex(middleItem, end, S_MovingItemTime)]);
        });
        if (middleItem != pivot)
        {
           queue.push(function () {
            return T_MANY([dataList.setColorForItem(pivot, Status.doneColor, S_ColorSettingTime),
                           dataList.setColorForItem(middleItem, Status.idleColor, S_ColorSettingTime)]);
            }); 
        }
        else
        {
            queue.push(function () {
            return T_MANY([dataList.setColorForItem(pivot, Status.doneColor, S_ColorSettingTime),
                           dataList.setColorForItem(middleItem, Status.doneColor, S_ColorSettingTime)]);
            }); 
        }
        queue.push(function () {
            return dataList.removeLineForItem(pivot);
        });
        queue.push(Q_hilightLineAndWait(15, 0.5));
        return i;
    }
    static function Q_hilightLineAndWait(line:Int, waitTime:Float):Void->ActionType
    {
        return function()
        {
            codeMenu.hilightLine(line);
            return T_SINGLE(new Wait(waitTime));
        }
    }

    static function Q_setColorForItem(item:Item, colorType:FlxColor, waitTime:Float, colorSettingTime:Float ):Void->ActionType
    {
        return function()
        {
            return T_MANY([T_SINGLE(new Wait(waitTime)),
            dataList.setColorForItem(item,colorType, colorSettingTime)]);
        }
    }

}

