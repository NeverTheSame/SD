using System;
using System.Collections.Generic;

namespace GradeBook
{
    class Program
    {
        static void Main(string[] args)
        {
            IBook book = new DiskBook("Scott's Grade Book");
            book.GradeAdded += OnGradeAdded;

            static void OnGradeAdded(object sender, EventArgs e)
            {
                Console.WriteLine("A grade was added");
            }
            
            EnterGrades(book);
            
            var stats = book.GetStatistics();
            
            Console.WriteLine($"For the book named {book.Name}");
            Console.WriteLine($"The average grade is: {stats.Average:N1}");
            Console.WriteLine($"The maximum grade is: {stats.High}");
            Console.WriteLine($"The minimum grade is: {stats.Low}");
            Console.WriteLine($"The letter is: {stats.Letter}");
            Func<double, double> avgDividedByTen = number => stats.Average / number;
            Console.WriteLine($"Testing lambda expressions. The avg grade divided by 10 is {avgDividedByTen(10)}");

            // const int factor = 5;
            // Func<int, int> multiplier = n => n * factor;
            //
            // var result = multiplier(10);
            // Console.WriteLine(result);
            
            
        }



        private static void EnterGrades(IBook book)
        {
            
            var gradeCount = 0; 
            while (true)
            {
                Console.Write($"Enter {gradeCount + 1} grade or 'q' to quit: ");
                var input = Console.ReadLine();

                if (input == "q")
                {
                    break;
                }
                
                try
                {
                    var grade = double.Parse(input);
                    book.AddGrade(grade);

                    gradeCount++;
                }
                catch (ArgumentException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                catch (FormatException ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
}
