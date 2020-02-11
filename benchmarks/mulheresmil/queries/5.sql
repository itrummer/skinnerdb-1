SELECT mulheresmil_1.ch_catalogo_guia AS ch_catalogo_guia,   mulheresmil_1.cod_da_unidade_de_ensino AS cod_da_unidade_de_ensino,   mulheresmil_1.cod_ibge_do_local_da_oferta AS cod_ibge_do_local_da_oferta,   CAST(mulheresmil_1.codigo_do_curso AS LONG) AS codigo_do_curso,   COUNT(DISTINCT mulheresmil_1.calculation_838513981462429699) AS ctdcalculation_838513981462429699ok,   mulheresmil_1.ead AS ead,   mulheresmil_1.eixo_tecnologico_catalogo_guia AS eixo_tecnologico_catalogo_guia,   mulheresmil_1.forma_ingresso AS forma_ingresso,   mulheresmil_1.municipio_do_local_da_oferta AS municipio_do_local_da_oferta,   mulheresmil_1.no_dependencia_admin AS no_dependencia_admin,   mulheresmil_1.no_modalidade AS no_modalidade,   mulheresmil_1.no_parceiro_demandante AS no_parceiro_demandante,   mulheresmil_1.no_sistema_ensino AS no_sistema_ensino,   mulheresmil_1.nome_curso_catalogo_guia AS nome_curso_catalogo_guia,   mulheresmil_1.nome_da_ue AS nome_da_ue,   mulheresmil_1.nome_da_uer AS nome_da_uer,   mulheresmil_1.subtipo_curso AS subtipo_curso,   mulheresmil_1.uf_do_local_da_oferta AS uf_do_local_da_oferta,   mulheresmil_1.unidade_demandante AS unidade_demandante,   CAST(EXTRACT(YEAR FROM mulheresmil_1.data_de_inicio) AS LONG) AS yrdata_de_iniciook FROM mulheresmil_1 WHERE ((CAST(EXTRACT(YEAR FROM mulheresmil_1.data_de_inicio) AS LONG) IN (2013, 2014, 2015)) AND (NOT ((mulheresmil_1.nome_da_sit_matricula_situacao_detalhada IN ('CANC_DESISTENTE', 'CANC_MAT_PRIM_OPCAO', 'CANC_SANO', 'CANC_SEM_FREQ_INICIAL', 'CANC_TURMA', 'DOC_INSUFIC', 'ESCOL_INSUFIC', 'INC _ITINERARIO', 'INSC_CANC', 'No Matriculado', 'NO_COMPARECEU', 'TURMA_CANC', 'VAGAS_INSUFIC')) OR (mulheresmil_1.nome_da_sit_matricula_situacao_detalhada IS NULL))) AND (NOT (mulheresmil_1.situacao_da_turma IN ('CANCELADA', 'CRIADA', 'PUBLICADA')))) GROUP BY ch_catalogo_guia,   cod_da_unidade_de_ensino,   cod_ibge_do_local_da_oferta,   mulheresmil_1.codigo_do_curso,   ead,   eixo_tecnologico_catalogo_guia,   forma_ingresso,   municipio_do_local_da_oferta,   no_dependencia_admin,   no_modalidade,   no_parceiro_demandante,   no_sistema_ensino,   nome_curso_catalogo_guia,   nome_da_ue,   nome_da_uer,   subtipo_curso,   uf_do_local_da_oferta,   unidade_demandante,   yrdata_de_iniciook,   codigo_do_curso;