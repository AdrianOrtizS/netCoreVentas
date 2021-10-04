using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Sistema.Datos;
using Sistema.Web.Hub;
using System.IO;
using System.Text;
using Microsoft.AspNetCore.SignalR;

namespace Sistema.Web
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
       
            //services.AddSingleton(typeof(IConverter), new SynchronizedConverter(new PdfTools()));

            /*            services.AddCors(options =>
                            {
                                options.AddPolicy("Todos",
                                                    builder => builder.WithOrigins("*")
                                                                      .WithHeaders("*")
                                                                      .WithMethods("*")
                                                                      .WithExposedHeaders(new string[] { "cantidadTotalRegistros" })
                                                  );
                            }
                        );
            */



            services.AddCors();
            
            services.AddSignalR();


            services.AddAuthentication(opt => {
                opt.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                opt.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
             .AddJwtBearer(options => {
                 options.TokenValidationParameters = new TokenValidationParameters
                 {
                     ValidateIssuer = true,
                     ValidateAudience = true,
                     ValidateLifetime = true,
                     ValidateIssuerSigningKey = true,

                     ValidIssuer = Configuration["Jwt:Issuer"],
                     ValidAudience = Configuration["Jwt:Issuer"],
                     IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]))

                 };
             });


            services.AddDbContext<DbContextSistema>(options => options.UseSqlServer(Configuration.GetConnectionString("conexion")));


/*            services.AddDbContext<DbContextSistema>(options => options.UseSqlServer(Configuration.GetConnectionString("conexion"),
                 optionsBuilder => optionsBuilder.MigrationsAssembly("WebApplicationTestLibrary")
            ));*/


            services.AddControllers();




            /*services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "Sistema.Web", Version = "v1" });
            });*/
        } 

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            //app.UseCors("Todos");

            app.UseCors(x => x
                .AllowAnyMethod()
                .AllowAnyHeader()
                .SetIsOriginAllowed(origin => true) // allow any origin
                .AllowCredentials()
                .WithExposedHeaders(new string[] { "cantidadTotalRegistros" })); // allow credentials

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                //app.UseSwagger();
                //app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Sistema.Web v1"));
            }

            app.Use(async (context, next)=> 
            {
                await next();
                if (context.Response.StatusCode == 404 && !Path.HasExtension(context.Request.Path.Value))
                {
                    context.Request.Path = "/index.html";
                    await next();
                }
            });

            app.UseHttpsRedirection();
            app.UseStaticFiles();

/*          app.UseStaticFiles(new StaticFileOptions()   { FileProvider = new PhysicalFileProvider( Path.Combine(Directory.GetCurrentDirectory(), @"Resources")), RequestPath = new PathString("/Resources")
*/
/*          FileProvider = new PhysicalFileProvider( Path.Combine(env.ContentRootPath, "MyStaticFiles")), RequestPath = "/StaticFiles" });
*/
            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapHub<Mensaje>("/api/notify");
            });
        }
    }
}
