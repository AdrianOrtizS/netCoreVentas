using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Usuarios.Usuario
{
    public class UsuarioActualizarViewModel
    { 
        [Required]
        public int idusuario { get; set; }
        [Required]
        public int idrol { get; set; }
        //public string rol { get; set; }
        [Required]
        [StringLength(100, ErrorMessage ="El nombre no debe tener mas de 100 y menos de 3 caracteres")]
        public string nombre { get; set; }
        public string tipo_documento { get; set; }
        public string num_documento { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }

        [Required]
        [EmailAddress]
        public string email { get; set; }
        public string foto { get; set; }

        /* [Required]
         public string password { get; set; }
         public bool act_password { get; set; }
 */
        //        public bool condicion { get; set; }
    }
}
