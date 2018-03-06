--drop table alumno
--go
--drop table curso
--go

--create table curso
--(idcurso int not null,
--nomcurso char(20) not null,
--primary key(idcurso)
--)
--go
--create table alumno
--(idalumno int not null,
--nomalu char(20) not null,
--idcurso int not null default 1,
--primary key(idalumno),
--foreign key (idcurso) references curso(idcurso)
--on delete set default
--)
--go

--insert into curso values( 1, 'de la tarde')
--go
--insert into curso values( 2, 'de la mañana')
--go
--insert into curso values( 3, 'de la noche')
--go
--insert into curso values( 4, 'del mediodia')
--go
--insert into alumno values(10, 'juan', 2)
--go
--insert into alumno values(20, 'jose', 2)
--go
--insert into alumno values(30, 'jorge', 1)
--go
--insert into alumno values(40, 'juan luis', 3)
--go
--insert into alumno values(50, 'juan pedro', 4)
--go
--insert into alumno values(60, 'juanito', 4)
--go
--insert into alumno values(70, 'juanca', 3)
--go


select  * from alumno
select * from curso


delete from curso
where idcurso=2