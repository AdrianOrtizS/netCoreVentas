using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ingresos
{
    public class IngresoCrearViewModel
    {
        //Propiedades ingreso
        [Required]
        public int idproveedor { get; set; }
        [Required]
        public int idusuario { get; set; }
        [Required]
        public string tipo_comprobante { get; set; }
        public string serie_comprobante { get; set; }
        [Required]
        public string num_comprobante { get; set; }
        
        public decimal impuesto12  { get; set; }
        public decimal impuesto0  { get; set; }
        
        [Required]
        public decimal total { get; set; }
        public DateTime fecha { get; set; }


        //Propiedades Detalle Lista
        [Required]
        public List<DetalleIngresoViewModel> detalles { get; set; }

    }
}
