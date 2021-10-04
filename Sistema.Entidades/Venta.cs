using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Sistema.Entidades
{
    public class Venta
    {
        [Key]
        public int idventa { get; set; }
        [Required]
        [ForeignKey("persona")]
        public int idcliente { get; set; }
        [Required]
        [ForeignKey("usuario")]
        public int idusuario { get; set; }
        [Required]
        public string tipo_comprobante { get; set; }
        public string serie_comprobante { get; set; }
        [Required]
        public string num_comprobante { get; set; }
        [Required]
        public DateTime fecha_hora { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        public decimal impuesto12 { get; set; }
        
        [Column(TypeName = "decimal(16,2)")]
        public decimal impuesto0 { get; set; }
        
        [Column(TypeName = "decimal(16,2)")]
        public decimal descuento { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        [Required]
        public decimal total { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        [Required]
        public decimal subtotal { get; set; }

        [Required]
        public string estado { get; set; }

        public ICollection<DetalleVenta> detalles { get; set; }

        public Usuario usuario { get; set; }
        public Persona persona { get; set; }
    }
}
