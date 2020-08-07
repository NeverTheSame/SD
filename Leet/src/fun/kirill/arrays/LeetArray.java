package fun.kirill.arrays;

public class LeetArray
{
    public LeetArray(String type)
    {
        if(type.equals("DVD"))
        {
            DVD[] dvdCollection = new DVD[15];

            DVD avengersDVD = new DVD("The Avengers", 2012, "Joss Whedon");
            DVD incrediblesDVD = new DVD("The Incredibles", 2004, "Brad Bird");
            DVD findingDoryDVD = new DVD("Finding Dory", 2016, "Andrew Stanton");
            DVD lionKingDVD = new DVD("The Lion King", 2019, "Jon Favreau");

            dvdCollection[7] = avengersDVD;
            dvdCollection[3] = incrediblesDVD;
            dvdCollection[9] = findingDoryDVD;
            dvdCollection[2] = lionKingDVD;

            DVD starWarsDVD = new DVD("Star Wars", 1977, "George Lucas");
            dvdCollection[3] = starWarsDVD;
            for(DVD dvd: dvdCollection)
            {
                if(dvd != null)
                {
                    System.out.println(dvd);
                }
            }
        }
        else if(type.equals("ints"))
        {
            // Create a new array with a capacity of 6.
            int[] array = new int[6];

            // Current length is 0, because it has 0 elements.
            int length = 0;

            // Add 3 items into it.
            for (int i = 0; i < 3; i++) {
                array[i] = i * i;
                // Each time we add an element, the length goes up by one.
                length++;
            }

            System.out.println("The Array has a capacity of " + array.length);
            System.out.println("The Array has a length of " + length);
        }
    }

    public static void printArray(int[] intArray)
    {
        for(int i = 0; i < intArray.length; i++)
        {
            System.out.println("Index " + i + " contains " + intArray[i]);
        }
    }
}
