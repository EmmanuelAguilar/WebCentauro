<%@ Page Title="" Language="C#" MasterPageFile="~/Template/Home.Master" AutoEventWireup="true" CodeBehind="gestionarUsuarios.aspx.cs" Inherits="WebCentauro.Bussines.gestionarUsuarios" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .FilaCabecera {
            background-color: #003565;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h3 style="text-align: left">Buscar</h3>
    </section>
    <section id="register-form" class="content">

        <div class="row">
            <div class="col-xs-6">
                <div class="box  box-primary" runat="server" id="id_prueba">
                    <div class="box box-body">
                        <div class="form-group has-feedback">
                            <label>Nombre:</label>
                            <asp:TextBox id="txt_nombre" runat="server"  placeholder="Nombre" CssClass="form-control"></asp:TextBox>
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>                            
                        </div>
                        <div id="idmsj" class="row"></div>


                        <div class="form-group has-feedback">
                            <label>Correo electronico:</label>
                            <asp:TextBox ID="txt_correo" runat="server" placeholder="Correo electronico" CssClass="form-control"></asp:TextBox>
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-6">
                <div class="box box-primary">
                    <div class="box box-body">

                        <div class="form-group has-feedback">
                            <label>Apellido parterno:</label>
                            <asp:TextBox ID="txt_apellidoP" runat="server"  placeholder="Apellido parterno" CssClass="form-control"></asp:TextBox>
                            <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                        </div>

                        <div class="form-group has-feedback">
                            <label>Apellido materno:</label>
                            <asp:TextBox ID="txt_apellidoM" runat="server" placeholder="Apellido materno" CssClass="form-control"></asp:TextBox>
                            <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="form-group has-feedback">
                    <div class="pull-right">
                        <a id="btn_buscar" class="btn btn-success btn-sm" >Buscar</a>
                    </div>
                </div>
            </div>
        </div>
        <br />

        <div class="row">

            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Lista de Usuarios</h3> 
                        <br />
                        <div class="pull-right">
                            <a id="btn_Registrar" class="btn btn-success btn-sm" style="color:white" >Agregar usuario</a>
                        </div>
                    </div>

                    <div class="box-body table-responsive">
                        <table id="tbl_users" class="table table-bordered table-hover" style="width: 100%;">
                            <thead class="FilaCabecera" style='font-size: 12px'>
                                <tr>
                                    <th></th> <%--Id user--%>
                                    <th></th> <%--Id Rol user--%>
                                    <th>Nombre</th>
                                    <th>Apellido Paterno</th>
                                    <th>Apellido Materno</th>
                                    <th>Correo</th>
                                    <th>Nombre Usuario</th>
                                    <th>Rol Nombre</th>
                                    <th>Status Rol</th>
                                    <th>Log Fch.Reg</th>
                                    <th>Log Desc.</th>
                                    <th>Log WebPage</th>
                                    <th>Status User</th>
                                    <th>Edit</th>
                                    <th>Del</th>
                                </tr>
                            </thead>

                            <tbody id="tbl_body">
                                <!-- CARGAR DATOS POR MEDIO DE AJAX -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="../Resources/js/gestionarUsuarios.js"></script>
    </section>

    <%--Modal editar usuario--%>
    <div class="modal fade" id="edit_user">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Editar Información del Usuario</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label><span>Nombre</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="tbx_Nombre" runat="server" ClientIDMode="Static" placeholder="Nombre" CssClass="form-control" style="font-size: 11px"></asp:TextBox>
                                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Apellido parterno</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="tbx_ApellidoP" runat="server" ClientIDMode="Static" placeholder="Apellido parterno" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Correo</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_correo2" runat="server" ClientIDMode="Static" placeholder="Correo" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Apellido materno</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="tbx_ApellidoM" runat="server" ClientIDMode="Static" placeholder="Apellido materno" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Nombre usuario</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_numbreUsuario" runat="server" ClientIDMode="Static" placeholder="Nombre usuario" CssClass="form-control selector_fechas" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask=""></asp:TextBox>
                                <span class="glyphicon glyphicon-user  form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Rol nombre</span></label>:
                            <div class="form-group has-feedback">
                                <asp:DropDownList ID="dpl_Role" runat="server"  ClientIDMode="Static"  CssClass="form-control" data-live-search="true"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Estatus rol</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_statusRol" runat="server" Enabled="false" ClientIDMode="Static" placeholder="Estatus rol" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-certificate form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Log Fecha.Reg</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_logFchReg" runat="server" Enabled="false" ClientIDMode="Static" placeholder="Log Fecha.Reg" CssClass="form-control"></asp:TextBox>                              
                                <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Log Descripción</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_logDesc" runat="server" Enabled="false" ClientIDMode="Static" placeholder="Log Descripción" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-list-alt form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Log WepPage</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_logWebPage" runat="server" Enabled="false" ClientIDMode="Static" placeholder="Log WepPage" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-globe form-control-feedback"></span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label><span>Estatus</span></label>:
                            <div class="form-group has-feedback">
                              <asp:DropDownList ID="dpl_status" runat="server"  ClientIDMode="Static"  CssClass="form-control" data-live-search="true"></asp:DropDownList>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <a id="btn-cl" class="btn btn-danger pull-left btn-cl">Cancelar</a>
                    <a id="btn-edit" class="btn btn-success pull-right btn_up">Guardar</a>
                </div>
            </div>
        </div>
    </div>
    <%--/Modal editar usuario--%>

    <%--Modal agregar usuario--%>
    <div class="modal fade" id="edit_userAdd">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Agregar Usuario</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label><span>Nombre</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_nombreAdd" runat="server" MaxLength="20" ClientIDMode="Static" placeholder="Nombre" CssClass="form-control" style="font-size: 11px"></asp:TextBox>
                                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Apellido parterno</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_apellidoPAdd" runat="server" MaxLength="25" ClientIDMode="Static" placeholder="Apellido parterno" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Correo</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_correoAdd" runat="server" MaxLength="80" ClientIDMode="Static" placeholder="Correo" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Apellido materno</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_apellidoMAdd" runat="server" MaxLength="25" ClientIDMode="Static" placeholder="Apellido materno" CssClass="form-control"></asp:TextBox>
                                <span class="glyphicon glyphicon-th-list form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Nombre usuario</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_nombreUsuarioAdd" runat="server" ClientIDMode="Static" MaxLength="15" placeholder="Nombre usuario" CssClass="form-control selector_fechas" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask=""></asp:TextBox>
                                <span class="glyphicon glyphicon-user  form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label><span>Rol nombre</span></label>:
                            <div class="form-group has-feedback">
                                <asp:DropDownList ID="dpl_rollAdd" runat="server"  ClientIDMode="Static"  CssClass="form-control" data-live-search="true"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label><span>Password</span></label>:
                            <div class="form-group has-feedback">
                                <asp:TextBox ID="txt_password" runat="server" ClientIDMode="Static" placeholder="Password" type="password" CssClass="form-control selector_fechas" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask=""></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a id="btn_clAdd" class="btn btn-danger pull-left btn_clAdd-cl">Cancelar</a>
                    <a id="btn_Add" class="btn btn-success pull-right btn_Add">Guardar</a>
                </div>
            </div>
        </div>
    </div>
    <%--/Modal agregar usuario--%>

</asp:Content>
