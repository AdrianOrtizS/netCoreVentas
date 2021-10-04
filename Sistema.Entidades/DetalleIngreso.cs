using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Sistema.Entidades
{
    public class DetalleIngreso
    {
        [Key]
        public int iddetalle_ingreso { get; set; }
        [Required]
        [ForeignKey("ingreso")]
        public int idingreso { get; set; }
        [Required]
        [ForeignKey("articulo")]
        public int idarticulo { get; set; }
        [Required]
        public int cantidad { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        [Required]
        public decimal precio_compra { get; set; }

        public Ingreso ingreso { get; set; }

        public Articulo articulo { get; set; }
    }
}
