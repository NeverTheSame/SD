using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;

namespace GraphTutorial {
    class Program {
        static string FormatDateTimeTimeZone(
            Microsoft.Graph.DateTimeTimeZone value,
            string dateTimeFormat) {
            // Parse the date/time string from Graph into a DateTime
            var dateTime = DateTime.Parse(value.DateTime);

            return dateTime.ToString(dateTimeFormat);
        }
        
        static void ListCalendarEvents(string userTimeZone, string dateTimeFormat)
        {
            var events = GraphHelper
                .GetCurrentWeekCalendarViewAsync(DateTime.Today, userTimeZone)
                .Result;

            Console.WriteLine("Events:");

            foreach (var calendarEvent in events)
            {
                Console.WriteLine($"Subject: {calendarEvent.Subject}");
                Console.WriteLine($"  Organizer: {calendarEvent.Organizer.EmailAddress.Name}");
                Console.WriteLine($"  Start: {FormatDateTimeTimeZone(calendarEvent.Start, dateTimeFormat)}");
                Console.WriteLine($"  End: {FormatDateTimeTimeZone(calendarEvent.End, dateTimeFormat)}");
            }
        }

        static IConfigurationRoot LoadAppSettings() {
            var appConfig = new ConfigurationBuilder()
                .AddUserSecrets<Program>()
                .Build();

            // Check for required settings
            if (string.IsNullOrEmpty(appConfig["appId"]) ||
                string.IsNullOrEmpty(appConfig["scopes"])) {
                return null;
            }

            return appConfig;
        }
        

        /*
        static void Main(string[] args) {
            // app id: d0724d85-d151-434e-abb9-74e7bd4ea93d

            Console.WriteLine(".NET Core Graph Tutorial\n");

            var appConfig = LoadAppSettings();
            
            if (appConfig == null) {
                Console.WriteLine("Missing or invalid appsettings.json...exiting");
                return;
            }

            var appId = appConfig["appId"];
            var scopesString = appConfig["scopes"];
            var scopes = scopesString.Split(';');

            
            // Initialize the auth provider with values from appsettings.json
            var authProvider = new DeviceCodeAuthProvider(appId, scopes);
            
            
            // Request a token to sign in the user
            // var accessToken = authProvider.GetAccessToken().Result;
            var accessToken = "eyJ0eXAiOiJKV1QiLCJub25jZSI6InJXeFN2X1pKRWxOM3dPRUo1cll4bG1ZbC1wUklDeVJjZ21XODdoc01Oa2ciLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDAiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xODIzYmUxYS00Y2QwLTQwOGItYTllZS00NWNiZmMwM2NlNTgvIiwiaWF0IjoxNjEzNTA5MTgwLCJuYmYiOjE2MTM1MDkxODAsImV4cCI6MTYxMzUxMzA4MCwiYWNjdCI6MCwiYWNyIjoiMSIsImFjcnMiOlsidXJuOnVzZXI6cmVnaXN0ZXJzZWN1cml0eWluZm8iLCJ1cm46bWljcm9zb2Z0OnJlcTEiLCJ1cm46bWljcm9zb2Z0OnJlcTIiLCJ1cm46bWljcm9zb2Z0OnJlcTMiLCJjMSIsImMyIiwiYzMiLCJjNCIsImM1IiwiYzYiLCJjNyIsImM4IiwiYzkiLCJjMTAiLCJjMTEiLCJjMTIiLCJjMTMiLCJjMTQiLCJjMTUiLCJjMTYiLCJjMTciLCJjMTgiLCJjMTkiLCJjMjAiLCJjMjEiLCJjMjIiLCJjMjMiLCJjMjQiLCJjMjUiXSwiYWlvIjoiQVVRQXUvOFRBQUFBYW9wL0YvdXg3cnN0a0xZdHNIL3VGWXdXYkprMVljZjlublhDMlJucmxmemZZd1dtUm9VcjhvblZjQTRNTVU0YVA3WnFHRGJRY1FrNGgxOE5kUkVqVmc9PSIsImFtciI6WyJwd2QiLCJtZmEiXSwiYXBwX2Rpc3BsYXluYW1lIjoiLk5FVCBDb3JlIEdyYXBoIFR1dG9yaWFsIiwiYXBwaWQiOiJkMDcyNGQ4NS1kMTUxLTQzNGUtYWJiOS03NGU3YmQ0ZWE5M2QiLCJhcHBpZGFjciI6IjAiLCJmYW1pbHlfbmFtZSI6Ikt1a2xpbiIsImdpdmVuX25hbWUiOiJLaXJpbGwiLCJpZHR5cCI6InVzZXIiLCJpcGFkZHIiOiIxNzIuMjE4LjIyMS4xNDQiLCJuYW1lIjoiS2lyaWxsIEt1a2xpbiIsIm9pZCI6ImI1ZjQ4MzdmLTlkODEtNDM5Ni1iMTQ0LTZmOTE5ZTIzNWEyZiIsInBsYXRmIjoiMTQiLCJwdWlkIjoiMTAwMzIwMDBBMEMyNzFCRCIsInJoIjoiMC5BQUFBR3I0akdOQk1pMENwN2tYTF9BUE9XSVZOY3RCUjBVNURxN2wwNTcxT3FUMUdBTGMuIiwic2NwIjoiQ2FsZW5kYXJzLlJlYWRXcml0ZSBNYWlsYm94U2V0dGluZ3MuUmVhZCBvcGVuaWQgcHJvZmlsZSBVc2VyLlJlYWQgZW1haWwiLCJzaWduaW5fc3RhdGUiOlsia21zaSJdLCJzdWIiOiI4am1VcHlfRE9LY0l1WUJOTzZqSlVZamVTQnhrdHgzM3RMVjNLZXpIWV9zIiwidGVuYW50X3JlZ2lvbl9zY29wZSI6Ik5BIiwidGlkIjoiMTgyM2JlMWEtNGNkMC00MDhiLWE5ZWUtNDVjYmZjMDNjZTU4IiwidW5pcXVlX25hbWUiOiJraXJpbGxAc2hha3Vkby5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJraXJpbGxAc2hha3Vkby5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJpUmxWR1FJWnMwMnJPWjk4N3NGaUFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyJmMjhhMWY1MC1mNmU3LTQ1NzEtODE4Yi02YTEyZjJhZjZiNmMiLCI2MmU5MDM5NC02OWY1LTQyMzctOTE5MC0wMTIxNzcxNDVlMTAiLCJiNzlmYmY0ZC0zZWY5LTQ2ODktODE0My03NmIxOTRlODU1MDkiXSwieG1zX3N0Ijp7InN1YiI6ImdQdW1Wd1RRUndGYjBWanRTTmMwLWVHeUVpTXMxQUFCMTF4RGszUEx6TVkifSwieG1zX3RjZHQiOjE1ODM0NjQ4MzZ9.UyBzWOHIfjIpicxgp18uxYolMYBesimdNyWB41sJlFgTBx0BsksXdDa_lAZH6x6B5hTDu4GjNIJf5XVorV3ViBUgK6zrVcZxjoVZ1s_3BPyGkpIVEri9NeiI5Zebi0kni_Cu7il5dqY7pEyFLlxV48FNxiMCtZh9fx-v01LijEmwZycd97BQR-t-NAg-_BSFp7U_BuNasCD2DF5Aoq0Ln-FEImTfHuPsLeOSHQxV27dO94vTumNBT_QyUXWB6qte51hv15SDTRw61hsvYUA9n9FY8DAh6Uc5_4us1QffbNsX9nbsJO9hyXV2CAv8VSJYZAxTw41I6Wq8nGIsPPBCBg";
            
            // Initialize Graph client
            GraphHelper.Initialize(authProvider);
            
            // Get signed in user
            var user = GraphHelper.GetMeAsync().Result;

            // After you log in the app welcomes you by name.
            Console.WriteLine($"Welcome {user.DisplayName}!\n");

            int choice = -1;

            while (choice != 0) {
                Console.WriteLine("Please choose one of the following options:");
                Console.WriteLine("0. Exit");
                Console.WriteLine("1. Display access token");
                Console.WriteLine("2. View this week's calendar");
                Console.WriteLine("3. Add an event");

                try {
                    choice = int.Parse(Console.ReadLine());
                }
                catch (System.FormatException) {
                    // Set to invalid value
                    choice = -1;
                }

                switch (choice) {
                    case 0:
                        // Exit the program
                        Console.WriteLine("Goodbye...");
                        break;
                    case 1:
                        // Display access token
                        Console.WriteLine($"Access token: {accessToken}\n");
                        break;
                    case 2:
                        // List the calendar
                        // TODO produces Unhandled exception. System.FormatException: Input string was not in a correct format.
                        ListCalendarEvents(
                            user.MailboxSettings.TimeZone,
                            $"{user.MailboxSettings.DateFormat} {user.MailboxSettings.TimeFormat}"
                        );
                        break;
                    case 3:
                        // Create a new event
                        // TODO https://docs.microsoft.com/en-us/graph/tutorials/dotnet-core?tutorial-step=5
                        break;
                    default:
                        Console.WriteLine("Invalid choice! Please try again.");
                        break;
                }
            }
        }*/
    }
}