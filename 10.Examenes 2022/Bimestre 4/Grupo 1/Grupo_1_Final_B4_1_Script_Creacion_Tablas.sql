#--Script de creacion de tablas para MySQL--

CREATE DATABASE IF NOT EXISTS FINAL;

USE FINAL;

SET GLOBAL max_allowed_packet=1073741824;

create table BP_EstadoCliente
(
	#id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
    alta int  not null,
    baja int  not null,
    Activo int  not null,
PRIMARY KEY (id)
);
 
ALTER TABLE BP_EstadoCliente 
    ADD CONSTRAINT UQ_BP_EstadoCliente UNIQUE 
    (
    codigo
    );

create table CLI_Cliente
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    estado int  not null,
    numeroCliente int  not null,
    fechaDesde datetime  not null,
    fechaHasta datetime  null,
    fechaEstado datetime  null,
	DISCRIMINATOR varchar (100) not null,
PRIMARY KEY (id)
);

ALTER TABLE CLI_Cliente 
    ADD CONSTRAINT UQ_CLI_Cliente UNIQUE 
    (
    numeroCliente
    );

ALTER TABLE CLI_Cliente 
    ADD CONSTRAINT FK_CLI_Cliente_bp_estado FOREIGN KEY
        (
        estado
        )
    references
        BP_EstadoCliente
        (
        id
        );

create table BP_TipoCuentaCobro
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    vigencia_desde datetime  not null,
    vigencia_hasta datetime  null,
    isRefinanciable int  not null,
    cantidadPermitida int  null,
    financiacion int  not null,
    CantDiasPerCorte int  null,
    CantDiasSdoCorte int  null,
    CantDiasVencido int  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_TipoCuentaCobro 
    ADD CONSTRAINT UQ_BP_TipoCuentaCobro UNIQUE 
    (
    codigo
    );

create table BP_EstadoTipoCtaCobro
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    vigencia_desde datetime  not null,
    vigencia_hasta datetime  null,
    cambioManual int  not null,
    primerCorte int  not null,
    segundoCorte int  not null,
    Activo int  not null,
PRIMARY KEY (id)
);

ALTER TABLE BP_EstadoTipoCtaCobro 
    ADD CONSTRAINT UQ_BP_EstadoTipoCtaCobro UNIQUE 
    (
    codigo
    );

create table BP_EstadoCuentaCobro
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
    activa int  not null,
    estadoTipoCuentaCobro int  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_EstadoCuentaCobro 
    ADD CONSTRAINT UQ_BP_EstadoCuentaCobro UNIQUE 
    (
    codigo
    );

ALTER TABLE BP_EstadoCuentaCobro 
    ADD CONSTRAINT FK_BP_EstadoCuentaCobro_BP_EstadoTipoCtaCobro FOREIGN KEY
        (
        estadoTipoCuentaCobro
        )
    references
        BP_EstadoTipoCtaCobro
        (
        id
        );

create table BP_EstadoServicio
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
    habilitado int  not null,
    deshabilitado int  not null,
    alta int  not null,
    baja int  not null,
    Activo int  not null,
PRIMARY KEY (id));

ALTER TABLE BP_EstadoServicio 
    ADD CONSTRAINT UQ_BP_EstadoServicio UNIQUE 
    (
    codigo
    );

create table BP_TipoServicio
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    aceptaReclamos int  null,
    aceptaRecursosTecnicos int  null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
    discriminator varchar (50) not null,
    esTelefonia int  not null,
    TipoServicioContenedor int  null,
    EsTipoServicioContenedor int  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_TipoServicio 
    ADD CONSTRAINT FK_BP_TipoServicio_BP_TipoServicioContenedor FOREIGN KEY
        (
        TipoServicioContenedor
        )
    references
        BP_TipoServicio
        (
        id
        );

create table BP_EstadoServicio_BPTipoServicio
(
    id_EstadoServicio int  not null,
    id_TipoServicio int  not null,
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    id_EstadoTipoCtaCobro int  null,
PRIMARY KEY (id)    
);

ALTER TABLE BP_EstadoServicio_BPTipoServicio 
    ADD CONSTRAINT UQ_BP_EstadoServicio_BPTipoServicio UNIQUE 
    (
    id_EstadoServicio,
    id_TipoServicio,
    id_EstadoTipoCtaCobro
    );

ALTER TABLE BP_EstadoServicio_BPTipoServicio 
    ADD CONSTRAINT FK_BP_EstadoServicio_BPTipoServicio_BP_EstadoServicio FOREIGN KEY
        (
        id_EstadoServicio
        )
    references
        BP_EstadoServicio
        (
        id
        );

ALTER TABLE BP_EstadoServicio_BPTipoServicio 
    ADD CONSTRAINT FK_BP_EstadoServicio_BPTipoServicio_BP_EstadoTipoCtaCobro FOREIGN KEY
        (
        id_EstadoTipoCtaCobro
        )
    references
        BP_EstadoTipoCtaCobro
        (
        id
        );

ALTER TABLE BP_EstadoServicio_BPTipoServicio 
    ADD CONSTRAINT FK_BP_EstadoServicio_BPTipoServicio_BPTipoServicio FOREIGN KEY
        (
        id_TipoServicio
        )
    references
        BP_TipoServicio
        (
        id
        );

create table BP_Moneda
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_Moneda 
    ADD CONSTRAINT UQ_BP_Moneda UNIQUE 
    (
    codigo
    );

create table CTACTES_CuentaCobro
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    numeroCuenta int  not null,
    valor numeric (10, 2) not null,
    moneda int  not null,
    estado int  not null,
	cliente int not null,
    tipoCuentaCobro int  null,
    estadoGestionCobro int  null,
    fechaEstado datetime  null,
    fechaEstadoGestionCobro datetime  null,
    numeroCliente int  null,
    debitoAutomatico int  null,
PRIMARY KEY (id)
);

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT UQ_CtaCtes_CuentaCobro UNIQUE 
    (
    numeroCuenta,
    cliente
    );

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobro_BP_EstadoCuentaCobro FOREIGN KEY
        (
        estado
        )
    references
        BP_EstadoCuentaCobro
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobro_BP_EstadoTipoCtaCobro FOREIGN KEY
        (
        estadoGestionCobro
        )
    references
        BP_EstadoTipoCtaCobro
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobro_BP_Moneda FOREIGN KEY
        (
        moneda
        )
    references
        BP_Moneda
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobro_BP_TipoCuentaCobro FOREIGN KEY
        (
        tipoCuentaCobro
        )
    references
        BP_TipoCuentaCobro
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobro 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobro_CLI_Cliente FOREIGN KEY
        (
        cliente
        )
    references
        CLI_Cliente
        (
        id
        );

create table BP_TipoMovimiento
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_TipoMovimiento 
    ADD CONSTRAINT UQ_BP_TipoMovimiento UNIQUE 
    (
    codigo
    );

create table CTACTES_CuentaCobroMovimiento
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    fechaMovimiento datetime  not null,
    fechaRegistracion datetime  not null,
    fechaVencimiento datetime  null,
    valor numeric (10, 2) not null,
    moneda int  not null,
    tipoMovimiento int  not null,
    cuentaCobro int  not null,
    comprobante int  not null,
    descripcion varchar (1024) null,
    saldoAFecha numeric (10, 2) not null,
    MonedaSaldoAFecha int  not null,
PRIMARY KEY (id)
);

ALTER TABLE CTACTES_CuentaCobroMovimiento 
    ADD CONSTRAINT UQ_CtaCtes_CuentaCobroMovimiento UNIQUE 
    (
    fechaMovimiento,
    fechaRegistracion,
    fechaVencimiento,
    valor,
    moneda,
    tipoMovimiento,
    comprobante,
    cuentaCobro
    );

ALTER TABLE CTACTES_CuentaCobroMovimiento 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobroMovimiento_BP_Moneda FOREIGN KEY
        (
        moneda
        )
    references
        BP_Moneda
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobroMovimiento 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobroMovimiento_BP_TipoMovimiento FOREIGN KEY
        (
        tipoMovimiento
        )
    references
        BP_TipoMovimiento
        (
        id
        );

ALTER TABLE CTACTES_CuentaCobroMovimiento 
    ADD CONSTRAINT FK_CtaCtes_CuentaCobroMovimiento_CtaCtes_CuentaCobro FOREIGN KEY
        (
        cuentaCobro
        )
    references
        CTACTES_CuentaCobro
        (
        id
        );

create table COMERCIAL_ProductoComercial
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (30) not null,
    nombre varchar (100) not null,
    descripcion varchar (2000) null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE COMERCIAL_ProductoComercial 
    ADD CONSTRAINT UQ_COMERCIAL_ProductoComercial_Nombre UNIQUE 
    (
    nombre
    );

ALTER TABLE COMERCIAL_ProductoComercial
	ADD CONSTRAINT UQ_COMERCIAL_ProductoComercial_codigo UNIQUE 
    (
    codigo
    );
    
create table SERVICIOS_Servicio
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    discriminator varchar (50) not null,
    tipoServicio int  not null,
    estado int  not null,
    fechaInstalacion datetime  null,
    cuentacobro int null,
    productoActual int  null,
    servicioPadre int  null,
    fechaEstado datetime  null,
    servicioContenedor int  null,
    LocalidadStr varchar (100) null,
    SeccionManzana varchar (30) null,
    puntoCentroGoogleMaps_x float  null,
    puntoCentroGoogleMaps_y float  null,
PRIMARY KEY (id)
);



ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_SERVICIOS_Servicio_BP_EstadoServicio FOREIGN KEY
        (
        estado
        )
    references
        BP_EstadoServicio
        (
        id
        );



ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_SERVICIOS_Servicio_BP_TipoServicio FOREIGN KEY
        (
        tipoServicio
        )
    references
        BP_TipoServicio
        (
        id
        );



ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_SERVICIOS_Servicio_COMERCIAL_ProductoComercial FOREIGN KEY
        (
        productoActual
        )
    references
        COMERCIAL_ProductoComercial
        (
        id
        );



ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_Servicios_Servicio_Servicios_ServicioContenedor FOREIGN KEY
        (
        servicioContenedor
        )
    references
        SERVICIOS_Servicio
        (
        id
        );



ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_SERVICIOS_ServicioPadre_Servicio FOREIGN KEY
        (
        servicioPadre
        )
    references
        SERVICIOS_Servicio
        (
        id
        );
        
ALTER TABLE SERVICIOS_Servicio
    ADD CONSTRAINT FK_SERVICIOS_Servicio_CtaCtes_CuentaCobro FOREIGN KEY
        (
        cuentaCobro
        )
    references
        CTACTES_CuentaCobro
        (
        id
        );        

create table BP_TipoRecursoTecnico
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    contenedorRecursos int  not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_TipoRecursoTecnico 
    ADD CONSTRAINT UQ_BP_TipoRecursoTecnico UNIQUE 
    (
    codigo
    );

create table BP_EstadoRecursoTecnico
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    anulado int  not null,
    enUso int  not null,
    libre int  not null,
    proyectado int  not null,
    ocupado int  not null,
    tipoRecursoTecnico int  null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
    asignable int  not null,
    Activo int  not null,
    recuperado int  not null,
PRIMARY KEY (id));

ALTER TABLE BP_EstadoRecursoTecnico 
    ADD CONSTRAINT UQ_BP_EstadoRecursoTecnico UNIQUE 
    (
    codigo
    );

ALTER TABLE BP_EstadoRecursoTecnico 
    ADD CONSTRAINT FK_BP_TipoRecursoTecnico FOREIGN KEY
        (
        tipoRecursoTecnico
        )
    references
        BP_TipoRecursoTecnico
        (
        id
        );

create table TECNICA_RecursoTecnico
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    estado int  not null,
    recursoContenedor int  null,
    tipoRecursoTecnico int  not null,
    nombre varchar (50) not null,
    discriminator varchar (50) not null,
    nombreLogico varchar (50) null,
    fechaEstado datetime  null,
    nombreCompleto varchar (100) null,
    observaciones TEXT null,
    Atributo1 varchar (100) null,
    Atributo2 varchar (100) null,
PRIMARY KEY (id));

ALTER TABLE TECNICA_RecursoTecnico 
    ADD CONSTRAINT UQ__TECNICA_RecursoTecnico UNIQUE 
    (
    nombre,
    tipoRecursoTecnico,
    recursoContenedor
    );

ALTER TABLE TECNICA_RecursoTecnico 
    ADD CONSTRAINT FK_TECNICA_RecursoTecnico_BP_EstadoRecursoTecnico FOREIGN KEY
        (
        estado
        )
    references
        BP_EstadoRecursoTecnico
        (
        id
        );

ALTER TABLE TECNICA_RecursoTecnico 
    ADD CONSTRAINT FK_TECNICA_RecursoTecnico_BP_TipoRecursoTecnico FOREIGN KEY
        (
        tipoRecursoTecnico
        )
    references
        BP_TipoRecursoTecnico
        (
        id
        );

ALTER TABLE TECNICA_RecursoTecnico 
    ADD CONSTRAINT FK_TECNICA_RecursoTecnico_RecursoContenedor FOREIGN KEY
        (
        recursoContenedor
        )
    references
        TECNICA_RecursoTecnico
        (
        id
        );

create table TECNICA_RecursosTecnicos_Servicios
(
    id_Recurso int  not null,
    id_Servicio int  not null
);

ALTER TABLE TECNICA_RecursosTecnicos_Servicios 
    ADD CONSTRAINT PK_TECNICA_RecursosTecnicos_Servicios PRIMARY KEY  
    (
    id_Recurso,
    id_Servicio
    );

ALTER TABLE TECNICA_RecursosTecnicos_Servicios 
    ADD CONSTRAINT FK_TECNICA_RecursosTecnicos_Servicios_SERVICIOS_Servicio FOREIGN KEY
        (
        id_Servicio
        )
    references
        SERVICIOS_Servicio
        (
        id
        );

ALTER TABLE TECNICA_RecursosTecnicos_Servicios 
    ADD CONSTRAINT FK_TECNICA_RecursosTecnicos_Servicios_TECNICA_RecursoTecnico FOREIGN KEY
        (
        id_Recurso
        )
    references
        TECNICA_RecursoTecnico
        (
        id
        );

	
create table BUSINESS_BOHistorico
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    date datetime  not null,
    description varchar (100) null,
    newStateName varchar (100) not null,
    oldStateName varchar (100) null,
    servicio int  null,
    cliente int null,
    cuentacobro int null,
    SPDName varchar (100) not null,
    anulado int  not null,
PRIMARY KEY (id));



ALTER TABLE BUSINESS_BOHistorico
    ADD CONSTRAINT FK_BUSINESS_BOHistorico_SERVICIOS_Servicio FOREIGN KEY
        (
        servicio
        )
    references
        SERVICIOS_Servicio
        (
        id
        );



ALTER TABLE BUSINESS_BOHistorico
    ADD CONSTRAINT FK_BUSINESS_BOHistorico_CLI_Cliente FOREIGN KEY
        (
        cliente
        )
    references
        CLI_Cliente
        (
        id
        );



ALTER TABLE BUSINESS_BOHistorico
    ADD CONSTRAINT FK_BUSINESS_BOHistorico_CTACTES_CuentaCobro FOREIGN KEY
        (
        cuentacobro
        )
    references
        CTACTES_CuentaCobro
        (
        id
        );


create table BP_TipoOperacion
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    codigo varchar (10) not null,
    descripcion varchar (100) not null,
    BTRangoFecha_fechaDesde datetime  not null,
    BTRangoFecha_fechaHasta datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE BP_TipoOperacion 
    ADD CONSTRAINT UQ_BP_TipoOperacion UNIQUE 
    (
    codigo
    );


create table TRAMITE_Operacion
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    tipoOperacion int  not null,
    numero int  not null,
    fechaFin datetime  null,
    servicio int  null,
    fechaInicio datetime  null,
PRIMARY KEY (id)
);

ALTER TABLE TRAMITE_Operacion 
    ADD CONSTRAINT FK_TRAMITE_Operacion_BP_TipoOperacion FOREIGN KEY
        (
        tipoOperacion
        )
    references
        BP_TipoOperacion
        (
        id
        );

ALTER TABLE TRAMITE_Operacion 
    ADD CONSTRAINT FK_TRAMITE_Operacion_SERVICIOS_Servicio FOREIGN KEY
        (
        servicio
        )
    references
        SERVICIOS_Servicio
        (
        id
        );


create table COMERCIAL_ProductoServicio
(
    #id int  not null AUTO_INCREMENT,
    id int  not null,
    productoComercial int  not null,
    vigencia_desde datetime  null,
    vigencia_hasta datetime  null,
    servicioAbs int  null,
    discriminator varchar (50) not null,
PRIMARY KEY (id)
);

#ALTER TABLE COMERCIAL_ProductoServicio 
#    ADD CONSTRAINT UQ__COMERCIAL_ProductoServicio UNIQUE
#    (
#    productoComercial,
#    servicioAbs,
#	vigencia_desde
#    );

ALTER TABLE COMERCIAL_ProductoServicio 
    ADD CONSTRAINT FK_COMERCIAL_ProductoServicio_COMERCIAL_ProductoComercial FOREIGN KEY
        (
        productoComercial
        )
    references
        COMERCIAL_ProductoComercial
        (
        id
        );
        
ALTER TABLE COMERCIAL_ProductoServicio 
    ADD CONSTRAINT FK_COMERCIAL_ProductoServicio_SERVICIO_Servicio FOREIGN KEY
        (
        servicioAbs
        )
    references
        SERVICIOS_Servicio
        (
        id
        );
