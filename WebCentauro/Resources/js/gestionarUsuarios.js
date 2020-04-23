var tabla;
var idUser;
function configurationElements() {
    //Configuración dataTable
    tabla = $('#tbl_users').DataTable({});

    //Botón Buscar
    document.getElementById("btn_buscar").onclick = function (e) {
        e.preventDefault;        
        getObjeData();
    }

    //Botón mostrar modal para agregar usuario
    document.getElementById("btn_Registrar").onclick = function (e) {
        e.preventDefault;
        $('#edit_userAdd').modal();
    }

    tabla.column(0).visible(false);
    tabla.column(1).visible(false);
}

function getObjeData() {
    var _nombre    =  document.getElementById("txt_nombre").value ; 
    var _apellidoP =  document.getElementById("txt_apellidoP").value;
    var _apellidoM =  document.getElementById("txt_apellidoM").value;
    var _correo    =  document.getElementById("txt_correo").value;   
    var obj = JSON.stringify({
        nombre: _nombre,
        apellidoP: _apellidoP,
        apellidoM: _apellidoM,
        correo: _correo
    });
    getUser(obj);
}

function getUser(obj) {
    $.ajax({
        type: 'POST',
        url: 'gestionarUsuarios.aspx/getUsers',
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset-utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log(data.d)
            if (data.d == null) {
                console.log('Error: Data is null');
                tabla.clear().draw();
            } else if (data.d != null && data.d.length > 0) {
                console.log('Get data success');
                addRow(data.d);
            } else if (data.d.length <= 0) {
                console.log('No data');
                tabla.clear().draw();
            }
        }
    });
}

//Añade filas al dataTable de jquery.
function addRow(data) {
    tabla.clear().draw();
    for (var i = 0; i < data.length; i++) {
        tabla.row.add([
            data[i].Id,                                           //Id
            data[i].IdRoleUser,                                   //IdRoleUser
            data[i].Name,                                         //Nombre
            data[i].LastName,                                     //Apellido Paterno
            data[i].Surname,                                      //Apellido Materno
            data[i].Email,                                        //Correo
            data[i].UserName,                                     //Nombre Usuario
            data[i].RoleName,                                     //Rol Nombre
            ((data[i].StatusRole == 1) ? '<span class="btn btn-xs btn-success">Activo</i></span>' : '<span class="btn btn-xs btn-warning">Inactivo</i></span>'), //Status Rol
            ((data[i].DateRegister == "1990-01-01 12:00:00") ? '' : data[i].DateRegister),                                 //Log Fch.Reg
            data[i].Description,                                  //Log Desc.
            data[i].WebPage,                                      //Log WebPage
            ((data[i].statusUser == 1 ? '<span class="btn btn-xs btn-success">Activo</i></span>' : '<span class="btn btn-xs btn-warning">Inactivo</i></span>')),                                   //Status User
            '<a id="btn-edit" class="btn btn-primary btn-xs btn-edit"><i class="fa fa-check-square-o"></i></a>',
            '<a id="btn-del" class="btn btn-danger btn-xs btn-del"><i class="fa fa-trash-o"></i></a>',
        ]).draw(false);
    }
}

//Evento click para editar registros.
$(document).on('click', '.btn-edit', function (e) {
    e.preventDefault();
    //Obtenemos fila seleccionada.
    var selected_row = $(this).parent().parent()[0];
    //Convertimos en array fila seleccionada
    var dataROW = tabla.row(selected_row).data();
    console.log(dataROW);
    idUser = dataROW[0];
    setUser(dataROW);
    
});

//Evento click para actualizar registros.
$(document).on('click', '.btn_up', function (e) {
    e.preventDefault();
    var _nombre = document.getElementById("tbx_Nombre").value;
    var _apellidoP = document.getElementById("tbx_ApellidoP").value;
    var _apellidoM = document.getElementById("tbx_ApellidoM").value;
    var _correo = document.getElementById("txt_correo2").value;
    var _nombreUsuario = document.getElementById("txt_numbreUsuario").value;
    var _idRol = document.getElementById("dpl_Role").value;
    var _status = document.getElementById("dpl_status").value;

    if (_idRol == "0")
    {
        alert('Debe seleccionar un rol');
        return false;
    }

    var obj = JSON.stringify({
        id:idUser,
        nombre: _nombre,
        apellidoP: _apellidoP,
        apellidoM: _apellidoM,
        correo: _correo,
        nombreUsuario: _nombreUsuario,
        idRol: _idRol,
        idStatus: _status
    });

    updateUser(obj); //==>Actualizar usuario
    getObjeData();   //==>Mostrar datos actualizados
});

//Evento click para eliminar registros.
$(document).on('click', '.btn-del', function (e) {
    e.preventDefault();
    //Obtenemos fila seleccionada.
    var selected_row = $(this).parent().parent()[0];
    //Convertimos en array fila seleccionada
    var dataROW = tabla.row(selected_row).data();
    var _id=dataROW[1]; //id usuario
    console.log(dataROW);
    
    var obj = JSON.stringify({
        id: _id
        });

    deleteUser(obj);
});

//Evento click para agregar registros.
$(document).on('click', '.btn_Add', function (e) {
    e.preventDefault();
    var _nombre = document.getElementById("txt_nombreAdd").value;
    var _apellidoP = document.getElementById("txt_apellidoPAdd").value;
    var _apellidoM = document.getElementById("txt_apellidoMAdd").value;
    var _correo = document.getElementById("txt_correoAdd").value;
    var _nombreUsuario = document.getElementById("txt_nombreUsuarioAdd").value;
    var _idRol = document.getElementById("dpl_rollAdd").value;
    var _password = document.getElementById("txt_password").value;

    if (_nombre == "") {
        alert('Debe ingresar un nombre');
        return false;
    } else if (_apellidoP == "") {
        alert('Debe ingresar apellido paterno');
        return false;
    } else if (_apellidoM == "") {
        alert('Debe ingresar apellido materno');
        return false;
    } else if (_correo == "") {
        alert('Debe ingresar un corre');
        return false;
    } else if (_nombreUsuario == "") {
        alert('Debe ingresar un nombre de usuario');
        return false;
    } else if (_idRol == "0") {
        alert('Debe seleccionar un rol');
        return false;
    } else if (_password == "") {
        alert('Debe ingresar un password');
        return false;
    }

    var obj = JSON.stringify({
        nombre: _nombre,
        apellidoP: _apellidoP,
        apellidoM: _apellidoM,
        correo: _correo,
        nombreUsuario: _nombreUsuario,
        idRol: _idRol,
        password: _password
    });

    addUser(obj);    //==>Agregar usuario
    getObjeData();   //==>Mostrar datos actualizados
});


function setUser(data) {
    var usuario = data;   
    $('#tbx_Nombre').val(usuario[2].toString());
    $('#tbx_ApellidoP').val(usuario[3].toString());
    $('#tbx_ApellidoM').val(usuario[4].toString());    
    $('#txt_correo2').val(usuario[5].toString());    
    $('#txt_numbreUsuario').val(usuario[6].toString());
    $('#dpl_Role').val(usuario[1]);
    if (usuario[8].toString().includes('Activo')) {
        $('#txt_statusRol').val('Activo');
    } else {
        $('#txt_statusRol').val('Inactivo');
    }
    $('#txt_logFchReg').val(usuario[9].toString());
    $('#txt_logDesc').val(usuario[10].toString());
    $('#txt_logWebPage').val(usuario[11].toString());
    if (usuario[12].toString().includes('Activo')) {
        $('#dpl_status').val(1);
    } else {
        $('#dpl_status').val(0);
    }
    $('#edit_user').modal();
}

function updateUser(obj) {
    $.ajax({
        type: 'POST',
        url: 'gestionarUsuarios.aspx/updateUser',
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset-utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log(data.d)
            if (data.d == null) {
                console.log('Error: Data is null');
                tabla.clear().draw();
            } else {
                if (data.d) {
                    alert('Usuario actualizado correctamente');
                } else {
                    alert('No se pudo actualizar usuario');
                }
            }
        }
    });
}

function addUser(obj) {
    $.ajax({
        type: 'POST',
        url: 'gestionarUsuarios.aspx/addteUser',
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset-utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log(data.d)
            if (data.d == null) {
                console.log('Error: Data is null');
                tabla.clear().draw();
            } else {
                if (data.d) {
                    alert('Usuario agregado correctamente');
                } else {
                    alert('No se pudo agregar usuario');
                }
            }
        }
    });
}

function deleteUser(obj) {
    $.ajax({
        type: 'POST',
        url: 'gestionarUsuarios.aspx/deleteUser',
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset-utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log(data.d)
            if (data.d == null) {
                console.log('Error: Data is null');
                tabla.clear().draw();
            } else {
                if (data.d) {
                    alert('Usuario eliminado');
                } else {
                    alert('No se pudo eliminar usuario asegurese que no exista log relacionado');
                }
            }
        }
    });
}

configurationElements(); //==>Configuración de elementos del ODM