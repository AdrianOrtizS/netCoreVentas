using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ingresos
{
    public class DetalleIngresoViewModel
    {

        [Required]
        public int idarticulo { get; set; }

        public string articulo { get; set; }

        [Required]
        public int cantidad { get; set; }
        [Required]
        public decimal precio_compra { get; set; }

    }
}
