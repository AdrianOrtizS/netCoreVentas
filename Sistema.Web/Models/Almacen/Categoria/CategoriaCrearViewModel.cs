using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Almacen.Categoria
{
    public class CategoriaCrearViewModel
    {
        [StringLength(40, MinimumLength = 5, ErrorMessage = "El nombre no debe ser menos de 5 letras y mayor de 40")]
        public string nombre { get; set; }
        [StringLength(255)]
        public string descripcion { get; set; }
      
    }
}
