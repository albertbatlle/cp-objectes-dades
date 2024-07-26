use ecommerce_2a_ma;

select * from productes;
-- Crea una automatització a la base de dades mitjançant un trigger i un event.

-- Anem a procedir a crear un trigger perquè no ens permeti vendre - comprar per part dels clients quan un producte tingui 0 unitats.
-- Primer afegim un producte sense stock.
insert into productes values(default, "Rellotge", "Complements", 0, 59.99);

drop trigger if exists producte_no_disponible;
delimiter //
create trigger producte_no_disponible
before insert on compra_client_producte
for each row
begin
	
    -- definim una variable per comprovar la disponibilitat del producte.
    set @disponible = (select unitats_disponibles from productes where id = new.producte_id);
    
    -- I afegim el condicional perquè ens surti el missatge de no disponible si la variable és igual o inferior a 0.
    if @disponible <= 0 then
		signal sqlstate '45000' set message_text = "Aquest producte no està disponible en aquests moments.";
	end if;
    
end //
delimiter ;

insert into compra_client_producte values(default, 4, 3, 5);
select * from compra_client_producte;

-- Per tal d'evitar que salti el trigger anterior, procedim a crear un event que t'avisi dels productes que has de comprar quan tinguis menys de 5 unitats d'un producte; mitjançant una nova taula que es digui productes_comprar

-- En primer lloc i prèviament a crear l'event, creem la nova taula on s'introduiran diariament les unitats dels productes dels quals tinguem menys de 5 unitats.
create table productes_comprar (
	id int primary key auto_increment,
    id_producte int not null,
    nom_producte varchar(100) not null,
    unitats_restants int,
    data_notificacio timestamp default current_timestamp,
    constraint FK_ProductesComprar foreign key (id_producte) references productes(id)
    );

-- Habilitem el programador d'events. 
SET GLOBAL event_scheduler=ON;

-- I seguidament, procedim a crear l'event que necessitem de manera diària
drop event if exists productes_comprar;
delimiter //
create event productes_comprar
on schedule every 1 day
do 
begin

-- Per fer el registre dels camps que necessitem a la nova taula hem de crear un cursor.
-- declarem les variables que necessitarem insertar a la taula que hem creat anteriorment.	
declare done boolean default false;    
declare cur_id_producte int;
declare cur_nom_producte varchar(100);
declare cur_unitats int;
    
-- afegim la consulta a fer amb el cursor on afegim els 3 camps que necessitem de la taula productes i el filtre de menys de 5 unitats.    
declare cursor_productes_comprar cursor for
	select id, nom, unitats_disponibles
	from productes
	where unitats_disponibles < 5;
	
declare continue handler for not found set done = true;
 
-- Obrim el curor i posteriorment el bucle
open cursor_productes_comprar;
    
bucle_lectura: loop
	fetch cursor_productes_comprar into cur_id_producte, cur_nom_producte, cur_unitats;
	if done then
		leave bucle_lectura;
	end if;
	
    -- i fem la inserció d'aquells productes que tenen menys de 5 unitats a la taula productes_comprar.
	insert into productes_comprar(id_producte, nom_producte, unitats_restants) values (cur_id_producte, cur_nom_producte, cur_unitats);
        
-- tanquem bucle, cursor i finalitzem l'event.	   
end loop bucle_lectura;

close cursor_productes_comprar;
    
end //
delimiter ;


select * from productes_comprar;

truncate productes_comprar;

select id, nom, unitats_disponibles
from productes
where unitats_disponibles < 5;
