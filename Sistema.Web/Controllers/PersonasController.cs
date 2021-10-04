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
using Sistema.Web.Models.Ventas;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonasController : ControllerBase
    {
        private readonly DbContextSistema _context;
        private IQueryable<Persona> queryablePerson;     //metodo buscar        //public static IWebHostEnvironment _enviroment;
        private readonly IHubContext<Mensaje> _hubContext;


        public PersonasController(DbContextSistema context, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }


      

     

        // GET: api/Personas/PdfClientes2
        [HttpGet("[action]")]
        public async Task<IEnumerable<PersonaViewModel>> PdfClientes2()
        {
            var personas = await _context.Persona
                                    .Where(a => a.tipo_persona.Equals("Cliente"))
                                    .OrderBy(x => x.nombre)
                                    .ToListAsync();

            return personas.Select(a => new PersonaViewModel
            {
                nombre = a.nombre,
                //idpersona = a.idpersona,
                tipo_persona = a.tipo_persona,
                tipo_documento = a.tipo_documento,
                num_documento = a.num_documento,
                direccion = a.direccion,
                telefono = a.telefono,
                email = a.email

            });
        }



        // GET: api/Personas/PdfProveedores2
        [HttpGet("[action]")]
        public async Task<IEnumerable<PersonaViewModel>> PdfProveedores2()
        {
            var personas = await _context.Persona
                                    .Where(a => a.tipo_persona.Equals("Proveedor"))
                                    .OrderBy(x => x.nombre)
                                    .ToListAsync();

            return personas.Select(a => new PersonaViewModel
            {
                nombre = a.nombre,
                //idpersona = a.idpersona,
                tipo_persona = a.tipo_persona,
                tipo_documento = a.tipo_documento,
                num_documento = a.num_documento,
                direccion = a.direccion,
                telefono = a.telefono,
                email = a.email

            });
        }







        // GET: api/Personas/ListarClientes
        [HttpGet("[action]")]
        public async Task<IEnumerable<PersonaViewModel>> ListarClientes([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            var queryable = _context.Persona
                            .Where(p =>p.tipo_persona.Contains("Cliente"))
                            .AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if(HttpContext == null)
            {
               throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
               double cantidad = await queryable.CountAsync();
               HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var personas = await queryable.OrderBy(x => x.nombre)
                                          .Paginar(paginacionViewModel).ToListAsync();

            return personas.Select(p => new PersonaViewModel
            {
                idpersona = p.idpersona,
                tipo_persona = p.tipo_persona,
                nombre = p.nombre,
                tipo_documento = p.tipo_documento,
                num_documento = p.num_documento,
                direccion = p.direccion,
                telefono = p.telefono,
                email = p.email
            });
        }

        // GET: api/Personas/ListarProveedores
        [HttpGet("[action]")]
        public async Task<IEnumerable<PersonaViewModel>> ListarProveedores([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            var queryable = _context.Persona
                            .Where(p => p.tipo_persona.Contains("Proveedor"))
                            .AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await queryable.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var personas = await queryable.OrderBy(x => x.nombre)
                                          .Paginar(paginacionViewModel).ToListAsync();

            return personas.Select(p => new PersonaViewModel
            {
                idpersona = p.idpersona,
                tipo_persona = p.tipo_persona,
                nombre = p.nombre,
                tipo_documento = p.tipo_documento,
                num_documento = p.num_documento,
                direccion = p.direccion,
                telefono = p.telefono,
                email = p.email
            });
        }


        // GET: api/Personas/BuscarClientes
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<PersonaViewModel>> BuscarClientes([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                [FromRoute] string campo,
                                                                [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryablePerson = _context.Persona.Where(p => p.nombre.Contains(valor))
                                            .Where(p => p.tipo_persona.Contains("Cliente")).AsQueryable();
            }

            if (campo == "num_documento")
            {
                this.queryablePerson = _context.Persona.Where(p => p.num_documento.Contains(valor))
                                            .Where(p => p.tipo_persona.Contains("Cliente")).AsQueryable();
            }

            var personas = await this.queryablePerson.OrderBy(x => x.nombre)
                                          .Paginar(paginacionViewModel).ToListAsync();

            return personas.Select(p => new PersonaViewModel
            {
                idpersona = p.idpersona,
                tipo_persona = p.tipo_persona,
                nombre = p.nombre,
                tipo_documento = p.tipo_documento,
                num_documento = p.num_documento,
                direccion = p.direccion,
                telefono = p.telefono,
                email = p.email
            });
        }

        // GET: api/Personas/BuscarProveedores
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<PersonaViewModel>> BuscarProveedores([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                [FromRoute] string campo,
                                                                [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryablePerson = _context.Persona.Where(p => p.nombre.Contains(valor))
                                            .Where(p => p.tipo_persona.Contains("Proveedor")).AsQueryable();
            }

            if (campo == "num_documento")
            {
                this.queryablePerson = _context.Persona.Where(p => p.num_documento.Contains(valor))
                                            .Where(p => p.tipo_persona.Contains("Proveedor")).AsQueryable();
            }

            var personas = await this.queryablePerson.OrderBy(x => x.nombre)
                                          .Paginar(paginacionViewModel).ToListAsync();

            return personas.Select(p => new PersonaViewModel
            {
                idpersona = p.idpersona,
                tipo_persona = p.tipo_persona,
                nombre = p.nombre,
                tipo_documento = p.tipo_documento,
                num_documento = p.num_documento,
                direccion = p.direccion,
                telefono = p.telefono,
                email = p.email
            });
        }


        // GET: api/Personas/MostrarCliente/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> MostrarCliente([FromRoute] int id)
        {
            var persona = await _context.Persona.Where(p => p.tipo_persona.Equals("Cliente"))
                                                .SingleOrDefaultAsync(p => p.idpersona == id);

            if (persona == null)
            {
                return NotFound();
            }

            PersonaViewModel personaViewModel = new PersonaViewModel
            {
                idpersona = persona.idpersona,
                tipo_persona = persona.tipo_persona,
                nombre = persona.nombre,
                tipo_documento = persona.tipo_documento,
                num_documento = persona.num_documento,
                direccion = persona.direccion,
                telefono = persona.telefono,
                email = persona.email
            };

            return Ok(personaViewModel);
        }

        // GET: api/Personas/MostrarProveedor/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> MostrarProveedor([FromRoute] int id)
        {
            var persona = await _context.Persona.Where(p => p.tipo_persona.Equals("Proveedor"))
                                                .SingleOrDefaultAsync(p => p.idpersona == id);

            if (persona == null)
            {
                return NotFound();
            }

            PersonaViewModel personaViewModel = new PersonaViewModel
            {
                idpersona = persona.idpersona,
                tipo_persona = persona.tipo_persona,
                nombre = persona.nombre,
                tipo_documento = persona.tipo_documento,
                num_documento = persona.num_documento,
                direccion = persona.direccion,
                telefono = persona.telefono,
                email = persona.email
            };

            return Ok(personaViewModel);
        }


        // PUT: api/Personas/Actualizar
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar ([FromBody] PersonaActualizarViewModel personaViewModel)
        {
            if (personaViewModel.idpersona <= 0)
            {
                return BadRequest();
            }

            var persona = await _context.Persona
                                    .FirstOrDefaultAsync(p => p.idpersona == personaViewModel.idpersona);

            if (persona == null)
            {
                return NotFound();
            }

            try
            {
                persona.tipo_persona = personaViewModel.tipo_persona;
                persona.nombre = personaViewModel.nombre;
                persona.tipo_documento = personaViewModel.tipo_documento;
                persona.num_documento = personaViewModel.num_documento;
                persona.direccion = personaViewModel.direccion;
                persona.telefono = personaViewModel.telefono;
                persona.email = personaViewModel.email;

                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha actualizado persona " + persona.nombre);


            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }


        // POST: api/Personas/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] PersonaCrearViewModel personaViewModel)
        {
            Persona persona = new Persona
            {
                tipo_persona = personaViewModel.tipo_persona,
                nombre = personaViewModel.nombre,
                tipo_documento = personaViewModel.tipo_documento,
                num_documento = personaViewModel.num_documento,
                direccion = personaViewModel.direccion,
                telefono = personaViewModel.telefono,
                email = personaViewModel.email
            };

            try
            {
                _context.Persona.Add(persona);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha registrado persona " + persona.nombre);

            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok();
        }

        // DELETE: api/Personas/5
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            var persona = await _context.Persona.FindAsync(id);
            if (persona == null)
            {
                return NotFound();
            }

            _context.Persona.Remove(persona);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok(persona);
        }

        

        private bool PersonaExists(int id)
        {
            return _context.Persona.Any(e => e.idpersona == id);
        }
    
    }

}
