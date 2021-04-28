using InvoiceLookupApi;
using System.Collections.Generic;
using ClassLibrary.Common;

namespace ClassLibrary.Data
{
    /// <summary>
    /// Defines the <see cref="InvoiceRepository" />.
    /// </summary>
    public static class InvoiceRepository
    {
        /// <summary>
        /// Method to get Invoices By Client Code.
        /// </summary>
        /// <param name="clientCode">The clientCode<see cref="string"/>.</param>
        /// <returns>The <see cref="List{Invoice}"/>.</returns>
        public static List<Invoice> GetInvoicesByClientCode(string clientCode)
        {
            return InvoiceLookupApiClient.GetInvoicesByClient(clientCode);
        }
    }
}
