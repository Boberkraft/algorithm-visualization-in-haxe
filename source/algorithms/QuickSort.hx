package algorithms;

/**
 * ...
 * @author Andrzej
 */
@:expose
class QuickSort extends SortingAlgorithm
{
    var QUICK_depth = 0;
    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);

        code =  ['QuickSort(Tablica):', // 0
                 '    jeżeli Tablica ma ponad 1 element:', //1
                 '        Odniesienie = Rozgródź(Tablica)', //2
                 '        RozdzielWPunkcie(Tablica, Odniesienie)', //3
                 '        QuickSort(LewaPołowa)', //4
                 '        QuickSort(PrawaPołowa)', //5
                 '', //6
                 'Rozgródź(Tablica):', //7
                 '    Odniesienie = Koniec(Tablica)', //8
                 '    DoZamiany = Początek(Tablica)', //9
                 '    Dla każdego elementu:', //10
                 '        Jeżeli Element < Odniesienie:', //11
                 '            Zamień(Element, Element)', //12
                 '            DoZamiany = Nastepny(DoZamiany)', //13
                 '    Zamień(DoZamiany, Odniesienie)', //14
                 '    zwróć Odniesienie'];  //15;
        description['englishName'] = 'Quick Sort';
       
       
        init();
        
        
    }
    override function _generateActions()
    {
        _quickSort(data, 0, data.length);
    }

    private function _quickSort(data:Array<Item>, start:Int, end:Int)
    {
        QUICK_depth += 1;
        queue.push(Q_hilightLine(0));
        if (start < end)
        {
            queue.push(Q_hilightLine(2));
            var pivot = _quickSortPartiton(data, start, end - 1);
            queue.push(Q_hilightLine(3));
            var depth = QUICK_depth;

            var leftSpan = pivot - start;

            queue.push(Q_hilightLine(4));
            if (leftSpan > 0)
            {
                queue.push(function ()
                {
                    return drawArea.addBracket(start, pivot - start, depth);
                });
            }

            _quickSort(data, start, pivot);

            if (leftSpan > 0)
            {
                queue.push(function ()
                {
                    return drawArea.removeBracket(start, depth);
                });
            }

            var rightSpan = end - pivot - 1;
            if (rightSpan > 0)
            {
                queue.push(function ()
                {
                    return drawArea.addBracket(pivot + 1,rightSpan, depth);
                });
            }

            queue.push(Q_hilightLine(5));
            _quickSort(data, pivot + 1, end);

            if (rightSpan > 0)
            {
                queue.push(function ()
                {
                    return drawArea.removeBracket(pivot + 1, depth);
                });
            }

        }
        else if (end == start+ 1)
        {
            var item:Item = data[start];
            queue.push(Q_setColor(item, Status.doneColor));
        }
        QUICK_depth -= 1;
    }
    function _quickSortPartiton(data:Array<Item>, start:Int, end:Int):Int
    {

        queue.push(Q_hilightLine(7));
        var pivot = data[end];

        queue.push(function ()
        {
            codeMenu.hilightLine(8);
            return T_MANY([T_SINGLE(ActionQueue.wait(S_NormWait)),
                drawArea.addLineForItem(pivot),
                drawArea.setColorForItem(pivot, Status.pickColor, S_SetColor)]);
        });
        //color the pivot Item

        queue.push(Q_hilightLine(9));
        var i = start; // left pointer -> smallest item
        var leftItem:Item = data[i];

        //queue.push(Q_setColorForItem(leftItem, Status.pickColorTertiary, 1, S_ColorSettingTime));
        for (j in start...end)
        {
            queue.push(Q_hilightLine(10));
            var leftItem:Item = data[i];
            var rightItem:Item = data[j];

            var jIndex = j;
            var iIndex = i;
            if (i != j)
            {
                queue.push(Q_setColor(rightItem, Status.pickColorSecondary));
            }
            else
            {
                queue.push(Q_setColor(leftItem, Status.pickColorTertiary));
            }

            if (data[j] < pivot)
            {
                data[i] = rightItem;
                data[j] = leftItem;

                i += 1;
                var newLeft:Item = data[i];

                queue.push(function ()
                {
                    codeMenu.hilightLine(12);
                    return T_MANY([T_SINGLE(ActionQueue.wait(S_NormWait)),
                                   drawArea.moveItemToIndex(leftItem, jIndex, S_MoveItem),
                                   drawArea.moveItemToIndex(rightItem, iIndex, S_MoveItem),
                                   drawArea.setColorForItem(leftItem, Status.idleColor, S_SetColor),
                                   drawArea.setColorForItem(rightItem, Status.idleColor, S_SetColor),
                                   drawArea.setColorForItem(newLeft, Status.pickColorTertiary, S_SetColor)]);
                });
                queue.push(Q_hilightLine(13));

            }
            else if (i != j)
            {
                queue.push(Q_setColor(rightItem, Status.idleColor));

            }

        }

        var middleItem:Item = data[i];
        data[end] = middleItem;
        data[i] = pivot;
        queue.push(function ()
        {
            codeMenu.hilightLine(14);
            return T_MANY([T_SINGLE(ActionQueue.wait(S_NormWait)),
                           drawArea.moveItemToIndex(pivot, i, S_MoveItem),
                           drawArea.moveItemToIndex(middleItem, end, S_MoveItem)]);
        });
        if (middleItem != pivot)
        {
            queue.push(function ()
            {
                return T_MANY([drawArea.setColorForItem(pivot, Status.doneColor, S_SetColor),
                               drawArea.setColorForItem(middleItem, Status.idleColor, S_SetColor)]);
            });
        }
        else
        {
            queue.push(function ()
            {
                return T_MANY([drawArea.setColorForItem(pivot, Status.doneColor, S_SetColor),
                               drawArea.setColorForItem(middleItem, Status.doneColor, S_SetColor)]);
            });
        }
        queue.push(function ()
        {
            return drawArea.removeLineForItem(pivot);
        });
        queue.push(Q_hilightLine(15));
        return i;
    }

}