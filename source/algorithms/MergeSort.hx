package algorithms;

import flixel.util.FlxColor;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
@:expose
class MergeSort extends SortingAlgorithm
{

    var MERGE_iterationCounter = 0;
    var MERGE_depth = 0;
    
    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);

        code = ['Rozdziel(Tablica):', // 0
                '    Jeżeli Tablica ma <= 1 element:', // 1
                '        zwróć Tablica', // 2
                '    W innym wypadku:', // 3
                '        RodzielTabliceWPół()', // 4
                '        Rodziel(LewaPołowa)', // 5
                '        Rodziel(PrawaPołowa)', // 6
                '        ScalonaTablica = Scal(LewaPołowa, PrawaPołowa)', // 7
                '        zwróć ScalonaTablica', // 8
                '', // 9
                'Scal(LewaPołowa, PrawaPołowa):', // 10
                '  Dla każego elementu:', // 11
                '    jeżeli Początek(LewaPołowa) < Początek(PrawaPołowa):',  // 12
                '        nowaTablica.push(Początek(PrawaPołowa))', // 13
                '    w innym wypadku:', // 14
                '        nowaTablica.push(Początek(LewaPołowa))']; // 15;
        description['englishName'] = 'Merge Sort';

       
            //just for inspection!
        init();
        
    }

    override function _generateActions()
    {
        var ans:Array<Item> = _mergeSort(data, queue, 0);

        queue.push(function ()
        {
            return T_MANY([for (el in ans) drawArea.setColorForItem(el, Status.doneColor, S_SetColor)]);
        });
    }

    private function _mergeSort(data, queue, left_side):Array<Item>
    {
        queue.push(Q_hilightLine(0));
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

                queue.push(Q_hilightLine(11));
                var index:Int = 0; // null
                if (left[i] < right[j])
                {
                    queue.push(Q_hilightLine(13));
                    ans.push(left[i]);
                    index = i;
                    i += 1;
                }
                else
                {
                    queue.push(Q_hilightLine(15));
                    ans.push(right[j]);
                    index = j;
                    j += 1;
                }
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColor(item, Status.pickColor));
                queue.push(function ()
                {
                    return T_MANY([drawArea.moveItemDown(item, -1, S_MoveItem),
                                   drawArea.moveItemToIndex(item, left_side+index, S_MoveItem),
                                   drawArea.setColorForItem(item, colorForSubArray, S_SetColor)]);
                });
            }

            for (_i in i ... left.length)
            {
                ans.push(left[_i]);
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColor(item, Status.pickColor));
                queue.push(function ()
                {
                    return T_MANY([drawArea.moveItemDown(item, -1, S_MoveItem),
                                   drawArea.moveItemToIndex(item, left_side+index, S_MoveItem),
                                   drawArea.setColorForItem(item, colorForSubArray, S_SetColor)]);
                });
            }

            for (_j in j ... right.length)
            {
                ans.push(right[_j]);
                var item:Item = ans[ans.length-1];
                var index:Int = ans.length - 1;
                queue.push(Q_setColor(item, Status.pickColor));
                queue.push(function ()
                {
                    return T_MANY([drawArea.moveItemDown(item, -1, S_MoveItem),
                                   drawArea.moveItemToIndex(item, left_side+index, S_MoveItem),
                                   drawArea.setColorForItem(item, colorForSubArray, S_SetColor)]);
                });
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
            queue.push(function ()
            {
                codeMenu.hilightLine(4);
                return T_MANY([drawArea.addBracket(left_side + 0, l.length, depth),
                               drawArea.addBracket(left_side + middle, r.length, depth)]);
            });

            MERGE_depth += 1;
            queue.push(Q_hilightLine(5));
            var ll:Array<Item> = _mergeSort(l, queue, left_side);
            queue.push(Q_hilightLine(6));
            var rr:Array<Item> = _mergeSort(r, queue, left_side + middle);
            MERGE_depth -= 1;
            queue.push(Q_hilightLine(7));
            var sorted:Array<Item> = sort(ll, rr);

            queue.push(Q_hilightLine(8));
            queue.push(function ()
            {
                var moves:Array<ActionType> = [];
                var leftside = left_side;
                for (item in sorted)
                {
                    //moves.push(dataList.setColorForItem(item, Status.doneColor, S_MovingItemTime));
                    moves.push(drawArea.moveItemDown(item, 1, S_MoveItem));
                }
                return T_MANY(moves);
            });

            queue.push(function ()
            {
                return T_MANY([drawArea.removeBracket(left_side, depth),
                               drawArea.removeBracket(left_side + middle, depth)]);
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
            queue.push(function ()
            {
                codeMenu.hilightLine(2);
                return T_MANY([drawArea.setColorForItem(item, colorForSubArray, S_SetColor),
                               T_SINGLE(ActionQueue.wait(S_NormWait))]);
            });
        }

        return cast data;
    }

}