using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Sistema.Entidades
{
    public class DetalleVenta
    {
        [Key]
        public int iddetalle_venta { get; set; }
        [Required]
        [ForeignKey("venta")]
        public int idventa { get; set; }
        [Required]
        [ForeignKey("articulo")]
        public int idarticulo { get; set; }
        [Required]
        public int cantidad { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        [Required]
        public decimal precio_venta { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        public decimal descuento { get; set; }

        public Venta venta { get; set; }

        public Articulo articulo { get; set; }
    }
}
