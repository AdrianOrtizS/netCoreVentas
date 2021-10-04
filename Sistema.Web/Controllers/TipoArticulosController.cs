using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Hub;
using Sistema.Web.Models.Almacen.TipoArticulo;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoArticulosController : ControllerBase
    {
        private IQueryable<TipoArticulo> queryableTipoArticulo;     //metodo buscar 
        private readonly DbContextSistema _context;

        private readonly IHubContext<Mensaje> _hubContext;


        public TipoArticulosController(DbContextSistema context, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _hubContext = hubContext;

        }

        // GET: api/TipoArticulos/ListarDropdown
        [HttpGet("[action]")]
        public async Task<IEnumerable<TipoArticuloViewModel>> ListarDropdown()
        {

            var TipoArticulos = await _context.TipoArticulo.Where(c => c.condicion == true).ToListAsync();

            return TipoArticulos.Select(c => new TipoArticuloViewModel
            {
                idTipoArticulo = c.idTipoArticulo,
                tipoArticulo = c.tipoArticulo,
                condicion = c.condicion
            });
        }


        // GET: api/TipoArticulos/ListarCheck
        [HttpGet("[action]")]
        public async Task<IEnumerable<TipoArticuloViewModel>> ListarCheck()
        {

            var tiposArticulo = await _context.TipoArticulo.Where(c => c.condicion == true).ToListAsync();

            return tiposArticulo.Select(c => new TipoArticuloViewModel
            {
                idTipoArticulo = c.idTipoArticulo,
                tipoArticulo = c.tipoArticulo
            });
        }



        // GET: api/TipoArticulos/Listar
        [HttpGet("[action]")]
//        [Authorize]
        public async Task<IEnumerable<TipoArticuloViewModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableTipoArticulo = _context.TipoArticulo.AsQueryable();
            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);

            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableTipoArticulo.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var TipoArticulos = await this.queryableTipoArticulo.OrderBy(x => x.tipoArticulo)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return TipoArticulos.Select(c => new TipoArticuloViewModel
            {
                idTipoArticulo = c.idTipoArticulo,
                tipoArticulo = c.tipoArticulo,
                condicion = c.condicion
            });
        }


        // GET: api/TipoArticulos/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<TipoArticuloViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string campo,
                                                                  [FromRoute] string valor)
        {
            if (campo == "tipoArticulo")
            {
                this.queryableTipoArticulo = _context.TipoArticulo.Where(c => c.tipoArticulo.Contains(valor)).AsQueryable();
            }

            var TipoArticulos = await this.queryableTipoArticulo.OrderBy(x => x.tipoArticulo)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return TipoArticulos.Select(c => new TipoArticuloViewModel
            {
                idTipoArticulo = c.idTipoArticulo,
                tipoArticulo = c.tipoArticulo,
                condicion = c.condicion
            });
        }
        // GET: api/TipoArticulos/Mostrar/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var tipoArticulo = await _context.TipoArticulo.FindAsync(id);

            if (tipoArticulo == null)
            {
                return NotFound();
            }

            TipoArticuloViewModel tipoArticuloViewModel = new TipoArticuloViewModel
            {
                idTipoArticulo = tipoArticulo.idTipoArticulo,
                tipoArticulo = tipoArticulo.tipoArticulo,
                condicion = tipoArticulo.condicion
            };


            return Ok(tipoArticuloViewModel);
        }

        // PUT: api/TipoArticulos/Actualizar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] TipoArticuloViewModel TipoArticulosViewModel)
        {
            if (TipoArticulosViewModel.idTipoArticulo <= 0)
            {
                return BadRequest();
            }

            var TipoArticulos = await _context.TipoArticulo.FirstOrDefaultAsync(c => c.idTipoArticulo == TipoArticulosViewModel.idTipoArticulo);

            if (TipoArticulos == null)
            {
                return NotFound();
            }

            try
            {
                TipoArticulos.tipoArticulo = TipoArticulosViewModel.tipoArticulo;

                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha actualizado Tipo Articulos " + TipoArticulos.tipoArticulo);

                //await _hubContext.Clients.All.SendAsync("enviaratodos", TipoArticulos);
            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }

        // POST: api/TipoArticulos/Crear
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] TipoArticuloViewModel TipoArticulosViewModel)
        {
            TipoArticulo TipoArticulos = new TipoArticulo
            {
                tipoArticulo = TipoArticulosViewModel.tipoArticulo,
                condicion = true
            };

            try
            {
                _context.TipoArticulo.Add(TipoArticulos);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha registrado Tipo Articulos " + TipoArticulos.tipoArticulo);

            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok();
        }

        // DELETE: api/TipoArticulos/5
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            var TipoArticulos = await _context.TipoArticulo.FindAsync(id);
            if (TipoArticulos == null)
            {
                return NotFound();
            }

            _context.TipoArticulo.Remove(TipoArticulos);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok(TipoArticulos);
        }

        // PUT: api/TipoArticulos/Desactivar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var TipoArticulos = await _context.TipoArticulo.FirstOrDefaultAsync(c => c.idTipoArticulo == id);

            if (TipoArticulos == null)
            {
                return NotFound();
            }

            TipoArticulos.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha desactivado Tipo Articulos " + TipoArticulos.tipoArticulo);

            }
            catch (DbUpdateConcurrencyException ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        // PUT: api/TipoArticulos/Activar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var TipoArticulos = await _context.TipoArticulo.FirstOrDefaultAsync(c => c.idTipoArticulo == id);

            if (TipoArticulos == null)
            {
                return NotFound();
            }

            TipoArticulos.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha activado Tipo Articulos " + TipoArticulos.tipoArticulo);

            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }

        private bool TipoArticuloExists(int id)
        {
            return _context.TipoArticulo.Any(e => e.idTipoArticulo == id);
        }
    }
}
