using System;

 namespace Komatik
{
    static class ConsolePrinter
    {
        public static void SetTitle()
        {
            Console.Title = "";
        }

        public static void PrintSeparator()
        {
            Console.WriteLine(new string('-', 60));
        }
        
        public static void PrintInvoiceListingMessage()
        {
            Console.WriteLine("Invoice Listing");
        }
        
        public static void PrintEmptyLine()
        {
            Console.WriteLine("");
        }

        public static void PrintNoArgsMessage()
        {
            Console.WriteLine("\nNo command line arguments provided.\n");
        }

        public static void PrintFileNotFoundMessage()
        {
            Console.WriteLine("\nFile not found.\n");
        }

        public static void PrintExceptionMessage(Exception ex)
        {
            Console.WriteLine($"\n{ex.Message}\n");
        }

        public static void PrintColumnNames()
        {
            Console.WriteLine("{0, 3} {1, -11} {2, -18} {3, 12} {4, -8} {5, -2}",
                "Qty", "SKU", "Description", "Price", "PST", "Ext");
        }
        

        public static void PressKeyToExit()
        {
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
        }


        public static void PrintCalculatedInvoiceData(string fieldName, double value) {
            Console.WriteLine($"{"", 3} " +
                              $"{"", -11} " +
                              $"{fieldName, -18} " +
                              $"{"", 12} " +
                              $"{"", 2} " +
                              $"{value, 9:N}");
        }
    }
}
