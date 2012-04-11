--
-- Changes to SQL-Ledger 3.0 database
--
-- armaghan 11-apr-2012 added department/warehouse
ALTER TABLE employee ADD COLUMN department_id integer;
ALTER TABLE employee ADD COLUMN warehouse_id integer;

-- EOF
