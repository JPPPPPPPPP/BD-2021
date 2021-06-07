--Query A 
--List all products (EAN and description) that have been replenished in more than 15 units, after 25/04/2021 in the “Milk” category.
SELECT DISTINCT ean, descr
FROM replenishment_event NATURAL JOIN product NATURAL JOIN category NATURAL JOIN simple_category
WHERE (cat_name LIKE 'Milk' OR super_name LIKE 'Milk') AND (units > 15) AND (instant > '2021-03-25');

--Query B
--Given the EAN of a product, display the name and NIF of all its suppliers (both primary and secondary).
--EAN used here is 1234567890126
SELECT DISTINCT s.supp_nif, supp_name FROM 
(
	SELECT primary_supplier.supp_nif, primary_supplier.ean FROM primary_supplier
    UNION ALL
    SELECT secondary_supplier.supp_nif, secondary_supplier.ean FROM secondary_supplier
) AS ss JOIN supplier s
ON ss.supp_nif = s.supp_nif
WHERE ean = 1234567890126;

--Query C
--Display the number of sub-categories (direct descendants) of the “Milk” category.
SELECT COUNT(cat_name)
FROM simple_category NATURAL JOIN super_category
WHERE super_name LIKE 'Milk';

--Query D
--What is the name and NIF of the supplier who supplied more categories.
SELECT supp_nif, supp_name FROM 
(
	SELECT supp_name, supp_nif, COUNT( DISTINCT cat_name ) AS catCount FROM 
	(
		SELECT primary_supplier.supp_nif, primary_supplier.ean FROM primary_supplier
	  	UNION ALL
	   	SELECT secondary_supplier.supp_nif, secondary_supplier.ean FROM secondary_supplier
	) AS aggSupp NATURAL JOIN product NATURAL JOIN supplier NATURAL JOIN category
	GROUP BY supp_name, supp_nif
) AS foo
WHERE catCount >= ALL (
	SELECT catCount FROM 
	(
		SELECT supp_name, supp_nif, COUNT( DISTINCT cat_name ) AS catCount FROM 
		(
			SELECT primary_supplier.supp_nif, primary_supplier.ean FROM primary_supplier
		  	UNION ALL
		   	SELECT secondary_supplier.supp_nif, secondary_supplier.ean FROM secondary_supplier
		) AS aggSupp NATURAL JOIN product NATURAL JOIN supplier NATURAL JOIN category
		GROUP BY supp_name, supp_nif
	) AS foo2
);

--Query E
--List the primary suppliers (name and NIF) who supplied products in all simple categories.
SELECT supp_name, supp_nif FROM
(
	SELECT supp_name, supp_nif, COUNT( DISTINCT cat_name ) AS catCount FROM 
	(
		SELECT primary_supplier.supp_nif, primary_supplier.ean FROM primary_supplier
	  	UNION ALL
	   	SELECT secondary_supplier.supp_nif, secondary_supplier.ean FROM secondary_supplier
	) AS aggSupp NATURAL JOIN product NATURAL JOIN supplier NATURAL JOIN simple_category
	GROUP BY supp_name, supp_nif
) AS foo
WHERE catCount >= 
(
	SELECT COUNT(DISTINCT cat_name) FROM simple_category
) 
AND supp_nif IN 
(
	SELECT primary_supplier.supp_nif FROM primary_supplier
);

--Query F
--List the aisles that contain products from all primary suppliers that are not secondary suppliers of any products.
SELECT DISTINCT nr, side FROM
(
	SELECT * FROM primary_supplier
	WHERE supp_nif NOT IN (
		SELECT secondary_supplier.supp_nif FROM secondary_supplier
	) 
) AS primaryButNotSecondarySupps JOIN planogram p ON primaryButNotSecondarySupps.ean = p.ean
;