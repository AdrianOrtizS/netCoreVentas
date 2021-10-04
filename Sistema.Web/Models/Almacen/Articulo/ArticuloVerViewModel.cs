using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Almacen.Articulo
{
    public class ArticuloVerViewModel
    {
        public int idarticulo { get; set; }
        public int idcategoria { get; set; }
        public string categoria { get; set; }
        public string codigo { get; set; }
        public string nombre { get; set; }
        public decimal precio_venta { get; set; }
        public decimal precio_compra { get; set; }
        public int stock { get; set; }
        public string descripcion { get; set; }
        public bool condicion { get; set; }
        public bool iva { get; set; }
        public string foto { get; set; }
        public IFormFile FormFile { get; set; }
        public int utilidad { get; set; }

        //        public List<Articulo_TipoArticulo> Art_TippoArt { get; set; }
        public List<ArticuloTipoListVerViewModel> tiposArt { get; set; }

    }
}
