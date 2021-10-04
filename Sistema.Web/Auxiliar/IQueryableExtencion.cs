using Sistema.Web.Models.ViewsModelAux;
using System.Linq;

namespace Sistema.Web.Auxiliar
{
    //2                    
    public static class IQueryableExtencion
    {
        //Cantidad de registros de una tabla 
        //Agrega metodo Paginar a IQueryable
        public static IQueryable<T> Paginar<T>( this IQueryable<T> queryable, 
                                                PaginacionViewModel paginacionDto)
        {
            return queryable.Skip((paginacionDto.Pagina - 1) * paginacionDto.RecordsPorPagina)
                            .Take(paginacionDto.RecordsPorPagina);
        }


        
    }
}
