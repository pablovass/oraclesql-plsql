--create database bd_ej2
--use bd_ej2

create table alumno
(idalumno int not null,
nomalu char(20) not null,
primary key(idalumno)
)
go
create table curso
(idcurso int not null,
nomcurso char(20) not null,
primary key(idcurso)
)
go
create table cursa
(id_alumno int not null,
id_curso int not null,
anio int
primary key(id_alumno, id_curso),
foreign key(id_alumno) references alumno(idalumno),
foreign key (id_curso) references curso(idcurso)
)
go

use bd_ej1

delete from curso
where idcurso=4

select * from alumno












