using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Sistema.Web.Models.Almacen.Articulo
{
    public class ArticuloActualizarViewModel
    {
        [Required]
        public int idarticulo { get; set; }
        [Required]
        public int idcategoria { get; set; }
        //public string categoria { get; set; }
        public string codigo { get; set; }
        [StringLength(40, MinimumLength = 3, ErrorMessage = "El nombre no debe ser menos de 3 letras y mayor de 40")]
        public string nombre { get; set; }
        
        public decimal precio_venta { get; set; }
        public decimal precio_compra { get; set; }
        [Required]
        public int stock { get; set; }
        public string descripcion { get; set; }
        public string foto { get; set; }
        public IFormFile FormFile { get; set; }
        public bool iva { get; set; }
        public int utilidad { get; set; }

        public List<ArticuloTipoListCrearViewModel> tiposArt { get; set; }

        //public bool condicion { get; set; }
    }
}
