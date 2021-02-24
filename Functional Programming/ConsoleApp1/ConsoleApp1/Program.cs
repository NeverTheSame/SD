using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using ConsoleApp1.Delegates;
using ConsoleApp1.LinqDemos;
using static System.Drawing.Rectangle;

namespace ConsoleApp1
{
    class Program
    {
        static void WorkPerformed2(int hours, WorkType workType)
        {
            Console.WriteLine("WorkPerformed2 called " + hours.ToString());
        }
        
        static void WorkPerformed1(int hours, WorkType workType)
        {
            Console.WriteLine("WorkPerformed1 called " + hours.ToString());
        }

        static void DoWork(DelegatesAndEvents.WorkPerformedHandler del)
        {
            del(5, WorkType.Golf);
        }

        delegate int AddDelegate(int a, int b);
        delegate String UpperDelegate(String word);
        delegate bool LogDelegate();
        
        
        static void Main(string[] args)
        {
            LogDelegate ld = () =>
            {
                // UpdateDatabase();
                // WriteToEventLog();
                return true;
            };
            bool status = ld();
            
            AddDelegate ad = (a, b) => a + b;
            UpperDelegate up = word => word.ToUpper();
            
            Console.WriteLine(ad(1, 1));
            Console.WriteLine(up("hello"));
            // DelegatesAndEvents.WorkPerformedHandler del1 = WorkPerformed1;
            // DelegatesAndEvents.WorkPerformedHandler del2 = WorkPerformed2;

            // del1(5, WorkType.Golf);
            // del2(10, WorkType.GenerateReports);

            


            
            // Rectangle.Union(r1, r2);
            var rectangles = new[]
            {
                new Rectangle(0, 0, 20, 20), 
                new Rectangle(20, 20, 60, 60),
                new Rectangle(80, 80, 20, 20),
            };
            
            // Console.WriteLine(rectangles.Aggregate(Rectangle.Union));
            
            
            var numbers = Enumerable.Range(1, 10);
            var words = new[] {"one", "two", "three"};
            
            
            // Console.WriteLine(words.Aggregate("hello", (p,x) => p + "," + x));
            // Console.WriteLine("We have " + words.Count() + " elements");
            // LINQ.ShowResultList(numbers);
            
            // Console.WriteLine("Sum = " + 
            //                   numbers.Aggregate(
            //                       (p, x) => p+x));
            
            // seed 1 -> p1
            // p1 2 -> p2
            // p2 3 ...
            // Console.WriteLine("Product = " + 
            //                   numbers.Aggregate(1, (p, x) => p*x));
            
            // var integralTypes = new[] {typeof(int), typeof(short)};
            // var floatingTypes = new[] {typeof(float), typeof(double)};
            // LINQ.ShowResultList(integralTypes
            //     .Concat(floatingTypes)
            //     .Prepend(typeof(bool)));
            
            // 'System.Linq.Enumerable.Prepend<TSource>(System.Collections.Generic.IEnumerable<TSource>, TSource)'
            // 'ConsoleApp1.LinqDemos.ExtensionMethods.Prepend<T>(System.Collections.Generic.IEnumerable<T>, T)'
            
            // var numbers = new List<int> {1, 2, 3};
            // Console.WriteLine(numbers.First());
            // Console.WriteLine(numbers.First(x => x > 2));
            // Console.WriteLine(numbers.FirstOrDefault(x => x > 10));
            
            // Console.WriteLine(new int[]{123}.Single());
            // Console.WriteLine(new int[]{1,2,3}.SingleOrDefault()); // exception
            // Console.WriteLine(new int[]{}.SingleOrDefault()); // works on empty collection
            //
            // Console.WriteLine("Item at position 1: " + numbers.ElementAt(1));
            // Console.WriteLine("Item at position 1: " + numbers.ElementAtOrDefault(4));
            
            
            
            // var arr1 = new[] {1, 2, 3};
            // var arr2 = new[] {1, 2, 3};
            // Console.WriteLine(arr1 == arr2);
            // Console.WriteLine(arr1.Equals(arr2));
            //
            // Console.WriteLine(arr1.SequenceEqual(arr2));
            //
            // var list1 = new List<int>{1,2,3};
            // Console.WriteLine(arr1.SequenceEqual(list1));
            //
            //
            // var people = new Person[]
            // {
            //     new Person("Jane", "jane@foo.com"), 
            //     new Person("John", "john@foo.com"), 
            //     new Person("Chris", String.Empty), 
            // };
            //
            // var records = new Record[]
            // {
            //     new Record("Jane@foo.com", "JaneAtFoo"),
            //     new Record("Jane@foo.com", "JaneAtHome"),
            //     new Record("John@foo.com", "John1980"),
            // };
            // foreach (var person in people)
            // {
            //     Console.WriteLine(person.Email);
            // }

            // var query = people.Join(records,
            //     person => person.Email,
            //     record => record.Mail,
            //     (person, record) => new {Name = person.Name, SkypeId = record.SkypeId}
            // );
            //
            // foreach (var item in query)
            // {
            //     Console.WriteLine(item);
            // }
            
            
            object[] values = {1, 2.5, 3, 4.5};
            // int[] numbers = {3, 3, 1, 2, 3, 4};
            // LINQ.ShowResultList(numbers.Skip(2).Take(1));
            // LINQ.ShowResultList(numbers.SkipWhile(i => i == 3));
            // Console.WriteLine("Are all numbers greater than 0? " + 
            //                   numbers.All(x => x > 0));
            // Console.WriteLine("Are all numbers odd? " + 
            //                   numbers.All(x => x % 2 == 1));
            // Console.WriteLine("Any number less than 2? " + 
            //                   numbers.Any(x => x < 2));
            
            
            // LINQ.ShowResultList(FilteringSortingData.GetIntegers(values));
            IEnumerable<int> randomNumbersEnumerable = ProjectionOperations.GetRandomNumbers();
            string randomNumbersString = LINQ.DisplayListAsCsvString(randomNumbersEnumerable);
            IEnumerable<char> orderedNumbersEnumerable = randomNumbersString.OrderBy(x => x);
            
            // Console.WriteLine(LINQ.DisplayListAsCsvString(randomNumbersEnumerable));
            // Console.WriteLine(LINQ.DisplayListAsCsvString(randomNumbersEnumerable.OrderBy(x => x)));
            // Console.WriteLine(LINQ.DisplayListAsCsvString(randomNumbersEnumerable.OrderByDescending(x => x)));

            // string sentence = "This is a test";
            // Console.WriteLine(new string(sentence.Reverse().ToArray()));
            // string word1 = "hello";
            // string word2 = "help!";
            
            // LINQ.ShowResultList(word1.Distinct());

            // var lettersInBoth = word1.Intersect(word2);
            // LINQ.ShowResultList(lettersInBoth);
            
            // LINQ.ShowResultList(word1.Union(word2));
            // LINQ.ShowResultList(word1.Except(word2));
        }
    }
}