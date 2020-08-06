package fun.kirill.arrays;
import java.util.Arrays;

/**
 * The type SquaresOfASortedArray.
 * https://leetcode.com/explore/learn/card/fun-with-arrays/521/introduction/3240/
 */
public class SquaresOfASortedArray
{
    public int[] sortedSquares(int[] A)
    {
        int[] result = new int[A.length];

        for(int i = 0; i < result.length; i++)
        {
            result[i] = (int) Math.pow(A[i], 2);
        }
        Arrays.sort(result);
        return result;
    }
}