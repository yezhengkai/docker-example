%% References:
% https://www.mathworks.com/help/database/ug/mongo.html
% https://www.mathworks.com/help/database/ug/export-matlab-data-into-mongodb.html
clc; clear; close all;

%% Connect to MongoDB
server = "kai-mongodb";
port = 27017;
dbname = "mydb";
username = "user1";
password = "user1Pass";

conn = mongo(server, port, dbname, ...
             'UserName', username, ...
             'Password', password)
isopen(conn)


%% Create Collections and Export Data into MongoDB
patientdata = readtable('patients.xls'); 
data = readtable('tsunamis.xlsx');
tsunamidata = table2struct(data);

patientcoll = "patients";
tsunamicoll = "tsunamis";

createCollection(conn, patientcoll)
createCollection(conn, tsunamicoll)

n = insert(conn, patientcoll, patientdata)
n = insert(conn, tsunamicoll, tsunamidata)


%% Count Documents in Collections
conn.CollectionNames'
npatients = count(conn, patientcoll)
ntsunamis = count(conn, tsunamicoll)


%% Remove Documents and Drop Collections
npatients = remove(conn, patientcoll, '{}')
ntsunamis = remove(conn, tsunamicoll, '{}')

dropCollection(conn, patientcoll)
dropCollection(conn, tsunamicoll)


%% Close MongoDB Connection
close(conn)
