SELECT motos_2.marca AS datos_copia,   SUM(motos_2.inversionus) AS temptc_26225288700,   motos_2.vehiculo AS vehiculo,   SUM(motos_2.inversionus) AS sumcalculation_0061002123102817ok,   SUM(CAST(motos_2.numanuncios AS LONG)) AS sumnumanunciosok,   CAST(EXTRACT(YEAR FROM motos_2.fecha) AS LONG) AS yrfechaok FROM motos_2 WHERE ((CAST(EXTRACT(YEAR FROM motos_2.fecha) AS LONG) = 2015) AND (motos_2.categoria = 'MOTOCICLETAS') AND (motos_2.medio = 'RADIO')) GROUP BY motos_2.marca,   motos_2.vehiculo,   yrfechaok;
