using CapaAccesoDatos;
using CapaLogicaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebCentauro.Bussines
{
    public partial class gestionarUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UsersLN.getRol(ref dpl_Role);
                UsersLN.getRol(ref dpl_rollAdd);
                UsersLN.getStatus(ref dpl_status);
            }
        }

        /// <summary>
        /// Obtine usuario según valores de busqueda
        /// </summary>
        /// <param name="nombre">Nombre de usuario a consultar</param>
        /// <param name="apellidoP">Apellido paterno a consultar</param>
        /// <param name="apellidoM">Apellido materno a consultar</param>
        /// <param name="correo">Correo a consultar</param>
        /// <returns>Lista de usuarios obtenidos</returns>
        [WebMethod]
        public static List<CTL_USERS> getUsers(string nombre, string apellidoP, string apellidoM, string correo)
        { 
            return  UsersLN.getUsers(nombre,apellidoP,apellidoM,correo);
        }

        /// <summary>
        /// Actualiza un usuario
        /// </summary>
        /// <param name="id">Id del usuario a actualizar</param>
        /// <param name="nombre">Nombre del usuario a actualizar</param>
        /// <param name="apellidoP">Apellido paterno a actualizar</param>
        /// <param name="apellidoM">Apellido materno a actualizar</param>
        /// <param name="correo">Correo a consultar a actualizar</param>
        /// <param name="nombreUsuario">Nombre de usuario a actualizar</param>
        /// <param name="idRol">Id del rol a actualizar</param>
        /// <param name="idStatus">Id del status a actualizar</param>
        /// <returns>True proceso correcto, caso contrario False</returns>
        [WebMethod]
        public static bool updateUser(string id,string nombre, string apellidoP, string apellidoM, string correo, string nombreUsuario, string idRol,string idStatus)
        {
            string action = "UP";
            CTL_USERS  oCTL_USERS = new CTL_USERS();
            oCTL_USERS.Id = Convert.ToInt32(id);
            oCTL_USERS.Name = nombre;
            oCTL_USERS.LastName = apellidoP;
            oCTL_USERS.Surname = apellidoM;
            oCTL_USERS.Email = correo;
            oCTL_USERS.UserName = nombreUsuario;
            oCTL_USERS.IdRole = Convert.ToInt32(idRol);
            oCTL_USERS.statusUser = Convert.ToInt32(idStatus);
            return UsersLN.crudUser(oCTL_USERS,action);
        }

        /// <summary>
        /// Agrega un usuario
        /// </summary>
        /// <param name="nombre">>Nombre de usuario</param>
        /// <param name="apellidoP">Apellido paterno</param>
        /// <param name="apellidoM">Apellido materno</param>
        /// <param name="correo">Correo electronico</param>
        /// <param name="nombreUsuario">Nombre de usuario</param>
        /// <param name="idRol">Id rol</param>
        /// <param name="password">Password</param>
        /// <returns>True proceso correcto, caso contrario False</returns>
        [WebMethod]
        public static bool addteUser(string nombre, string apellidoP, string apellidoM, string correo, string nombreUsuario, string idRol, string password)
        {
            string action = "IN";
            CTL_USERS oCTL_USERS = new CTL_USERS();
            oCTL_USERS.Name = nombre;
            oCTL_USERS.LastName = apellidoP;
            oCTL_USERS.Surname = apellidoM;
            oCTL_USERS.Email = correo;
            oCTL_USERS.UserName = nombreUsuario;
            oCTL_USERS.IdRole = Convert.ToInt32(idRol);
            oCTL_USERS.Password = password;
            oCTL_USERS.Parent = 1;
            oCTL_USERS.WebPage = "gestionarUsuarios.apsx";
            return UsersLN.crudUser(oCTL_USERS, action);
        }

        /// <summary>
        /// Elimina un usuario
        /// </summary>
        /// <param name="id">Id del usuario a eliminar</param>
        /// <returns>True proceso correcto, caso contrario False</returns>
        [WebMethod]
        public static bool deleteUser(string id)
        {
            string action = "DE";
            CTL_USERS oCTL_USERS = new CTL_USERS();
            oCTL_USERS.Id = Convert.ToInt32(id);
            return UsersLN.crudUser(oCTL_USERS, action);
        }
    }
}