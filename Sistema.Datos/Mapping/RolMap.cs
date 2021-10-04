using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Sistema.Entidades;

namespace Sistema.Datos.Mapping
{
    public class RolMap : IEntityTypeConfiguration<Rol>
    {
        public void Configure(EntityTypeBuilder<Rol> builder)
        {
            builder.ToTable("rol")
               .HasKey(p => p.idrol);

            var rolAdministrador = new Rol() { idrol = 1, nombre = "Administrador", descripcion = "Administrador de sitio", condicion = true };
            var rolVendedor = new Rol() { idrol = 2, nombre = "Vendedor", descripcion = "Vendedor de sitio", condicion = true };
            var rolAlmacenero = new Rol() { idrol = 3, nombre = "Almacenero", descripcion = "Almacenero de sitio", condicion = true };

            builder.ToTable("rol").HasData(rolAdministrador);
            builder.ToTable("rol").HasData(rolVendedor);
            builder.ToTable("rol").HasData(rolAlmacenero);


        }
    }
}
