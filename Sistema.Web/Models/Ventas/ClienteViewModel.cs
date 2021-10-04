using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas
{
    public class ClienteViewModel
    {
        public int idcliente { get; set; }

        public string nombre { get; set; }

        public string direccion  { get; set; }

        public string num_documento { get; set; }

        public string telefono  { get; set; }


    }
}
