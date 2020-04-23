using CapaAccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace CapaLogicaNegocio
{
    public class UsersLN
    {
        /// <summary>
        /// Obtiene lista de usuarios
        /// </summary>
        /// <param name="nombre">Nombre de usuario</param>
        /// <param name="apellidoP">Apellido paterno</param>
        /// <param name="apellidoM">Apellido materno</param>
        /// <param name="correo">Correo electronico</param>
        /// <returns>Lista de objetos CTL_USERS</returns>
        public static List<CTL_USERS> getUsers(string nombre, string apellidoP,string apellidoM, string correo)
        {
            return CTL_USERS_DAO.getUsers(nombre, apellidoP, apellidoM, correo);
        }

        /// <summary>
        /// Agrega, actualiza, y elimina un usuario
        /// - Action = IN para agregar
        /// - Action = UP para actualizar
        /// - Action = DE para eliminar
        /// </summary>
        /// <param name="oCTL_USERS">oCTL_USERS Objeto a agregar, actualizar o eliminar</param>
        /// <param name="action">action Acción a realizar</param>
        /// <returns></returns>
        public static bool crudUser(CTL_USERS oCTL_USERS, string action)
        {
            return CTL_USERS_DAO.crudteUser(oCTL_USERS, action);
        }

        /// <summary>
        /// Pobla un control html DropDownList
        /// </summary>
        /// <param name="dpl_roles">DropDownList</param>
        public static void getRol(ref DropDownList dpl_roles)
        {
            DataTable tb = CTL_USERS_DAO.getRoles();
            dpl_roles.DataSource = tb;
            dpl_roles.DataValueField = "Id";
            dpl_roles.DataTextField = "Description";
            dpl_roles.DataBind();
            dpl_roles.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
        }

        /// <summary>
        /// Pobla un control html DropDownList
        /// </summary>
        /// <param name="dpl_status">DropDownList</param>
        public static void getStatus(ref DropDownList dpl_status)
        {
            dpl_status.Items.Insert(0, new ListItem("Inactivo", "0"));
            dpl_status.Items.Insert(1, new ListItem("Activo", "1"));
        }
    }
}
