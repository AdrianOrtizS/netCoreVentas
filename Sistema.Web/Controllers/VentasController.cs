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
using Sistema.Web.Models.Almacen.Articulo;
using Sistema.Web.Models.Ventas;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VentasController : ControllerBase
    {

        private IQueryable<Venta> queryableVenta;   //public static IWebHostEnvironment _enviroment;  //   private IQueryable<Persona> queryableProveedor;
        private IQueryable<Articulo> queryableArticulo;
        private readonly DbContextSistema _context;
        private readonly IHubContext<Mensaje> _hubContext;


        public VentasController(DbContextSistema context, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }



        //GET: api/Ventas/Listar
        [HttpGet("[action]")]
        //[Authorize]
        public async Task<IEnumerable<VentaViewModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableVenta = _context.Venta.Include(u => u.usuario)
                .Include(p => p.persona)
                .Take(100).AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableVenta.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var ventas = await this.queryableVenta.OrderByDescending(i => i.idventa)
                                           .Paginar(paginacionViewModel).ToListAsync();

            return ventas.Select(i => new VentaViewModel
            {
                idventa = i.idventa,
                idcliente = i.idcliente,
                cliente = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                serie_comprobante = i.serie_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto12 = i.impuesto12,
                impuesto0 = i.impuesto0,
                total = i.total,
                subtotal = i.subtotal,
                estado = i.estado

            });
        }






        //GET: api/Ventas/VentasMes12
        [HttpGet("[action]")]
        //[Authorize]
        public async Task<IEnumerable<ConsultaViewModel>> VentasMes12()
        {
            var consulta = await _context.Venta.GroupBy(v => v.fecha_hora.Month)
                .Select(x => new { etiqueta = x.Key, valor = x.Sum(v => v.total) })
                .OrderBy(x => x.etiqueta).Take(12).ToListAsync();

            return consulta.Select(v => new ConsultaViewModel
            {
                etiqueta = v.etiqueta.ToString(),
                valor = v.valor
            });
        }


        //GET: api/Ventas/ProductosMasVendidos
        [HttpGet("[action]")]
        //[Authorize]
        public async Task<IEnumerable<ProductosMasVendidosViewModel>> ProductosMasVendidos()
        {
            var consulta = await _context.DetalleVenta.GroupBy(
                c => new
                {
                    c.idarticulo,
                    c.articulo.nombre,  //c.cantidad
                })
                .Select(gcs => new 
                {
                    idProducto = gcs.Key.idarticulo,
                    producto = gcs.Key.nombre,
                    cantidad = gcs.Sum( v => v.cantidad)

                }).Take(5). ToListAsync();
            return consulta.Select(v => new ProductosMasVendidosViewModel
            {
                idProducto = v.idProducto,
                cantidad = v.cantidad,
                producto = v.producto
            });
        }







        // GET: api/Ventas/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<VentaViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string campo,
                                                                  [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryableVenta = _context.Venta.Where(i => i.persona.nombre.Contains(valor))
                    .Include(p => p.persona).Include(u => u.usuario).AsQueryable();
            }

            if (campo == "num_comprobante")
            {
                this.queryableVenta = _context.Venta.Where(i => i.num_comprobante.Contains(valor))
                    .Include(p => p.persona).Include(u => u.usuario).AsQueryable();
            }

            var ventas = await this.queryableVenta.OrderBy(i => i.idventa)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return ventas.Select(i => new VentaViewModel
            {
                idventa = i.idventa,
                idcliente = i.idcliente,
                cliente = i.persona.nombre,
                idusuario = i.idusuario,
                usuario = i.usuario.nombre,
                tipo_comprobante = i.tipo_comprobante,
                serie_comprobante = i.serie_comprobante,
                num_comprobante = i.num_comprobante,
                fecha_hora = i.fecha_hora,
                impuesto0 = i.impuesto0,
                impuesto12 = i.impuesto12,
                subtotal = i.subtotal,
                total = i.total,
                estado = i.estado
            });
        }


        // GET: api/Ventas/SelectClientes
        [HttpGet("[action]/{valor}")]
        public async Task<IEnumerable<ClienteViewModel>> SelectClientes([FromRoute] string valor)
        {
            List<Persona> clientes;

            if (valor == null || valor == "")
            {
                clientes = await _context.Persona.Where(p => p.tipo_persona.Equals("Cliente"))
                                                            //.Where(p => p.nombre.Contains(valor))
                                                            .Take(10).ToListAsync();
            }

            clientes = await _context.Persona.Where(p => p.tipo_persona.Equals("Cliente"))
                                             .Where(p => p.nombre.Contains(valor) || p.num_documento.Contains(valor) )
                                             .Take(10).ToListAsync();

            return clientes.Select(p => new ClienteViewModel
            {
                idcliente = p.idpersona,
                nombre = p.nombre,
                telefono = p.telefono,
                direccion = p.direccion,
                num_documento = p.num_documento
            });
        }



        // GET: api/Ventas/UltimaFact
        [HttpGet("[action]")]
        public async Task<IActionResult> UltimaFact()
        {

            var ultimaFact = await _context.Venta.OrderByDescending(v => v.idventa).FirstOrDefaultAsync();

            var ultFact = Int32.Parse(ultimaFact.num_comprobante);
            return Ok(ultimaFact);
        }






        // GET: api/Ventas/SelectArticuloPorCodigo
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
                precio_venta = articulo.precio_venta,
                codigo = articulo.codigo,
                stock = articulo.stock,
                idcategoria = articulo.categoria.idcategoria,
                categoria = articulo.categoria.nombre,
                iva = articulo.iva
            };

            return Ok(articuloVM);
        }



        //GET: api/Articulos/BuscarArticlePorNombre
        [HttpGet("[action]/{valor}")]
        public async Task<IEnumerable<ArticleVentaViewModel>> BuscarArticlePorNombre([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string valor)
        {
            this.queryableArticulo =  _context.Articulo.Where(a => a.nombre.Contains(valor))
                                                        .Include(c => c.categoria)
                                                        .AsQueryable();

            var articulos = await this.queryableArticulo.OrderBy(x => x.nombre)
                                                        .Paginar(paginacionViewModel)
                                                        .ToListAsync();

            return articulos.Select(u => new ArticleVentaViewModel
            {
                idarticulo  = u.idarticulo,
                idcategoria = u.categoria.idcategoria,
                categoria   = u.categoria.nombre,
                codigo      = u.codigo,
                nombre      = u.nombre,
                precio_venta = u.precio_venta,
                stock       = u.stock
            });

        }



        // PUT: api/Ventas/Anular
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Anular([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var venta = await _context.Venta.FirstOrDefaultAsync(i => i.idventa == id);

            if (venta == null)
            {
                return NotFound();
            }

            try
            {
                venta.estado = "Anulado";
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


        // POST: api/Ventas/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] VentaCrearViewModel ventaViewModel)
        {
            var fecha = DateTime.Now;
            Venta venta = new Venta
            {
                idcliente = ventaViewModel.idcliente,
                idusuario = ventaViewModel.idusuario,
                tipo_comprobante = ventaViewModel.tipo_comprobante,
                num_comprobante = ventaViewModel.num_comprobante,
                serie_comprobante = ventaViewModel.serie_comprobante,
                descuento = ventaViewModel.descuento,
                //fecha_hora = ventaViewModel.fecha,
                fecha_hora = fecha,
                impuesto12 = ventaViewModel.impuesto12,
                impuesto0 = ventaViewModel.impuesto0,
                total = ventaViewModel.total,
                subtotal = ventaViewModel.subtotal,
                estado = "Aceptado"
            };

            try
            {
                _context.Venta.Add(venta);
                await _context.SaveChangesAsync();

                var id = venta.idventa;

                //Lista Detalles de viewModel
                foreach (var det in ventaViewModel.detalles)
                {
                    //Detalles a BD con formato DetalleVenta
                    DetalleVenta detalle = new DetalleVenta
                    {
                        idventa = id,
                        idarticulo = det.idarticulo,
                        cantidad = det.cantidad,
                        precio_venta = det.precio_venta,
                        descuento = det.descuento
                    };

                    _context.DetalleVenta.Add(detalle);

                }
                await _context.SaveChangesAsync();

            }
            catch (Exception ex)
            {
                //                Console.WriteLine(ex.InnerException.Message);
                //Rollback
                return BadRequest("Error: " + ex.Message);
            }

            return Ok(ventaViewModel);
        }




        // GET: api/Ventas/Ver
        [HttpGet("[action]/{idventa}")]
        public async Task<IActionResult> Ver([FromRoute] int idventa)
        {

            var venta = await _context.Venta.Include(p => p.persona)
                                        .Include(u => u.usuario)
                                        .SingleOrDefaultAsync(i => i.idventa.Equals(idventa));

            VentaVerViewModel ventav = new VentaVerViewModel
            {
                idcliente = venta.idcliente,
                cliente = venta.persona.nombre,
                idusuario = venta.idusuario,
                usuario = venta.usuario.nombre,
                direccion = venta.persona.direccion,
                telefono = venta.persona.telefono,
                num_documento = venta.persona.num_documento,
                fecha = venta.fecha_hora,
                num_comprobante = venta.num_comprobante,
                serie_comprobante = venta.serie_comprobante,
                tipo_comprobante = venta.tipo_comprobante,
                descuento = venta.descuento,
                impuesto12 = venta.impuesto12,
                impuesto0 = venta.impuesto0,
                total = venta.total,
                subtotal = venta.subtotal,
                estado = venta.estado

            };

            return Ok(ventav);
        }

        // GET: api/Ventas/VerDetalles
        [HttpGet("[action]/{idventa}")]
        public async Task<IEnumerable<DetalleVentaViewModel>> VerDetalles([FromRoute] int idventa)
        {
            var detalles = await _context.DetalleVenta
                                   .Include(a => a.articulo)
                                   .Where(d => d.idventa.Equals(idventa))
                                   .ToListAsync();

            return detalles.Select(d => new DetalleVentaViewModel
            {
                idarticulo = d.idarticulo,
                articulo = d.articulo.nombre,
                cantidad = d.cantidad,
                precio_venta = d.precio_venta,
                descuento = d.descuento
            });

        }



        private bool VentaExists(int id)
        {
            return _context.Venta.Any(e => e.idventa == id);
        }
    }
}
