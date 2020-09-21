using System;
using Xunit;

namespace GradeBook.Tests
{

    public delegate string WriteLogDelegate(string logMessage);
    
    public class TypeTests
    {
        int count = 0;
        
        [Fact]
        public void WriteLogDelegateCanPointToMethod()
        {
            WriteLogDelegate log = ReturnMessage;
            
            log += ReturnMessage;
            log += IncrementCount;
            
            var result = log("Hello!");
            Assert.Equal(3, count);
        }

        string IncrementCount(string message)
        {
            count++;
            return message.ToLower();
        }
        
        string ReturnMessage(string message)
        {
            count++;
            return message;
        }
        
        [Fact]
        public void StringBehavesLikeValueTypes()
        {
            string name = "Scott";
            var upper = MakeUpperCase(name);
            
            Assert.Equal("SCOTT", upper);
            Assert.Equal("Scott", name);
        }

        public string MakeUpperCase(string parameter)
        {
            return parameter.ToUpper();
        }
        
        [Fact]
        public void Test1()
        {
            var x = GetInt();
            SetInt(ref x); // it is not going to be changed to 42 because we pass by value in C#, unless add ref before parameter
            Assert.Equal(42, x);
        }

        private void SetInt(ref int z)
        {
            z = 42;
        }
            
            
        private int GetInt()
        {
            return 3;
        }
        
        [Fact]
        public void PassByRef()
        {
            var book1 = GetBook("Book 1");
            GetBookSetName(ref book1, "New Name");

            Assert.Equal("New Name", book1.Name);
        }
		
        
        private void GetBookSetName(ref Book book, string name)
        {
            book = new DiskBook(name);
        }
        
        
		[Fact]
        public void IsPassByValue()
        {
            var book1 = GetBook("Book 1");
            // making a copy of a value in book1
            GetBookSetName(book1, "New Name");

            Assert.Equal("Book 1", book1.Name);
        }
		
        // doesn't change the name of the book
		private void GetBookSetName(Book book, string name)
		{
			book = new DiskBook(name);
            book.Name = name;
        }

		[Fact]
        public void CanSetNameFromReference()
        {
            var book1 = GetBook("Book 1");
            SetName(book1, "New Name");

            Assert.Equal("New Name", book1.Name);
        }
		
        // changes the name of the book
		private void SetName(Book book, string name)
		{
			book.Name = name;
		}

        [Fact]
        public void GetBookReturnsDifferentObjects()
        {
            var book1 = GetBook("Book 1");
            var book2 = GetBook("Book 2");

            Assert.Equal("Book 1", book1.Name);
            Assert.Equal("Book 2", book2.Name);
            Assert.NotSame(book1, book2);
        }
        
        
        [Fact]
        public void TwoVariablesCanReferenceSameObject()
        {
            var book1 = GetBook("Book 1");
            var book2 = book1;

            Assert.Same(book1, book2);
            Assert.True(Object.ReferenceEquals(book1, book2));
        }
        
        Book GetBook(string name)
        {
            return new DiskBook(name);
        }
    }
}
