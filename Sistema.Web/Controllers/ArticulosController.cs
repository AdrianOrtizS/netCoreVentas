using System;
using System.Collections.Generic;
using System.IO;
//using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Hub;
using Sistema.Web.Models.Almacen.Articulo;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ArticulosController : ControllerBase
    {
        private IQueryable<Articulo> queryableArtice;       //public static IWebHostEnvironment _enviroment;
        
        private readonly DbContextSistema _context;
        private readonly IHubContext<Mensaje> _hubContext;



        public ArticulosController(DbContextSistema context 
                                        , IWebHostEnvironment enviroment, IHubContext<Mensaje> hubContext)
        {
            _context = context;        //_enviroment = enviroment;
            _hubContext = hubContext;
        }



        // GET: api/Articulos/Pdf2
        [HttpGet("[action]")]
        public async Task<IEnumerable<ArticuloViewModel>> Pdf2()
        {
            var articulos = await _context.Articulo
                                    .Include(c => c.categoria)
                                    .Include(r => r.Art_TipoArt)
                                    .ThenInclude(t => t.tipoArticulo)
                                    .Where(a => a.condicion.Equals(true))
                                    .OrderBy(x => x.nombre)
                                    .ToListAsync();

            return articulos.Select(a => new ArticuloViewModel
            {
                idarticulo = a.idarticulo,
                idcategoria = a.idcategoria,
                categoria = a.categoria.nombre,
                codigo = a.codigo,
                nombre = a.nombre,
                stock = a.stock,
                precio_venta = a.precio_venta,
                precio_compra = a.precio_compra,
                descripcion = a.descripcion,
                iva = a.iva,
                utilidad = a.utilidad,
                condicion = a.condicion,
//                foto = a.foto
                

            });
        }



        // GET: api/Articulos/Mostrar/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var articulo = await _context.Articulo.Include(a => a.categoria)
                                .Include(r => r.Art_TipoArt)
                                .ThenInclude(t => t.tipoArticulo)
                                .SingleOrDefaultAsync(a => a.idarticulo == id);

            var tipoArticulo = articulo.Art_TipoArt
                .Select(a => new ArticuloTipoListVerViewModel
                {
                    idTipoArticulo = a.idtipoArticulo,
                    tipoArticulo = a.tipoArticulo.tipoArticulo
                }
                ).ToList();

            if (articulo == null || tipoArticulo == null)
            {
                return NotFound();
            }

            ArticuloVerViewModel articuloViewModel = new ArticuloVerViewModel
            {
                idarticulo = articulo.idarticulo,
                idcategoria = articulo.idcategoria,
                categoria = articulo.categoria.nombre,
                codigo = articulo.codigo,
                nombre = articulo.nombre,
                stock = articulo.stock,
                precio_venta = articulo.precio_venta,
                precio_compra = articulo.precio_compra,
                descripcion = articulo.descripcion,
                foto = articulo.foto,
                iva = articulo.iva,
                condicion = articulo.condicion,
                utilidad = articulo.utilidad,
                tiposArt = tipoArticulo
            };


            return Ok(articuloViewModel);

        }


        // POST: api/Articulos/Upload
        [HttpPost("[action]"), DisableRequestSizeLimit]
        public async Task<IActionResult> Upload()
        {
            try
            {
                var formCollection = await Request.ReadFormAsync();
                var file = formCollection.Files.First();
                var folderName = Path.Combine("Resources", "Images");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory()
                                            , "wwwroot", folderName);

                if (file.Length > 0)
                {
                    var fileName = (DateTime.Now.ToString("yyyyMMddHHmmss") + "-" + file.FileName)
                                            .ToLower();
                    var fullPath = Path.Combine(pathToSave, fileName);
                    //var dbPath = Path.Combine(folderName, fileName);
                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                        file.CopyTo(stream);
                    }
                    return Ok(new { fileName });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex}");
            }
        }


        // GET: api/Articulos/GetImage/nomImage
        [HttpGet("[action]/{image}")]
        public IActionResult GetImage([FromRoute] string image)
        {
            try
            {
                var folderName = Path.Combine("Resources", "Images");
                var pathToOpen = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", folderName);
                var fullPath = Path.Combine(pathToOpen, image).Replace(@"\", "/");

                bool fileExist = System.IO.File.Exists(fullPath);
                if (fileExist)
                {
                    return Ok(System.IO.File.OpenRead(fullPath));
                }
                else
                {
                    return NotFound();
                }

            }
            catch (Exception ex)
            {
                return NotFound();
                throw;
            }
        }




        // GET: api/Articulos/Listar
        [HttpGet("[action]")]
        public async Task<IEnumerable<ArticuloViewModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableArtice = _context.Articulo.Include(c => c.categoria).AsQueryable();
 
            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableArtice.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var articulos = await this.queryableArtice.OrderBy(x => x.nombre)
                                           .Paginar(paginacionViewModel).ToListAsync();

            return articulos.Select(a => new ArticuloViewModel
            {
                idarticulo = a.idarticulo,
                idcategoria = a.idcategoria,
                categoria = a.categoria.nombre,
                codigo = a.codigo,
                nombre = a.nombre,
                stock = a.stock,
                precio_venta = a.precio_venta,
                precio_compra = a.precio_compra,
                descripcion = a.descripcion,//foto = a.foto,
                iva = a.iva,
                utilidad = a.utilidad,
                condicion = a.condicion
                

            });
        }


        // GET: api/Articulos/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<ArticuloViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string campo,
                                                                  [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryableArtice = _context.Articulo.Where(a => a.nombre.Contains(valor)).Include(a => a.categoria).AsQueryable();
            }

            if (campo == "descripcion")
            {
                this.queryableArtice = _context.Articulo.Where(c => c.descripcion.Contains(valor)).Include(a => a.categoria).AsQueryable();
            }

            var articulos = await this.queryableArtice.OrderBy(x => x.nombre)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return articulos.Select(a => new ArticuloViewModel
            {
                idarticulo = a.idarticulo,
                idcategoria = a.idcategoria,
                categoria = a.categoria.nombre,
                codigo = a.codigo,
                nombre = a.nombre, 
                stock = a.stock,
                precio_venta = a.precio_venta,
                precio_compra = a.precio_compra,
                descripcion = a.descripcion, //foto = a.foto,
                iva = a.iva,
                utilidad = a.utilidad,
                condicion = a.condicion
            });
        }



        // PUT: api/Articulos/Actualizar
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] ArticuloActualizarViewModel articuloViewModel)
        {
            if (articuloViewModel.idarticulo <= 0)
            {
                return BadRequest();
            }
            //var articulo = await _context.Articulo.FirstOrDefaultAsync(a => a.idarticulo == articuloViewModel.idarticulo);
            var articulo = await _context.Articulo.Include(a => a.categoria)
                               .Include(r => r.Art_TipoArt)
                               .ThenInclude(t => t.tipoArticulo)
                               .SingleOrDefaultAsync(a => a.idarticulo == articuloViewModel.idarticulo);

            var tipoArticulo = articulo.Art_TipoArt
                .Select(a => new ArticuloTipoListVerViewModel
                {
                    idTipoArticulo = a.idtipoArticulo,
                    tipoArticulo = a.tipoArticulo.tipoArticulo
                }
                ).ToList();

            if (articulo == null)
            {
                return NotFound();
            }

            try
            {
                articulo.idcategoria = articuloViewModel.idcategoria;
                articulo.codigo = articuloViewModel.codigo;
                articulo.nombre = articuloViewModel.nombre;
                articulo.precio_venta = articuloViewModel.precio_venta;
                articulo.precio_compra = articuloViewModel.precio_compra;

                articulo.stock = articuloViewModel.stock;
                articulo.descripcion = articuloViewModel.descripcion;
                articulo.iva = articuloViewModel.iva;
                articulo.foto = articuloViewModel.foto;

                articulo.utilidad = articuloViewModel.utilidad;
                await _context.SaveChangesAsync();

                var id = articulo.idarticulo;

                //eliminar datos de tabla intermedia
                var art_tip = await _context.Articulo_TipoArticulo.Where(ta =>ta.idarticulo == id).ToListAsync();
                foreach (var at in art_tip)
                {
                    _context.Articulo_TipoArticulo.Remove(at);
                    await _context.SaveChangesAsync();
                }

                //agrega datos relacionados en table intermedia
                foreach (var A_T in articuloViewModel.tiposArt)
                {
                    Articulo_TipoArticulo art_T = new Articulo_TipoArticulo
                    {
                        idarticulo = id,
                        idtipoArticulo = A_T.idTipoArticulo,
                    };

                    _context.Articulo_TipoArticulo.Add(art_T);

                }

                //       await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha actualizado articulo " + articulo.nombre);
                await _context.SaveChangesAsync();


            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }


        // POST: api/Articulos/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] ArticuloCrearViewModel articuloViewModel)
        {
            Articulo articulo = new Articulo
            {
                idcategoria = articuloViewModel.idcategoria,
                codigo = articuloViewModel.codigo,
                nombre = articuloViewModel.nombre,
                precio_venta = articuloViewModel.precio_venta,
                utilidad = articuloViewModel.utilidad,
                precio_compra = articuloViewModel.precio_compra,
                stock = articuloViewModel.stock,
                descripcion = articuloViewModel.descripcion,
                foto = articuloViewModel.foto,
                iva = articuloViewModel.iva,
                condicion = true
            };


            try
            {
                _context.Articulo.Add(articulo);
                await _context.SaveChangesAsync();
                var id = articulo.idarticulo;

                foreach (var A_T in articuloViewModel.tiposArt)
                {
                    Articulo_TipoArticulo art_T = new Articulo_TipoArticulo
                    {
                        idarticulo = id,
                        idtipoArticulo = A_T.idTipoArticulo,                        
                    };

                    _context.Articulo_TipoArticulo.Add(art_T);

                }
                await _context.SaveChangesAsync();

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return BadRequest("Error: " + ex.Message);
            }

            return Ok(articuloViewModel);
        }



        // DELETE: api/Articulos/5
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            var articulo = await _context.Articulo.FindAsync(id);
            if (articulo == null)
            {
                return NotFound();
            }

            _context.Articulo.Remove(articulo);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok(articulo);
        }


        // PUT: api/Articulos/Desactivar
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var articulo = await _context.Articulo.FirstOrDefaultAsync(a => a.idarticulo == id);

            if (articulo == null)
            {
                return NotFound();
            }

            articulo.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
             //   await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha desactivado articulo " + articulo.nombre);

            }
            catch (DbUpdateConcurrencyException ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }


        // PUT: api/Categorias/Activar
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var articulo = await _context.Articulo.FirstOrDefaultAsync(c => c.idarticulo == id);

            if (articulo == null)
            {
                return NotFound();
            }

            articulo.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
              //  await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha activado articulo " + articulo.nombre);

            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }



        private bool ArticuloExists(int id)
        {
            return _context.Articulo.Any(e => e.idarticulo == id);
        }
    
    
    }
}
