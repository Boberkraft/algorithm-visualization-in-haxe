package algorithms;
import hanoi.HanoiCodeBlock;
import hanoi.HanoiPeg;
import flixel.group.FlxSpriteGroup;
/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */

class HanoiTower extends SortingAlgorithm
{
    var hanoiCodeBlock:HanoiCodeBlock;
    var left:HanoiPeg;
    var middle:HanoiPeg;
    var right:HanoiPeg;

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);
        code = [
        'def hanoi(how_many, src, storage, dest):', // 0
        '    if how_many > 0:', // 1
        '        hanoi(how_many - 1, src, dest, storage)', // 2
        '        item_to_move = src.pop()', // 3  
        '        dest.append(item_to_move)', // 4 
        '        hanoi(how_many - 1, storage, src, dest)' // 5
        ];
        description['englishName'] = 'Hanoi Tower';
        description['polishName'] = 'Wieża Hanoi';
        trace('setting blocks');
        HanoiPeg.MAX_BLOCKS = 6;

        
        init();
    }
    override public function preInit()
    {
        
        Status.howManyItems = 0;
        Status.preloadedItems = null;
       
    }
    override function _generateActions()
    {
        
        
        left = new HanoiPeg('left', [for (x in 1...HanoiPeg.MAX_BLOCKS+1) HanoiPeg.MAX_BLOCKS - x +2]);
        middle = new HanoiPeg('middle', []);
        right = new HanoiPeg('right', []);
        hanoiCodeBlock = new HanoiCodeBlock(left, middle, right);
        trace('TEST');
        trace(hanoiCodeBlock.x);
        trace(hanoiCodeBlock.y);
        drawArea.addSubSystem(cast hanoiCodeBlock);
        trace('BEFORESORTING:');
        trace('left:');
        trace([for (block in left.blocks) block.value]);
        trace('middle:');
        trace([for (block in middle.blocks) block.value]);
        trace('right:');
        trace([for (block in right.blocks) block.value]);
        hanoi(HanoiPeg.MAX_BLOCKS, left, middle, right);
        trace('\nAFTERSORTING:');
        trace('left:');
        trace([for (block in left.blocks) block.value]);
        trace('middle:');
        trace([for (block in middle.blocks) block.value]);
        trace('right:');
        trace([for (block in right.blocks) block.value]);
    }
    /* PYTHON CODE
    class Tower:
        def __init__(self, name, items):
            self.name = name
            self.items = items

        def pop(self):
            return self.items.pop()

        def append(self, val):
            self.items.append(val)

        def __len__(self):
            return len(self.items)

    def hanoi(how_many, src, storage, dest):

        if how_many > 0:
            # if there is stuff to move

            # move stuff above source to storage
            hanoi(how_many - 1, src, dest, storage)

            # move item
            item_to_move = src.pop()
            print('moving item {} from {.name} to {.name}'.format(item_to_move, src, dest))
            dest.append(item_to_move)

            # show new arrangement
            towers = {tower.name: tower.items for tower in [src, storage, dest]}
            print(towers['Left'], towers['Middle'], towers['Right'], '', sep='\n')

            # move stuff from storage on top of source
            hanoi(how_many - 1, storage, src, dest)

    tower_left = Tower('Left', [ 3, 2, 1])
    tower_middle = Tower('Middle', [])
    tower_right = Tower('Right', [])

    hanoi(len(tower_left), tower_left, tower_middle, tower_right)
    */
    function hanoi(howMany:Int, source:HanoiPeg, storage:HanoiPeg, destination:HanoiPeg)
    {

        //trace(left.x);
        //trace(middle.x);
        //trace(right.x);
        //var block = source.pop();
        //queue.push(source.moveBlockUp(block, S_MoveItem, 0));
        //queue.push(source.moveBlockOver(block, storage, S_MoveItem, 0));
        //queue.push(storage.putBlockOn(block, S_MoveItem, 0));
        //storage.push(block);
        //
        //var block = source.pop();
        //queue.push(source.moveBlockUp(block, S_MoveItem, 0));
        //queue.push(source.moveBlockOver(block, destination, S_MoveItem, 0));
        //queue.push(destination.putBlockOn(block, S_MoveItem, 0));
        //destination.push(block);
        //trace('xd');
        //
        //var block = source.pop();
        //queue.push(source.moveBlockUp(block, S_MoveItem, 0));
        //queue.push(source.moveBlockOver(block, source, S_MoveItem, 0));
        //queue.push(source.putBlockOn(block, S_MoveItem, 0));
        //source.push(block);
        
        queue.push(Q_hilightLine(0, S_NormWait/10));
        if (howMany > 0)
        {
            queue.push(Q_hilightLine(2, S_NormWait/10));
            hanoi(howMany - 1, source, destination, storage);
            
            var block = source.pop();
            queue.push(Q_hilightLine(3, 0));
            queue.push(source.moveBlockUp(block, S_MoveItem, 0));
            queue.push(source.moveBlockOver(block, destination, S_MoveItem, 0));
            queue.push(Q_hilightLine(4, 0));
            queue.push(destination.putBlockOn(block, S_MoveItem, 0));
            destination.push(block);
            //trace('Moving block ${block.value} from ${source.name} to ${destination.name}');
            //trace('--');
            //trace('left:');
            //trace([for (block in left.blocks) block.value]);
            //trace('middle:');
            //trace([for (block in middle.blocks) block.value]);
            //trace('right:');
            //trace([for (block in right.blocks) block.value]);
           
            queue.push(Q_hilightLine(5, S_NormWait/10));
            hanoi(howMany - 1, storage, source, destination);
        }
        
    }

}