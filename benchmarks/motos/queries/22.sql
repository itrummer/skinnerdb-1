SELECT CAST(EXTRACT(MONTH FROM motos_2.fecha) AS LONG) AS mnfechaok FROM motos_2 WHERE ((motos_2.categoria IN ('CAMIONES', 'CAMIONES, BUSES Y PANELES', 'MOTOCICLETAS', 'PICK UPS, VANS Y JEEPS', 'PICK-UPS', 'SUV Y JEEPS', 'VEHICULOS NUEVOS')) AND (CAST(EXTRACT(YEAR FROM motos_2.fecha) AS LONG) >= 2010) AND (CAST(EXTRACT(YEAR FROM motos_2.fecha) AS LONG) <= 2015)) GROUP BY mnfechaok;
