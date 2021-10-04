using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sistema.Entidades
{
    public class Configuracion
    {
        [Key]
        public int idconfiguracion { get; set; }
        [Required]
        public string descripcion { get; set; }
        [Required]
        public string valor { get; set; }
    }
}
