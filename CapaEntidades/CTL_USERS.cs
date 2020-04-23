using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class CTL_USERS: CTL_ROLES
    {
        public int Id { get; set; }
        public int IdRoleUser { get; set; }
        public string Name { get; set; }
        public string LastName { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public int Parent { get; set; }
        public int statusUser { get; set; }

        public CTL_USERS() { }
        public CTL_USERS(DataRow fila):base (fila)
        {
            Id = Convert.ToInt32(fila["Id"]);
            IdRoleUser = IdRole;
            Name = Convert.ToString(fila["Name"]);
            LastName = Convert.ToString(fila["LastName"]);
            Surname = Convert.ToString(fila["Surname"]);
            Email = Convert.ToString(fila["Email"]);
            UserName = Convert.ToString(fila["UserName"]);
            //Password = Convert.ToString(fila["Password"]);
            Parent = Convert.ToInt32(fila["Parent"]);
            statusUser = Convert.ToInt32(fila["StatusUser"]);
        }
    }
}
