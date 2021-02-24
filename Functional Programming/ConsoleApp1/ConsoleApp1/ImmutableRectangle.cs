namespace ConsoleApp1
{
    public class ImmutableRectangle
    {
        private int Length { get; }
        private int Height { get; }

        public ImmutableRectangle(int length, int height)
        {
            Length = length;
            Height = height;
        }

        public ImmutableRectangle Grow(int length, int height) =>
            new ImmutableRectangle(Length + length, Height + height);
    }
}