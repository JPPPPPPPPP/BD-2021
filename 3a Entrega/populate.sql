-- Populate supermarket
insert into supermarket values (123456789, 'el super',  'el street');

--Populate corridor
insert into corridor values(5, 1, 123456789);
insert into corridor values(3, 2, 123456789);
insert into corridor values(4, 3, 123456789);
insert into corridor values(2, 4, 123456789);

--Populate shelf
insert into shelf values('left', 'middle', 1);
insert into shelf values('right', 'middle', 1);
insert into shelf values('left', 'floor', 2);
insert into shelf values('right', 'upper', 2);
insert into shelf values('right', 'floor', 2);
insert into shelf values('left', 'upper', 3);
insert into shelf values('left', 'middle', 3);
insert into shelf values('right', 'middle', 3);
insert into shelf values('left', 'floor', 4);

--Populate category
insert into category values('Milk');
insert into category values('schmeat');
insert into category values('standard milk');
insert into category values('flavoured milk');
insert into category values('sosig');
insert into category values('cow');

--Populate super-category
insert into super_category values('Milk');
insert into super_category values('schmeat');

--Populate simple-category
insert into simple_category values('standard milk', 'Milk');
insert into simple_category values('flavoured milk', 'Milk');
insert into simple_category values('sosig', 'schmeat');
insert into simple_category values('cow', 'schmeat');

--Populate supplier
insert into supplier values(121212121, 'el suplemento');
insert into supplier values(232323232, 'soupplier');
insert into supplier values(343434343, 'supplier dude');
insert into supplier values(454545454, 'le suplier');
insert into supplier values(565656565, 'the extra one');
insert into supplier values(676767676, 'the non primary dude');
insert into supplier values(787878787, 'the dude who only primarily supplies');

--Populate products
insert into product values(1234567890123, 'Skimmed Milk', 'standard milk');
insert into product values(3214567890123, 'Low Fat Milk', 'standard milk');
insert into product values(1234567890124, 'Milk Lite', 'standard milk');
insert into product values(1234567890125, 'straberry Milk', 'flavoured milk');
insert into product values(1234567890126, 'choccy melk', 'flavoured milk');
insert into product values(1234567890127, 'dingdong', 'sosig');
insert into product values(1234567890128, 'beef', 'cow');
insert into product values(1234567890129, 'milkerino', 'Milk');

--Populate primary supplier
insert into primary_supplier values(121212121, 1234567890123, '1987-12-31');
insert into primary_supplier values(343434343, 3214567890123, '1967-12-31');
insert into primary_supplier values(565656565, 1234567890124, '1987-10-31');
insert into primary_supplier values(121212121, 1234567890125, '1987-12-23');
insert into primary_supplier values(454545454, 1234567890126, '1997-07-31');
insert into primary_supplier values(232323232, 1234567890127, '2007-02-03');
insert into primary_supplier values(121212121, 1234567890128, '2008-02-03');
insert into primary_supplier values(787878787, 1234567890129, '2011-01-21');

--Populate secondary supplier
insert into secondary_supplier values(232323232, 1234567890123);
insert into secondary_supplier values(343434343, 1234567890123);
insert into secondary_supplier values(454545454, 1234567890123);
insert into secondary_supplier values(343434343, 1234567890124);
insert into secondary_supplier values(676767676, 1234567890124);
insert into secondary_supplier values(232323232, 1234567890125);
insert into secondary_supplier values(232323232, 1234567890126);
insert into secondary_supplier values(676767676, 1234567890126);
insert into secondary_supplier values(121212121, 1234567890127);
insert into secondary_supplier values(454545454, 1234567890127);
insert into secondary_supplier values(676767676, 1234567890127);
insert into secondary_supplier values(565656565, 1234567890128);
insert into secondary_supplier values(454545454, 1234567890128);
insert into secondary_supplier values(676767676, 1234567890128);
insert into secondary_supplier values(565656565, 1234567890129);
insert into secondary_supplier values(121212121, 1234567890129);
insert into secondary_supplier values(454545454, 3214567890123);
insert into secondary_supplier values(232323232, 3214567890123);
insert into secondary_supplier values(121212121, 3214567890123);

--Populate planogram
insert into planogram values(1, 'left', 'middle', 'standard milk', 1, 4, 3, 1234567890123);
insert into planogram values(1, 'right', 'middle', 'standard milk', 1, 4, 3, 3214567890123);
insert into planogram values(2, 'left', 'floor', 'standard milk', 1, 4, 3, 1234567890124);
insert into planogram values(2, 'right', 'upper', 'flavoured milk', 1, 4, 3, 1234567890125);
insert into planogram values(3, 'left', 'upper', 'flavoured milk', 1, 4, 3, 1234567890126);
insert into planogram values(3, 'left', 'middle', 'beef', 1, 4, 3, 1234567890128);
insert into planogram values(3, 'right', 'middle', 'sosig', 1, 4, 3, 1234567890127);
insert into planogram values(4, 'left', 'floor', 'Milk', 1, 4, 3, 1234567890129);

--Populate replenishment event
insert into replenishment_event values(1, 123456789, 'left', 'middle', 1234567890123, 17, '2020-03-20');
insert into replenishment_event values(1, 123456789, 'right', 'middle', 3214567890123, 25, '2021-04-01');
insert into replenishment_event values(1, 123456789, 'right', 'middle', 3214567890123, 45, '2020-06-22');
insert into replenishment_event values(2, 123456789, 'left', 'floor', 1234567890124, 10, '2021-03-10');
insert into replenishment_event values(2, 123456789, 'right', 'upper', 1234567890125, 16, '2021-04-10');
insert into replenishment_event values(2, 123456789, 'right', 'upper', 1234567890125, 17, '2021-04-11');
insert into replenishment_event values(3, 123456789, 'right', 'middle', 1234567890127, 16, '2020-07-04');

--Testing for integrity constraints

--Max 3 secondary suppliers
--insert into secondary_supplier values(565656565, 3214567890123);

--Primary supplier is already secondarily supplying a product
--insert into primary_supplier values(232323232, 1234567890123, '1987-12-31');

--Secondary supplier is already primarily supplying a product
--insert into secondary_supplier values(121212121, 1234567890123);