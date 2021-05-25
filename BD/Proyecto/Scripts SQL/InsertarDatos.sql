/*-----------------------------------------------------------*/
/* Inserción de datos */
insert into directoradmin values ('11992312K', 'Francisco Silgado Macías', 58, 2450, 'C/Intenso N 34', 176);
insert into directoradmin values ('73765142M', 'María Sánchez García', 52, 2600, 'C/Vivaldi N 23', 184);
insert into directoradmin values ('81723465P', 'Paula Méndez Arias', 42, 1860, 'C/Catador N 41', 182);
insert into directoradmin values ('83890412S', 'Ana María Delgado de la Rosa', 36, 2100, 'Avda del Rocío N 32 A', 166);
insert into directoradmin values ('92398132H', 'Antonio Pérez Delgado', 33, 1920, 'C/Blanco White N 16', 160);

insert into administracion values (122783, 'Avda Expo 92 N 20', '16/09/2020', '92398132H');
insert into administracion values (632521, 'Calle Los Reyes Católicos N 1', '12/11/2020', '81723465P');
insert into administracion values (636251, 'Paseo La Isla N 56', '29/03/2018', '11992312K');
insert into administracion values (823716, 'Avda La Antigua N 40', '12/02/2016', '83890412S');
insert into administracion values (923812, 'Calle El Torreón N 15', '22/08/2019', '73765142M');

insert into gerente values ('33241123C', 'Francisco Cortina Lumbreras', 28, 1350, 'Vía Lorem ipsum, 106A 3ºH', 202);
insert into gerente values ('66534267J', 'Isidro Pujol Solís', 32, 1500, 'Londa Lorem ipsum, 211 11ºB', 160);
insert into gerente values ('73761928B', 'Rafael Torrijos Bolaños', 34, 1600, 'Callejón Lorem ipsum, 170B 2ºA', 184);
insert into gerente values ('83719938N', 'Lupe Pozuelo Pizarro', 44, 1550, 'Alameda Lorem, 84A', 190);

insert into centrotrabajo values(113921, 'Ctra. Hornos, 13', '19/06/2020', '73761928B', 122783);
insert into centrotrabajo values(777638, 'C/ Domingo Beltrán, 59', '05/08/2020', '66534267J', 823716);
insert into centrotrabajo values(798002, 'C/ Eras, 24', '15/07/2016', '33241123C', 923812);
insert into centrotrabajo values(837212, 'Celso Emilio Ferreiro, 16', '09/05/2019', '83719938N', 632521);

insert into directorescolar values ('23313424F', 'Erato Corona Arreola', 67, 113921);
insert into directorescolar values ('33126645V', 'Bela Riojas Alarcón', 45, 798002);
insert into directorescolar values ('41427686G', 'Celmira Enríquez Esquivel', 34, 837212);

insert into centroescolar values (100231, 'Avda. de la Estación, 99', '09/09/1996', '23313424F', 113921);
insert into centroescolar values (332442, 'Escuadro, 85', '20/04/2002', '41427686G', 837212);
insert into centroescolar values (736828, 'Avendaño, 69', '11/04/2001', '33126645V', 798002);

insert into encargado values ('09003241L', 'Zaba Macías Aranda', 34, 790, 'Comandante Izarduy, 84', 80, 332442, 837212);
insert into encargado values ('77639912X', 'Macedonio Guevara Romero', 42, 770, 'Rio Segura, 61', 80, '736828', '798002');
insert into encargado values ('83874321C', 'Florida Guerra García', 52, 800, 'Herrería, 52', 80, '100231', '113921');

insert into empleado values ('00930821H', 'Oberto Espinoza Osorio', 38, 630, 'Cercas Bajas, 42', 80, 100231, 113921, '83874321C');
insert into empleado values ('12346789U', 'Filemón Hidalgo Granado', 34, 660, 'Constitución, 56', 80, 332442, 837212, '09003241L');
insert into empleado values ('19283794F', 'Normando Moreno Cortez', 40, 640, 'C/ Fernández de Leceta, 26', 80, 100231, 113921, '83874321C');
insert into empleado values ('67812378E', 'Janice Pizarro Montalvo', 21, 660, 'Herrería, 35', 80, 332442, 837212, '09003241L');
insert into empleado values ('67832456P', 'Laia Jaime Santacruz', 42, 650, 'C/ Manuel Iradier, 37', 80, 736828, 798002, '77639912X');
insert into empleado values ('77365498C', 'Arquímedes Arana Coronado', 24, 665, 'Rua da Rapina, 77', 80, 100231, 113921, '83874321C');
insert into empleado values ('81376289N', 'Servio Guerrero Porras', 29, 640, 'Avda. Los llanos, 91', 80, 100231, 113921, '83874321C');
insert into empleado values ('88376253O', 'Pirra Corona Maestas', 30, 640, 'Avda. Los llanos, 13', 80, 100231, 113921, '83874321C');
insert into empleado values ('89785634R', 'Dalmazio Gaona Serrano', 47, 650, 'Prolongacion San Sebastian, 21', 80, 736828, 798002, '77639912X');

insert into vendedor values (121231, 'Velasco Madrigal Lemus');
insert into vendedor values (665362, 'Dimpna Gómez Sotelo');
insert into vendedor values (783721, 'Teolinda Estévez Rosas');

insert into compraventa values (121231, '33241123C', 'Esponjas');
insert into compraventa values (121231, '83719938N', 'Bayetas');
insert into compraventa values (665362, '73761928B', 'Fregonas');
insert into compraventa values (665362, '83719938N', 'Friega suelos');
insert into compraventa values (783721, '66534267J', 'Limpia cristales');
insert into compraventa values (783721, '73761928B', 'Limpia cristales');