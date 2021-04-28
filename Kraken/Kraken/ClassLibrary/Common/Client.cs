namespace ClassLibrary.Common
{
    /// <summary>
    /// Defines the <see cref="Client" />.
    /// </summary>
    public class Client
    {
        /// <summary>
        /// Gets or sets the ClientCode.
        /// </summary>
        public string ClientCode { get; set; }

        /// <summary>
        /// Gets or sets the CompanyName.
        /// </summary>
        public string CompanyName { get; set; }

        /// <summary>
        /// Gets or sets the Address1.
        /// </summary>
        public string Address1 { get; set; }

        /// <summary>
        /// Gets or sets the Address2.
        /// </summary>
        public string Address2 { get; set; }

        /// <summary>
        /// Gets or sets the City.
        /// </summary>
        public string City { get; set; }

        /// <summary>
        /// Gets or sets the Province.
        /// </summary>
        public string Province { get; set; }

        /// <summary>
        /// Gets or sets the PostalCode.
        /// </summary>
        public string PostalCode { get; set; }

        /// <summary>
        /// Gets or sets the YtdSales.
        /// </summary>
        public decimal YtdSales { get; set; }

        /// <summary>
        /// Gets or sets the Notes.
        /// </summary>
        public string Notes { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether client is on a credit hold...
        /// </summary>
        public bool CreditHold { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether HasInvoices.
        /// </summary>
        public bool HasInvoices { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="Client"/> class.
        /// </summary>
        /// <param name="clientCode">The clientCode<see cref="string"/>.</param>
        /// <param name="companyName">The companyName<see cref="string"/>.</param>
        /// <param name="address1">The address1<see cref="string"/>.</param>
        /// <param name="address2">The address2<see cref="string"/>.</param>
        /// <param name="city">The city<see cref="string"/>.</param>
        /// <param name="province">The province<see cref="string"/>.</param>
        /// <param name="postalCode">The postalCode<see cref="string"/>.</param>
        /// <param name="ytdSales">The ytdSales<see cref="decimal"/>.</param>
        /// <param name="creditHold">The creditHold<see cref="bool"/>.</param>
        /// <param name="notes">The notes<see cref="string"/>.</param>
        public Client(string clientCode, string companyName, string address1,
            string address2, string city, string province, string postalCode,
            decimal ytdSales, bool creditHold, string notes)
        {
            ClientCode = clientCode;
            CompanyName = companyName;
            Address1 = address1;
            Address2 = address2;
            City = city;
            Province = province;
            PostalCode = postalCode;
            YtdSales = ytdSales;
            CreditHold = creditHold;
            Notes = notes;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Client"/> class.
        /// </summary>
        public Client()
        {
        }

        /// <summary>
        /// The ToString.
        /// </summary>
        /// <returns>The <see cref="string"/>.</returns>
        public override string ToString()
        {
            return ClientCode + " " + CompanyName;
        }
    }
}
