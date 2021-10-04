using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sistema.Entidades
{
    public class Rol
    {
        [Key]
        public int idrol { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 3, ErrorMessage = "Nombre debe tener mas de 3 y menos de 100 caracteres")]
        public string nombre { get; set; }

        [StringLength(100, MinimumLength = 10, ErrorMessage = "Descripcion debe tener mas de 10 y menos de 100 caracteres")]
        public string descripcion { get; set; }

        public bool condicion { get; set; }

        public ICollection<Usuario> usuarios { get; set; }
    }
}
