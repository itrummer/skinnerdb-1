SELECT COUNT(DISTINCT eixo_1.calculation_838513981462429699) AS ctdcalculation_838513981462429699ok,   CAST(EXTRACT(YEAR FROM eixo_1.data_de_inicio) AS LONG) AS yrdata_de_iniciook FROM eixo_1 WHERE ((NOT ((eixo_1.nome_da_sit_matricula_situacao_detalhada IN ('CANC_DESISTENTE', 'CANC_MAT_PRIM_OPCAO', 'CANC_SANO', 'CANC_SEM_FREQ_INICIAL', 'CANC_TURMA', 'DOC_INSUFIC', 'ESCOL_INSUFIC', 'INC _ITINERARIO', 'INSC_CANC', 'No Matriculado', 'NO_COMPARECEU', 'TURMA_CANC', 'VAGAS_INSUFIC')) OR (eixo_1.nome_da_sit_matricula_situacao_detalhada IS NULL))) AND (NOT (eixo_1.situacao_da_turma IN ('CANCELADA', 'CRIADA', 'PUBLICADA'))) AND (eixo_1.uf_do_local_da_oferta = 'PE')) GROUP BY yrdata_de_iniciook;
