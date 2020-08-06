import fun.kirill.arrays.SquaresOfASortedArray;

public class Main
{
    public static final void main(String[] args)
    {
        SquaresOfASortedArray s = new SquaresOfASortedArray();
        int[] nums = new int[] {-4,-1,0,3,10};
        System.out.println(s.sortedSquares(nums));
    }
}
