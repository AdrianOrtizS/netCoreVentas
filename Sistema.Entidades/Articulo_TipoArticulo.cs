using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Sistema.Entidades
{
    public class Articulo_TipoArticulo
    {

/*        [Key]
        public int idTipo_Articulo { get; set; }
*/
        [Required]
        [ForeignKey("articulo")]
        public int idarticulo { get; set; }
        public Articulo articulo { get; set; }


        [Required]
        [ForeignKey("tipoArticulo")]
        public int idtipoArticulo { get; set; }
        public TipoArticulo tipoArticulo { get; set; }


    }
}
