SELECT uberlandia_1.nome_da_sit_matricula_situacao_detalhada AS nome_da_sit_matricula_situacao_detalhada,   SUM(CAST(uberlandia_1.number_of_records AS LONG)) AS sumnumber_of_recordsok FROM uberlandia_1 WHERE ((NOT ((uberlandia_1.nome_da_sit_matricula_situacao_detalhada IN ('AGUARD_CONF', 'CANC_DESISTENTE', 'CANC_MAT_PRIM_OPCAO', 'CANC_SANO', 'CANC_SEM_FREQ_INICIAL', 'CANC_TURMA', 'DOC_INSUFIC', 'ESCOL_INSUFIC', 'INC _ITINERARIO', 'INSC_CANC', 'NO_COMPARECEU', 'TURMA_CANC', 'VAGAS_INSUFIC')) OR (uberlandia_1.nome_da_sit_matricula_situacao_detalhada IS NULL))) AND (NOT (uberlandia_1.situacao_da_turma IN ('CANCELADA', 'CRIADA', 'PUBLICADA')))) GROUP BY uberlandia_1.nome_da_sit_matricula_situacao_detalhada;