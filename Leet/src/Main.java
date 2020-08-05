import fun.kirill.arrays.LeetArray;
import fun.kirill.arrays.Solution;

public class Main
{
    public static final void main(String[] args)
    {
    //        LeetArray arrays = new LeetArray("ints");
        Solution s = new Solution();
//        int[] arr = new int[] {1,1,0,1,1,1};
        int[] arr = new int[] {1,1,0,1};
        System.out.println(s.findMaxConsecutiveOnes(arr));
    }
}
