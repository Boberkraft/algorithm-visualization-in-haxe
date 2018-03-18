package js;

import flixel.FlxG;
import js.Browser.document;
import js.Browser.window;
/**
 * ...
 * @author Andrzej
 */
@:keep
@:expose
class AlgorithmChanger 
{
    private static var codeImplementation:Dynamic;

    private static var namePolish:String;
    private static var nameEnglish:String;
    private static var worstCase:String;
    private static var avCase:String;
    private static var bestCase:String;
    private static var desc:String;
    private static var code:String;
    
    public static function load(type:AlgorithmType)
    {
        
        
        Status.setAlgorithm(type);
        FlxG.switchState(new PlayState());
        switch (type) 
        {
            case AlgorithmType.BubbleSort:
                bubbleSort();
                
            case AlgorithmType.InsertionSort:
                insertionSort();
            
            case AlgorithmType.MergeSort:
                mergeSort();
            
            case AlgorithmType.QuickSort:
                quickSort();
        }
        init();
    }
    
    private static function bubbleSort()
    {
        namePolish = 'sortowanie bąbelkowe';
        nameEnglish = 'bubble sort';
        worstCase = 'O(n^2)';
        bestCase = 'O(n)';
        avCase = ' ';
        desc = 'Kiedy używać? Nigdy!';
        code = 
"def buble(data):
    for passnum in range(1, len(data)):
        for i in range(0, len(data) - passnum):
            if data[i] > data[i + 1]:
                data[i], data[i + 1] = data[i + 1], data[i]";
    }
    
    private static function insertionSort()
    {
        namePolish = 'sortowanie poprzez wstawianie';
        nameEnglish = 'insertion sort';
        worstCase = 'O(n^2)';
        bestCase = 'O(1)';
        avCase = ' ';
        desc = 'Kiedy używać? Tylko gdy niewielka ilość elementów jest pomieszanych, a prawie wszystkie są posortowane';
        
        code = 
"def insertion(data):
    for i in range(1, len(data)):
        offset = i
        while offset - 1 >= 0 and data[offset - 1] > data[offset]:
            data[offset - 1], data[offset] = data[offset], data[offset - 1]
            offset -= 1";
    }
    
    private static function mergeSort()
    {
        namePolish = 'sortowanie poprzez scalanie';
        nameEnglish = 'merge sort';
        worstCase = 'O(n log n)';
        bestCase = 'O(n log n)';
        avCase = ' ';
        desc = 'Kiedy używać? Kiedy tylko pragniesz. I tak lepszy jest TimSort';
        code = 
"def merge_sort(x):
    result = []
    if len(x) < 2:
        return x
    mid = int(len(x) / 2)
    y = merge_sort(x[:mid])
    z = merge_sort(x[mid:])
    i = 0
    j = 0
    while i < len(y) and j < len(z):
        if y[i] > z[j]:
            result.append(z[j])
            j += 1
        else:
            result.append(y[i])
            i += 1
    result += y[i:]
    result += z[j:]
    return result";
    }
    private static function quickSort()
    {
        namePolish = 'sortowanie szybkie';
        nameEnglish = 'quick sort';
        worstCase = 'O(n^2)';
        bestCase = 'O(n log n)';
        avCase = 'O(n log n)';
        desc = 'Kiedy używać? Kiedy tylko pragniesz. Pamietaj, że zmienia on kolejność elementów o tych samych wartościach';
        code = 
"def quicksort(data):
    _quicksort(data, 0, len(data))

def _quicksort(data, start, end):
    if start < end:
        pivot = _partiton(data, start, end - 1)
        _quicksort(data, start, pivot)
        _quicksort(data, pivot + 1, end)

def _partiton(data, start, end):
    pivot = data[end]
    i = start
    for j in range(start, end):
        if data[j] < pivot:
            data[i], data[j] = data[j], data[i]
            i += 1
    data[end], data[i] = data[i], data[end]
    return i";
        
    }
    
    private static function init()
    {
        var codeImplementationAnchor = document.getElementById("codeImplementation");
        var descAnchor = document.getElementById("desc");
        codeImplementationAnchor.innerHTML = code;
        descAnchor.innerHTML = desc;
        untyped window.hljs.initHighlighting.called = false;
        untyped window.hljs.initHighlighting();
    }
}
