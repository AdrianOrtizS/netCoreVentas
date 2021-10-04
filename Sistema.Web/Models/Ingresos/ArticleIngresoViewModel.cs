using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Models.Ingresos
{
    public class ArticleVentaViewModel
    {
        public int idarticulo { get; set; }
        public int idcategoria { get; set; }
        public string categoria { get; set; }
        public string codigo { get; set; }
        public string nombre { get; set; }
        public decimal precio_compra { get; set; }
        public int stock { get; set; }
        public bool iva { get; set; }

    }
}
