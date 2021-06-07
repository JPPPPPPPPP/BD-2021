DROP TABLE IF EXISTS d_product;

create table d_product(
    id_product SERIAL PRIMARY KEY UNIQUE NOT NULL,
    ean numeric(13) NOT NULL,
    category varchar(80) NOT NULL
);


DROP TABLE IF EXISTS d_date;

create table d_date(
	id_date SERIAL PRIMARY KEY UNIQUE NOT NULL,
	day int NOT NULL,
	week_day int NOT NULL,
	week int NOT NULL,
	month int NOT NULL,
	year int NOT NULL
);


DROP TABLE  IF EXISTS f_replenishment

create TABLE f_replenishment(
	id_product int NOT NULL,
	id_date int NOT NULL,
	PRIMARY KEY(id_product, id_date),
	FOREIGN KEY(id_product) REFERENCES d_product(id_product),
	FOREIGN KEY(id_date) REFERENCES d_date(id_date)
);

