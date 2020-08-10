package fun.kirill.arrays;

public class Solution
{
    public void duplicateZeros(int[] arr)
    {
//        LeetArray.printArray(arr);
//      [1,0,2,3,0,4,5,0] → [1,0,0,2,3,0,0,4]
        for(int i = 4; i >= 1; i--)
        {
            arr[i+1] = arr[i];
        }
        for(int i = 5; i >= 1; i--)
        {
            arr[i+1] = arr[i];
        }

//        for(int i = 4; i >= 0; i--)
//        {
//            arr[i+1] = arr[i];
//        }
//        arr[4] = 0;

//        System.out.println("\n");
        LeetArray.printArray(arr);
    }
}