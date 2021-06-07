INSERT INTO d_product(ean, category)
SELECT ean, category FROM product;


CREATE OR REPLACE FUNCTION load_d_date()
	RETURNS VOID AS
	$$
	DECLARE date_value TIMESTAMP;
	BEGIN
		date_value := '2020-01-01 00:00:00';
		WHILE date_value < '2022-01-01 00:00:00' LOOP
	INSERT INTO d_date(
		id_date,
		day,
		week_day,
		week,
		month,
		year
		) VALUES (
			EXTRACT(YEAR FROM date_value) * 10000
				+ EXTRACT(MONTH FROM date_value)*100
				+ EXTRACT(DAY FROM date_value),
			CAST(EXTRACT(DAY FROM date_value) AS INTEGER),
			CAST(EXTRACT(DOW FROM date_value) AS INTEGER),
			CAST(EXTRACT(MONTH FROM date_value) AS INTEGER),
			EXTRACT(YEAR FROM date_value)
		);
	date_value := date_value + INTERVAL '1 DAY';
	END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT load_d_tempo();


INSERT INTO f_replenishment_event(id_date, id_product)
SELECT id_productr, EXTRACT(YEAR FROM T.ts) * 10000 + EXTRACT(MONTH FROM T.ts)*100 + EXTRACT(DAY FROM T.ts)

FROM (SELECT replenishment_event AS ts, ean, category
		FROM replenishment_event
		)
	
	LEFT OUTER JOIN d_local d1
		ON d1.ean = T.ean
		AND d1.category = T.category;
)





