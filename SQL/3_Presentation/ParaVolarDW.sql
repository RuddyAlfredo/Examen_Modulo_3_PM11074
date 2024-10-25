
-- Base de Datos para guardar los datos RAW que será nuestro insumo para STAGE
CREATE DATABASE ParaVolarDW
GO

USE ParaVolarDW
GO

-- ****DIMENSIones**** --
-- ------------------------------------------------------------------------- Vuelo
create table DimVuelo(
	VueloKey int identity (1,1) primary key,
	VueloId int not null,
	DepTime varchar(10) not null,
	ArrTime varchar(10) not null,
	DepDelay varchar(10) not null,
	DepDel15 varchar(10) not null,
	ArrDelay varchar(10) not null,
	ArrDel15 varchar(10) not null,
	Cancelled varchar(10) not null,
	Tail_Number varchar(20) not null,
)
go

select * from DimVuelo
delete DimVuelo
drop table DimVuelo


-- ------------------------------------------------------------------------- Aerolinea
create table DimAerolinea(
	AerolineaKey int identity (1,1) primary key,
	CodigoAerolinea varchar(10) not null,
	NombreAerolinea varchar(100) not null,
)
go

select * from DimAerolinea
delete DimAerolinea
drop table DimAerolinea


-- ------------------------------------------------------------------------- FECHA
create table DimFecha(
	FechaKey int primary key,
	FechaVuelo datetime not null,
	Anio int not null,
	Trimestre tinyint not null,
	Mes tinyint not null,
	DiaMes smallint not null)
go

select * from DimFecha
delete DimFecha
drop table DimFecha

-- ------------------------------------------------------------------------- FACT TABLE
create table FactCausaRetraso(
	FlightDateKey int not null foreign key references DimFecha(FechaKey),
	VueloKey int not null foreign key references DimVuelo(VueloKey),
	AerolineaKey int not null foreign key references DimAerolinea(AerolineaKey),
	CarrierDelay smallint not null,
	WeatherDelay smallint not null,
	NASDelay smallint not null,
	SecurityDelay smallint not null,
	LateAircraftDelay smallint not null
)

select * from FactCausaRetraso 
drop table FactCausaRetraso