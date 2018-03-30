package algorithms;

/**
 * ...
 * @author Andrzej
 */

@:expose
class BubbleSort extends SortingAlgorithm
{

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);

        code = ['Dla każdego elementu:', // 0
        '    od 0 do (ostatniego nieposortowanego elementu - 1):', // 1
        '        jeżeli lewyElement > prawyElement:', // 2
        '            zamień(lewyElement, prawyElement)']; //3
        //
        description['englishName'] = 'Bubble Sort';
        //
        description['implementation'] =
            "def buble(data):
            \tfor passnum in range(1, len(data)):
            \t\tfor i in range(0, len(data) - passnum):
            \t\t\tif data[i] > data[i + 1]:
            \t\t\tdata[i], data[i + 1] = data[i + 1], data[i]";
        //
        
        
            //just for inspection!
        init();
        
    }
    
    override function _generateActions()
    {
        queue.push(Q_hilightLine(0));
        for (passnum in 1...data.length)
        {
            queue.push(this.Q_hilightLine(1));
            //passnum += 1;
            for (i in 0...(data.length - passnum))
            {
                // for every item (in series 8, 7, 6, 5...)
                var itemA:Item = data[i];
                var itemB:Item = data[i + 1];
                var lastItem = itemB;

                // move color marker
                queue.push(function()
                {
                    codeMenu.hilightLine(2);
                    return T_MANY([
                        T_SINGLE(ActionQueue.wait(S_NormWait)),
                        drawArea.setColorForItem(itemA, Status.pickColor, S_SetColor),
                        drawArea.setColorForItem(itemB, Status.pickColor, S_SetColor)]);
                });

                if (itemA > itemB)
                {
                    // swap them
                    queue.push(function()
                    {
                        codeMenu.hilightLine(3);
                        return T_MANY([
                                          T_SINGLE(ActionQueue.wait(S_NormWait)),
                                          drawArea.moveItemToIndex(itemA, i + 1, S_MoveItem),
                                          drawArea.moveItemToIndex(itemB, i, S_MoveItem)]);
                    });
                    var temp = data[i];
                    data[i] = data[i + 1];
                    data[i + 1] = temp;

                    queue.push(Q_setColor(itemB, Status.idleColor));
                    lastItem = itemA;
                }
                else
                {
                    queue.push(Q_setColor(itemA, Status.idleColor));
                }
                if (i == data.length - passnum - 1)
                {
                    queue.push(Q_setColor(lastItem,Status.doneColor));
                }
            }
        }
        // First element wont be marked as done
        // fix it
        if (data.length > 0)
        {
            queue.push(Q_setColor(drawArea.get(0), Status.doneColor));
        }
    }
}