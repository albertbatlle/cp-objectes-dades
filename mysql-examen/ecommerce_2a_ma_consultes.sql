USE ecommerce_2a_ma;

-- Dues consultes de cada tipus:

-- Consultes sobre una taula:

-- 1. Com es diu (nom i cognoms) el client amb id 3?
select concat_ws(" ", nom, cognom1, cognom2) as nom_cognoms from clients where id =3;

-- 2. Quin preu i categoria té el producte amb id 2)
select preu, categoria from productes where id = 2;

-- Consultes sobre divereses taules (composició interna)?

-- 1. Comprova el mail utilitzat en cada compra
select distinct compra_id, mail
from compra_client_producte CCP join clients C on C.id = CCP.client_id;

-- 2. Consulta els productes comprats per cada client? Així com la categoria a la que pertanyen.
select concat_ws(" ", C.nom, cognom1, cognom2) as nom_cognoms_clients, P.nom as producte, categoria
from compra_client_producte CCP join clients C on C.id = CCP.client_id join compres CO on CO.id = CCP.compra_id join productes P on P.id = CCP.producte_id;


-- Consultes sobre diverses taules (composició externa)
insert into clients values (default, "67834581H", "Pepe", "Sánchez", "Martínez", "pepe.sm@gmail.com");
insert into productes values (default, "Ulleres de natació", "Natació", 38, 15.99);

select * from clients;

-- 1. Consulta el total de productes que ha comprat cadascun dels clients?
select concat_ws(" ", nom, cognom1, cognom2) as nom_cognom, count(compra_id) as productes_comprats 
from compra_client_producte CCP right join clients C on C.id = CCP.client_id
group by 1;

-- 2. Consulta el total de vendes de cada producte tingui o no vendes?
select nom, count(compra_id) as unitat_venudes 
from productes P left join compra_client_producte CCP on P.id = CCP.producte_id 
group by 1 
order by 2 desc;

-- Consultes resum?

-- 1. Quants productes ha comprat cada client ordenat de més a menys?

select concat_ws(" ", nom, cognom1, cognom2) as nom_cognom, count(compra_id) as productes_comprats 
from clients C join compra_client_producte CCP on C.id = CCP.client_id 
group by nom_cognom
order by productes_comprats desc;

-- 2. Digues el preu comprat de cada compra a través de la taula productes i comprova si coincideix amb el preu total de la taula compres i el client que l'ha fet?
select C.id as client_id, concat_ws(" ", C.nom, cognom1, cognom2) as nom_cognom, sum(preu) as preu_total, preu_total_compra
from compra_client_producte CCP join clients C on C.id = CCP.client_id join compres CO on CO.id = CCP.compra_id join productes P on P.id = CCP.producte_id
group by 1, 2, 4;

-- Sub-consultes:

-- 1. Quin és el client que ha comprat el producte més car?
select C.*
from compra_client_producte CCP join clients C on C.id = CCP.client_id join productes P on P.id = CCP.producte_id
where preu = (select max(preu) from productes);

-- 2. Quin és el client que ha comprat el producte més barat?
select C.*
from compra_client_producte CCP join clients C on C.id = CCP.client_id join productes P on P.id = CCP.producte_id
where preu = (select min(preu) from productes);

--
-- select * from compra_client_producte CCP join clients C on C.id = CCP.client_id join compres CO on CO.id = CCP.compra_id join productes P on P.id = CCP.producte_id;