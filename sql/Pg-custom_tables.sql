
CREATE TABLE report (
  reportid int primary key default nextval('id'),
  reportcode text,
  reportdescription text,
  login text
);
--
CREATE TABLE reportvars (
  reportid int not null,
  reportvariable text,
  reportvalue text
);

--
-- Table for generic text file import
-- 
CREATE TABLE generic_import (
    id serial,
    a0 text,
    b0 text,
    c0 text,
    d0 text,
    e0 text,
    f0 text,
    g0 text,
    h0 text,
    i0 text,
    j0 text,
    k0 text,
    l0 text,
    m0 text,
    n0 text,
    o0 text,
    p0 text,
    q0 text,
    r0 text,
    s0 text,
    t0 text,
    u0 text,
    v0 text,
    w0 text,
    x0 text,
    y0 text,
    z0 text,
    aa text,
    ab text,
    ac text,
    ad text,
    ae text,
    af text,
    ag text,
    ah text,
    ai text,
    aj text,
    ak text,
    al text,
    am text,
    an text,
    ao text,
    ap text,
    aq text,
    ar text,
    as0 text,
    at text,
    au text,
    av text,
    aw text,
    ax text,
    ay text,
    az text
);

CREATE TABLE invoices_import (
    filetype        text,
    customer_id     integer,
    transdate       date,
    duedate         date,
    currency        text,
    salesperson     text,
    partnumber      text,
    description     text,
    qty             numeric(12,2),
    sellprice       numeric(12,2)
);

ALTER TABLE customer ADD domain text;
ALTER TABLE vendor ADD domain text;
