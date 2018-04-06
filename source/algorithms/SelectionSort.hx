package algorithms;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class SelectionSort extends SortingAlgorithm
{
   /**
    * def selection_sort(data):
    *    for i in range(len(data)):
    *       minimum = i
    *       for j in range(i, len(data)):
    *           if data[minimum] > data[j]:
    *              /minimum = j
    *      data[minimum], data[i] = data[i], data[minimum]
    */
   
    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);
        code = [
                'Dla każdego elementu (i):', // 0
                '    minimum = element',  // 1
                '    Dla każdego nieposortowanego elementu:',  //2
                '        Jeżeli minimum < element:',  //3
                '            minimum = element', //4
                '    zamień(element, minimum))', //5
        ];
        description['englishName'] = 'Selection Sort';
        description['polishName'] = 'Poprzez wybieranie';
        
        init();
    }
    override function _generateActions()
    {
        for (i in 0...data.length)
        {
            var itemI:Item = data[i];
            queue.push(function () {
                codeMenu.hilightLine(1);
                return T_MANY([
                    T_SINGLE(ActionQueue.wait(S_NormWait)),
                    drawArea.setColorForItem(itemI, Status.pickColor, S_SetColor)]);
            });
            var min = i;
            var itemMin = data[i];
            
            for (j in (i+1)...data.length)
            {
                var itemJ:Item = data[j];
                queue.push(function () {
                    codeMenu.hilightLine(3);
                    return drawArea.setColorForItem(itemJ, Status.pickColorTertiary, S_SetColor);
                });
                if (data[min] > data[j])
                {
                    var oldMin:Item = data[min];
                    min = j;
                    var itemMin:Item = data[min];
                    queue.push(function () {
                        codeMenu.hilightLine(4);
                        return T_MANY([
                                T_SINGLE(ActionQueue.wait(S_NormWait)),
                                drawArea.setColorForItem(oldMin, Status.idleColor, S_SetColor),
                                drawArea.setColorForItem(itemMin, Status.pickColor, S_SetColor)]);
                    });
                }
                else 
                {
                    queue.push(Q_setColor(itemJ, Status.idleColor));   
                }
            }
            //swap
            
            var itemMin = data[min];
            var itemI = data[i];
            var min = min;
            var i = i;
            queue.push(function () {
                codeMenu.hilightLine(5);
                return T_MANY([
                               T_SINGLE(ActionQueue.wait(S_NormWait)),
                               drawArea.moveItemToIndex(itemMin, i, S_MoveItem),
                               drawArea.moveItemToIndex(itemI, min, S_MoveItem)]);
            });
            
            
            if (i != min)
            {
                queue.push(function () {
                    return T_MANY([
                            T_SINGLE(ActionQueue.wait(S_NormWait)),
                            drawArea.setColorForItem(itemMin, Status.doneColor, S_SetColor),
                            drawArea.setColorForItem(itemI, Status.idleColor, S_SetColor)]);
                });
            }
            else 
            {
                queue.push(Q_setColor(itemMin, Status.doneColor));
            }
            
            var temp = data[min];
            data[min] = data[i];
            data[i] = temp;
            
        }
    }

}