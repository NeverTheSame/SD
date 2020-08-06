package fun.kirill.arrays;

/**
 * The type NumbersWithEvenNumberOfDigits.
 * https://leetcode.com/explore/learn/card/fun-with-arrays/521/introduction/3237/
 */
public class NumbersWithEvenNumberOfDigits
{
    public int findNumbers(int[] nums)
    {
        int result = 0;
        for(int n: nums)
        {
            int count = 0;
            while (n != 0)
            {
                n = n / 10;
                count++;
            }
            if (count % 2 == 0)
            {
                result++;
            }
        }

        return result;
    }
}
