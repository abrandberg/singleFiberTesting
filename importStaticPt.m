function sampleStaticData = importStaticPt()
%
% 1 set - nominal free spans
% 2 set - non-glued part
% 3 set - original fiber length (inc glued part)

%  NAME           FREESPAN           AREA   REAL LENGTH  startIdx endIdx
sampleStaticData =          {'Pb0.3-1'      , 1e-3*[0.3],   1e-12*[nan],          nan, 150, 350;                 
                             'Pb0.3-2'      , 1e-3*[0.3],   1e-12*[nan],          nan, 150, 350;       
                             'Pb0.3-3'      , 1e-3*[0.3],   1e-12*[nan],          nan, 100, 225;       
                             'Pb1-1'        , 1e-3*[1.0],   1e-12*[nan],          nan,   1, 250;       
                             'Pb1-2'        , 1e-3*[1.0],   1e-12*[nan],          nan,  10, 320;       
                             'Pb1-3'        , 1e-3*[1.0],   1e-12*[nan],          nan,   1, 250;       
                             'Pb3-1'        , 1e-3*[3.0],   1e-12*[nan],          nan,  50, 390;       
                             'Pb3-2'        , 1e-3*[3.0],   1e-12*[nan],          nan, 120, 540;       
                             'Pb3-3'        , 1e-3*[3.0],   1e-12*[nan],          nan,  30, 230;       
                             'Pb5-1'        , 1e-3*[5.0],   1e-12*[nan],          nan,  30, 130;       
                             'Pb5-1_1'      , 1e-3*[5.0],   1e-12*[nan],          nan,  35, 100;       
                             'Pb5-2'        , 1e-3*[5.0],   1e-12*[nan],          nan,  50, 400;       
                             'Pb5-3'        , 1e-3*[5.0],   1e-12*[nan],          nan,  50, 400};
                         
                         
                         
% %  NAME           FREESPAN           AREA   REAL LENGTH  startIdx endIdx
% sampleStaticData =          {'Pb0.3-1'      , 1e-3*[0.31],   1e-12*[nan],          nan, 150, 350;                 
%                              'Pb0.3-2'      , 1e-3*[0.34],   1e-12*[nan],          nan, 150, 350;       
%                              'Pb0.3-3'      , 1e-3*[0.52],   1e-12*[nan],          nan, 100, 225;       
%                              'Pb1-1'        , 1e-3*[0.78],   1e-12*[nan],          nan,   1, 250;       
%                              'Pb1-2'        , 1e-3*[0.86],   1e-12*[nan],          nan,  10, 320;       
%                              'Pb1-3'        , 1e-3*[1.02],   1e-12*[nan],          nan,   1, 250;       
%                              'Pb3-1'        , 1e-3*[2.14],   1e-12*[nan],          nan,  50, 390;       
%                              'Pb3-2'        , 1e-3*[2.69],   1e-12*[nan],          nan, 120, 540;       
%                              'Pb3-3'        , 1e-3*[2.32],   1e-12*[nan],          nan,  30, 230;       
%                              'Pb5-1'        , 1e-3*[4.4],   1e-12*[nan],          nan,  30, 130;       
%                              'Pb5-1_1'      , 1e-3*[4.99],   1e-12*[nan],          nan,  35, 100;       
%                              'Pb5-2'        , 1e-3*[3.88],   1e-12*[nan],          nan,  50, 400;       
%                              'Pb5-3'        , 1e-3*[5.11],   1e-12*[nan],          nan,  50, 400};