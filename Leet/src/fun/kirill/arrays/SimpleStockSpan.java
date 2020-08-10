package fun.kirill.arrays;

public class SimpleStockSpan
{
    public static void calculateSpans(int[] arr)
    {
        int[] spans = new int[arr.length];
        // initially we're at day 0
        for(int day = 0; day < arr.length; day++)
        {
            int lengthOfCurrentSpan = 1;
            boolean span_ends = false; // indicator variable, will be true when we reach the end of span
            // inner loop - calculating length of a span
            while(day - lengthOfCurrentSpan >= 0 && !span_ends)
            {
                // go back in time as far as we can
                if(arr[day-lengthOfCurrentSpan] <= arr[day])
                {
                    lengthOfCurrentSpan++;
                }
                else
                {
                    span_ends = true;
                }
            }
            spans[day] = lengthOfCurrentSpan;
            System.out.println("Day " + day + ": " + arr[day] + "\t→ " + spans[day]);
        }
    }
}
