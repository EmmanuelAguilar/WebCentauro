using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class CTL_USERS_DAO
    {
        /// <summary>
        /// Ejecuta Stored Procedure con query dinamico para obtener una lista de usuarios
        /// </summary>
        /// <param name="nombre">Nombre a buscar</param>
        /// <param name="apellidoP">Apellido paterno a buscar</param>
        /// <param name="apellidoM">Apellido materno a buscar</param>
        /// <param name="correo">Correo electronico a buscar</param>
        /// <returns></returns>
        public static List<CTL_USERS> getUsers(string nombre,string apellidoP,string apellidoM,string correo)
        {
            List<CTL_USERS> lisUsers = null;

            SqlConnection conexion = null;
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            SqlParameter param;
            DataSet dS = new DataSet();

            try
            {
                conexion = Conexion.getInstanceConexion().ConexionBD();
                conexion.Open();
                cmd.Connection = conexion;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "SP_DYNAMIC_QUERY_SEARCH_USER";

                //Params IN
                param = new SqlParameter("@nombre", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = nombre;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@apellidoP", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = apellidoP;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@apellidoM", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = apellidoM;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@correo", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = correo;
                cmd.Parameters.Add(param);
                param = null;

                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dS);

                if (dS.Tables[0].Rows.Count>0)
                {
                    lisUsers = new List<CTL_USERS>();
                    foreach (DataRow fila in dS.Tables[0].Rows)
                    {
                        lisUsers.Add(new CTL_USERS(fila));
                    }
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return lisUsers;
        }

        /// <summary>
        /// Ejecuta Stored Procedure que Agrega, actualiza, y elimina un usuario
        /// - Action = IN para agregar
        /// - Action = UP para actualizar
        /// - Action = DE para eliminar
        /// </summary>
        /// <param name="oCTL_USERS"><oCTL_USERS Objeto a agregar, actualizar o eliminar/param>
        /// <param name="action">action Acción a realizar</param>
        /// <returns>True proceso correcto, caso contrario False</returns>
        public static bool crudteUser(CTL_USERS oCTL_USERS, string action)
        {
            SqlConnection conexion = null;
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adapter;
            SqlParameter param, paramR;
            DataSet dS = new DataSet();

            try
            {
                conexion = Conexion.getInstanceConexion().ConexionBD();
                conexion.Open();
                cmd.Connection = conexion;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "SP_NEW_USER";

                //Params IN
                param = new SqlParameter("@Action", SqlDbType.Char);
                param.Direction = ParameterDirection.Input;
                param.Value = action;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Id", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Id;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@IdRole", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.IdRole;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Name", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Name;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@LastName", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.LastName;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Surname", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Surname;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Email", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Email;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@UserName", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.UserName;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Password", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Password;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Parent", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Parent;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Status", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.statusUser;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@IdLog", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.IdLog;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@DateRegister", SqlDbType.DateTime);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.DateRegister;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@IdMovement", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.IdMovement;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@IdAffectedRegiser", SqlDbType.Int);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.IdAffectedRegiser;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@Description", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.Description;
                cmd.Parameters.Add(param);
                param = null;

                param = new SqlParameter("@WebPage", SqlDbType.VarChar);
                param.Direction = ParameterDirection.Input;
                param.Value = oCTL_USERS.WebPage;
                cmd.Parameters.Add(param);
                param = null;

                paramR = new SqlParameter("@Result", SqlDbType.VarChar);
                paramR.Direction = ParameterDirection.Output;
                paramR.Value = "";
                paramR.Size = 100;
                cmd.Parameters.Add(paramR);

                adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dS);

                string varf = cmd.Parameters["@Result"].Value.ToString();

                return varf == "1" ? true : false;
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw new HttpRequestException(HttpStatusCode.NotFound.ToString());
            }
            finally
            {
                conexion.Close();
            }
        }

        /// <summary>
        /// Ejecuta Función para obtener lista de roles 
        /// </summary>
        /// <returns>DataTable</returns>
        public static DataTable getRoles()
        {
            SqlConnection conexion = null;
            SqlCommand cmd = null;
            SqlDataAdapter render = null;
            DataSet dS = new DataSet();

            try
            {
                conexion = Conexion.getInstanceConexion().ConexionBD();
                conexion.Open();
                cmd = new SqlCommand("SELECT * FROM FN_GET_ROLES()", conexion);
                render = new SqlDataAdapter();
                render.SelectCommand = cmd;
                render.Fill(dS);
            }
            catch
            {
                throw new HttpRequestException(HttpStatusCode.NotFound.ToString());
            }
            finally
            {
                conexion.Close();
            }
            return dS.Tables[0];
        }
    }
}
