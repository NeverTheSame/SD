using ClassLibrary.Common;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace ClassLibrary.Data
{
    /// <summary>
    /// Defines the <see cref="Repository" /> that supplies the data for this project.
    /// </summary>
    internal class Repository
    {
        public static bool DataFetchedFromRepo = true;
        /// <summary>
        /// Defines the SQL Connection String.
        /// </summary>
        private const string ConnectionString = @"Server=tcp:comp2614.database.windows.net,1433;
             Initial Catalog=comp2614;
             User ID=student;
             Password=iLOVEpho!;
             Encrypt=True;
             TrustServerCertificate=False;
             Connection Timeout=30;";

        /// <summary>
        /// Defines the ClientTableName.
        /// </summary>
        internal const string ClientTableName = "Client1233289";

        /// <summary>
        /// Fetches all clients from SQL DB.
        /// </summary>
        /// <returns>The <see cref="Clients"/>.</returns>
        public static Clients GetAllClients()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                string query = $@"SELECT ClientCode, CompanyName, Address1, Address2, City, Province, PostalCode, YTDSales, CreditHold, Notes
                                  FROM {ClientTableName}
                                  ORDER BY ClientCode";

                using (var cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;
                    conn.Open();

                    var clients = new Clients();

                    using (var reader = cmd.ExecuteReader())
                    {
                        string address2 = null;
                        string city = null;
                        string postalCode = null;
                        string notes = null;

                        while (reader.Read())
                        {
                            var clientCode = reader["ClientCode"] as string;
                            var companyName = reader["CompanyName"] as string;
                            var address1 = reader["Address1"] as string;

                            if (!reader.IsDBNull(reader.GetOrdinal("Address2")))
                            {
                                address2 = reader["Address2"] as string;
                            }
                            if (!reader.IsDBNull(reader.GetOrdinal("City")))
                            {
                                city = reader["City"] as string;
                            }
                            var province = reader["Province"] as string;

                            if (!reader.IsDBNull(reader.GetOrdinal("PostalCode")))
                            {
                                postalCode = reader["PostalCode"] as string;
                            }
                            var ytdSales = (decimal)reader["YTDSales"];
                            var creditHold = (bool)reader["CreditHold"];

                            if (!reader.IsDBNull(reader.GetOrdinal("Notes")))
                            {
                                notes = reader["Notes"] as string;
                            }
                            clients.Add(new Client(clientCode, companyName, address1, address2,
                                city, province, postalCode, ytdSales, creditHold, notes));

                            address2 = null;
                            city = null;
                            postalCode = null;
                            notes = null;
                        }
                    }
                    
                    return clients;
                }
            }
        }

        /// <summary>
        /// Gets client by using Client code.
        /// </summary>
        /// <param name="clientCode">The clientCode<see cref="string"/>.</param>
        /// <returns>The <see cref="Client"/>.</returns>
        public static Client GetClient(string clientCode)
        {
            Client client = null;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = $@"SELECT ClientCode, CompanyName, Address1, Address2, City, Province, PostalCode, YTDSales, CreditHold, Notes
                                  FROM {ClientTableName}
                                  WHERE ClientCode = @ClientCode";

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        string address2 = null;
                        string city = null;
                        string postalCode = null;
                        string notes = null;

                        while (reader.Read())
                        {
                            var clientCodeFromDB = reader["ClientCode"] as string;
                            var companyName = reader["CompanyName"] as string;
                            var address1 = reader["Address1"] as string;

                            if (!reader.IsDBNull(reader.GetOrdinal("Address2")))
                            {
                                address2 = reader["Address2"] as string;
                            }
                            if (!reader.IsDBNull(reader.GetOrdinal("City")))
                            {
                                city = reader["City"] as string;
                            }
                            var province = reader["Province"] as string;

                            if (!reader.IsDBNull(reader.GetOrdinal("PostalCode")))
                            {
                                postalCode = reader["PostalCode"] as string;
                            }
                            var ytdSales = (decimal)reader["YTDSales"];
                            var creditHold = (bool)reader["CreditHold"];

                            if (!reader.IsDBNull(reader.GetOrdinal("Notes")))
                            {
                                notes = reader["Notes"] as string;
                            }
                            client = new Client(clientCodeFromDB, companyName, address1, address2,
                                city, province, postalCode, ytdSales, creditHold, notes);

                            address2 = null;
                            city = null;
                            postalCode = null;
                            notes = null;
                        }

                    }

                }
            }
            return client;
        }

        /// <summary>
        /// Method to add the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int AddClient(ref Client client)
        {
            int rowsAffected;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = $@"INSERT INTO {ClientTableName}
                                 (ClientCode, CompanyName, Address1, Address2, City, Province, PostalCode, YTDSales, CreditHold, Notes)
                                  VALUES (@clientCode, @companyName, @companyName, @address2, @city, @province, @postalCode, @ytdSales, @creditHold, @notes)";

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;

                    cmd.Parameters.AddWithValue("clientCode", client.ClientCode);
                    cmd.Parameters.AddWithValue("companyName", client.CompanyName);
                    cmd.Parameters.AddWithValue("address1", client.Address1);
                    cmd.Parameters.AddWithValue("address2", (object)client.Address2 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("city", (object)client.City ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("province", client.Province);
                    cmd.Parameters.AddWithValue("postalCode", (object)client.PostalCode ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("ytdSales", client.YtdSales);
                    cmd.Parameters.AddWithValue("creditHold", client.CreditHold);
                    cmd.Parameters.AddWithValue("notes", (object)client.Notes ?? DBNull.Value);

                    conn.Open();

                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }

        /// <summary>
        /// Method to update the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <param name="originalClientCode">The originalClientCode<see cref="string"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int UpdateClient(Client client, string originalClientCode)
        {
            int rowsAffected;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = $@"UPDATE {ClientTableName}
                                  SET ClientCode = @clientCode,
                                      CompanyName = @companyName,
                                      Address1 = @address1,
                                      Address2 = @address2,
                                      City = @city,
                                      Province = @province,
                                      PostalCode = @postalCode,
                                      YTDSales = @ytdSales,
                                      CreditHold = @creditHold,
                                      Notes = @notes
                                  WHERE ClientCode = @originalClientCode";

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;

                    cmd.Parameters.AddWithValue("clientCode", client.ClientCode);
                    cmd.Parameters.AddWithValue("companyName", client.CompanyName);
                    cmd.Parameters.AddWithValue("address1", client.Address1);
                    cmd.Parameters.AddWithValue("address2", (object)client.Address2 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("city", (object)client.City ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("province", client.Province);
                    cmd.Parameters.AddWithValue("postalCode", (object)client.PostalCode ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("ytdSales", client.YtdSales);
                    cmd.Parameters.AddWithValue("creditHold", client.CreditHold);
                    cmd.Parameters.AddWithValue("notes", (object)client.Notes ?? DBNull.Value);

                    cmd.Parameters.AddWithValue("originalClientCode", originalClientCode);

                    conn.Open();

                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }

            return rowsAffected;
        }

        /// <summary>
        /// Method to delete the client.
        /// </summary>
        /// <param name="client">The client<see cref="Client"/>.</param>
        /// <returns>The number of rows affected, or -1 if no rows were affected as <see cref="int"/>.</returns>
        public static int DeleteClient(Client client)
        {
            int rowsAffected;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = $@"DELETE {ClientTableName}
                                  WHERE ClientCode = @clientCode";

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;

                    cmd.Parameters.AddWithValue("clientCode", client.ClientCode);

                    conn.Open();

                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }

            return rowsAffected;
        }

        public static Provinces GetProvinces()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"SELECT ProvinceId, Sort, Abbreviation, Name
                              FROM Province
                              ORDER BY Sort";


                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = query;
                    cmd.Connection = conn;

                    conn.Open();

                    var provinces = new Provinces();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        string name = null;

                        while (reader.Read())
                        {
                            int provinceId = (int)reader["ProvinceId"];
                            int sort = (int)reader["Sort"];
                            string abbreviation = reader["Abbreviation"] as string;

                            if (!reader.IsDBNull(reader.GetOrdinal("Name")))
                            {
                                name = reader["Name"] as string;
                            }

                            provinces.Add(new Province(name, abbreviation));

                            // nulling out name so that if it is null it won't be taken from the previous tableName
                            name = null;
                            abbreviation = null;
                        }
                    }
                    return provinces;
                }
            }
        }
    }
}
