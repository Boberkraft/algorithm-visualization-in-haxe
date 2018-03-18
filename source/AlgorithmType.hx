package;

/**
 * @author Andrzej
 */

enum AlgorithmType 
{
    BubbleSort;
    InsertionSort;
    MergeSort;
    QuickSort;
}

@:expose
class AlgorithmTypeJS
{
    public static var BubbleSort = AlgorithmType.BubbleSort;
    public static var InsertionSort = AlgorithmType.InsertionSort;
    public static var MergeSort = AlgorithmType.MergeSort;
    public static var QuickSort = AlgorithmType.QuickSort;
}