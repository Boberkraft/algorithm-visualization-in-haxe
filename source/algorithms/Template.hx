package algorithms;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */

class Template extends SortingAlgorithm
{

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        super(itemInterface, codeMenuInterface);
        code;
        description['englishName'];
        
        init();
    }
    
    //Called on empty instance without all variables!
    //Usefull if you want to prepare foryourself a nice data or limit something!
    //See Bogosort.hx
    override public function preInit()
    {

    }
    
    override function _generateActions()
    {
        
    }

}