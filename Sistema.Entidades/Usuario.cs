using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Sistema.Entidades
{
    public class Usuario
    {
        [Key]
        public int idusuario { get; set; }
        [Required]
        [ForeignKey("rol")]
        public int idrol { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Nombre debe tener mas de 3 y menos de 100 caracteres")]
        public string nombre { get; set; }
        public string tipo_documento { get; set; }
        public string num_documento { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        [Required]
        public string email { get; set; }
        [Required]
        public byte[] password_hash { get; set; }
        [Required]
        public byte[] password_salt { get; set; }
        public bool condicion { get; set; }
        public Rol rol { get; set; }
        public string foto { get; set; }

        public ICollection<Ingreso> ingresos{ get; set; }

    }
}
