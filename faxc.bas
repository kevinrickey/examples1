5 REM L"CLOCK":GOSUB 9000
10 D$=MID$(DATE$,1,8):MID$(D$,7,2)=MID$(DATE$,9,2)
100 FOR P=1 TO 12:P$=MID$(STR$(P),2,LEN(STR$(P))-1):IF LEN(P$)=2 THEN P$="0"+P$ ELSE P$="00"+P$
110 C$="DIR F:\UNILINK\UNI_LAN\PIN"+P$+"\*.MES >F:\PINS\PIN"+P$
120 SHELL C$:C$="F:\PINS\PIN"+P$:OPEN "I",1,C$:IF LOF(1) >85 THEN 130 ELSE CLOSE#1:C$="DEL F:\PINS\PIN"+P$:SHELL C$:GOTO 860:REM (NEXT P)
130 P1$="F:\PINS\DIN"+P$:OPEN "O",2,P1$
140 A$=INPUT$(116,#1)
150 IF EOF(1) THEN CLOSE#1:CLOSE#2:C$="DEL F:\PINS\PIN"+P$:SHELL C$ ELSE PRINT #2,INPUT$(1,#1);:GOTO 150
160 F$="F:\PINS\DIN"+P$:OPEN "R",1,F$,41
170 FIELD#1,8 AS N$,1 AS C$,3 AS E$,11 AS S$,8 AS D1$,2 AS C1$, 6 AS T$,2 AS C2$
180 OPEN "R",2,"F:\SEND\FAXES.KEV",257
190 FIELD#2,8 AS DAT$,6 AS TIM$,11 AS FS$,12 AS FU$,3 AS PIN$,20 AS PHON$,30 AS ATTN$,15 AS FROM$,1 AS SENT$,1 AS CANC$,148 AS EM$,2 AS RT$
200 FOR T=1 TO LOF(1)/41:GET #1,T
210 IF D1$<>D$ THEN 850
220 NAM$="":FOR T1=1 TO LEN(N$):A$=MID$(N$,T1,1):IF A$<>" " THEN NAM$=NAM$+MID$(N$,T1,1)
230 NEXT T1:NAM$=NAM$+"."+E$
240 FOR T1=1 TO LOF(2)/257:GET#2,T1:FU1$="":FOR X=1 TO LEN(FU$):A$=MID$(FU$,X,1):IF A$<>" " THEN FU1$=FU1$+A$
250 NEXT X
260 IF NAM$=FU1$ AND DAT$=D$ AND TIM$=T$ THEN 850 ELSE NEXT T1
270 REM
280 REM
290 K$="F:\UNILINK\UNI_LAN\PIN"+P$+"\"+NAM$:OPEN "R",3,K$,1
295 IF LOF(3)<142 THEN 850 ELSE CLOSE#3
300 REM
310 LSET DAT$=D1$:LSET TIM$=T$:LSET FS$=S$:LSET FU$=NAM$:LSET PIN$=P$:LSET SENT$="0":LSET FROM$="WHO CARES":LSET CANC$="0":LSET RT$="00"
320 K$="F:\UNILINK\UNI_LAN\PIN"+P$+"\"+NAM$:OPEN "R",3,K$,1
330 FIELD#3,1 AS G$:K=152:A$=""
335 REM GET#3,K:IF G$<>"/" THEN K=K+1:GOTO 335 ELSE K=K+1
336 REM GET#3,K:IF G$<>"F" THEN K=K+1:GOTO 335
340 GET#3,K:IF G$>="0" AND G$<="9" THEN A$=A$+G$:K=K+1 ELSE K=K+1:GOTO 340
350 GET#3,K:IF G$>="0" AND G$<="9" THEN A$=A$+G$:K=K+1 ELSE K=K+1:GOTO 340
360 GET#3,K:IF G$<>"+" AND ASC(G$)<>13 THEN A$=A$+G$:K=K+1:GOTO 360
362 IF G$="+" THEN NA=1:LSET ATTN$="GENERAL FAX"
370 B$="":FOR B=1 TO LEN(A$):IF MID$(A$,B,1)>="0" AND MID$(A$,B,1)<="9" THEN B$=B$+MID$(A$,B,1)
380 NEXT B
390 IF LEN(B$)>10 THEN 400
391 IF LEN(B$)=7 THEN 400
392 IF MID$(B$,1,3)="503" THEN B$=MID$(B$,4,7):GOTO 400
394 B$="1"+B$
400 LSET PHON$=B$
405 IF NA=1 THEN PUT #2,T1:NA=0:GOTO 780
410 GET #3,K:IF G$="N" THEN 420 ELSE K=K+1:GOTO 410
420 K=K+2:GET #3,K:A$=""
430 A$=A$+G$:K=K+1:GET#3,K
440 IF G$="+" THEN LSET ATTN$=A$:PUT #2,T1:GOTO 780
450 IF G$="," THEN LSET ATTN$=A$:PUT #2,T1:VV=1:TS=T1+1:GOTO 470
460 GOTO 430
470 V$="":V=1
471 IF MID$(NAM$,V,1)<>"." THEN V$=V$+MID$(NAM$,V,1):V=V+1:GOTO 471
480 V$=V$+"."+MID$(STR$(VV),2,LEN(STR$(VV))-1)
490 LSET DAT$=D1$:LSET TIM$=T$:LSET FS$=S$:LSET FU$=V$:LSET PIN$=P$:LSET SENT$="0":LSET FROM$="WHO CARES":LSET CANC$="0":LSET RT$="00"
500 T1=T1+1
502 GET#3,K:IF G$<>"/" THEN K=K+1:GOTO 502 ELSE K=K+1
503 GET#3,K:IF G$<>"F" THEN K=K+1:GOTO 502
510 GET#3,K:IF G$>="0" AND G$<="9" THEN A$=A$+G$:K=K+1 ELSE K=K+1:GOTO 510
520 GET#3,K:IF G$>="0" AND G$<="9" THEN A$=A$+G$:K=K+1 ELSE K=K+1:GOTO 510
530 GET#3,K:IF G$<>"+" AND ASC(G$)<>13 THEN A$=A$+G$:K=K+1:GOTO 530
532 IF G$="+" THEN NA=1:LSET ATTN$="GENERAL FAX"
540 B$="":FOR B=1 TO LEN(A$):IF MID$(A$,B,1)>="0" AND MID$(A$,B,1)<="9" THEN B$=B$+MID$(A$,B,1)
550 NEXT B
560 IF LEN(B$)=10 THEN B$="1"+B$
570 LSET PHON$=B$
572 IF NA=1 THEN PUT #2,T1:NA=0:GOTO 650
580 GET #3,K:IF G$="N" THEN 590 ELSE K=K+1:GOTO 580
590 K=K+2:GET #3,K:A$=""
600 A$=A$+G$:K=K+1:GET#3,K
610 IF G$="+" THEN LSET ATTN$=A$:PUT #2,T1:GOTO 640
620 IF G$="," THEN LSET ATTN$=A$:PUT #2,T1:VV=VV+1:GOTO 470
630 GOTO 600
640 REM
650 K=K+3:K1=0
660 K$="F:\SEND\"+NAM$:OPEN "R",4,K$,1:FIELD #4,1 AS A$
670 GET#3,K:IF ASC(G$)<>0 THEN K=K+1:GOTO 670 ELSE K=K+1
680 K1=K1+1:K=K+1:IF EOF(3) THEN 700
690 GET #3,K:IF ASC(G$)=142 OR ASC(G$)=131 THEN K1=K1-1:GOTO 680
692 IF ASC(G$)>128 THEN LSET A$=CHR$(ASC(G$)-128):PUT #4,K1:GOTO 680 ELSE LSET A$=G$:PUT#4,K1:GOTO 680
700 CLOSE #4
710 REM
720 FOR K=TS TO T1:GET #2,K
730 K$="COPY F:\SEND\"+NAM$+" F:\SEND\"+FU$:SHELL K$:NEXT K
740 GOTO 850
750 REM
760 REM
770 REM
780 K=K+1:K1=0
790 K$="F:\SEND\"+NAM$:OPEN "R",4,K$,1:FIELD #4,1 AS A$
800 GET#3,K:IF ASC(G$)<>0 THEN K=K+1:GOTO 800
810 K1=K1+1:K=K+1:IF EOF(3) THEN 830
820 GET #3,K:IF ASC(G$)=142 OR ASC(G$)=131 THEN K1=K1-1:GOTO 810
822 IF ASC(G$)>128 THEN LSET A$=CHR$(ASC(G$)-128):PUT #4,K1:GOTO 810 ELSE LSET A$=G$:PUT#4,K1:GOTO 810
830 REM
840 REM
850 CLOSE#3,#4:NEXT T
860 CLOSE#1,#2:NEXT P
870 REM  SEND 'EM
880 REM ******* SEND THE DAMN FAXES
890 OPEN "R",2,"F:\SEND\FAXES.KEV",257
900 FIELD#2,8 AS DAT$,6 AS TIM$,11 AS FS$,12 AS FU$,3 AS PIN$,20 AS PHON$,30 AS ATTN$,15 AS FROM$,1 AS SENT$,1 AS CANC$,148 AS EM$,2 AS RT$
910 FOR T=1 TO LOF(2)/257:GET#2,T
920 IF SENT$="1" OR CANC$="1" THEN 1030
930 SHELL"DEL F:\FAX\HISTORY.TXT"
940 C$="FPSEND F:\SEND\"+FU$+" "+PHON$+" -A"+CHR$(34)+ATTN$+CHR$(34)+" -X"
950 SHELL C$
951 PRINT:PRINT PHON$
952 REM goSUB 9000
960 ON ERROR GOTO 1020
970 OPEN "I",1,"F:\FAX\HISTORY.TXT"
980 FOR X=1 TO 58:A$=INPUT$(1,#1):NEXT X:A$=""
990 IF EOF(1) THEN 1010
1000 A$=A$+INPUT$(1,#1):GOTO 990
1010 CLOSE#1:LSET EM$=A$:PUT#2,T:ON ERROR GOTO 0:GOTO 1030
1020 RESUME 970
1030 NEXT T
1040 ON ERROR GOTO 1090
1050 FOR T=1 TO LOF(2)/257:GET#2,T
1060 C$="F:\SEND\"+FU$:OPEN "I",1,C$
1062 RT=VAL(RT$):IF RT=5 THEN 1066:REM SET EM$, TOO MANY TRIES
1064 RT=RT+1:A$=MID$(STR$(RT),2,LEN(STR$(RT))-1):IF LEN(A$)=1 THEN A$="0"+A$
1065 LSET RT$=A$:GOTO 1070
1066 LSET CANC$="1":LSET EM$="THE FAX PHONE# WAS TRIED 5 TIMES WITHOUT SUCCESS, AND HAS BEEN CANCELED.        PLEASE CHECK FAX AND RE-SEND."
1068 REM
1070 PUT#2,T:CLOSE #1
1080 GOTO 1100
1090 LSET SENT$="1":RESUME 1070
1100 NEXT T
1110 ON ERROR GOTO 0
1120 ON ERROR GOTO 1160
1130 CLOSE#1,2,3,4:SHELL"COPY FAXES.KEV STATUS.KEV >NUL"
1140 SHELL"FLAG STATUS.KEV SRW >NUL"
1150 ON ERROR GOTO 0:GOTO 1170
1160 RESUME 1130
1170 FOR T=1 TO 800000!:NEXT
1180 CLEAR:GOTO 10
9000 CLS:PRINT"�";STRING$(67,"�");"�";"           ";
9010 PRINT"�";STRING$(67," ");"�����������";"�";
9020 FOR ZZ=1 TO 21:PRINT"�";STRING$(78," ");"�";:NEXT ZZ
9030 PRINT"�";STRING$(78,"�");"�";
9040 LOCATE 4,13:PRINT"��    ��        �����    �����     �����   ������   ������ "
9050 LOCATE 5,13:PRINT" ��  ��        ��   �   ��   �    ��      ���      ���
9060 LOCATE 6,13:PRINT"   ��    ��   �������  �������   �����      ���      ��� "
9070 LOCATE 7,13:PRINT" ��  ��      ��       ��  ��    ��            ��       ��"
9080 LOCATE 8,13:PRINT"��    ��    ��       ��    ��  �������  �������  ������� "
9090 REM LOCATE 9,13:PRINT"                          "
9100 LOCATE 10,22:PRINT" ���������      ��        ���      ���"
9110 LOCATE 11,22:PRINT" ��      �     ����         ��    ��"
9120 LOCATE 12,22:PRINT" ��           ��  ��         ��  ��"
9130 LOCATE 13,22:PRINT" �������     ��������         ����"
9140 LOCATE 14,22:PRINT" ��         ���    ���       ��  ��"
9150 LOCATE 15,22:PRINT" ��         ��      ��      ��    ��"
9160 LOCATE 16,22:PRINT"����       ���      ���   ���      ���"
9170 REM
9180 REM
9190 LOCATE 18,15:PRINT"         ��������������������������������ͻ";
9200 LOCATE 19,15:PRINT"         �      CURRENT FAX OPERATION     �";
9210 LOCATE 20,15:PRINT"��������������������������������������������������ͻ";
9220 LOCATE 21,15:PRINT"�                                                  �";
9230 LOCATE 22,15:PRINT"��������������������������������������������������ͼ";
9240 REM
9250 LOCATE 23,63:PRINT"By: Kevin Rickey
9260 LOCATE 25,26:PRINT" * COAST CONSULTING GROUP *";
9270 RETURN
