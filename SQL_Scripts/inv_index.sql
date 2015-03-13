/*
This file is creates the inverted index to be used for searching
*/

CREATE INDEX pFirstName on persons(first_name)
INDEXTYPE is CTXSYS.CONTEXT
parameters ('sync (on commit)');

CREATE INDEX pLastName on persons(last_name)
INDEXTYPE is CTXSYS.CONTEXT
parameters ('sync (on commit)');

CREATE INDEX rTestType on radiology_record(test_type)
INDEXTYPE IS CTXSYS.CONTEXT
parameters ('sync (on commit)');

CREATE INDEX rDiagnosis on radiology_record(diagnosis)
INDEXTYPE IS CTXSYS.CONTEXT
parameters ('sync (on commit)');

CREATE INDEX rDescription on radiology_record(description)
INDEXTYPE IS CTXSYS.CONTEXT
parameters ('sync (on commit)');
