namespace ClassLibrary.Common
{
    using System.Collections.Generic;
    using System.Linq;

    /// <summary>
    /// Defines the list of <see cref="Client" />.
    /// </summary>
    public class Clients : List<Client>
    {
        /// <summary>
        /// Gets the total YTD sales for all clients..
        /// </summary>
        public decimal TotalYtdSales => this.Sum(x => x.YtdSales);

        /// <summary>
        /// Gets the number of clients on credit hold..
        /// </summary>
        public int CreditHoldCount => this.Count(x => x.CreditHold);

        /// <summary>
        /// Gets the AverageYtdSales.
        /// </summary>
        public decimal AverageYtdSales => this.Average(x => x.YtdSales);
    }
}
