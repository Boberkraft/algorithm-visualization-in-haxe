package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import ItemList.PythonRange;
import flixel.tweens.FlxTween;
import ActionType;
import flixel.util.FlxColor;
import haxe.macro.ExprTools.ExprArrayTools;
/**
 * ...
 * @author Andrzej
 */
class AlgorithmQueue
{
    private static var codeMenu:CodeMenu;
    private static var dataList:ItemList;

    public static function generateOperations(_data:ItemList, _codeMenu:CodeMenu):ActionQueue
    {
        dataList = _data;
        codeMenu = _codeMenu;
        return switch (Status.algorithm)
        {
            case AlgorithmType.BubbleSort:
                bubbleSort();
            case AlgorithmType.InsertionSort:
                insertionSort();
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
        trace([for (el in data) el.value]);
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
                queue.push(function ()
                {
                    codeMenu.hilightLine(2);
                    return T_MANY([dataList.moveItemToIndex(leftItem, offset, S_MovingItemTime),
                                   dataList.moveItemToIndex(leftItem, offset - 1, S_MovingItemTime)]);
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
        trace(queue);
        return queue;
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

