using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Sistema.Entidades
{
    public class Categoria
    {
        [Key]
        public int idcategoria { get; set; }
        [Required]
        [StringLength(40, MinimumLength =3, ErrorMessage ="El nombre no debe ser menos de 5 letras y mayor de 40")]
        public string nombre { get; set; }
        [StringLength(255)]
        public string descripcion { get; set; }
        public bool condicion { get; set; }

        public ICollection<Articulo> articulos { get; set; }
    }
}
