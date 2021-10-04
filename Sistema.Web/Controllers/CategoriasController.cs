using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Hub;
using Sistema.Web.Models.Almacen.Categoria;
using Sistema.Web.Models.ViewsModelAux;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriasController : ControllerBase
    {

        private IQueryable<Categoria> queryableCategory;     //metodo buscar 
        private readonly DbContextSistema _context;

        private readonly IHubContext<Mensaje> _hubContext;


        public CategoriasController(DbContextSistema context, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }


        // GET: api/Categorias/ListarDropdown
        [HttpGet("[action]")]
        public async Task<IEnumerable<CategoriaViewModel>> ListarDropdown()
        {

            var categorias = await _context.Categoria.Where(c => c.condicion == true).ToListAsync();

            return categorias.Select(c => new CategoriaViewModel
            {
                idcategoria = c.idcategoria,
                nombre = c.nombre
            });
        }



        // GET: api/Categorias/Listar
        [HttpGet("[action]")]
        //[Authorize]
        public async Task<IEnumerable<CategoriaViewModel>> Listar( [FromQuery] PaginacionViewModel paginacionViewModel)
        {                                                             
            this.queryableCategory = _context.Categoria.AsQueryable();
            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);

            if (HttpContext == null) { 
                throw new ArgumentNullException(nameof(HttpContext)); 
            }else {
                double cantidad = await this.queryableCategory.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var categorias = await this.queryableCategory.OrderBy(x => x.nombre)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return categorias.Select( c => new CategoriaViewModel 
            {
                idcategoria = c.idcategoria,
                nombre = c.nombre,
                descripcion = c.descripcion,
                condicion = c.condicion
            });
        }


        // GET: api/Categorias/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<CategoriaViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel, 
                                                                  [FromRoute] string campo, 
                                                                  [FromRoute] string valor)
        {
            if (campo == "nombre") {
               this.queryableCategory = _context.Categoria.Where(c => c.nombre.Contains(valor)).AsQueryable();
            }

            if (campo == "descripcion") {
               this.queryableCategory = _context.Categoria.Where(c => c.descripcion.Contains(valor)).AsQueryable();
            }

            var categorias = await this.queryableCategory.OrderBy(x => x.nombre)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return categorias.Select(c => new CategoriaViewModel
            {
                idcategoria = c.idcategoria,
                nombre      = c.nombre,
                descripcion = c.descripcion,
                condicion   = c.condicion
            });
        }
        // GET: api/Categorias/Mostrar/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var categoria = await _context.Categoria.FindAsync(id);

            if (categoria == null)
            {
                return NotFound();
            }

            CategoriaViewModel categoriaViewModel = new CategoriaViewModel
            {
                idcategoria = categoria.idcategoria,
                nombre = categoria.nombre,
                descripcion = categoria.descripcion,
                condicion = categoria.condicion
            };


            return Ok(categoriaViewModel) ;
        }

        // PUT: api/Categorias/Actualizar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] CategoriaActualizarViewModel categoriaViewModel)
        {
            if (categoriaViewModel.idcategoria <= 0 )
            {
                return BadRequest();
            } 

            var categoria = await _context.Categoria.FirstOrDefaultAsync(c => c.idcategoria == categoriaViewModel.idcategoria);
            
            if (categoria == null)
            {
                return NotFound();
            }

            try
            {
                categoria.nombre = categoriaViewModel.nombre;
                categoria.descripcion = categoriaViewModel.descripcion;

                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha actualizado categoria "+categoria.nombre);

                //await _hubContext.Clients.All.SendAsync("enviaratodos", categoria);
            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }

        // POST: api/Categorias/Crear
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] CategoriaCrearViewModel categoriaViewModel)
        {
            Categoria categoria = new Categoria 
            {
                nombre = categoriaViewModel.nombre,
                descripcion = categoriaViewModel.descripcion,
                condicion = true
            };

            try
            {
                _context.Categoria.Add(categoria);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha registrado categoria " + categoria.nombre);

            }
            catch (Exception )
            {
                return BadRequest();
            }

            return Ok();
        }

        // DELETE: api/Categorias/5
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            var categoria = await _context.Categoria.FindAsync(id);
            if (categoria == null)
            {
                return NotFound();
            }

            _context.Categoria.Remove(categoria);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok(categoria);
        }

        // PUT: api/Categorias/Desactivar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var categoria = await _context.Categoria.FirstOrDefaultAsync(c => c.idcategoria == id);

            if (categoria == null)
            {
                return NotFound();
            }

            categoria.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha desactivado categoria " + categoria.nombre);

            }
            catch (DbUpdateConcurrencyException ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        // PUT: api/Categorias/Activar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var categoria = await _context.Categoria.FirstOrDefaultAsync(c => c.idcategoria == id);

            if (categoria == null)
            {
                return NotFound();
            }

            categoria.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha activado categoria " + categoria.nombre);

            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }


        private bool CategoriaExists(int id)
        {
            return _context.Categoria.Any(e => e.idcategoria == id);
        }


    }
}
