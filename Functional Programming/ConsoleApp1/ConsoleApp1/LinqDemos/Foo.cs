using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace ConsoleApp1.LinqDemos
{
    public class Params : IEnumerable<int>
    {
        public Params(int a, int b, int c)
        {
            this.a = a;
            this.b = b;
            this.c = c;
        }
        
        private int a, b, c;
        public IEnumerator<int> GetEnumerator()
        {
            yield return a;
            yield return b;
            yield return c;
        }
        
        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
    
    public class Foo : Collection<int>
    {
        
    }
}