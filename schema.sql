--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.1
-- Started on 2015-06-06 16:07:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 65811)
-- Name: pr_inplant; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pr_inplant;


ALTER SCHEMA pr_inplant OWNER TO postgres;

SET search_path = pr_inplant, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 65812)
-- Name: tbl_card; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_card (
    i_plant_id numeric(32,0) NOT NULL,
    c_card_id character varying(32) NOT NULL
);


ALTER TABLE tbl_card OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 65815)
-- Name: tbl_data; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_data (
    epos_data text NOT NULL,
    seen boolean NOT NULL,
    i_data_id numeric NOT NULL
);


ALTER TABLE tbl_data OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 65821)
-- Name: tbl_do; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_do (
    i_plant_id numeric(32,0) NOT NULL,
    i_do_id numeric(30,0) NOT NULL,
    dt_issue_date timestamp without time zone,
    t_consignee text,
    t_consigner text,
    t_delivery_address text,
    dt_issue_time timestamp without time zone
);


ALTER TABLE tbl_do OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 65827)
-- Name: tbl_driver; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_driver (
    i_plant_id numeric(32,0) NOT NULL,
    i_driver_id numeric(32,0) NOT NULL,
    i_transporter_id numeric(32,0) NOT NULL,
    t_driver_name text,
    t_driver_addr1 text,
    t_driver_addr2 text,
    t_driver_city text,
    t_state_id text,
    i_driver_pin text,
    t_country_id text,
    t_driver_email_id text,
    t_licence_no text NOT NULL,
    b_is_active boolean,
    t_created_by text DEFAULT 'SYS'::text,
    dt_created timestamp without time zone DEFAULT now(),
    t_modified_by text,
    dt_modified timestamp without time zone,
    b_is_deleted boolean
);


ALTER TABLE tbl_driver OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 65835)
-- Name: tbl_epos; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_epos (
    i_plant_id numeric(32,0) NOT NULL,
    i_terminal_id numeric(32,0) NOT NULL,
    i_machine_id numeric(30,0) NOT NULL,
    i_gate_no numeric(50,0),
    t_gateway_name text,
    t_location text,
    b_bothways boolean NOT NULL,
    i_time_in_between numeric(30,0)
);


ALTER TABLE tbl_epos OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 65841)
-- Name: tbl_exceptions; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_exceptions (
    i_exception_id numeric(32,0) NOT NULL,
    dt_created timestamp without time zone DEFAULT now(),
    i_plant_id numeric(32,0) NOT NULL,
    i_trip_id numeric(32,0) NOT NULL,
    i_machine_id numeric(30,0) NOT NULL,
    dt_expected_time timestamp without time zone,
    dt_arrival_time timestamp without time zone,
    b_is_checked boolean NOT NULL
);


ALTER TABLE tbl_exceptions OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 65845)
-- Name: tbl_links; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_links (
    i_lid numeric(32,0) NOT NULL,
    i_plant_id numeric(32,0) NOT NULL,
    i_to numeric(30,0),
    i_from numeric(30,0),
    n_timediff_in_min numeric
);


ALTER TABLE tbl_links OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 65851)
-- Name: tbl_live_path; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_live_path (
    i_plant_id numeric(32,0) NOT NULL,
    i_path_id numeric(32,0) NOT NULL,
    t_curr_path text,
    t_next text
);


ALTER TABLE tbl_live_path OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 65857)
-- Name: tbl_mapping; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_mapping (
    i_plant_id numeric(32,0) NOT NULL,
    i_trip_id numeric(30,0) NOT NULL,
    c_card_id character varying(32) NOT NULL,
    i_process_id numeric(30,0),
    t_vehicle_id text NOT NULL,
    i_driver_id numeric(30,0),
    i_transporter_id numeric(30,0),
    i_do_id numeric(30,0),
    dt_created timestamp without time zone DEFAULT now(),
    b_is_active boolean NOT NULL,
    i_path_id numeric(32,0),
    i_card_id numeric(30,0),
    t_driver_name text
);


ALTER TABLE tbl_mapping OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 65864)
-- Name: tbl_paths; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_paths (
    i_plant_id numeric(32,0) NOT NULL,
    i_arr_path numeric(30,0)[],
    t_name text NOT NULL
);


ALTER TABLE tbl_paths OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 65870)
-- Name: tbl_plant; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_plant (
    i_plant_id numeric(32,0) NOT NULL,
    t_plant_name text,
    t_plant_owner text
);


ALTER TABLE tbl_plant OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 65876)
-- Name: tbl_process; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_process (
    i_plant_id numeric(32,0) NOT NULL,
    i_process_id numeric(30,0) NOT NULL,
    t_process_type text
);


ALTER TABLE tbl_process OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 65882)
-- Name: tbl_transporter; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_transporter (
    i_plant_id numeric(32,0) NOT NULL,
    i_transporter_id numeric(50,0) NOT NULL,
    t_transporter_name text,
    t_transporter_mobile_no text,
    t_transporter_addr text,
    t_transporter_city text,
    t_transporter_state text,
    i_transporter_pin text,
    t_transporter_email_id text
);


ALTER TABLE tbl_transporter OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 65888)
-- Name: tbl_users; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_users (
    i_plant_id numeric(32,0) NOT NULL,
    s_username text NOT NULL,
    s_password text,
    s_password_md5 text NOT NULL,
    b_remove_trip boolean,
    b_view_trip boolean,
    b_node_view boolean,
    b_add_trip boolean,
    b_view_exception boolean,
    b_end_exception boolean,
    b_view_history boolean,
    b_setup_new_plant boolean,
    b_plant_modify boolean,
    b_add_user boolean,
    b_modify_user boolean,
    b_change_current_plant boolean,
    b_add_vehicle boolean,
    b_modify_vehicle boolean,
    b_modify_driver boolean,
    b_add_driver boolean,
    b_view_do boolean,
    b_logged_in boolean,
    i_transporter_id numeric(30,0),
    i_driver_id numeric(30,0),
    b_add_transporter boolean,
    b_add_card boolean,
    b_add_path boolean,
    b_add_epos boolean,
    b_add_process boolean
);


ALTER TABLE tbl_users OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 65894)
-- Name: tbl_vehicle; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_vehicle (
    i_plant_id numeric(32,0) NOT NULL,
    t_vehicle_id text NOT NULL,
    t_chasis_no text,
    t_vehicle_type text,
    i_load_capacity numeric(10,0),
    t_national_permit text,
    dt_license_expiry_date timestamp without time zone,
    i_transporter_id numeric(32,0) NOT NULL,
    t_owner character varying(255)
);


ALTER TABLE tbl_vehicle OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 65900)
-- Name: tbl_vehicle_flight; Type: TABLE; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

CREATE TABLE tbl_vehicle_flight (
    i_vfid numeric(32,0) NOT NULL,
    dt_time timestamp without time zone,
    i_machine_id numeric(50,0) NOT NULL,
    c_card_id character varying(32) NOT NULL,
    i_trip_id numeric(50,0) NOT NULL,
    t_model_no text,
    t_data_status text,
    t_event text,
    i_plant_id numeric(32,0) NOT NULL,
    i_card_id numeric(50,0) NOT NULL
);


ALTER TABLE tbl_vehicle_flight OWNER TO postgres;

--
-- TOC entry 2131 (class 0 OID 65812)
-- Dependencies: 174
-- Data for Name: tbl_card; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_card VALUES (17, '1002');
INSERT INTO tbl_card VALUES (119, '100');
INSERT INTO tbl_card VALUES (119, '101');
INSERT INTO tbl_card VALUES (119, '102');
INSERT INTO tbl_card VALUES (119, '103');
INSERT INTO tbl_card VALUES (119, '104');
INSERT INTO tbl_card VALUES (23, '1');
INSERT INTO tbl_card VALUES (23, '2');
INSERT INTO tbl_card VALUES (23, '3');
INSERT INTO tbl_card VALUES (130, '4');
INSERT INTO tbl_card VALUES (130, '5');
INSERT INTO tbl_card VALUES (130, '6');
INSERT INTO tbl_card VALUES (130, '7');


--
-- TOC entry 2132 (class 0 OID 65815)
-- Dependencies: 175
-- Data for Name: tbl_data; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--



--
-- TOC entry 2133 (class 0 OID 65821)
-- Dependencies: 176
-- Data for Name: tbl_do; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--



--
-- TOC entry 2134 (class 0 OID 65827)
-- Dependencies: 177
-- Data for Name: tbl_driver; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_driver VALUES (17, 21, 20, 'souradip', 'hgfh', 'hvhgv', 'vhv', '45', '45', '45', 'geminiankit.26@gmail.com', 'jyg', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (17, 22, 19, 'ankit', 'jg', 'jgj', 'jhgjhb', '45', '48', '847', 'hfguyjg', 'gyuj', NULL, 'SYS', '2015-05-30 17:17:03.385', NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (119, 125, 123, 'Sourodip', 'Sodepur', 'Howrah', 'Kolkata', '12', '12', '12', 'sourodip@gmail.com', '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (119, 126, 124, 'Sourodip', 'Sodepur', 'Howrah', 'Kolkata', '12', '12', '12', 'sourodip@gmail.com', '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (23, 30, 28, 'souradip', 'sodepur', 'howrah', 'kolkata', '12', '12', '12', 'geminiankit.26@gmail.com', 'h', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (23, 31, 29, 'rahul', 'tobbin road', 'tobin road', 'kolkata', 'west bengal', '45', '45', 'geminiankit.26@gmail.com', 'jyg', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (130, 134, 132, 'Sourodip', 'Sodepur', 'Howrah', 'Kolkata', '12', '12', '12', 'sourodip@gmail.com', '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_driver VALUES (130, 135, 133, 'Rahul', 'Tobin Road', 'Tobin Road', 'Kolkata', '12', '12', '12', 'sourodip@gmail.com', '123', NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2135 (class 0 OID 65835)
-- Dependencies: 178
-- Data for Name: tbl_epos; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_epos VALUES (17, 100, 100, 1, 'Entry Gate', 'Entry', false, 0);
INSERT INTO tbl_epos VALUES (17, 101, 101, 2, 'Exit', 'Exit', false, 0);
INSERT INTO tbl_epos VALUES (119, 2, 202, 2, 'Exit', 'Exit', false, 0);
INSERT INTO tbl_epos VALUES (119, 1, 201, 1, 'Entry', 'Entry', false, 0);
INSERT INTO tbl_epos VALUES (119, 3, 203, 3, 'Security', 'Security', true, 5);
INSERT INTO tbl_epos VALUES (119, 3, -203, 3, 'Security Exit', 'Security', true, 5);
INSERT INTO tbl_epos VALUES (23, 1, 300, 1, 'Entry Gate', 'Entry', false, 0);
INSERT INTO tbl_epos VALUES (23, 2, 301, 2, 'Security', 'Security', true, 10);
INSERT INTO tbl_epos VALUES (23, 2, -301, 2, 'Security Exit', 'Security', true, 10);
INSERT INTO tbl_epos VALUES (23, 3, 302, 3, 'Exit', 'Exit', false, 0);
INSERT INTO tbl_epos VALUES (23, 3, 303, 3, 'Exit', 'Exit', false, 0);
INSERT INTO tbl_epos VALUES (130, 1, 500, 1, 'Entry', 'Entry', false, 0);
INSERT INTO tbl_epos VALUES (130, 2, 501, 2, 'Exit', 'Exit', false, 0);


--
-- TOC entry 2136 (class 0 OID 65841)
-- Dependencies: 179
-- Data for Name: tbl_exceptions; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--



--
-- TOC entry 2137 (class 0 OID 65845)
-- Dependencies: 180
-- Data for Name: tbl_links; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_links VALUES (18, 17, 100, 101, 10);
INSERT INTO tbl_links VALUES (120, 119, 201, 203, 10);
INSERT INTO tbl_links VALUES (121, 119, 203, -203, 10);
INSERT INTO tbl_links VALUES (122, 119, -203, 202, 10);
INSERT INTO tbl_links VALUES (24, 23, 300, 301, 10);
INSERT INTO tbl_links VALUES (25, 23, 301, -301, 10);
INSERT INTO tbl_links VALUES (26, 23, -301, 302, 10);
INSERT INTO tbl_links VALUES (27, 23, -301, 303, 10);
INSERT INTO tbl_links VALUES (131, 130, 500, 501, 10);


--
-- TOC entry 2138 (class 0 OID 65851)
-- Dependencies: 181
-- Data for Name: tbl_live_path; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_live_path VALUES (23, 1, '1,2,3', '1');
INSERT INTO tbl_live_path VALUES (23, 2, '1,2,-2,3', '1');


--
-- TOC entry 2139 (class 0 OID 65857)
-- Dependencies: 182
-- Data for Name: tbl_mapping; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_mapping VALUES (17, 115, '1002', 1, '11', 22, 19, NULL, NULL, true, NULL, 1002, NULL);
INSERT INTO tbl_mapping VALUES (17, 116, '1002', 1, '22', 21, 20, NULL, NULL, true, NULL, 1002, NULL);
INSERT INTO tbl_mapping VALUES (17, 117, '1002', 1, '11', NULL, 19, NULL, NULL, true, NULL, 1002, 'Ukv');
INSERT INTO tbl_mapping VALUES (23, 1, '1', 2, '3', NULL, 28, NULL, NULL, true, NULL, 1, 'roy');


--
-- TOC entry 2140 (class 0 OID 65864)
-- Dependencies: 183
-- Data for Name: tbl_paths; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_paths VALUES (23, '{1,2,3}', 'Path A');
INSERT INTO tbl_paths VALUES (23, '{1,2,-2,3}', 'Path B');


--
-- TOC entry 2141 (class 0 OID 65870)
-- Dependencies: 184
-- Data for Name: tbl_plant; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_plant VALUES (1, 'jrd', 'tata');
INSERT INTO tbl_plant VALUES (2, 'ankit', 'raj');
INSERT INTO tbl_plant VALUES (17, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (18, 'abc', 'def');
INSERT INTO tbl_plant VALUES (119, 'JSPL', 'Jindal');
INSERT INTO tbl_plant VALUES (22, 'JSPL', 'jindal');
INSERT INTO tbl_plant VALUES (23, 'Tisco', 'Tata');
INSERT INTO tbl_plant VALUES (37, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (38, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (39, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (40, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (41, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (42, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (43, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (44, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (45, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (46, 'tata', 'ankit');
INSERT INTO tbl_plant VALUES (130, 'Tisco', 'Tata');


--
-- TOC entry 2142 (class 0 OID 65876)
-- Dependencies: 185
-- Data for Name: tbl_process; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_process VALUES (17, 118, 'Both');
INSERT INTO tbl_process VALUES (17, 127, 'Loading');
INSERT INTO tbl_process VALUES (17, 128, 'Delivery');
INSERT INTO tbl_process VALUES (17, 129, 'Both');
INSERT INTO tbl_process VALUES (17, 32, 'Loading');
INSERT INTO tbl_process VALUES (17, 33, 'Delivery');
INSERT INTO tbl_process VALUES (23, 1, 'Loading');
INSERT INTO tbl_process VALUES (23, 2, 'Delivery');
INSERT INTO tbl_process VALUES (23, 34, 'Both');


--
-- TOC entry 2143 (class 0 OID 65882)
-- Dependencies: 186
-- Data for Name: tbl_transporter; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_transporter VALUES (1, 1, 'A', '1', 'a', 'a', 'a', '1', 'a');
INSERT INTO tbl_transporter VALUES (1, 2, 'B', '2', 'b', 'b', 'b', '2', 'b');
INSERT INTO tbl_transporter VALUES (2, 3, 'C', '3', 'c', 'c', 'c', '3', 'c');
INSERT INTO tbl_transporter VALUES (17, 19, 'Ankit Shaw', '09804828980', '17/1/H/23, Ultadanga Main Rd, muchibazar', 'kolkata', 'west bengal', '700006', 'geminiankit.26@gmail.com');
INSERT INTO tbl_transporter VALUES (17, 20, 'kaustav', '96464646546', 'chingrihata', 'kolkata', 'west bengal', '700003', 'kaustavray17@gmail.com');
INSERT INTO tbl_transporter VALUES (18, 21, 'v', '789', 'vb', 'kol', 'wb', '700003', 'wj@cd.com');
INSERT INTO tbl_transporter VALUES (119, 123, 'Ankit', '9804828980', 'Muchibazar', 'Kolkata', 'West Bengal', '700006', 'ankit@gmail.com');
INSERT INTO tbl_transporter VALUES (119, 124, 'Kautav', '9674988058', 'Chingrihata', 'Kolkata', 'West Bengal', '700006', 'kaustav@gmail.com');
INSERT INTO tbl_transporter VALUES (23, 28, 'Ankit Shaw', '09804828980', '17/1/H/23, Ultadanga Main Rd, muchibazar', 'kolkata', 'west bengal', '700006', 'geminiankit.26@gmail.com');
INSERT INTO tbl_transporter VALUES (23, 29, 'kaustav', '96464646546', 'chingrihata', 'kolkata', 'west bengal', '700003', 'xyz@t.com');
INSERT INTO tbl_transporter VALUES (130, 132, 'Ankit', '9804828980', 'Muchibazar', 'Kolkata', 'West Bengal', '700006', 'ankit@gmail.com');
INSERT INTO tbl_transporter VALUES (130, 133, 'Kautav', '9674988058', 'Chingrihata', 'Kolkata', 'West Bengal', '700006', 'kaustav@gmail.com');


--
-- TOC entry 2144 (class 0 OID 65888)
-- Dependencies: 187
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_users VALUES (17, 'ankit', 'ankit', '447d2c8dc25efbc493788a322f1a00e7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (23, 'Ankit', 'ankit', '447d2c8dc25efbc493788a322f1a00e7', true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (22, 'Admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (17, 'kaustav', 'kaustav', '461dab91ddb4b65835eb92c169e473f0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (46, 'asd', 'asd', '7815696ecbf1c96e6894b779456d330e', true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (23, 'Raj', 'raj', '65a1223dae83b8092c4edba0823a793c', true, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (130, 'abcd', 'abcd', 'e2fc714c4727ee9395f324cd2e7f331f', true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (130, 'u', 'u', '7b774effe4a349c6dd82ad4f4f21d34c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tbl_users VALUES (130, 'k', 'k', '8ce4b16b22b58894aa86c421e8759df3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2145 (class 0 OID 65894)
-- Dependencies: 188
-- Data for Name: tbl_vehicle; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--

INSERT INTO tbl_vehicle VALUES (17, '11', '123', 'mini', 56, 'dgf56', NULL, 19, NULL);
INSERT INTO tbl_vehicle VALUES (17, '22', '235', 'tempo', 89, 'hfj5', NULL, 20, NULL);
INSERT INTO tbl_vehicle VALUES (119, '123', '456', 'Mini', 100, 'dontknow', NULL, 123, NULL);
INSERT INTO tbl_vehicle VALUES (119, '234', '567', 'Truck', 500, 'dontknow', NULL, 124, NULL);
INSERT INTO tbl_vehicle VALUES (23, '1', 'dontknow', 'mini', 300, 'jk', NULL, 28, NULL);
INSERT INTO tbl_vehicle VALUES (23, '2', 'dontknow', 'tempo', 500, 'dghs', NULL, 29, NULL);
INSERT INTO tbl_vehicle VALUES (23, '3', 'dontknow', 'mini', 100, 'hdu', NULL, 28, NULL);
INSERT INTO tbl_vehicle VALUES (130, '4', '123', 'Mini', 100, 'dontknow', NULL, 132, NULL);
INSERT INTO tbl_vehicle VALUES (130, '5', '567', 'Truck', 500, 'dontknow', NULL, 133, NULL);


--
-- TOC entry 2146 (class 0 OID 65900)
-- Dependencies: 189
-- Data for Name: tbl_vehicle_flight; Type: TABLE DATA; Schema: pr_inplant; Owner: postgres
--



--
-- TOC entry 1962 (class 2606 OID 65907)
-- Name: pk_card_card_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_card
    ADD CONSTRAINT pk_card_card_id PRIMARY KEY (c_card_id);


--
-- TOC entry 1964 (class 2606 OID 65909)
-- Name: pk_data_data_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_data
    ADD CONSTRAINT pk_data_data_id PRIMARY KEY (i_data_id);


--
-- TOC entry 1966 (class 2606 OID 65911)
-- Name: pk_do_do_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_do
    ADD CONSTRAINT pk_do_do_id PRIMARY KEY (i_do_id);


--
-- TOC entry 1968 (class 2606 OID 65914)
-- Name: pk_driver_driver_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_driver
    ADD CONSTRAINT pk_driver_driver_id PRIMARY KEY (i_driver_id);


--
-- TOC entry 1970 (class 2606 OID 65916)
-- Name: pk_epos_machine_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_epos
    ADD CONSTRAINT pk_epos_machine_id PRIMARY KEY (i_machine_id);


--
-- TOC entry 1972 (class 2606 OID 65918)
-- Name: pk_exceptions_exception_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_exceptions
    ADD CONSTRAINT pk_exceptions_exception_id PRIMARY KEY (i_exception_id);


--
-- TOC entry 1974 (class 2606 OID 65920)
-- Name: pk_links_lid; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_links
    ADD CONSTRAINT pk_links_lid PRIMARY KEY (i_lid);


--
-- TOC entry 1976 (class 2606 OID 65922)
-- Name: pk_live_path_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_live_path
    ADD CONSTRAINT pk_live_path_id PRIMARY KEY (i_path_id);


--
-- TOC entry 1978 (class 2606 OID 65924)
-- Name: pk_mapping_trip; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT pk_mapping_trip PRIMARY KEY (i_trip_id);


--
-- TOC entry 1980 (class 2606 OID 65926)
-- Name: pk_paths_t_name; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_paths
    ADD CONSTRAINT pk_paths_t_name PRIMARY KEY (t_name);


--
-- TOC entry 1982 (class 2606 OID 65928)
-- Name: pk_plant_plant_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_plant
    ADD CONSTRAINT pk_plant_plant_id PRIMARY KEY (i_plant_id);


--
-- TOC entry 1984 (class 2606 OID 65930)
-- Name: pk_process_process_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_process
    ADD CONSTRAINT pk_process_process_id PRIMARY KEY (i_process_id);


--
-- TOC entry 1986 (class 2606 OID 65932)
-- Name: pk_transporter_transporter_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_transporter
    ADD CONSTRAINT pk_transporter_transporter_id PRIMARY KEY (i_transporter_id);


--
-- TOC entry 1988 (class 2606 OID 65934)
-- Name: pk_users_username; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_users
    ADD CONSTRAINT pk_users_username PRIMARY KEY (s_username);


--
-- TOC entry 1992 (class 2606 OID 65936)
-- Name: pk_vehicle_flight_vfid; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_vehicle_flight
    ADD CONSTRAINT pk_vehicle_flight_vfid PRIMARY KEY (i_vfid);


--
-- TOC entry 1990 (class 2606 OID 65938)
-- Name: pk_vehicle_vehicle_id; Type: CONSTRAINT; Schema: pr_inplant; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbl_vehicle
    ADD CONSTRAINT pk_vehicle_vehicle_id PRIMARY KEY (t_vehicle_id);


--
-- TOC entry 1993 (class 2606 OID 65939)
-- Name: fk_card_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_card
    ADD CONSTRAINT fk_card_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 1994 (class 2606 OID 65944)
-- Name: fk_do_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_do
    ADD CONSTRAINT fk_do_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 1995 (class 2606 OID 65949)
-- Name: fk_driver_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_driver
    ADD CONSTRAINT fk_driver_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 1996 (class 2606 OID 65954)
-- Name: fk_driver_transporter_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_driver
    ADD CONSTRAINT fk_driver_transporter_id FOREIGN KEY (i_transporter_id) REFERENCES tbl_transporter(i_transporter_id) MATCH FULL;


--
-- TOC entry 1997 (class 2606 OID 65959)
-- Name: fk_epos_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_epos
    ADD CONSTRAINT fk_epos_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 1998 (class 2606 OID 65964)
-- Name: fk_exceptions_m_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_exceptions
    ADD CONSTRAINT fk_exceptions_m_id FOREIGN KEY (i_machine_id) REFERENCES tbl_epos(i_machine_id) MATCH FULL;


--
-- TOC entry 1999 (class 2606 OID 65969)
-- Name: fk_exceptions_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_exceptions
    ADD CONSTRAINT fk_exceptions_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2000 (class 2606 OID 65974)
-- Name: fk_exceptions_trip_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_exceptions
    ADD CONSTRAINT fk_exceptions_trip_id FOREIGN KEY (i_trip_id) REFERENCES tbl_mapping(i_trip_id) MATCH FULL;


--
-- TOC entry 2001 (class 2606 OID 65979)
-- Name: fk_links_from; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_links
    ADD CONSTRAINT fk_links_from FOREIGN KEY (i_from) REFERENCES tbl_epos(i_machine_id) MATCH FULL;


--
-- TOC entry 2002 (class 2606 OID 65984)
-- Name: fk_links_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_links
    ADD CONSTRAINT fk_links_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2003 (class 2606 OID 65989)
-- Name: fk_links_to; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_links
    ADD CONSTRAINT fk_links_to FOREIGN KEY (i_to) REFERENCES tbl_epos(i_machine_id) MATCH FULL;


--
-- TOC entry 2004 (class 2606 OID 65994)
-- Name: fk_live_path_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_live_path
    ADD CONSTRAINT fk_live_path_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2005 (class 2606 OID 65999)
-- Name: fk_mapping_card_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_card_id FOREIGN KEY (c_card_id) REFERENCES tbl_card(c_card_id) MATCH FULL;


--
-- TOC entry 2006 (class 2606 OID 66004)
-- Name: fk_mapping_do_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_do_id FOREIGN KEY (i_do_id) REFERENCES tbl_do(i_do_id) MATCH FULL;


--
-- TOC entry 2007 (class 2606 OID 66009)
-- Name: fk_mapping_driver_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_driver_id FOREIGN KEY (i_driver_id) REFERENCES tbl_driver(i_driver_id) MATCH FULL;


--
-- TOC entry 2008 (class 2606 OID 66014)
-- Name: fk_mapping_path_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_path_id FOREIGN KEY (i_path_id) REFERENCES tbl_live_path(i_path_id);


--
-- TOC entry 2009 (class 2606 OID 66019)
-- Name: fk_mapping_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2010 (class 2606 OID 66024)
-- Name: fk_mapping_process_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_process_id FOREIGN KEY (i_process_id) REFERENCES tbl_process(i_process_id) MATCH FULL;


--
-- TOC entry 2011 (class 2606 OID 66029)
-- Name: fk_mapping_transporter_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_transporter_id FOREIGN KEY (i_transporter_id) REFERENCES tbl_transporter(i_transporter_id) MATCH FULL;


--
-- TOC entry 2012 (class 2606 OID 66034)
-- Name: fk_mapping_vehicle_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_mapping
    ADD CONSTRAINT fk_mapping_vehicle_id FOREIGN KEY (t_vehicle_id) REFERENCES tbl_vehicle(t_vehicle_id) MATCH FULL;


--
-- TOC entry 2013 (class 2606 OID 66039)
-- Name: fk_paths_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_paths
    ADD CONSTRAINT fk_paths_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2014 (class 2606 OID 66044)
-- Name: fk_process_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_process
    ADD CONSTRAINT fk_process_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2015 (class 2606 OID 66049)
-- Name: fk_transporter_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_transporter
    ADD CONSTRAINT fk_transporter_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2016 (class 2606 OID 66054)
-- Name: fk_users_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_users
    ADD CONSTRAINT fk_users_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2019 (class 2606 OID 66059)
-- Name: fk_vehicle_card_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_vehicle_flight
    ADD CONSTRAINT fk_vehicle_card_id FOREIGN KEY (c_card_id) REFERENCES tbl_card(c_card_id) MATCH FULL;


--
-- TOC entry 2020 (class 2606 OID 66064)
-- Name: fk_vehicle_flight_m_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_vehicle_flight
    ADD CONSTRAINT fk_vehicle_flight_m_id FOREIGN KEY (i_machine_id) REFERENCES tbl_epos(i_machine_id) MATCH FULL;


--
-- TOC entry 2021 (class 2606 OID 66069)
-- Name: fk_vehicle_flight_trip_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_vehicle_flight
    ADD CONSTRAINT fk_vehicle_flight_trip_id FOREIGN KEY (i_trip_id) REFERENCES tbl_mapping(i_trip_id) MATCH FULL;


--
-- TOC entry 2017 (class 2606 OID 66074)
-- Name: fk_vehicle_plant_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_vehicle
    ADD CONSTRAINT fk_vehicle_plant_id FOREIGN KEY (i_plant_id) REFERENCES tbl_plant(i_plant_id) MATCH FULL;


--
-- TOC entry 2018 (class 2606 OID 66079)
-- Name: fk_vehicle_transporter_id; Type: FK CONSTRAINT; Schema: pr_inplant; Owner: postgres
--

ALTER TABLE ONLY tbl_vehicle
    ADD CONSTRAINT fk_vehicle_transporter_id FOREIGN KEY (i_transporter_id) REFERENCES tbl_transporter(i_transporter_id) MATCH FULL;


-- Completed on 2015-06-06 16:07:59

--
-- PostgreSQL database dump complete
--

