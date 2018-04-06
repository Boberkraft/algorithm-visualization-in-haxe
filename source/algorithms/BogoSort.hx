package algorithms;

import flixel.FlxG;
import AlgorithmQueue;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class BogoSort extends SortingAlgorithm
{

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        /*
        def issorted(data):
            return data == sorted(data)

        def bogo_sort(data):

            over = True
            while not issorted(data):
                print(data)
                for i in range(len(data)-1):
                    pos = randint(i+1, len(data) - 1)
                    data[i], data[pos] = data[pos], data[i]
        */
        super(itemInterface, codeMenuInterface);
        code = [
            'Do póki nie jest posortowane:', //0
            '    Wymieszaj(tablica)' //1
        ];
        description['englishName'] = 'BogoSort';
        description['polishName'] = 'BogoSort';
        
        init();
    }
    override public function preInit()
    {
        Status.howManyItems = 5;
        
    }
    function isSorted():Bool
    {
        var before:Item = data[0];
        for (el in data)
        {
            if (before > cast el) {
                return false;
            }
            before = el;
        }
        return true;
    }
    override function _generateActions()
    {
        
        queue.push(function () {
            codeMenu.hilightLine(1);
            return T_SINGLE(ActionQueue.wait(S_MoveItem));
        });
        
        for (i in 0...data.length - 1)
        {
            var pos = FlxG.random.int(i + 1, data.length -1);
            
            var temp = data[i];
            data[i] = data[pos];
            data[pos] = temp;
        }
        
        queue.push(function () {
            for (i in 0...data.length) {
                drawArea.moveItemToIndex(data[i], i, S_MoveItem);
            }
            return T_SINGLE(ActionQueue.wait(S_MoveItem));
        });
        if (!isSorted()) {
            queue.push(function () {
                Status.loadAlgorithm(Status.activeAlgorithm);
                return T_SINGLE(ActionQueue.wait(0.1));
            });
            Status.preloadedItems = [for (el in data) el.value];
        }
        else 
        {
            queue.push(function () {
                for (i in 0...data.length) {
                    drawArea.setColorForItem(data[i], Status.doneColor, S_SetColor);
                }
                return T_SINGLE(ActionQueue.wait(S_MoveItem));
            });
        }
        
        
    }

}