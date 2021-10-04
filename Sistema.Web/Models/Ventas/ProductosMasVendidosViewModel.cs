using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas
{
    public class ProductosMasVendidosViewModel
    {
        public int idProducto { get; set; }
        public string producto { get; set; }

        public int cantidad { get; set; }
    }
}
