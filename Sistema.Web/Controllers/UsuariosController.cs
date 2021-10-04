using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
//using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Sistema.Datos;
using Sistema.Entidades;
using Sistema.Web.Auxiliar;
using Sistema.Web.Hub;
using Sistema.Web.Models.Usuarios.Usuario;
using Sistema.Web.Models.ViewsModelAux;

namespace Sistema.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly DbContextSistema _context;
        private IQueryable<Usuario> queryableUser;       //public static IWebHostEnvironment _enviroment;
        private readonly IConfiguration _config;
        private readonly IHubContext<Mensaje> _hubContext;


        public UsuariosController(DbContextSistema context, IConfiguration config, IHubContext<Mensaje> hubContext)
        {
            _context = context;
            _config = config;
            _hubContext = hubContext;
        }


        // POST: api/Usuarios/Upload
        [HttpPost("[action]"), DisableRequestSizeLimit]
        public async Task<IActionResult> Upload()
        {
            try
            {
                var formCollection = await Request.ReadFormAsync();
                var file = formCollection.Files.First();
                var folderName = Path.Combine("Resources", "Images");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", folderName);

                if (file.Length > 0)
                {

                    var fileName = (DateTime.Now.ToString("yyyyMMddHHmmss") + "-" + file.FileName).ToLower();
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


        // GET: api/Usuarios/GetImage/nomImage
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



        // GET: api/Usuarios/Listar
        [HttpGet("[action]")]
        public async Task<IEnumerable<UsuarioViewModel>> Listar([FromQuery] PaginacionViewModel paginacionViewModel)
        {
            this.queryableUser = _context.Usuario.Include(r => r.rol).AsQueryable();

            //Devuelve cantidad de registros en Db a cabecera de peticion
            //await HttpContext.InsertarParametrosPaginacionEnCabecera(queryable);
            if (HttpContext == null)
            {
                throw new ArgumentNullException(nameof(HttpContext));
            }
            else
            {
                double cantidad = await this.queryableUser.CountAsync();
                HttpContext.Response.Headers.Add("cantidadTotalRegistros", cantidad.ToString());
            }

            var usuarios = await this.queryableUser.OrderBy(u => u.nombre)
                                           .Paginar(paginacionViewModel).ToListAsync();

            return usuarios.Select(u => new UsuarioViewModel
            {
                idusuario = u.idusuario,
                idrol = u.idrol,
                rol = u.rol.nombre,
                nombre =u.nombre,
                tipo_documento= u.tipo_documento,
                num_documento= u.num_documento,
                direccion= u.direccion,
                telefono= u.telefono,
                email =u.email,
//                password_hash= u.password_hash,
                condicion= u.condicion
            });
        }


        // GET: api/Usuarios/Buscar
        [HttpGet("[action]/{campo}/{valor}")]
        public async Task<IEnumerable<UsuarioViewModel>> Buscar([FromQuery] PaginacionViewModel paginacionViewModel,
                                                                  [FromRoute] string campo,
                                                                  [FromRoute] string valor)
        {
            if (campo == "nombre")
            {
                this.queryableUser = _context.Usuario.Where(u => u.nombre.Contains(valor)).Include(r => r.rol).AsQueryable();
            }

            if (campo == "email")
            {
                this.queryableUser = _context.Usuario.Where(u => u.email.Contains(valor)).Include(r => r.rol).AsQueryable();
            }

            var usuarios = await this.queryableUser.OrderBy(x => x.nombre)
                                            .Paginar(paginacionViewModel).ToListAsync();

            return usuarios.Select(u => new UsuarioViewModel
            {
                idusuario = u.idusuario,
                idrol = u.idrol,
                rol = u.rol.nombre,
                nombre = u.nombre,
                tipo_documento = u.tipo_documento,
                num_documento = u.num_documento,
                direccion = u.direccion,
                telefono = u.telefono,
                email = u.email,
                password_hash = u.password_hash,
                condicion = u.condicion
            });
        }


        // GET: api/Usuarios/Mostrar/5
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var usuario = await _context.Usuario.Include(r => r.rol).SingleOrDefaultAsync(u => u.idusuario == id);

            if (usuario == null)
            {
                return NotFound();
            }

            UsuarioViewModel usuarioViewModel = new UsuarioViewModel
            {
                idusuario = usuario.idusuario,
                idrol = usuario.idrol,
                rol = usuario.rol.nombre,
                nombre = usuario.nombre,
                tipo_documento = usuario.tipo_documento,
                num_documento = usuario.num_documento,
                direccion = usuario.direccion,
                telefono = usuario.telefono,
                email = usuario.email,
                foto = usuario.foto,
            //    password_hash = usuario.password_hash,
                condicion = usuario.condicion
            };

            return Ok(usuarioViewModel);
        }


        // PUT: api/Usuarios/Actualizar 
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] UsuarioActualizarViewModel usuarioViewModel)
        {
            if (usuarioViewModel.idusuario <= 0)
            {
                return BadRequest();
            }

            var usuario = await _context.Usuario.Where(u => u.condicion == true).FirstOrDefaultAsync(u => u.idusuario == usuarioViewModel.idusuario);

            if (usuario == null)
            {
                return NotFound();
            }

            try
            {
                usuario.idrol = usuarioViewModel.idrol;
                usuario.nombre = usuarioViewModel.nombre;
                usuario.tipo_documento = usuarioViewModel.tipo_documento;
                usuario.num_documento = usuarioViewModel.num_documento;
                usuario.direccion = usuarioViewModel.direccion;
                usuario.telefono = usuarioViewModel.telefono;
                usuario.email = usuarioViewModel.email;
                usuario.foto = usuarioViewModel.foto;

/*                if (usuarioViewModel.act_password == true)
                {
                    CrearPasswordHash(usuarioViewModel.password, out byte[] password_Hash, out byte[] password_Salt);
                    usuario.password_hash = password_Hash;
                    usuario.password_salt = password_Salt;
                }
*/
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha actualizado usuario " + usuario.nombre);

            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }


        // POST: api/Usuarios/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] UsuarioCrearViewModel usuarioViewModel)
        {
            var email = usuarioViewModel.email.ToLower();

            if (await _context.Usuario.AnyAsync(u => u.email == email))
            {
                return BadRequest("El email ya existe");
            }


            CrearPasswordHash(usuarioViewModel.password, out byte[] password_Hash, out byte[] password_Salt);

            Usuario usuario = new Usuario
            {
                idrol =     usuarioViewModel.idrol,
                nombre =    usuarioViewModel.nombre,
                tipo_documento = usuarioViewModel.tipo_documento,
                num_documento = usuarioViewModel.num_documento,
                direccion = usuarioViewModel.direccion,
                telefono =  usuarioViewModel.telefono,
                email =     usuarioViewModel.email,
                foto =      usuarioViewModel.foto,
                password_salt = password_Salt,  //clave encriptada
                password_hash = password_Hash,  //llaves con la que se encripta
                condicion = true
            };

            try
            {
                _context.Usuario.Add(usuario);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha registrado usuario " + usuario.nombre);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.InnerException.Message);
                return BadRequest(ex.Message );
            }

            return Ok();
        }


        private void CrearPasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }



        // POST: api/Usuarios/Login
        [HttpPost("[action]")]
        public async Task<IActionResult> Login(LoginViewModel loginViewModel)
        {
            var email = loginViewModel.email.ToLower();

            var usuario = await _context.Usuario
                .Where(u => u.condicion == true)
                .Include(r => r.rol)
                .FirstOrDefaultAsync(u => u.email == email);

            if (usuario == null )
            {
                return NotFound();
            }


            if (!VerificarPasswordHash(loginViewModel.password, usuario.password_hash, usuario.password_salt ))
            {
                return NotFound();
            }

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, usuario.idusuario.ToString()),
                new Claim(ClaimTypes.Email, email),
                new Claim(ClaimTypes.Role, usuario.rol.nombre),
                new Claim("idusuario", usuario.idusuario.ToString()),
                new Claim("idrol",      usuario.rol.idrol.ToString()),
                new Claim("rol",        usuario.rol.nombre),
                new Claim("nombre",     usuario.nombre),
                new Claim("email",      usuario.email),
                new Claim("direccion",  usuario.direccion),
                new Claim("telefono",   usuario.telefono),
                new Claim("tipo_documento", usuario.tipo_documento),
                new Claim("num_documento", usuario.num_documento),
                new Claim("foto",       usuario.foto)
            };

            return Ok(  new {token = GenerarToken(claims)} );
        }


        private bool VerificarPasswordHash(string password, byte[] passwordHashAlmacenado, byte[] passwordSalt)
        {
            using (var hmac = new System.Security.Cryptography.HMACSHA512(passwordSalt))
            {
                var passwordHashNuevo = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return new ReadOnlySpan<byte>(passwordHashAlmacenado).SequenceEqual(new ReadOnlySpan<byte>(passwordHashNuevo));
            }
        }


        private string GenerarToken(List<Claim> claims)
        {
                                                                     //Clave secreta appSetting
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
                                                            //Encripta clave key
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                _config["Jwt:Issuer"],   // Issuer.....https://localhost:44328/
                _config["Jwt:Issuer"],
                notBefore: DateTime.Now,
                expires: DateTime.Now.AddHours(2),
                signingCredentials: creds,
                claims: claims
                );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }



        // DELETE: api/Usuarios/5
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            var usuario = await _context.Usuario.FindAsync(id);
            if (usuario == null)
            {
                return NotFound();
            }

            _context.Usuario.Remove(usuario);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception)
            {
                return BadRequest();
            }

            return Ok(usuario);
        }


        // PUT: api/Usuarios/Desactivar
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var usuarios = await _context.Usuario.FirstOrDefaultAsync(u => u.idusuario == id);

            if (usuarios == null)
            {
                return NotFound();
            }

            usuarios.condicion = false;

            try
            {
                await _context.SaveChangesAsync();
             //   await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha desactivado usuario " + usuarios.nombre);

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

            var usuarios = await _context.Usuario.FirstOrDefaultAsync(u => u.idusuario == id);

            if (usuarios == null)
            {
                return NotFound();
            }

            usuarios.condicion = true;

            try
            {
                await _context.SaveChangesAsync();
           //     await _hubContext.Clients.Group("Administrador").SendAsync("ReceiveMessage", "Se ha activado usuario " + usuarios.nombre);

            }
            catch (DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok();
        }



        private bool UsuarioExists(int id)
        {
            return _context.Usuario.Any(e => e.idusuario == id);
        }
    }
}
