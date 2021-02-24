using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace ConsoleApp1.LinqDemos
{
    public class LINQ
    {

        public static string DisplayListAsCsvString(IEnumerable<int> items)
        {
            var csvString = new Func<IEnumerable<int>, string>(values =>
            {
                return string.Join(",", values.Select(v => v.ToString()).ToArray());
            });
            return csvString(items);
        }

        public static void ShowResultList(IEnumerable enumerableCollection)
        {
            foreach (var result in enumerableCollection)
            {
                Console.WriteLine(result);
            }
        }
        
        static void Execute()
        {
            var ints = Enumerable.Range('a', 'z' - 'a')
                .Select(c => (char) c);
            var strings = Enumerable.Range(1, 10)
                .Select(i => new string('x', i));

            var numbers = Enumerable.Range(1, 10);
            var dict = numbers.ToDictionary(
                i => (double)i / 10,
                i => i % 2 == 0);

            var arr2 = new[] {1, 2, 3};
            var arrEnumerable = arr2.AsEnumerable();
            IEnumerable<int> arrE = arr2.AsEnumerable();
            // AsQuerable, AsParallel
            
        }
    }

    public static class ProjectionOperations
    {
        public static IEnumerable Execute()
        {
            var numbers = Enumerable.Range(1, 4);
            var squares = numbers.Select(x => x * x); // map reduce

            string sentence = "This is sentence";
            var wordsLength = GetWordsLength(sentence);
            var wordsWithLength = GetWordsWithLength(sentence);
            var randomNumbers = GetRandomNumbers();

            var sequences = new[] {"red,green,blue", "orange", "white,pink"};
            var allWords = FlattenStructure(sequences);

            string[] objects = {"house", "car", "bicycle"}; 
            string[] colors = {"red", "green", "gray"};
            var pairsOfStrings = GetStringPairs(colors, objects);
            var pairs = CreateCartesianProductPairs(colors, objects);
            
            return pairs;
        }

        private static IEnumerable CreateCartesianProductPairs(string[] colors, string[] objects)
        {
            var pairs = colors.SelectMany(_ => objects,
                (c, o) => new {Color = c, Obj = o});
            return pairs;
        }

        private static IEnumerable<string> GetStringPairs(string[] colors, string[] objects)
        {
            var pairs = colors.SelectMany(_ => objects,
                (c, o) => $"{c} {o}");
            return pairs;
        }

        private static IEnumerable<string> FlattenStructure(string[] sequences)
        {
            var allWords = sequences.SelectMany(s => s.Split(','));
            return allWords;
        }

        private static IEnumerable<int> GetWordsLength(string sentence)
        {
            var wordsLength = sentence.Split().Select(w => w.Length);
            return wordsLength;
        }

        public static IEnumerable<int> GetRandomNumbers()
        {
            Random rand = new Random();
            var randomNumbers = Enumerable.Range(1, 10)
                .Select(_ => rand.Next((10)) - 5);
            return randomNumbers; // add .ToArray() if required materialized data structure
        }

        private static IEnumerable GetWordsWithLength(string sentence)
        {
            var wordsWithLength = sentence.Split()
                .Select(w => new
                {
                    Word = w, Size = w.Length
                });
            return wordsWithLength;
        }
    }
    
    public static class FilteringSortingData {
        
        public static IEnumerable GetEvenNumbers(int start, int count)
        {
            var numbers = Enumerable.Range(start, count);
            var evenNumbers = numbers.Where(n => n % 2 == 0);
            return evenNumbers;
        }

        public static IEnumerable GetOddSquares(int start, int count)
        {
            var numbers = Enumerable.Range(start, count);
            var oddSquares = numbers.Select(x => x * x)
                .Where(y => y % 2 == 1);
            return oddSquares;
        }

        public static IEnumerable GetIntegers(object [] values)
        {
            return values.OfType<int>();
        }
        
        
    }
}