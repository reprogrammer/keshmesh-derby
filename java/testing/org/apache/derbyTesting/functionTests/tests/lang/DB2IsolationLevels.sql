--
--   Licensed to the Apache Software Foundation (ASF) under one or more
--   contributor license agreements.  See the NOTICE file distributed with
--   this work for additional information regarding copyright ownership.
--   The ASF licenses this file to You under the Apache License, Version 2.0
--   (the "License"); you may not use this file except in compliance with
--   the License.  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
--
-- single user test for the various isolation levels
-- also notice in the runtimestatistics output that Fetch Size is 16 for various isolation levels ie we are doing bulk fetch for all isolation levels
-- this will test the fix for bug 5953 - which is to enable bulk fetching for RR and serializable isolation levels as well.
prepare getIsolation as 'values current isolation';

autocommit off;
call SYSCS_UTIL.SYSCS_SET_RUNTIMESTATISTICS(1);
maximumdisplaywidth 2000;

-- create a table
create table t1(c1 int not null constraint asdf primary key);
commit;

-- insert a row
insert into t1 values 1;
-- verify table scan gets row lock at read committed
select * from t1;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();
-- verify SET ISOLATION commits and changes isolation level
set isolation RR;
execute getIsolation;

-- rollback should find nothing to undo
rollback;
select * from t1;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set isolation reset;
execute getIsolation;
-- verify SET ISOLATION commits and changes isolation level
set isolation read committed;
execute getIsolation;
-- rollback should find nothing to undo
rollback;
select * from t1;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set current isolation = reset;
execute getIsolation;

-- verify SET ISOLATION commits and changes isolation level
set current isolation = RS;
execute getIsolation;
-- rollback should find nothing to undo
rollback;
select * from t1;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set isolation to reset;
execute getIsolation;

-- verify SET ISOLATION commits and changes isolation level
set isolation = dirty read;
execute getIsolation;
-- rollback should find nothing to undo
rollback;
select * from t1;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

-- test WITH ISOLATION clause
set isolation serializable;
execute getIsolation;
select * from t1 with CS;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set isolation cursor stability;
execute getIsolation;
select * from t1 with RR;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set isolation serializable;
execute getIsolation;
select * from t1 with RS;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

set current isolation to read committed;
execute getIsolation;
select * from t1 with ur;
values SYSCS_UTIL.SYSCS_GET_RUNTIMESTATISTICS();

-- unknown isolation level
select * from t1 with rw;
select * from t1 with DIRTY READ;
select * from t1 with READ UNCOMMITTED;
select * from t1 with READ COMMITTED;
select * from t1 with CURSOR STABILITY;
select * from t1 with REPEATABLE READ;
select * from t1 with SERIALIZABLE;

-- check the db2 isolation levels can be used as identifiers
create table db2iso(cs int, rr int, ur int, rs int);
select cs, rr, ur, rs from db2iso;
-- cleanup
drop table t1;
