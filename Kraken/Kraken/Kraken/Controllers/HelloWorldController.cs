using System;
using System.Diagnostics;
using System.Text;
using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Mvc;

    
    
namespace Kraken.Controllers {
    public class HelloWorldController : Controller
    {
        // 
        // GET: /HelloWorld/

        public IActionResult Index()
        {
            return View();
        }

        // 
        // GET: /HelloWorld/Welcome/ 

        public string Welcome() {
            String result = string.Empty;
            var allClients = ClassLibrary.Business.ClientValidation.GetClients();
            foreach (var client in allClients) {
                Debug.WriteLine(client.ToString());
                result += client.ToString() + '\n';
            }
            // return HtmlEncoder.Default.Encode($"{result}");
            return result;
        }
    }
}