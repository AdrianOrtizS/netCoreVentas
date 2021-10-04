using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Models.Configuracion;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConfiguracionesController : ControllerBase
    {
        private IQueryable<Configuracion> queryableConfiguracion;       //public static IWebHostEnvironment _enviroment;

        private readonly DbContextSistema _context;

        public ConfiguracionesController(DbContextSistema context)
        {
            _context = context;
        }


        // GET: api/Configuraciones/Listar
        [HttpGet("[action]")]
        public async Task<IEnumerable<ConfiguracionVieModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableConfiguracion = _context.Configuracion.AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableConfiguracion.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var configuraciones = await this.queryableConfiguracion.OrderBy(x => x.descripcion)
                                           .Paginar(paginacionViewModel).ToListAsync();

            return configuraciones.Select(a => new ConfiguracionVieModel
            {
                idconfiguracion = a.idconfiguracion,
                descripcion = a.descripcion,
                valor = a.valor
                
            });
        }


        // GET: api/Configuraciones/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<ConfiguracionVieModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel, [FromRoute] string valor)
        {

            this.queryableConfiguracion = _context.Configuracion.Where(a => a.descripcion.Contains(valor)).AsQueryable();

            var configuraciones = await this.queryableConfiguracion.OrderBy(x => x.descripcion)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return configuraciones.Select(a => new ConfiguracionVieModel
            {
                idconfiguracion = a.idconfiguracion,
                descripcion = a.descripcion,
                valor = a.valor

            });
        }



        // PUT: api/Configuraciones/Actualizar
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] ConfiguracionVieModel configuracionViewModel)
        {
            if (configuracionViewModel.idconfiguracion <= 0)
            {
                return BadRequest();
            }

            var configuracion = await _context.Configuracion.FirstOrDefaultAsync(a => a.idconfiguracion == configuracionViewModel.idconfiguracion);

            if (configuracion == null)
            {
                return NotFound();
            }

            try
            {
                configuracion.idconfiguracion = configuracionViewModel.idconfiguracion;
                configuracion.descripcion = configuracionViewModel.descripcion;
                configuracion.valor = configuracionViewModel.valor;

                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }


        // POST: api/Configuraciones/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] ConfiguracionVieModel configuracionViewModel)
        {
            Configuracion configuracion = new Configuracion
            {
                idconfiguracion = configuracionViewModel.idconfiguracion,
                descripcion = configuracionViewModel.descripcion,
                valor = configuracionViewModel.valor

            };

            try
            {
                _context.Configuracion.Add(configuracion);
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok();
        }


        // GET: api/Configuraciones/Mostrar/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var configuracion = await _context.Configuracion.SingleOrDefaultAsync(c => c.idconfiguracion == id);

            if (configuracion == null)
            {
                return NotFound();
            }

            ConfiguracionVieModel configuracionViewModel = new ConfiguracionVieModel
            {
                idconfiguracion = configuracion.idconfiguracion,
                descripcion = configuracion.descripcion,
                valor = configuracion.valor
            };

            return Ok(configuracionViewModel);
        }


        // GET: api/Configuraciones/ObtenerIva
        [HttpGet("[action]")]
        public async Task<IActionResult> ObtenerIva()
        {
            var configuracion = await _context.Configuracion.SingleOrDefaultAsync(c => c.descripcion.Equals("Iva"));

            if (configuracion == null)
            {
                return NotFound();
            }

            ConfiguracionVieModel configuracionViewModel = new ConfiguracionVieModel
            {
                idconfiguracion = configuracion.idconfiguracion,
                descripcion = configuracion.descripcion,
                valor = configuracion.valor
            };

            return Ok(configuracionViewModel);
        }



        // GET: api/Configuraciones/ObtenerSerie
        [HttpGet("[action]")]
        public async Task<IActionResult> ObtenerSerie()
        {
            var configuracion = await _context.Configuracion.SingleOrDefaultAsync(c => c.descripcion.Equals("Serie"));

            if (configuracion == null)
            {
                return NotFound();
            }

            ConfiguracionVieModel configuracionViewModel = new ConfiguracionVieModel
            {
                idconfiguracion = configuracion.idconfiguracion,
                descripcion = configuracion.descripcion,
                valor = configuracion.valor
            };

            return Ok(configuracionViewModel);
        }




        private bool ConfiguracionExists(int id)
        {
            return _context.Configuracion.Any(e => e.idconfiguracion == id);
        }
    }
}
