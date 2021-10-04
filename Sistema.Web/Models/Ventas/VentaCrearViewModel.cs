using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas
{
    public class VentaCrearViewModel
    {
        //Propiedades ingreso
        [Required]
        public int idcliente { get; set; }
        [Required]
        public int idusuario { get; set; }
        [Required]
        public string tipo_comprobante { get; set; }
        public string serie_comprobante { get; set; }
        [Required]
        public string num_comprobante { get; set; }

        public decimal impuesto12 { get; set; }
        public decimal impuesto0 { get; set; }
        public decimal descuento { get; set; }

        [Required]
        public decimal total { get; set; }
        public decimal subtotal { get; set; }
        public DateTime fecha { get; set; }


        //Propiedades Detalle Lista
        [Required]
        public List<DetalleVentaViewModel> detalles { get; set; }
    }
}
