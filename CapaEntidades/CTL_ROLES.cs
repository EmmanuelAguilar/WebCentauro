using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class CTL_ROLES: CTL_SYSTEM_LOG
    {
        public int IdRole { get; set; }
        public string RoleName { get; set; }
        public int StatusRole { get; set; }
        public CTL_ROLES() { }
        public CTL_ROLES(DataRow fila):base(fila)
        {
            IdRole = Convert.ToInt32(fila["IdRole"]);
            RoleName = Convert.ToString(fila["RoleName"]);
            StatusRole = Convert.ToInt32(fila["StatusRole"]);
        }
    }
}
