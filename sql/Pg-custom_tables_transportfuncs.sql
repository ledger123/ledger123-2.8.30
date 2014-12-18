-- First Choice Internet www.choicenet.ne.jp

-- additional fields for the enhanced foreign currency processing
ALTER TABLE acc_trans ADD COLUMN fxamount double precision;
ALTER TABLE payment ADD COLUMN fxamount double precision;


-- additional tables for the SQL-Ledger transport functions
-- bp 2010/04/27

ALTER TABLE oe ADD COLUMN transportdate date;
ALTER TABLE customer ADD COLUMN transport_id integer;
ALTER TABLE vendor ADD COLUMN transportcompany boolean;
ALTER TABLE vendor ADD COLUMN transport_id integer;


CREATE TABLE transport
(
  trans_id integer,
  transportname character varying(64),
  transportaddress1 character varying(32),
  transportaddress2 character varying(32),
  transportcity character varying(32),
  transportstate character varying(32),
  transportzipcode character varying(10),
  transportcountry character varying(32),
  transportcontact character varying(64),
  transportphone character varying(20),
  transportfax character varying(20),
  transportemail text,
  transportcc text,
  transportbcc text
)
WITH (OIDS=FALSE);

-- Index: transport_trans_id_key

-- DROP INDEX transport_trans_id_key;

CREATE INDEX transport_trans_id_key
  ON transport
  USING btree
  (trans_id);
