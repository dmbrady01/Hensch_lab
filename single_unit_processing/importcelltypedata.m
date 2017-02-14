%Importing Cell Type Data
%
%Written by D.M. Brady 11/1/2010

%% Importing Data (DR)

dr.v1.vis = importdata('DR_Cell_Types_V1_Visual.csv'); % V1 Visual
dr.v1.both = importdata('DR_Cell_Types_V1_Both.csv'); % V1 Both
dr.v1.bothpref = importdata('DR_Cell_Types_V1_BothPref.csv'); % V1 BothPref
dr.v1.aud = importdata('DR_Cell_Types_V1_Aud.csv'); % V1 Auditory

dr.v2.vis = importdata('DR_Cell_Types_V2_Visual.csv'); % V2 Visual
dr.v2.both = importdata('DR_Cell_Types_V2_Both.csv'); % V2 Both
dr.v2.bothpref = importdata('DR_Cell_Types_V2_BothPref.csv'); % V2 BothPref
dr.v2.aud = importdata('DR_Cell_Types_V2_Aud.csv'); % V2 Auditory

dr.ac.aud = importdata('DR_Cell_Types_AC_Aud.csv'); % AC Auditory


save('DR_Cell_Types')


%% Importing Data (NgR)

ngr.v1.vis = importdata('NgR_Cell_Types_V1_Visual.csv'); % V1 Visual
ngr.v1.both = importdata('NgR_Cell_Types_V1_Both.csv'); % V1 Both
ngr.v1.bothpref = importdata('NgR_Cell_Types_V1_BothPref.csv'); % V1 BothPref
ngr.v1.aud = importdata('NgR_Cell_Types_V1_Aud.csv'); % V1 Auditory

ngr.v2.vis = importdata('NgR_Cell_Types_V2_Visual.csv'); % V2 Visual
ngr.v2.both = importdata('NgR_Cell_Types_V2_Both.csv'); % V2 Both
ngr.v2.bothpref = importdata('NgR_Cell_Types_V2_BothPref.csv'); % V2 BothPref
ngr.v2.aud = importdata('NgR_Cell_Types_V2_Aud.csv'); % V2 Auditory

ngr.ac.aud = importdata('NgR_Cell_Types_AC_Aud.csv'); % AC Auditory
ngr.ac.both = importdata('NgR_Cell_Types_AC_Both.csv'); % AC Both


save('NgR_Cell_Types')