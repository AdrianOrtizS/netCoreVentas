using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Auxiliar
{
    //2 =>NO reemplazo en controller de forma directa
    public static class HttpContextExtencions
    {
                       //Devuelve cantidad de registros en Db a cabecera de peticion
        public async static Task InsertarParametrosPaginacionEnCabecera<T>(this HttpContext httpContext, 
                                                                            IQueryable<T> queryable)
        {
            if(httpContext == null) { throw new ArgumentNullException(nameof(httpContext)); }

            double cantidad = await queryable.CountAsync();
            httpContext.Response.Headers.Add("cantidadTotalRegistros",cantidad.ToString());
        }
    }
}
