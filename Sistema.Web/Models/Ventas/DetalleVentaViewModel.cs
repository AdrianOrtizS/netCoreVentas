using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas
{
    public class DetalleVentaViewModel
    {
        [Required]
        public int idarticulo { get; set; }

        public string articulo { get; set; }

        [Required]
        public int cantidad { get; set; }
        [Required]
        public decimal precio_venta { get; set; }

        public decimal descuento { get; set; }

    }
}
