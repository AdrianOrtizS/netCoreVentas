using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Models.Usuarios.Rol;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RolsController : ControllerBase
    {
        private readonly DbContextSistema _context;

        public RolsController(DbContextSistema context)
        {
            _context = context;
        }

        // GET: api/Roles/ListarDropdown
        [HttpGet("[action]")]
        public async Task<IEnumerable<RolViewModel>> ListarDropdown()
        {

            var roles = await _context.Rol.Where(c => c.condicion == true).ToListAsync();

            return roles.Select(r => new RolViewModel
            {
                idrol = r.idrol,
                nombre = r.nombre
            });
        }



        // GET: api/Roles/Listar
        [HttpGet("[action]")]
        public async Task<IEnumerable<RolViewModel>> Listar()
        {
            var roles = await _context.Rol.ToListAsync();

            return roles.Select(r => new RolViewModel
            {
                idrol = r.idrol,
                nombre = r.nombre,
                descripcion = r.descripcion,
                condicion = r.condicion
            });
        }


        // PUT: api/Roles/Actualizar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] RolActualizarViewModel rolViewModel)
        {
            if (rolViewModel.idrol <= 0)
            {
                return BadRequest();
            }

            var rol = await _context.Rol.FirstOrDefaultAsync(r => r.idrol == rolViewModel.idrol);

            if (rol == null)
            {
                return NotFound();
            }

            try
            {
                rol.nombre = rolViewModel.nombre;
                rol.descripcion = rolViewModel.descripcion;

                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }

       
        // PUT: api/Roles/Desactivar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var rol = await _context.Rol.FirstOrDefaultAsync(r => r.idrol == id);

            if (rol == null)
            {
                return NotFound();
            }

            rol.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }

        // PUT: api/Roles/Activar
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var rol = await _context.Rol.FirstOrDefaultAsync(r => r.idrol == id);

            if (rol == null)
            {
                return NotFound();
            }

            rol.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }



        private bool RolExists(int id)
        {
            return _context.Rol.Any(e => e.idrol == id);
        }
    }
}
