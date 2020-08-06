package fun.kirill.arrays;

/**
 * The type Solution.
 * https://leetcode.com/explore/learn/card/fun-with-arrays/521/introduction/3238/
 */
public class Solution
{
    /**
     * Find max consecutive ones int.
     *
     * @param nums the nums
     * @return the int
     */
    public int findMaxConsecutiveOnes(int[] nums)
    {
        int counter = 0;
        int curValue = 0;
        int result = 0;

        for (int num : nums)
        {
            if (num == 1)
            {
                counter++;
                curValue = counter;
            }
            else
            {
                counter = 0;
            }
            if (curValue > result)
            {
                result = curValue;
            }
        }
        return result;
    }
}