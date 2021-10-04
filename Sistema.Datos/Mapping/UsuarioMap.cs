using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Sistema.Entidades;

namespace Sistema.Datos.Mapping
{
    public class UsuarioMap : IEntityTypeConfiguration<Usuario>
    {
        public void Configure(EntityTypeBuilder<Usuario> builder)
        {
            builder.ToTable("usuario")
                .HasKey(p => p.idusuario);

            CrearPasswordHash("1718348053", out byte[] password_Hash, out byte[] password_Salt);


            var userAdmin = new Usuario() 
            {   idusuario = 1, nombre = "Adrian Ortiz", idrol = 1, num_documento="1718348053",
                direccion = "Magdalena", email="adrian-2222@hotmail.com",telefono="0983740668",
                condicion = true , tipo_documento="Cedula", foto= "",
                password_salt= password_Salt, password_hash=password_Hash 
            };
            

            builder.ToTable("usuario").HasData(userAdmin);
        }


        private void CrearPasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }
    }
}
