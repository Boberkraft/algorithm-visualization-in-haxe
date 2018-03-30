package;
import algorithms.BubbleSort;
import algorithms.InsertionSort;
import algorithms.MergeSort;
import algorithms.QuickSort;


/**
 * @author Andrzej
 */

enum _AlgorithmTypes 
{
    BubbleSort;
    InsertionSort;
    MergeSort;
    QuickSort;
}
//https://stackoverflow.com/questions/32909150/in-haxe-how-do-you-add-types-classes-to-a-module-with-macros
@:expose
class AlgorithmTypes
{
    public static var BubbleSort = algorithms.BubbleSort;
    //public static var InsertionSort = algorithms.InsertionSort;
    //public static var MergeSort = algorithms.MergeSort;
    //public static var QuickSort = algorithms.QuickSort;
}