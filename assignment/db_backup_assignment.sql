--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: internal_schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA internal_schema;


ALTER SCHEMA internal_schema OWNER TO postgres;

--
-- Name: public_info; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public_info;


ALTER SCHEMA public_info OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: positions; Type: TABLE; Schema: internal_schema; Owner: postgres
--

CREATE TABLE internal_schema.positions (
    company_id character varying(50),
    portfolio_id character varying(50),
    current_stock numeric(20,3) NOT NULL
);


ALTER TABLE internal_schema.positions OWNER TO postgres;

--
-- Name: traders; Type: TABLE; Schema: internal_schema; Owner: postgres
--

CREATE TABLE internal_schema.traders (
    staff_id character varying(50) NOT NULL,
    trader_name character varying(50) NOT NULL,
    date_joined date NOT NULL
);


ALTER TABLE internal_schema.traders OWNER TO postgres;

--
-- Name: companies; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.companies (
    internal_id character varying(50) NOT NULL,
    company_name character varying(50) NOT NULL,
    annual_revenue money NOT NULL
);


ALTER TABLE public_info.companies OWNER TO postgres;

--
-- Name: portfolio; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.portfolio (
    portfolio_id character varying(50) NOT NULL,
    portfolio_name character varying(50) NOT NULL
);


ALTER TABLE public_info.portfolio OWNER TO postgres;

--
-- Name: prices; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.prices (
    company_id character varying(50),
    record_date date NOT NULL,
    record_value money NOT NULL
)
PARTITION BY RANGE (record_date);


ALTER TABLE public_info.prices OWNER TO postgres;

--
-- Name: prices1; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.prices1 (
    company_id character varying(50),
    record_date date NOT NULL,
    record_value money NOT NULL
);


ALTER TABLE public_info.prices1 OWNER TO postgres;

--
-- Name: prices2; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.prices2 (
    company_id character varying(50),
    record_date date NOT NULL,
    record_value money NOT NULL
);


ALTER TABLE public_info.prices2 OWNER TO postgres;

--
-- Name: prices3; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.prices3 (
    company_id character varying(50),
    record_date date NOT NULL,
    record_value money NOT NULL
);


ALTER TABLE public_info.prices3 OWNER TO postgres;

--
-- Name: prices4; Type: TABLE; Schema: public_info; Owner: postgres
--

CREATE TABLE public_info.prices4 (
    company_id character varying(50),
    record_date date NOT NULL,
    record_value money NOT NULL
);


ALTER TABLE public_info.prices4 OWNER TO postgres;

--
-- Name: prices1; Type: TABLE ATTACH; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.prices ATTACH PARTITION public_info.prices1 FOR VALUES FROM ('2022-01-01') TO ('2022-04-01');


--
-- Name: prices2; Type: TABLE ATTACH; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.prices ATTACH PARTITION public_info.prices2 FOR VALUES FROM ('2022-04-01') TO ('2022-07-01');


--
-- Name: prices3; Type: TABLE ATTACH; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.prices ATTACH PARTITION public_info.prices3 FOR VALUES FROM ('2022-07-01') TO ('2022-10-01');


--
-- Name: prices4; Type: TABLE ATTACH; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.prices ATTACH PARTITION public_info.prices4 FOR VALUES FROM ('2022-10-01') TO ('2023-01-01');


--
-- Data for Name: positions; Type: TABLE DATA; Schema: internal_schema; Owner: postgres
--

COPY internal_schema.positions (company_id, portfolio_id, current_stock) FROM stdin;
\.


--
-- Data for Name: traders; Type: TABLE DATA; Schema: internal_schema; Owner: postgres
--

COPY internal_schema.traders (staff_id, trader_name, date_joined) FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.companies (internal_id, company_name, annual_revenue) FROM stdin;
\.


--
-- Data for Name: portfolio; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.portfolio (portfolio_id, portfolio_name) FROM stdin;
\.


--
-- Data for Name: prices1; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.prices1 (company_id, record_date, record_value) FROM stdin;
\N	2022-01-20	£300.00
\.


--
-- Data for Name: prices2; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.prices2 (company_id, record_date, record_value) FROM stdin;
\N	2022-04-21	£100.00
\.


--
-- Data for Name: prices3; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.prices3 (company_id, record_date, record_value) FROM stdin;
\N	2022-08-02	£350.00
\.


--
-- Data for Name: prices4; Type: TABLE DATA; Schema: public_info; Owner: postgres
--

COPY public_info.prices4 (company_id, record_date, record_value) FROM stdin;
\N	2022-11-06	£150.00
\.


--
-- Name: traders traders_pkey; Type: CONSTRAINT; Schema: internal_schema; Owner: postgres
--

ALTER TABLE ONLY internal_schema.traders
    ADD CONSTRAINT traders_pkey PRIMARY KEY (staff_id);


--
-- Name: companies companies_company_name_key; Type: CONSTRAINT; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.companies
    ADD CONSTRAINT companies_company_name_key UNIQUE (company_name);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (internal_id);


--
-- Name: portfolio portfolio_pkey; Type: CONSTRAINT; Schema: public_info; Owner: postgres
--

ALTER TABLE ONLY public_info.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (portfolio_id);


--
-- Name: ix_current_stock; Type: INDEX; Schema: internal_schema; Owner: postgres
--

CREATE INDEX ix_current_stock ON internal_schema.positions USING btree (current_stock);


--
-- Name: ix_date_joined_btree; Type: INDEX; Schema: internal_schema; Owner: postgres
--

CREATE INDEX ix_date_joined_btree ON internal_schema.traders USING btree (date_joined);


--
-- Name: ix_staff_id_hash; Type: INDEX; Schema: internal_schema; Owner: postgres
--

CREATE INDEX ix_staff_id_hash ON internal_schema.traders USING hash (staff_id);


--
-- Name: ix_annual_revenue_btree; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX ix_annual_revenue_btree ON public_info.companies USING btree (annual_revenue);


--
-- Name: ix_company_name_btree; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX ix_company_name_btree ON public_info.companies USING btree (company_name);


--
-- Name: ix_portfolio_id; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX ix_portfolio_id ON public_info.portfolio USING hash (portfolio_id);


--
-- Name: ix_record_value; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX ix_record_value ON ONLY public_info.prices USING btree (record_value);


--
-- Name: prices1_record_value_idx; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX prices1_record_value_idx ON public_info.prices1 USING btree (record_value);


--
-- Name: prices2_record_value_idx; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX prices2_record_value_idx ON public_info.prices2 USING btree (record_value);


--
-- Name: prices3_record_value_idx; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX prices3_record_value_idx ON public_info.prices3 USING btree (record_value);


--
-- Name: prices4_record_value_idx; Type: INDEX; Schema: public_info; Owner: postgres
--

CREATE INDEX prices4_record_value_idx ON public_info.prices4 USING btree (record_value);


--
-- Name: prices1_record_value_idx; Type: INDEX ATTACH; Schema: public_info; Owner: postgres
--

ALTER INDEX public_info.ix_record_value ATTACH PARTITION public_info.prices1_record_value_idx;


--
-- Name: prices2_record_value_idx; Type: INDEX ATTACH; Schema: public_info; Owner: postgres
--

ALTER INDEX public_info.ix_record_value ATTACH PARTITION public_info.prices2_record_value_idx;


--
-- Name: prices3_record_value_idx; Type: INDEX ATTACH; Schema: public_info; Owner: postgres
--

ALTER INDEX public_info.ix_record_value ATTACH PARTITION public_info.prices3_record_value_idx;


--
-- Name: prices4_record_value_idx; Type: INDEX ATTACH; Schema: public_info; Owner: postgres
--

ALTER INDEX public_info.ix_record_value ATTACH PARTITION public_info.prices4_record_value_idx;


--
-- Name: positions positions_company_id_fkey; Type: FK CONSTRAINT; Schema: internal_schema; Owner: postgres
--

ALTER TABLE ONLY internal_schema.positions
    ADD CONSTRAINT positions_company_id_fkey FOREIGN KEY (company_id) REFERENCES public_info.companies(internal_id);


--
-- Name: positions positions_portfolio_id_fkey; Type: FK CONSTRAINT; Schema: internal_schema; Owner: postgres
--

ALTER TABLE ONLY internal_schema.positions
    ADD CONSTRAINT positions_portfolio_id_fkey FOREIGN KEY (portfolio_id) REFERENCES public_info.portfolio(portfolio_id);


--
-- Name: prices prices_company_id_fkey; Type: FK CONSTRAINT; Schema: public_info; Owner: postgres
--

ALTER TABLE public_info.prices
    ADD CONSTRAINT prices_company_id_fkey FOREIGN KEY (company_id) REFERENCES public_info.companies(internal_id);


--
-- Name: TABLE positions; Type: ACL; Schema: internal_schema; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE internal_schema.positions TO trader;


--
-- Name: TABLE traders; Type: ACL; Schema: internal_schema; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE internal_schema.traders TO trader;


--
-- Name: TABLE companies; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.companies TO trader;
GRANT SELECT ON TABLE public_info.companies TO customer;


--
-- Name: TABLE portfolio; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.portfolio TO trader;
GRANT SELECT ON TABLE public_info.portfolio TO customer;


--
-- Name: TABLE prices; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.prices TO trader;
GRANT SELECT ON TABLE public_info.prices TO customer;


--
-- Name: TABLE prices1; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.prices1 TO trader;
GRANT SELECT ON TABLE public_info.prices1 TO customer;


--
-- Name: TABLE prices2; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.prices2 TO trader;
GRANT SELECT ON TABLE public_info.prices2 TO customer;


--
-- Name: TABLE prices3; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.prices3 TO trader;
GRANT SELECT ON TABLE public_info.prices3 TO customer;


--
-- Name: TABLE prices4; Type: ACL; Schema: public_info; Owner: postgres
--

GRANT SELECT ON TABLE public_info.prices4 TO trader;
GRANT SELECT ON TABLE public_info.prices4 TO customer;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: internal_schema; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA internal_schema GRANT SELECT,INSERT ON TABLES  TO trader;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public_info; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public_info GRANT SELECT ON TABLES  TO trader;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public_info GRANT SELECT ON TABLES  TO customer;


--
-- PostgreSQL database dump complete
--

