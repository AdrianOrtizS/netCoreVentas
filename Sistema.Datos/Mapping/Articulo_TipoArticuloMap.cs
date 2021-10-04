using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Sistema.Entidades;
using System;
using System.Collections.Generic;
using System.Text;

namespace Sistema.Datos.Mapping
{
    public class Articulo_TipoArticuloMap : IEntityTypeConfiguration<Articulo_TipoArticulo>
    {
        public void Configure(EntityTypeBuilder<Articulo_TipoArticulo> builder)
        {
            builder.ToTable("articulo_tipoArticulo")
                .HasKey(bc => new { bc.idarticulo, bc.idtipoArticulo });

            
            
            builder.ToTable("articulo_tipoArticulo")
                .HasOne(b => b.articulo)
                .WithMany(bg => bg.Art_TipoArt)
                .HasForeignKey(bc => bc.idarticulo);


            builder.ToTable("articulo_tipoArticulo")
                .HasOne(c => c.tipoArticulo)
                .WithMany(ca => ca.Art_TipoArt)
                .HasForeignKey(cc => cc.idtipoArticulo);


        }
    }
}
