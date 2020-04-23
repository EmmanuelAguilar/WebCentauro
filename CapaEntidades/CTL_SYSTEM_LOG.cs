using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class CTL_SYSTEM_LOG
    {
        public int IdLog { get; set; }
        public string DateRegister { get; set; }
        public int IdMovement { get; set; }
        public int IdAffectedRegiser { get; set; }
        public string Description { get; set; }
        public int IdUser { get; set; }
        public string WebPage { get; set; }

        public CTL_SYSTEM_LOG() { }
        public CTL_SYSTEM_LOG(DataRow fila)
        {
            //Id = Convert.ToInt32(fila["Id"]);
            DateRegister = Convert.ToDateTime(fila["LogDateRegister"] == DBNull.Value ? new DateTime(1990, 01, 01) : (DateTime)fila["LogDateRegister"]).ToString("yyyy-MM-dd hh:mm:ss");
            //IdMovement = Convert.ToInt32(fila["IdMovement"]);
            //IdAffectedRegiser = Convert.ToInt32(fila["IdAffectedRegiser"]);
            Description = Convert.ToString(fila["LogDescription"]);
            //IdUser =  Convert.ToInt32(fila["IdUser"]);
            WebPage = Convert.ToString(fila["LogWebPage"]);
        }
    }
}
