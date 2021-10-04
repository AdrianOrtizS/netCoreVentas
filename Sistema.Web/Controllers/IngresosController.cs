using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Models.Almacen.Articulo;
using Sistema.Web.Models.Ingresos;
using Sistema.Web.Models.ViewsModelAux;
using Microsoft.AspNetCore.SignalR;
using Sistema.Web.Hub;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IngresosController : ControllerBase
    {
        private IQueryable<Ingreso> queryableIngreso;   //public static IWebHostEnvironment _enviroment;  //   private IQueryable<Persona> queryableProveedor;
        private IQueryable<Articulo> queryableArticulo;
        private readonly DbContextSistema _context;
        private readonly IHubContext<Mensaje> _hubContext;


        public IngresosController(DbContextSistema context, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }


        // GET: api/Ingresos/Listar
        [HttpGet("[action]")]
        //[Authorize]
        public async Task<IEnumerable<IngresoViewModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableIngreso = _context.Ingreso.Include(u => u.usuario)
                .Include(p =>p.persona)
             //   .OrderByDescending(i =>i.idingreso)
                .Take(100).AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableIngreso.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var ingresos = await this.queryableIngreso.OrderByDescending(i => i.idingreso)
                                           .Paginar(paginacionViewModel).ToListAsync();


            return ingresos.Select(i => new IngresoViewModel
            {
                idingreso = i.idingreso,
                idproveedor = i.idproveedor,
                proveedor = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                serie_comprobante = i.serie_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto12 = i.impuesto12,
                impuesto0 = i.impuesto0,
                total = i.total,
                estado = i.estado

            });
        }


        // GET: api/Ingresos/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<IngresoViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string campo,
                                                                  [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryableIngreso = _context.Ingreso.Where(i => i.persona.nombre.Contains(valor))
                    .Include(p => p.persona).Include(u => u.usuario).AsQueryable();
            }

            if (campo == "num_comprobante")
            {
                this.queryableIngreso = _context.Ingreso.Where(i => i.num_comprobante.Contains(valor))
                    .Include(p => p.persona).Include(u => u.usuario).AsQueryable();
            }

            var ingresos = await this.queryableIngreso.OrderBy(i => i.idingreso)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return ingresos.Select(i => new IngresoViewModel
            {
                idingreso = i.idingreso,
                idproveedor = i.idproveedor,
                proveedor = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                serie_comprobante = i.serie_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto0 = i.impuesto0,
                impuesto12 = i.impuesto12,
                total = i.total,
                estado = i.estado
            });
        }


        // GET: api/Ingresos/SelectProveedores
        [HttpGet("[action]/{valor}")]
        public async Task<IEnumerable<ProveedorViewModel>> SelectProveedores([FromRoute] string valor)
        {
            List<Persona> proveedores;

            if (valor == null || valor == "")
            {
                proveedores = await _context.Persona.Where(p => p.tipo_persona.Equals("Proveedor"))
                                                            //.Where(p => p.nombre.Contains(valor))
                                                            .Take(10).ToListAsync();
            }

            proveedores = await _context.Persona.Where(p => p.tipo_persona.Equals("Proveedor"))
                                                        .Where(p => p.nombre.Contains(valor))
                                                        .Take(10).ToListAsync();

            return proveedores.Select(p => new ProveedorViewModel
            {
                idproveedor = p.idpersona,
                nombre = p.nombre
            });
        }



        // GET: api/Ingresos/SelectArticuloPorCodigo
        [HttpGet("[action]/{valor}")]
        public async Task<IActionResult> SelectArticuloPorCodigo([FromRoute] string valor)
        {
            var articulo = await _context.Articulo.Include(c => c.categoria)
                                                  .SingleOrDefaultAsync(a => a.codigo == valor);

            if (articulo == null)
            {
                return NotFound();
            }

            ArticleVentaViewModel articuloVM = new ArticleVentaViewModel
            {
                idarticulo = articulo.idarticulo,
                nombre = articulo.nombre,
                precio_compra = articulo.precio_compra,
                codigo = articulo.codigo,
                stock = articulo.stock,
                iva = articulo.iva,
                idcategoria = articulo.categoria.idcategoria,
                categoria = articulo.categoria.nombre
            };

            return Ok(articuloVM);

        }



        // GET: api/Articulos/BuscarArticlePorNombre
        [HttpGet("[action]/{valor}")]
        public async Task<IEnumerable<ArticleVentaViewModel>> BuscarArticlePorNombre([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string valor)
        {

            this.queryableArticulo = _context.Articulo.Where(a => a.nombre.Contains(valor))
                                                        .Include(c => c.categoria)
                                                        .AsQueryable();

            var articulos = await this.queryableArticulo.OrderBy(x => x.nombre)
                                                        .Paginar(paginacionViewModel)
                                                        .ToListAsync();

            return articulos.Select(u => new ArticleVentaViewModel
            {
                idarticulo = u.idarticulo,
                idcategoria = u.categoria.idcategoria,
                categoria = u.categoria.nombre,
                codigo = u.codigo,
                nombre = u.nombre,
                precio_compra = u.precio_compra,
                stock = u.stock
            });

        }
          


        // PUT: api/Ingresos/Anular
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Anular([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var ingreso = await _context.Ingreso.FirstOrDefaultAsync(i => i.idingreso == id);

            if (ingreso == null )
            {
                return NotFound();
            }

            try
            {
                ingreso.estado = "Anulado";
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                Console.WriteLine(ex.InnerException.Message);
                return BadRequest("Error: " + ex.Message + "<br/> Error Inner" + ex.InnerException.Message);
            }

            return Ok();
        }


        // POST: api/Ingresos/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] IngresoCrearViewModel ingresoViewModel)
        {
            //Console.WriteLine(ingresoViewModel);
           // var fechaDay = DateTime.Now.Day;
            Ingreso ingreso = new Ingreso
            {
                idproveedor =   ingresoViewModel.idproveedor,
                idusuario =     ingresoViewModel.idusuario,
                tipo_comprobante = ingresoViewModel.tipo_comprobante,
                num_comprobante = ingresoViewModel.num_comprobante,
                serie_comprobante = ingresoViewModel.serie_comprobante,
                fecha_hora = ingresoViewModel.fecha,
                impuesto12 =      ingresoViewModel.impuesto12,
                impuesto0 = ingresoViewModel.impuesto0,
                total =         ingresoViewModel.total,
                estado =        "Aceptado"
            };

            try
            {
                _context.Ingreso.Add(ingreso);
                await _context.SaveChangesAsync();

                var id = ingreso.idingreso;

                                    //Lista Detalles de viewModel
                foreach (var det in ingresoViewModel.detalles)
                {
                    //Detalles a BD con formato DetalleIngreso
                    DetalleIngreso detalle = new DetalleIngreso
                    {
                        idingreso = id,
                        idarticulo = det.idarticulo,
                        cantidad = det.cantidad,
                        precio_compra = det.precio_compra
                    };

                    _context.DetalleIngreso.Add(detalle);

                }
                await _context.SaveChangesAsync();

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.InnerException.Message);
                //Rollback
                return BadRequest("Error: "+ex.Message);
            }

            return Ok(ingresoViewModel);
        }




        // GET: api/Ingresos/Ver
        [HttpGet("[action]/{idingreso}")]
        public async Task<IActionResult> Ver([FromRoute] int idingreso)
        {
            
            var ingreso = await _context.Ingreso.Include(p => p.persona)
                                        .Include(u => u.usuario)
                                        .SingleOrDefaultAsync(i => i.idingreso.Equals(idingreso));

            IngresoVerViewModel ingresov = new IngresoVerViewModel
            {
                //              idingreso = ingreso.idingreso,
                idproveedor = ingreso.idproveedor,
                proveedor = ingreso.persona.nombre,
                idusuario = ingreso.idusuario,
                usuario = ingreso.usuario.nombre,
                fecha = ingreso.fecha_hora,
                num_comprobante = ingreso.num_comprobante,
                serie_comprobante = ingreso.serie_comprobante,
                tipo_comprobante = ingreso.tipo_comprobante,
                impuesto12 = ingreso.impuesto12,
                impuesto0 = ingreso.impuesto0,
                total = ingreso.total,
                estado = ingreso.estado

            };

            return Ok(ingresov);
        }

        // GET: api/Ingresos/VerDetalles
        [HttpGet("[action]/{idingreso}")]
        public async Task<IEnumerable<DetalleIngresoViewModel>> VerDetalles([FromRoute] int idingreso)
        {

            var detalles = await _context.DetalleIngreso
                                   .Include(a => a.articulo)
                                   .Where(d => d.idingreso.Equals(idingreso))
                                   .ToListAsync();


            return detalles.Select(d => new DetalleIngresoViewModel 
            { 
                idarticulo = d.idarticulo,
                articulo = d.articulo.nombre,
                cantidad = d.cantidad,
                precio_compra = d.precio_compra
            });
            
        }



        private bool IngresoExists(int id)
        {
            return _context.Ingreso.Any(e => e.idingreso == id);
        }
    }

}
