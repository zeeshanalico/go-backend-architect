--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: ExpenseType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ExpenseType" AS ENUM (
    'SALARY',
    'RENT',
    'UTILITY',
    'FOOD',
    'TRAVEL',
    'OTHER'
);


--
-- Name: InternalUserRole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InternalUserRole" AS ENUM (
    'ADMIN',
    'SUPER_ADMIN'
);


--
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TransactionType" AS ENUM (
    'CREDIT',
    'DEBIT'
);


--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UserRole" AS ENUM (
    'USER'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: batch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch (
    id integer NOT NULL,
    product_id integer,
    quantity integer NOT NULL,
    cost_price numeric(10,2) NOT NULL,
    purchase_id integer,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Batch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Batch_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Batch_id_seq" OWNED BY public.batch.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public.category.id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    secret character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    is_active boolean DEFAULT true,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Customer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Customer_id_seq" OWNED BY public.customer.id;


--
-- Name: expense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expense (
    id integer NOT NULL,
    kiosk_id integer,
    amount numeric(10,2) NOT NULL,
    expense_date timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description text,
    expense_type public."ExpenseType" NOT NULL,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Expense_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Expense_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Expense_id_seq" OWNED BY public.expense.id;


--
-- Name: internal_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.internal_user (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role public."InternalUserRole" NOT NULL,
    is_active boolean DEFAULT true,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Internal_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Internal_user_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Internal_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Internal_user_id_seq" OWNED BY public.internal_user.id;


--
-- Name: journal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journal (
    id integer NOT NULL,
    kiosk_id integer,
    amount numeric(10,2) NOT NULL,
    trx_type public."TransactionType" NOT NULL,
    account character varying(50) NOT NULL,
    description text,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Journal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Journal_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Journal_id_seq" OWNED BY public.journal.id;


--
-- Name: kiosk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kiosk (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255),
    registered_by integer,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Kiosk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Kiosk_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Kiosk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Kiosk_id_seq" OWNED BY public.kiosk.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    id integer NOT NULL,
    category_id integer,
    name character varying(255) NOT NULL,
    sale_price numeric(10,2) NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    image_url text,
    kiosk_id integer,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public.product.id;


--
-- Name: purchase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    user_id integer,
    kiosk_id integer,
    purchase_date timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    amount numeric(10,2) NOT NULL,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Purchase_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Purchase_id_seq" OWNED BY public.purchase.id;


--
-- Name: sale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale (
    id integer NOT NULL,
    customer_id integer,
    kiosk_id integer,
    sub_total numeric(10,2) NOT NULL,
    discount numeric(10,2) DEFAULT 0 NOT NULL,
    total numeric(10,2) NOT NULL,
    qty integer NOT NULL,
    sale_date timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Sale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Sale_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Sale_id_seq" OWNED BY public.sale.id;


--
-- Name: sale_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_product (
    id integer NOT NULL,
    sale_id integer,
    product_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    discount numeric(10,2) DEFAULT 0 NOT NULL,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Sale_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Sale_product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Sale_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Sale_product_id_seq" OWNED BY public.sale_product.id;


--
-- Name: trx; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trx (
    id integer NOT NULL,
    kiosk_id integer,
    amount numeric(10,2) NOT NULL,
    customer_id integer,
    vendor_id integer,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Trx_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Trx_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Trx_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Trx_id_seq" OWNED BY public.trx.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    kiosk_id integer,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role public."UserRole" NOT NULL,
    is_active boolean DEFAULT true,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."user".id;


--
-- Name: vendor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vendor (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_info character varying(255),
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: Vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Vendor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Vendor_id_seq" OWNED BY public.vendor.id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: vendor_product_purchase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vendor_product_purchase (
    id integer NOT NULL,
    vendor_id integer,
    purchase_id integer,
    product_id integer,
    qty integer NOT NULL,
    cost_price numeric(10,2) NOT NULL,
    is_dummy boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp(6) without time zone
);


--
-- Name: vendor_product_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendor_product_purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_product_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendor_product_purchase_id_seq OWNED BY public.vendor_product_purchase.id;


--
-- Name: batch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch ALTER COLUMN id SET DEFAULT nextval('public."Batch_id_seq"'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public."Customer_id_seq"'::regclass);


--
-- Name: expense id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expense ALTER COLUMN id SET DEFAULT nextval('public."Expense_id_seq"'::regclass);


--
-- Name: internal_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.internal_user ALTER COLUMN id SET DEFAULT nextval('public."Internal_user_id_seq"'::regclass);


--
-- Name: journal id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journal ALTER COLUMN id SET DEFAULT nextval('public."Journal_id_seq"'::regclass);


--
-- Name: kiosk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kiosk ALTER COLUMN id SET DEFAULT nextval('public."Kiosk_id_seq"'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public."Purchase_id_seq"'::regclass);


--
-- Name: sale id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale ALTER COLUMN id SET DEFAULT nextval('public."Sale_id_seq"'::regclass);


--
-- Name: sale_product id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_product ALTER COLUMN id SET DEFAULT nextval('public."Sale_product_id_seq"'::regclass);


--
-- Name: trx id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trx ALTER COLUMN id SET DEFAULT nextval('public."Trx_id_seq"'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: vendor id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor ALTER COLUMN id SET DEFAULT nextval('public."Vendor_id_seq"'::regclass);


--
-- Name: vendor_product_purchase id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_product_purchase ALTER COLUMN id SET DEFAULT nextval('public.vendor_product_purchase_id_seq'::regclass);


--
-- Name: batch Batch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT "Batch_pkey" PRIMARY KEY (id);


--
-- Name: category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: expense Expense_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expense
    ADD CONSTRAINT "Expense_pkey" PRIMARY KEY (id);


--
-- Name: internal_user Internal_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.internal_user
    ADD CONSTRAINT "Internal_user_pkey" PRIMARY KEY (id);


--
-- Name: journal Journal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journal
    ADD CONSTRAINT "Journal_pkey" PRIMARY KEY (id);


--
-- Name: kiosk Kiosk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kiosk
    ADD CONSTRAINT "Kiosk_pkey" PRIMARY KEY (id);


--
-- Name: product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: purchase Purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "Purchase_pkey" PRIMARY KEY (id);


--
-- Name: sale Sale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT "Sale_pkey" PRIMARY KEY (id);


--
-- Name: sale_product Sale_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_product
    ADD CONSTRAINT "Sale_product_pkey" PRIMARY KEY (id);


--
-- Name: trx Trx_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trx
    ADD CONSTRAINT "Trx_pkey" PRIMARY KEY (id);


--
-- Name: user User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: vendor Vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor
    ADD CONSTRAINT "Vendor_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: vendor_product_purchase vendor_product_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_product_purchase
    ADD CONSTRAINT vendor_product_purchase_pkey PRIMARY KEY (id);


--
-- Name: Category_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Category_name_key" ON public.category USING btree (name);


--
-- Name: Customer_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Customer_email_key" ON public.customer USING btree (email);


--
-- Name: Internal_user_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Internal_user_email_key" ON public.internal_user USING btree (email);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."user" USING btree (email);


--
-- Name: batch Batch_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT "Batch_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: batch Batch_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT "Batch_purchase_id_fkey" FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) ON DELETE CASCADE;


--
-- Name: expense Expense_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expense
    ADD CONSTRAINT "Expense_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE SET NULL;


--
-- Name: journal Journal_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journal
    ADD CONSTRAINT "Journal_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE SET NULL;


--
-- Name: kiosk Kiosk_registered_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kiosk
    ADD CONSTRAINT "Kiosk_registered_by_fkey" FOREIGN KEY (registered_by) REFERENCES public.internal_user(id) ON DELETE SET NULL;


--
-- Name: product Product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE CASCADE;


--
-- Name: product Product_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "Product_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE CASCADE;


--
-- Name: purchase Purchase_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "Purchase_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE CASCADE;


--
-- Name: purchase Purchase_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "Purchase_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL;


--
-- Name: sale Sale_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT "Sale_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE SET NULL;


--
-- Name: sale Sale_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT "Sale_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE CASCADE;


--
-- Name: sale_product Sale_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_product
    ADD CONSTRAINT "Sale_product_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE SET NULL;


--
-- Name: sale_product Sale_product_sale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_product
    ADD CONSTRAINT "Sale_product_sale_id_fkey" FOREIGN KEY (sale_id) REFERENCES public.sale(id) ON DELETE CASCADE;


--
-- Name: trx Trx_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trx
    ADD CONSTRAINT "Trx_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE SET NULL;


--
-- Name: trx Trx_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trx
    ADD CONSTRAINT "Trx_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE SET NULL;


--
-- Name: trx Trx_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trx
    ADD CONSTRAINT "Trx_vendor_id_fkey" FOREIGN KEY (vendor_id) REFERENCES public.vendor(id) ON DELETE SET NULL;


--
-- Name: user User_kiosk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "User_kiosk_id_fkey" FOREIGN KEY (kiosk_id) REFERENCES public.kiosk(id) ON DELETE SET NULL;


--
-- Name: vendor_product_purchase vendor_product_purchase_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_product_purchase
    ADD CONSTRAINT vendor_product_purchase_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: vendor_product_purchase vendor_product_purchase_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_product_purchase
    ADD CONSTRAINT vendor_product_purchase_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) ON DELETE CASCADE;


--
-- Name: vendor_product_purchase vendor_product_purchase_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_product_purchase
    ADD CONSTRAINT vendor_product_purchase_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

