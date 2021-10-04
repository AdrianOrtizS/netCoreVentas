using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ingresos
{
    public class IngresoVerViewModel
    {
        //Propiedades ingreso
        public int idproveedor { get; set; }
        public string proveedor { get; set; }
        public int idusuario { get; set; }
        public string usuario { get; set; }
        public string tipo_comprobante { get; set; }
        public string serie_comprobante { get; set; }
        public string num_comprobante { get; set; }
        
        public decimal impuesto12 { get; set; }
        public decimal impuesto0 { get; set; }

        public decimal total { get; set; }
        public DateTime fecha { get; set; }

        public string estado { get; set; }

        //Propiedades Detalle Lista
        public List<DetalleIngresoViewModel> detalles { get; set; }
    }
}
