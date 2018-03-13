package;

/**
 * @author Andrzej
 */

enum AlgorithmType 
{
    BubbleSort;
    InsertionSort;
}

@:expose
class AlgorithmTypeJS
{
    public static var BubbleSort = AlgorithmType.BubbleSort;
    public static var InsertionSort = AlgorithmType.InsertionSort;
}