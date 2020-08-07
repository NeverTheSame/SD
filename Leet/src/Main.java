import fun.kirill.arrays.LeetArray;

public class Main
{
    public static void main(String[] args)
    {
        int[] intArray = new int[6];
        int length = 0;

        // Inserting at the End of an Array
        for (int i = 0; i < 3; i++)
        {
            intArray[length] = i;
            length++;
        }
        intArray[length] = 10;

        // Inserting at the Start of an Array
        for(int i = 3; i >= 0; i--)
        {
            intArray[i + 1] = intArray[i];
        }
        intArray[0] = 20;

        // Inserting Anywhere in the Array
        for(int i = 4; i >= 2; i--)
        {
            intArray[i + 1] = intArray[i];
        }
        intArray[2] = 30;
        LeetArray.printArray(intArray);
    }
}
