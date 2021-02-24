namespace ConsoleApp1
{
    public class CustomRectangle
    {
        public int Length { get; set; }
        public int Height { get; set; }
        
        public void Grow(int length, int height) 
        {
            Length += length;
            Height += height;
        }
    }
}