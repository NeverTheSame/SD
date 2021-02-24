using System.Collections;
using System.Collections.Generic;

namespace ConsoleApp1.LinqDemos
{
    public static class ExtensionMethods
    {
        public static IEnumerable<T> Prepend<T>(this IEnumerable<T> values, T value)
        {
            yield return value;
            foreach (var item in values)
            {
                yield return item;
            }
        } 
    }
}