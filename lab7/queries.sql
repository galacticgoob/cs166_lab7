SELECT Count(part_number) AS PartCount FROM part_nyc WHERE on_hand > 70;

SELECT Count(*) FROM(
	SELECT part_number
		FROM part_nyc NY, color C1
		WHERE NY.color = C1.color_id AND C1.color_name = 'Red' UNION ALL
	SELECT part_number
		FROM part_sfo SF, color C2
		WHERE SF.color = C2.color_id AND color_name = 'Red') AS PartCount;

SELECT S.supplier_name FROM supplier S
	INNER JOIN part_nyc NY ON S.supplier_id = NY.supplier
	INNER JOIN part_sfo SF ON S.supplier_id = SF.supplier
	HAVING SUM(NY.on_hand) > SUM(SF.on_hand);

SELECT supplier_name
	FROM supplier 
	WHERE supplier_id 
	IN (SELECT supplier FROM part_nyc) 
	AND supplier_id 
	NOT IN (SELECT supplier FROM part_sfo);

UPDATE part_nyc SET on_hand = -10;

DELETE FROM part_nyc WHERE on_hand < 30;
