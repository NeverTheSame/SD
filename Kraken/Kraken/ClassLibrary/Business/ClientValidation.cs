using System.Diagnostics;

namespace ClassLibrary.Business
{
    using ClassLibrary.Common;
    using ClassLibrary.Data;
    using InvoiceLookupApi;
    using System.Collections.Generic;
    using System.Text.RegularExpressions;

    /// <summary>
    /// Defines the <see cref="ClientValidation" />.
    /// </summary>
    public class ClientValidation
    {
        /// <summary>
        /// Defines the list of errors..
        /// </summary>
        private static readonly List<string> Errors = new List<string>();

        /// <summary>
        /// Gets the Error Message..
        /// </summary>
        public static string ErrorMessage
        {
            get
            {
                string message = "";
                foreach (string error in Errors)
                {
                    message += error + "\r\n";
                }

                return message;
            }
        }

        /// <summary>
        /// Method to add the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int AddClient(ref Client client)
        {
            Debug.WriteLine("In add method? ");
            if (Validate(client))
            {
                return Repository.AddClient(ref client);
            }
            return -1;
        }

        /// <summary>
        /// Method to update the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <param name="originalClientCode">The originalClientCode<see cref="string"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int UpdateClient(Client client, string originalClientCode)
        {
            if (!Validate(client))
            {
                return -1;
            }
            return Repository.UpdateClient(client, originalClientCode);
        }

        /// <summary>
        /// Method to delete the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int DeleteClient(Client client) => Repository.DeleteClient(client);

        /// <summary>
        /// The GetClients.
        /// </summary>
        /// <returns>The list of all <see cref="Clients"/>.</returns>
        public static Clients GetClients()
        {
            return Repository.GetAllClients();
        }

        /// <summary>
        /// The GetProvinces.
        /// </summary>
        /// <returns>The <see cref="Provinces"/>.</returns>
        public static Provinces GetProvinces() => Repository.GetProvinces();

        /// <summary>
        /// The RepoDataLoaded.
        /// </summary>
        /// <returns>The <see cref="bool"/>.</returns>
        public static bool RepoDataLoaded() => Repository.DataFetchedFromRepo;

        /// <summary>
        /// Gets Client Table Name.
        /// </summary>
        /// <returns>The <see cref="string"/>.</returns>
        public static string GetClientTableName() => Repository.ClientTableName;

        /// <summary>
        /// The GetInvoicesByClientCode.
        /// </summary>
        /// <param name="clientCode">The clientCode<see cref="string"/>.</param>
        /// <returns>The <see cref="List{Invoice}"/> of invoices .</returns>
        public static List<Invoice> GetInvoicesByClientCode(string clientCode) => InvoiceRepository.GetInvoicesByClientCode(clientCode);

        /// <summary>
        /// The Validate method with business logic.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <returns>True as <see cref="bool"/> if validation is successful.</returns>
        private static bool Validate(Client client)
        {
            Errors.Clear();

            #region ClientCodeValidation
            if (string.IsNullOrEmpty(client.ClientCode))
            {
                Errors.Add("Client code cannot be empty.");
            }
            const string clientCodeFilter = @"^[A-Z]{5}$";
            if (client.ClientCode != null && !Regex.IsMatch(client.ClientCode, clientCodeFilter))
            {
                Debug.WriteLine("Client code must consist of 5 capital characters");
                Errors.Add("Client code must consist of 5 capital characters.");
            }
            #endregion

            #region CompanyNameValidation
            if (string.IsNullOrEmpty(client.CompanyName))
            {
                Errors.Add("Company name cannot be empty.");
            }
            const int companyNameCharLimit = 40;
            if (client.CompanyName != null && client.CompanyName.Length > companyNameCharLimit)
            {
                Errors.Add($"Company name cannot be more than {companyNameCharLimit} characters.");
            }
            #endregion

            #region AddressValidation
            if (string.IsNullOrEmpty(client.Address1))
            {
                Errors.Add("Address cannot be empty.");
            }

            int addressCharLimit = 60;
            if (client.Address1 != null && client.Address1.Length > addressCharLimit)
            {
                Errors.Add($"Address cannot be more than {addressCharLimit} characters.");
            }

            if (client.Address2 != null && client.Address2.Length > addressCharLimit)
            {
                Errors.Add($"Second address cannot be more than {addressCharLimit} characters.");
            }
            #endregion

            #region CityValidation
            const int cityCharLimit = 20;
            if (client.City != null && client.City.Length > cityCharLimit)
            {
                Errors.Add($"City cannot be more than {cityCharLimit} characters.");
            }
            #endregion

            #region ProvinceValidation
            if (string.IsNullOrEmpty(client.Province))
            {
                Errors.Add("Province name cannot be empty.");
            }
            const int provinceCharLimit = 2;
            if (client.Province != null && client.Province.Length > provinceCharLimit)
            {
                Errors.Add($"province name cannot be more than {provinceCharLimit} characters.");
            }
            const string provinceFilter = @"^[A-Z]{2}$";
            if (client.Province != null && !Regex.IsMatch(client.Province, provinceFilter))
            {
                Errors.Add("Province must be of AA format.");
            }
            #endregion

            #region PostalCodeValidation
            const int postalCharLimit = 10;
            if (client.PostalCode != null && client.PostalCode.Length > postalCharLimit)
            {
                Errors.Add($"Postal code cannot be more than {postalCharLimit} characters.");
            }

            const string postalFilter = @"^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$";
            if (client.PostalCode != null && !Regex.IsMatch(client.PostalCode, postalFilter))
            {
                Errors.Add("Postal code must be of A9A 9A9 format.");
            }
            #endregion

            #region YtdSalesValidation
            if (client.YtdSales < 0.0m)
            {
                Errors.Add("YTD Sales cannot be negative.");
            }
            #endregion

            #region CreditHoldCLientValidation
            if (client.CreditHold)
            {
                if (string.IsNullOrEmpty(client.Address1))
                {
                    Errors.Add("Address cannot be empty.");
                }

                if (string.IsNullOrEmpty(client.City))
                {
                    Errors.Add("City cannot be empty.");
                }

                if (string.IsNullOrEmpty(client.Province))
                {
                    Errors.Add("Province cannot be empty.");
                }

                if (string.IsNullOrEmpty(client.PostalCode))
                {
                    Errors.Add("PostalCode cannot be empty.");
                }
            }
            #endregion

            return Errors.Count == 0;
        }
    }
}
