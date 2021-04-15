SELECT 
     CASE
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  1
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  8
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  31
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  61
          ELSE 91
       END FAIXAINICIO,
     	CASE
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  8
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  30
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  60
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  90
          ELSE NULL
          END FAIXAFIM,
     CASE   
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  'até 7 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  'entre 8 e 30 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  'entre 31 e 60 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  'entre 61 e 90 dias de atraso'
          ELSE ' mais de 90 dias de atraso'
       END TEXTOFAIXA,  
   SUM(FIN.VLRDESDOB) VALOR ,
   COUNT(FIN.NUFIN)  QTD 
  FROM TGFFIN FIN, TGFPAR PAR
  WHERE FIN.CODPARC = PAR.CODPARC 
  AND FIN.DHBAIXA IS NULL
  AND trunc(sysdate) - fin.dtvenc >= 1 
  AND PAR.CODGRUPO = 2
  AND FIN.RECDESP = 1 
  AND FIN.CODTIPTIT IN ('2','4','3','7','32','20')
   GROUP BY      
     CASE
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  1
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  8
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  31
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  61
          ELSE 91
       END ,
     	CASE
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  8
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  30
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  60
          WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  90
          ELSE NULL
       END ,
CASE    
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 7 THEN  'até 7 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 30 THEN  'entre 8 e 30 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 60 THEN  'entre 31 e 60 dias de atraso'
            WHEN TRUNC (SYSDATE) - FIN.DTVENC <= 90 THEN  'entre 61 e 90 dias de atraso'
          ELSE ' mais de 90 dias de atraso'
       END
  ORDER BY 1
