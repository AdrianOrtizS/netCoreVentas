using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sistema.Entidades
{
    public class TipoArticulo
    {
        [Key]
        public int idTipoArticulo { get; set; }
        public string tipoArticulo { get; set; }
        public bool condicion { get; set; }

        public List<Articulo_TipoArticulo> Art_TipoArt { get; set; }
    }
}
