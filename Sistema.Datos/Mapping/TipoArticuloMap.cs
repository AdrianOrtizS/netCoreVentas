using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Sistema.Entidades;
using System;
using System.Collections.Generic;
using System.Text;

namespace Sistema.Datos.Mapping
{
    public class TipoArticuloMap : IEntityTypeConfiguration<TipoArticulo>
    {
        public void Configure(EntityTypeBuilder<TipoArticulo> builder)
        {
            builder.ToTable("tipoArticulo")
                  .HasKey(ta => ta.idTipoArticulo);
        }
    }
}
