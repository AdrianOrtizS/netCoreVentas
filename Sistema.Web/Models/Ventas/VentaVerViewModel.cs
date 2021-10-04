using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ventas
{
    public class VentaVerViewModel
    {
        //Propiedades venta
        public int idcliente { get; set; }
        public string cliente { get; set; }

        public string direccion { get; set; }
        public string telefono { get; set; }
        public string num_documento { get; set; }


        public int idusuario { get; set; }
        public string usuario { get; set; }
        public string tipo_comprobante { get; set; }
        public string serie_comprobante { get; set; }
        public string num_comprobante { get; set; }

        public decimal impuesto12 { get; set; }
        public decimal impuesto0 { get; set; }
        public decimal descuento { get; set; }

        public decimal total { get; set; }
        public decimal subtotal { get; set; }
        public DateTime fecha { get; set; }

        public string estado { get; set; }

        //Propiedades Detalle Lista
        public List<DetalleVentaViewModel> detalles { get; set; }
    }
}
