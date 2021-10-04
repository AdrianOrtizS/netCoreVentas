
namespace Sistema.Web.Models.ViewsModelAux
{
    //1
    public class PaginacionViewModel
    {
        public int Pagina { get; set; } = 1;
        public int recordsPorPagina = 10;

        private readonly int cantidadMaximaPorPagina = 15;

        public int RecordsPorPagina
        {
            get
            {
                return recordsPorPagina;
            }
            set
            {
                recordsPorPagina = (value > cantidadMaximaPorPagina) ? cantidadMaximaPorPagina : value;
            }
        }
    }
}