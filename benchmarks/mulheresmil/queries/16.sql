SELECT COUNT(DISTINCT mulheresmil_1.calculation_838513981462429699) AS ctdcalculation_838513981462429699ok FROM mulheresmil_1 WHERE ((mulheresmil_1.no_modalidade IN ('pronatec turismo cidado', 'Pronatec turismo Desenvolvimento Local', 'PRONATEC TURISMO na EMPRESA', 'PRONATEC TURISMO SOCIAL')) AND (NOT ((mulheresmil_1.nome_da_sit_matricula_situacao_detalhada NOT IN ('', 'CONCLUDA')) OR (mulheresmil_1.nome_da_sit_matricula_situacao_detalhada IS NULL))) AND (mulheresmil_1.nome_curso_catalogo_guia IN ('ESPANHOL APLICADO A SERVIOS TURSTICOS', 'ESPANHOL BSICO', 'ESPANHOL INTERMEDIRIO', 'FRANCS APLICADO A SERVIOS TURSTICOS', 'FRANCS BSICO', 'FRANCS INTERMEDIRIO', 'INGLS APLICADO A SERVIOS TURSTICOS', 'INGLS BSICO', 'Ingls Intermedirio', 'INGLS INTERMEDIRIO')) AND (NOT (mulheresmil_1.situacao_da_turma IN ('CANCELADA', 'CRIADA', 'PUBLICADA'))) AND (mulheresmil_1.uf_do_local_da_oferta IN ('AM', 'BA', 'DF', 'MG', 'RJ', 'SP')) AND (CAST(EXTRACT(YEAR FROM mulheresmil_1.data_de_inicio) AS LONG) IN (2012, 2013, 2014, 2015))) HAVING (COUNT(1) > 0);
