package;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Andrzej
 */
class CodeMenu extends FlxSpriteGroup
{
    private var code:Array<String>;
    private var texts:Array<FlxText>;
    private var textsBackground:Array<FlxSprite>;
    private var lastTextY = 0;
    private var highlightedLine = 0;
    public function new() 
    {
        super();
    }
    
    private function init(code:Array<String>)
    {
        texts = [];
        textsBackground = [];
        var maxWidth = 0.0;
        for (row in code)
        {
            var text = new FlxText(0, lastTextY, 0, row, 16);
            text.font = 'Arial';
            if (text.width > maxWidth)
                maxWidth = text.width;
            texts.push(text);
            lastTextY = Std.int(text.y + text.height);
        }
        
        for (text in texts)
        {
            var back = new FlxSprite(0, text.y);
            textsBackground.push(back);
            back.makeGraphic(Std.int(maxWidth), Std.int(text.height), 0xffffffff);
            back.color = Status.idleCodeColor;
            add(back);
            add(text);
        }
    }
    
    public function generateCodeMenu()
    {
        var code:Array<String> = switch (Status.algorithm) 
        {
            case AlgorithmType.BubbleSort:
                ['Dla każdego elementu:', // 0
                '    od 0 do (ostatniego nieposortowanego elementu - 1):', // 1
                '        jeżeli lewyElement > prawyElement:', // 2
                '            zamień(lewyElement, prawyElement)']; //3
            case AlgorithmType.InsertionSort:
                ['Dla każdego elementu:', // 0
                '    do póki lewyElement < element:', // 1
                '        zamień(LewyElement, Element)', // 2
                '        element = lewyElement']; // 3
            case AlgorithmType.MergeSort:
                ['Rozdziel(Tablica):', // 0
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
                '        nowaTablica.push(Początek(LewaPołowa))']; // 15
            case AlgorithmType.QuickSort:
                ['QuickSort(Tablica):', // 0
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
                '    zwróć Odniesienie'];  //15
        }
        //trace(code);
        init(code);
    }
    public function hilightLine(line:Int)
    {
        textsBackground[highlightedLine].color = Status.idleCodeColor;
        texts[highlightedLine].color = Color.White;
        
        
        textsBackground[line].color = Status.pickCodeColor;
        texts[line].color = Color.Black;
        
        highlightedLine = line;
    }
    public function stopLineHilighting()
    {
        textsBackground[highlightedLine].color = Status.idleCodeColor;
        texts[highlightedLine].color = Color.White;
    }
}