SELECT COUNT(DISTINCT mulheresmil_1.calculation_838513981462429699) AS ctdcalculation_838513981462429699ok,   mulheresmil_1.nome_da_sit_matricula_situacao_detalhada AS nome_da_sit_matricula_situacao_detalhada,   mulheresmil_1.subtipo_curso AS subtipo_curso,   CAST(EXTRACT(YEAR FROM mulheresmil_1.data_de_inicio) AS LONG) AS yrdata_de_iniciook FROM mulheresmil_1 WHERE ((NOT ((mulheresmil_1.nome_da_sit_matricula_situacao_detalhada NOT IN ('', 'INTEGRALIZADA', 'TRANCADA', 'EM_CURSO', 'EM_DEPENDNCIA')) OR (mulheresmil_1.nome_da_sit_matricula_situacao_detalhada IS NULL))) AND (NOT (mulheresmil_1.situacao_da_turma IN ('CANCELADA', 'CRIADA', 'PUBLICADA')))) GROUP BY nome_da_sit_matricula_situacao_detalhada,   subtipo_curso,   yrdata_de_iniciook;
