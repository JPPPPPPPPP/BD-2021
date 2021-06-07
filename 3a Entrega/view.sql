DROP VIEW IF EXISTS supplier_stats;

CREATE VIEW supplier_stats AS
SELECT a.ean AS productEAN, countPrimary, countSecondary FROM
(
    --counts secondary suppliers of product
    SELECT ean, COUNT(*) AS countSecondary FROM secondary_supplier
    GROUP BY ean
) AS a JOIN (
    --counts primary suppliers of product
    SELECT ean, COUNT(*) AS countPrimary FROM primary_supplier
    GROUP BY ean
) AS b ON a.ean = b.ean;