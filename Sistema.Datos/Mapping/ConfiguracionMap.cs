using Microsoft.EntityFrameworkCore;
using Sistema.Entidades;
using System;
using System.Collections.Generic;
using System.Text;

namespace Sistema.Datos.Mapping
{
    public class ConfiguracionMap : IEntityTypeConfiguration<Configuracion>
    {
        public void Configure(Microsoft.EntityFrameworkCore.Metadata.Builders.EntityTypeBuilder<Configuracion> builder)
        {
            builder.ToTable("configuracion")
                .HasKey(c => c.idconfiguracion);
        }
    }
}
