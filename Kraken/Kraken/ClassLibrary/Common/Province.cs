namespace ClassLibrary.Common
{
    /// <summary>
    /// Defines the <see cref="Province" />.
    /// </summary>
    public class Province
    {
        /// <summary>
        /// Gets the Name.
        /// </summary>
        public string Name { get; }

        /// <summary>
        /// Gets the Abbreviation.
        /// </summary>
        public string Abbreviation { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="Province"/> class.
        /// </summary>
        /// <param name="name">The name<see cref="string"/>.</param>
        /// <param name="abbreviation">The abbreviation<see cref="string"/>.</param>
        public Province(string name, string abbreviation)
        {
            Name = name;
            Abbreviation = abbreviation;
        }
    }
}
