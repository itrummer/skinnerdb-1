SELECT iglocations2_2.calculation_8090724143600502 AS calculation_8090724143600502,   iglocations2_2.city AS city,   iglocations2_2.state AS state,   SUM(CAST(iglocations2_2.number_of_records AS LONG)) AS sumnumber_of_recordsok FROM iglocations2_2 WHERE ((iglocations2_2.calculation_8090724143600502 = 'Bar') AND (iglocations2_2.state IN ('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas')) AND (iglocations2_2.state_copy = 'Alaska')) GROUP BY iglocations2_2.calculation_8090724143600502,   iglocations2_2.city, iglocations2_2.state;