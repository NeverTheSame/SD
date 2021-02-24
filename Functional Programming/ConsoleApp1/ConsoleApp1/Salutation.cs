namespace ConsoleApp1
{
    public class Salutation
    {
        public static string GetSalutation(int hour) =>
            hour < 12 ? "Good morning" : "Good afternoon";

        public static string GetSalutationMutator(int hour)
        {
            string salutation;

            if (hour > 12)
            {
                salutation = "Good morning";
            }
            else
            {
                salutation = "Good afternoon";
            }

            return salutation;
        }
    }
}