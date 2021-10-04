using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sistema.Entidades
{
    public class Articulo
    {
        [Key]
        public int idarticulo { get; set; }
        [Required]
        [ForeignKey("categoria")]
        public int idcategoria { get; set; }
        public string codigo { get; set; }
        [StringLength(40, MinimumLength = 3, ErrorMessage = "El nombre no debe ser menos de 3 letras y mayor de 40")]
        public string nombre { get; set; }

        [Column(TypeName = "decimal(16,2)")]
        public decimal precio_venta { get; set; }
        [Column(TypeName = "decimal(16,2)")]
        public decimal precio_compra { get; set; }
        [Required]
        public int stock { get; set; }
        public string descripcion { get; set; }
        public bool condicion { get; set; }
        public string foto { get; set; }
        //public IFormFile FormFile { get; set; }

        public bool iva { get; set; }

        public int utilidad { get; set; }

        public Categoria categoria { get; set; }
        public ICollection<DetalleIngreso> detalles { get; set; }



        public List<Articulo_TipoArticulo> Art_TipoArt { get; set; }



    }
}
