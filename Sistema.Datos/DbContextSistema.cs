using Microsoft.EntityFrameworkCore;
using Sistema.Datos.Mapping;
using Sistema.Entidades;

namespace Sistema.Datos
{

    public class DbContextSistema:DbContext
    {
        public DbSet<Categoria> Categoria { get; set; }
        public DbSet<Articulo> Articulo { get; set; }
        public DbSet<Persona> Persona { get; set; }
        public DbSet<Rol> Rol { get; set; }
        public DbSet<Usuario> Usuario { get; set; }
        public DbSet<Ingreso> Ingreso { get; set; }
        public DbSet<DetalleIngreso> DetalleIngreso { get; set; }
        public DbSet<Venta> Venta { get; set; }
        public DbSet<DetalleVenta> DetalleVenta { get; set; }
        public DbSet<Configuracion> Configuracion { get; set; }
        public DbSet<TipoArticulo> TipoArticulo { get; set; }
        public DbSet<Articulo_TipoArticulo> Articulo_TipoArticulo { get; set; }



        public DbContextSistema(DbContextOptions<DbContextSistema> options): base(options)
        {

        }



        protected override void OnModelCreating(ModelBuilder modelBuilder) 
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfiguration(new CategoriaMap());
            modelBuilder.ApplyConfiguration(new ArticuloMap());
            modelBuilder.ApplyConfiguration(new PersonaMap());
            modelBuilder.ApplyConfiguration(new RolMap());
            modelBuilder.ApplyConfiguration(new UsuarioMap());
            modelBuilder.ApplyConfiguration(new IngresoMap());
            modelBuilder.ApplyConfiguration(new DetalleIngresoMap());
            modelBuilder.ApplyConfiguration(new VentaMap());
            modelBuilder.ApplyConfiguration(new DetalleVentaMap());
            modelBuilder.ApplyConfiguration(new ConfiguracionMap());
            modelBuilder.ApplyConfiguration(new TipoArticuloMap());
            modelBuilder.ApplyConfiguration(new Articulo_TipoArticuloMap());

        }

    }
}
