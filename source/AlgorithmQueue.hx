package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import ItemList.PythonRange;
import flixel.tweens.FlxTween;
import ActionType;
import haxe.macro.ExprTools.ExprArrayTools;
/**
 * ...
 * @author Andrzej
 */
class AlgorithmQueue
{
    public static function generateOperations(data:ItemList, codeMenu:CodeMenu):ActionQueue
    {
        
        return switch (Status.algorithm)
        {
            case AlgorithmType.BubbleSort:
                bubbleSort(data, codeMenu);
            case AlgorithmType.InsertionSort:
                insertionSort(data, codeMenu);
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

    private static function bubbleSort(dataList:ItemList, codeMenu:CodeMenu):ActionQueue
    {
        var queue = new ActionQueue();
        trace('Starting Bubble Sort');
        //for passnum in range(1, len(data)):
        //for i in range(0, len(data) - passnum):
        //print('range 0 to',format(len(data) - passnum))
        //if data[i] > data[i+1]:
        //data[i], data[i+1] = data[i+1], data[i]
        //data.swapItemsByIndex(0, 2);
        var data:Array<Item> = dataList._ItemList;
        queue.push(function() {
                codeMenu.hilightLine(0);
                return T_SINGLE(new Wait(0.5)); 
            });
        for (passnum in new PythonRange(0, data.length))
        {
            queue.push(function() {
                codeMenu.hilightLine(1);
                return T_SINGLE(new Wait(0.5)); 
            });
            
            passnum += 1;
            for (i in new PythonRange(0, data.length - passnum))
            {
                var itemA:Item = dataList.get(i);
                var itemB:Item = dataList.get(i + 1);
                var lastItem = itemB;
                
                queue.push(function() {
                    codeMenu.hilightLine(2);
                    return T_MANY([
                    T_SINGLE(new Wait(0.5)),
                    dataList.setColorByItem(itemA, Status.pickColor),
                    dataList.setColorByItem(itemB, Status.pickColor)]); 
                });
                
                if (itemA > itemB)
                {
                    var action:Void->ActionType = function()
                    {
                        trace('swaping $i and ${i+1}');
                        codeMenu.hilightLine(3);
                        return T_MANY([
                            T_SINGLE(new Wait(0.5)),
                            dataList.swapItemsByItem(itemA, itemB)]);
                    }
                    queue.push(action);
                    var temp = data[i];
                    data[i] = data[i + 1];
                    data[i + 1] = temp;
                    queue.push(function() {return dataList.setColorByItem(itemB, Status.idleColor); });
                    lastItem = itemA;
                }
                else
                {
                    queue.push(function() {return dataList.setColorByItem(itemA, Status.idleColor); });
                }
                if (i == data.length - passnum - 1)
                {
                    queue.push(function() {return dataList.setColorByItem(lastItem, Status.doneColor); });
                }
            }
        }
        // fix first element
        if (data.length > 0)
            queue.push(function() {return dataList.setColorByItem(dataList.get(0), Status.doneColor); });
            
        queue.push(function() {
                codeMenu.stopLineHilighting();
                return T_SINGLE(new Wait(0.1)); 
            });
        return queue;
    }
    private static function insertionSort(dataList:ItemList, codeMenu:CodeMenu):ActionQueue
    {
        trace('Starting Insertion Sort');
        var queue = new ActionQueue();
        var data:Array<Item> = dataList._ItemList;
        trace([for (el in data) el.value]);
        // hilight line (for every element)
        queue.push(function () {
            codeMenu.hilightLine(0);
            return T_SINGLE(new Wait(0.5));
        });
        for (i in 0...data.length)
        {
            var offset:Int = i;
            var pickedItem:Item = dataList.get(i);
            
            //hilight line while (LewyElement < Element)
            
            if (i == 0)
            {
                queue.push(function () {
                    codeMenu.hilightLine(1);
                    return T_MANY([T_SINGLE(new Wait(0.5)), 
                                   dataList.setColorByItem(pickedItem, Status.pickColor)]);
                });
            }
            else
            {
                var leftItem = dataList.get(i - 1);
                queue.push(function () {
                    codeMenu.hilightLine(1);
                    return T_MANY([T_SINGLE(new Wait(0.5)), 
                                   dataList.setColorByItem(pickedItem, Status.pickColor),
                                   dataList.setColorByItem(leftItem, Status.pickColorSecondary)]);
                });
            }
            
            

            
            while (offset - 1 >= 0 && data[offset - 1] > data[offset])
            {
                var leftItem:Item = dataList.get(offset - 1);  
                var rightItem:Item = dataList.get(offset);
                
                if (offset != i) // if it was hilighted at index i, dont do it again
                {
                    queue.push(function () {
                        codeMenu.hilightLine(2);
                        return T_MANY([T_SINGLE(new Wait(0.5)), 
                                       dataList.setColorByItem(leftItem, Status.pickColorSecondary)]);
                    }); 
                }
                
                // hilight swap()
                queue.push(function () {
                    codeMenu.hilightLine(2);
                    return dataList.swapItemsByItem(leftItem, rightItem);
                });
                
                // hilight element = LeftElement
                queue.push(function () {
                    codeMenu.hilightLine(3);
                    return T_MANY([T_SINGLE(new Wait(0.5)), 
                                            dataList.setColorByItem(leftItem, Status.doneColor)]);
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
                queue.push(function () {return dataList.setColorByItem(leftItem, Status.doneColor); });
            }
            queue.push(function () {return dataList.setColorByItem(pickedItem, Status.doneColor); });
            
        }
        trace([for (el in data) el.value]);
        
        queue.push(function() {
                codeMenu.stopLineHilighting();
                return T_SINGLE(new Wait(0.1)); 
            });
        return queue;
    }
    
}

