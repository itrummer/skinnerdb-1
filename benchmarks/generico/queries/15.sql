SELECT generico_5.categoria AS categoria FROM generico_5 WHERE ((generico_5.anunciante IN ('BANTRAB/TODOTICKET', 'TODOTICKET', 'TODOTICKET.COM')) AND (CAST(EXTRACT(YEAR FROM generico_5.fecha) AS LONG) >= 2010) AND (CAST(EXTRACT(YEAR FROM generico_5.fecha) AS LONG) <= 2015) AND (CAST(EXTRACT(YEAR FROM generico_5.fecha) AS LONG) IN (2014, 2015)) AND (generico_5.medio = 'PRENSA') AND (generico_5.vehiculo IN ('Al Dia', 'El Periodico', 'Nuestro Diario', 'Prensa Libre', 'Siglo Veintiuno'))) GROUP BY generico_5.categoria;