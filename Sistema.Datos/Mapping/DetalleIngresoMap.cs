using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Sistema.Entidades;
using System;
using System.Collections.Generic;
using System.Text;

namespace Sistema.Datos.Mapping
{
    public class DetalleIngresoMap : IEntityTypeConfiguration<DetalleIngreso>
    {
        public void Configure(EntityTypeBuilder<DetalleIngreso> builder)
        {
            builder.ToTable("detalle_ingreso").HasKey(d => d.iddetalle_ingreso);
        }
    }
}
