
-- Base de Datos para guardar los datos RAW que será nuestro insumo para STAGE
CREATE DATABASE RawVuelosDB
GO

USE RawVuelosDB
GO

-- Tabla para guardar la data seleccionada, en crudo
CREATE TABLE RawDataVuelos(
	RawVueloKey int identity (1,1) primary key,
	FlightDate date not null,
	DepTime varchar(10) not null,
	ArrTime varchar(10) not null,
	DepDelay varchar(10) not null,
	DepDel15 varchar(10) not null,
	ArrDelay varchar(10) not null,
	ArrDel15 varchar(10) not null,
	Cancelled varchar(10) not null,
	Operating_Airline varchar(10) not null,
	Tail_Number varchar(20) not null,
	CarrierDelay smallint not null default 0,
	WeatherDelay smallint not null default 0,
	NASDelay smallint not null default 0,
	SecurityDelay smallint not null default 0,
	LateAircraftDelay smallint not null default 0
)


select COUNT(FlightDate) from RawDataVuelos

select top 1000 * from RawDataVuelos

drop table RawDataVuelos


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


create table DimAerolinea(
	AerolineaKey int identity (1,1) primary key,
	AerolineaId varchar(10) not null,
	Descripcion varchar(100) not null,
)
go


CREATE TABLE FactCausaRetraso(
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

-- Quey para buscar los datos de la tabla de hechos
select top 100 rv.CarrierDelay, rv.WeatherDelay, rv.NASDelay, rv.SecurityDelay, rv.LateAircraftDelay, dv.Tail_Number, rv.Operating_Airline, dv.VueloId, rv.FlightDate
from RawDataVuelos as rv INNER JOIN DimVuelo as dv on dv.VueloId=rv.RawVueloKey INNER JOIN DimAerolinea as da on rv.Operating_Airline=da.AerolineaId