package algorithms;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
@:expose
class InsertionSort extends SortingAlgorithm
{

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);

        code = ['Dla każdego elementu:', // 0
                '    do póki lewyElement < element:', // 1
                '        zamień(LewyElement, Element)', // 2
                '        element = lewyElement']; // 3;

        description['englishName']  = 'Insertion Sort';
        description['polishName'] = 'Poprzez wstawianie';

        
            //just for inspection!
        init();
        
    }
    override function _generateActions()
    {
        queue.push(Q_hilightLine(0));
        for (i in 0...data.length)
        {
            var offset:Int = i;
            var pickedItem:Item = data[i];

            //hilight line while (LewyElement < Element)

            if (i == 0)
            {
                queue.push(function ()
                {
                    codeMenu.hilightLine(1);
                    return T_MANY([
                        T_SINGLE(ActionQueue.wait(S_NormWait)),
                        drawArea.setColorForItem(pickedItem, Status.pickColor, S_SetColor)]);
                });
            }
            else
            {
                var leftItem = drawArea.get(i - 1);
                queue.push(function ()
                {
                    codeMenu.hilightLine(1);
                    return T_MANY([
                        T_SINGLE(ActionQueue.wait(S_NormWait)),
                        drawArea.setColorForItem(pickedItem, Status.pickColor, S_SetColor),           
                        drawArea.setColorForItem(leftItem, Status.pickColorSecondary, S_SetColor)]);
                });
            }

            while (offset - 1 >= 0 && data[offset - 1] > data[offset])
            {
                var leftItem:Item = data[offset - 1];
                var rightItem:Item = data[offset];

                if (offset != i) // if it was hilighted at index i, dont do it again
                {
                    queue.push(function ()
                    {
                        codeMenu.hilightLine(2);
                        return T_MANY([
                            T_SINGLE(ActionQueue.wait(S_NormWait)),
                            drawArea.setColorForItem(leftItem, Status.pickColorSecondary, S_SetColor)]);
                    });
                }

                // hilight swap()
                var index = offset;
                queue.push(function ()
                {
                    codeMenu.hilightLine(2);
                    return T_MANY([
                        drawArea.moveItemToIndex(leftItem, index, S_MoveItem),
                        drawArea.moveItemToIndex(rightItem, index - 1, S_MoveItem)]);
                });

                // hilight element = LeftElement
                queue.push(function ()
                {
                    codeMenu.hilightLine(3);
                    return T_MANY([
                        T_SINGLE(ActionQueue.wait(S_NormWait)),
                        drawArea.setColorForItem(leftItem, Status.doneColor, S_SetColor)]);
                });

                // swap alright
                var temp = data[offset];
                data[offset] = data[offset - 1];
                data[offset - 1] = temp;
                offset -= 1;
            }
            if (i != 0)
            {
                var leftItem = data[i - 1];
                queue.push(Q_setColor(leftItem, Status.doneColor));
            }
            queue.push(Q_setColor(pickedItem, Status.doneColor));
        }
        trace([for (el in data) el.value]);
    }

}