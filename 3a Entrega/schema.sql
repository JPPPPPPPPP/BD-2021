DROP TABLE IF EXISTS supermarket CASCADE;
DROP TABLE IF EXISTS corridor CASCADE;
DROP TABLE IF EXISTS shelf CASCADE;
DROP TABLE IF EXISTS planogram CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS supplier CASCADE;
DROP TABLE IF EXISTS primary_supplier CASCADE;
DROP TABLE IF EXISTS secondary_supplier CASCADE;
DROP TABLE IF EXISTS replenishment_event CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS simple_category CASCADE;
DROP TABLE IF EXISTS super_category CASCADE;


CREATE TABLE supermarket(
    nif NUMERIC(9) NOT NULL,
    market_name VARCHAR(80) NOT NULL,
    addr VARCHAR(80) NOT NULL,
    PRIMARY KEY(nif)
);

CREATE TABLE corridor(
    width INTEGER NOT NULL,
    nr INTEGER NOT NULL,
    nif NUMERIC(9) NOT NULL,
    PRIMARY KEY(nr),
    FOREIGN KEY(nif) REFERENCES supermarket(nif)
);

CREATE TABLE shelf(
    side VARCHAR(80) NOT NULL,
    height VARCHAR(80) NOT NULL,
    nr INTEGER NOT NULL,
    PRIMARY KEY(nr, side, height),
    FOREIGN KEY(nr) REFERENCES corridor(nr),
    CHECK (side IN ('left', 'right')),
    CHECK (height IN ('floor', 'middle', 'upper'))
);

CREATE TABLE category(
    cat_name VARCHAR(80) NOT NULL,
    PRIMARY KEY(cat_name)
    --every category must be either a simple or super category
);

CREATE TABLE super_category(
    super_name VARCHAR(80) NOT NULL,
    PRIMARY KEY(super_name),
    FOREIGN KEY(super_name) REFERENCES category(cat_name)
);

CREATE TABLE simple_category(
    cat_name VARCHAR(80) NOT NULL,
    super_name VARCHAR(80) NOT NULL,
    PRIMARY KEY(cat_name),
    FOREIGN KEY(super_name) REFERENCES super_category(super_name),
    FOREIGN KEY(cat_name) REFERENCES category(cat_name),
    CHECK(cat_name NOT LIKE super_name) -- (IC-1) is verified here
);

CREATE TABLE product(
    ean NUMERIC(13) NOT NULL,
    descr VARCHAR(80) NOT NULL,
    cat_name VARCHAR(80) NOT NULL,
    PRIMARY KEY(ean),
    FOREIGN KEY(cat_name) REFERENCES category(cat_name)
    --(IC-4.1) For a given Product, a supplier cannot be simultaneously a Primary and Secondary Supplier
    --(IC-4.2) A product can only have at most 3 Secondary Suppliers
    --(IC-5) A Product can only be exposed in one of the Shelves to which it is associated
);

CREATE TABLE supplier(
    supp_nif NUMERIC(9) NOT NULL,
    supp_name VARCHAR(80) NOT NULL,
    PRIMARY KEY(supp_nif)
);

CREATE TABLE primary_supplier(
    supp_nif NUMERIC(9) NOT NULL,
    ean NUMERIC(13) NOT NULL, 
    since DATE NOT NULL,
    FOREIGN KEY(supp_nif) REFERENCES supplier(supp_nif),
    FOREIGN KEY(ean) REFERENCES product(ean) 
);

CREATE TABLE secondary_supplier(
    supp_nif NUMERIC(9) NOT NULL,
    ean NUMERIC(13) NOT NULL, 
    FOREIGN KEY(supp_nif) REFERENCES supplier(supp_nif),
    FOREIGN KEY(ean) REFERENCES product(ean) 
);

CREATE TABLE planogram(
    nr INTEGER NOT NULL,
    side VARCHAR(80) NOT NULL,
    height VARCHAR(80) NOT NULL,
    cat_name VARCHAR(80) NOT NULL,
    loc INTEGER NOT NULL,
    units INTEGER NOT NULL,
    facings INTEGER NOT NULL,
    ean NUMERIC(13) NOT NULL,
    PRIMARY KEY(nr, side, height),
    FOREIGN KEY(nr, side, height) REFERENCES shelf(nr, side, height),
    FOREIGN KEY(ean) REFERENCES product(ean)
);


CREATE TABLE replenishment_event(
    nr INTEGER NOT NULL,
    nif NUMERIC(9) NOT NULL,
    side VARCHAR(80) NOT NULL,
    height VARCHAR(80) NOT NULL,
    ean NUMERIC(13) NOT NULL,
    units INTEGER NOT NULL,
    instant DATE CONSTRAINT tres CHECK(instant < now()), -- (IC-3) is verified here
    FOREIGN KEY(nr, side, height) REFERENCES planogram(nr, side, height),
    FOREIGN KEY(ean) REFERENCES product(ean),
    FOREIGN KEY(nif) REFERENCES supermarket(nif)
);

