using System.Collections.Generic;
using System.Linq;

namespace ConsoleApp1.LinqDemos
{
    public class Person
    {
        private string middleName;
        private string lastName;
        
        public string Name;
        public string Email;

        public Person(string name, string email)
        {
            Name = name;
            Email = email;
        }
        
        

        public IEnumerable<string> Names
        {
            get
            {
                yield return Name;
                yield return middleName;
                yield return lastName;
            }
        }
    }
}