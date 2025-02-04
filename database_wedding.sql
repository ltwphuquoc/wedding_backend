PGDMP                          |         
   wedding_db    15.2    15.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    129507 
   wedding_db    DATABASE     �   CREATE DATABASE wedding_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE wedding_db;
                postgres    false                        2615    146976    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   postgres    false    5            �           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   postgres    false    5            m           1247    146978    GENDER_ENUM_TYPE    TYPE     Y   CREATE TYPE public."GENDER_ENUM_TYPE" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);
 %   DROP TYPE public."GENDER_ENUM_TYPE";
       public          postgres    false    5            p           1247    146986    ROLE    TYPE     C   CREATE TYPE public."ROLE" AS ENUM (
    'ADMIN',
    'CUSTOMER'
);
    DROP TYPE public."ROLE";
       public          postgres    false    5            y           1247    147010    STATUS_BOOKING    TYPE     z   CREATE TYPE public."STATUS_BOOKING" AS ENUM (
    'NEW',
    'PENDING',
    'APPROVED',
    'FINISHED',
    'REJECTED'
);
 #   DROP TYPE public."STATUS_BOOKING";
       public          postgres    false    5            v           1247    147004    STATUS_COMBO    TYPE     Q   CREATE TYPE public."STATUS_COMBO" AS ENUM (
    'CUSTOMIZED',
    'AVAILABLE'
);
 !   DROP TYPE public."STATUS_COMBO";
       public          postgres    false    5            |           1247    147022    STATUS_PAYMENT    TYPE     Y   CREATE TYPE public."STATUS_PAYMENT" AS ENUM (
    'DEPOSIT',
    'PAID',
    'UNPAID'
);
 #   DROP TYPE public."STATUS_PAYMENT";
       public          postgres    false    5                       1247    147030    STATUS_USER    TYPE     K   CREATE TYPE public."STATUS_USER" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);
     DROP TYPE public."STATUS_USER";
       public          postgres    false    5            s           1247    146992    TYPE_NOTIFICATION    TYPE     N   CREATE TYPE public."TYPE_NOTIFICATION" AS ENUM (
    'INFO',
    'WARNING'
);
 &   DROP TYPE public."TYPE_NOTIFICATION";
       public          postgres    false    5            �            1259    147260    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    postgres    false    5            �            1259    147085    booking    TABLE     V  CREATE TABLE public.booking (
    id integer NOT NULL,
    "numberOfGuest" integer NOT NULL,
    "depositMoney" integer NOT NULL,
    "totalMoney" integer NOT NULL,
    "toTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "comeInAt" timestamp(3) without time zone NOT NULL,
    "comeOutAt" timestamp(3) without time zone NOT NULL,
    number_table integer NOT NULL,
    "userId" integer NOT NULL,
    "comboMenuId" integer NOT NULL,
    "serviceId" integer NOT NULL,
    "statusBooking" public."STATUS_BOOKING" DEFAULT 'NEW'::public."STATUS_BOOKING" NOT NULL,
    "statusPayment" public."STATUS_PAYMENT" DEFAULT 'UNPAID'::public."STATUS_PAYMENT" NOT NULL,
    "zoneId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.booking;
       public         heap    postgres    false    889    892    889    892    5            �            1259    147084    booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.booking_id_seq;
       public          postgres    false    223    5            �           0    0    booking_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;
          public          postgres    false    222            �            1259    147114    combo_items    TABLE     �  CREATE TABLE public.combo_items (
    id integer NOT NULL,
    quantity integer NOT NULL,
    "totalPrice" integer NOT NULL,
    "menuItemId" integer NOT NULL,
    "comboMenuId" integer,
    "comboCustomizedMenuId" integer,
    status public."STATUS_COMBO" DEFAULT 'AVAILABLE'::public."STATUS_COMBO" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.combo_items;
       public         heap    postgres    false    886    5    886            �            1259    147113    combo_items_id_seq    SEQUENCE     �   CREATE SEQUENCE public.combo_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.combo_items_id_seq;
       public          postgres    false    5    229            �           0    0    combo_items_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.combo_items_id_seq OWNED BY public.combo_items.id;
          public          postgres    false    228            �            1259    147096    combo_menus    TABLE     A  CREATE TABLE public.combo_menus (
    id integer NOT NULL,
    "comboName" text NOT NULL,
    description text NOT NULL,
    "totalPrice" integer,
    "serviceId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.combo_menus;
       public         heap    postgres    false    5            �            1259    147095    combo_menus_id_seq    SEQUENCE     �   CREATE SEQUENCE public.combo_menus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.combo_menus_id_seq;
       public          postgres    false    225    5            �           0    0    combo_menus_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.combo_menus_id_seq OWNED BY public.combo_menus.id;
          public          postgres    false    224            �            1259    147106    customized_combo_menus    TABLE     7  CREATE TABLE public.customized_combo_menus (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "comboMenuId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    "bookingId" integer NOT NULL
);
 *   DROP TABLE public.customized_combo_menus;
       public         heap    postgres    false    5            �            1259    147105    customized_combo_menus_id_seq    SEQUENCE     �   CREATE SEQUENCE public.customized_combo_menus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.customized_combo_menus_id_seq;
       public          postgres    false    5    227            �           0    0    customized_combo_menus_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.customized_combo_menus_id_seq OWNED BY public.customized_combo_menus.id;
          public          postgres    false    226            �            1259    147075 	   feedbacks    TABLE     >  CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    "userId" integer NOT NULL,
    "bookingId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.feedbacks;
       public         heap    postgres    false    5            �            1259    147074    feedbacks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.feedbacks_id_seq;
       public          postgres    false    221    5            �           0    0    feedbacks_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;
          public          postgres    false    220            �            1259    147123 	   menu_item    TABLE     D  CREATE TABLE public.menu_item (
    id integer NOT NULL,
    "dishName" text NOT NULL,
    description text,
    price integer NOT NULL,
    image text,
    "typeId" integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.menu_item;
       public         heap    postgres    false    5            �            1259    147122    menu_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.menu_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.menu_item_id_seq;
       public          postgres    false    231    5            �           0    0    menu_item_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.menu_item_id_seq OWNED BY public.menu_item.id;
          public          postgres    false    230            �            1259    147164    notifications    TABLE     �  CREATE TABLE public.notifications (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    "userId" integer NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    type public."TYPE_NOTIFICATION" DEFAULT 'INFO'::public."TYPE_NOTIFICATION" NOT NULL,
    link text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 !   DROP TABLE public.notifications;
       public         heap    postgres    false    883    5    883            �            1259    147163    notifications_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.notifications_id_seq;
       public          postgres    false    239    5            �           0    0    notifications_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;
          public          postgres    false    238            �            1259    147154    restaurant_information    TABLE     
  CREATE TABLE public.restaurant_information (
    id integer NOT NULL,
    filed text NOT NULL,
    description text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
 *   DROP TABLE public.restaurant_information;
       public         heap    postgres    false    5            �            1259    147153    restaurant_information_id_seq    SEQUENCE     �   CREATE SEQUENCE public.restaurant_information_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.restaurant_information_id_seq;
       public          postgres    false    237    5            �           0    0    restaurant_information_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.restaurant_information_id_seq OWNED BY public.restaurant_information.id;
          public          postgres    false    236            �            1259    147048    roles    TABLE     �   CREATE TABLE public.roles (
    id integer NOT NULL,
    "roleName" public."ROLE" DEFAULT 'CUSTOMER'::public."ROLE" NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false    880    5    880            �            1259    147047    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    5    217            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    216            �            1259    147143    services    TABLE     �  CREATE TABLE public.services (
    id integer NOT NULL,
    "serviceName" text NOT NULL,
    price integer NOT NULL,
    capacity integer NOT NULL,
    image text DEFAULT 'https://img.freepik.com/free-vector/young-waitress-waiter-object-element-professional-service-restaurant_24797-2133.jpg'::text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.services;
       public         heap    postgres    false    5            �            1259    147142    services_id_seq    SEQUENCE     �   CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.services_id_seq;
       public          postgres    false    235    5            �           0    0    services_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;
          public          postgres    false    234            �            1259    147133 	   type_dish    TABLE     �   CREATE TABLE public.type_dish (
    id integer NOT NULL,
    "typeName" text NOT NULL,
    description text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);
    DROP TABLE public.type_dish;
       public         heap    postgres    false    5            �            1259    147132    type_dish_id_seq    SEQUENCE     �   CREATE SEQUENCE public.type_dish_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.type_dish_id_seq;
       public          postgres    false    5    233            �           0    0    type_dish_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.type_dish_id_seq OWNED BY public.type_dish.id;
          public          postgres    false    232            �            1259    147036    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    phone text,
    image text DEFAULT 'https://haycafe.vn/wp-content/uploads/2023/04/Hinh-anh-avatar-cute-TikTok-nam.jpg'::text,
    email text NOT NULL,
    "dateOfBirth" timestamp(3) without time zone,
    gender public."GENDER_ENUM_TYPE",
    password text NOT NULL,
    status public."STATUS_USER" DEFAULT 'ACTIVE'::public."STATUS_USER" NOT NULL,
    address text,
    "hashedRt" text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    "roleId" integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    895    5    895    877            �            1259    147035    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    215    5            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    214            �            1259    147056    zones    TABLE     �   CREATE TABLE public.zones (
    id integer NOT NULL,
    "zoneName" text NOT NULL,
    "priceRent" integer,
    "numberRoom" integer NOT NULL
);
    DROP TABLE public.zones;
       public         heap    postgres    false    5            �            1259    147055    zones_id_seq    SEQUENCE     �   CREATE SEQUENCE public.zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.zones_id_seq;
       public          postgres    false    5    219            �           0    0    zones_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.zones_id_seq OWNED BY public.zones.id;
          public          postgres    false    218            �           2604    147268 
   booking id    DEFAULT     h   ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);
 9   ALTER TABLE public.booking ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    147269    combo_items id    DEFAULT     p   ALTER TABLE ONLY public.combo_items ALTER COLUMN id SET DEFAULT nextval('public.combo_items_id_seq'::regclass);
 =   ALTER TABLE public.combo_items ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    229    229            �           2604    147270    combo_menus id    DEFAULT     p   ALTER TABLE ONLY public.combo_menus ALTER COLUMN id SET DEFAULT nextval('public.combo_menus_id_seq'::regclass);
 =   ALTER TABLE public.combo_menus ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    147271    customized_combo_menus id    DEFAULT     �   ALTER TABLE ONLY public.customized_combo_menus ALTER COLUMN id SET DEFAULT nextval('public.customized_combo_menus_id_seq'::regclass);
 H   ALTER TABLE public.customized_combo_menus ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    147273    feedbacks id    DEFAULT     l   ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);
 ;   ALTER TABLE public.feedbacks ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            �           2604    147274    menu_item id    DEFAULT     l   ALTER TABLE ONLY public.menu_item ALTER COLUMN id SET DEFAULT nextval('public.menu_item_id_seq'::regclass);
 ;   ALTER TABLE public.menu_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    147275    notifications id    DEFAULT     t   ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);
 ?   ALTER TABLE public.notifications ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            �           2604    147276    restaurant_information id    DEFAULT     �   ALTER TABLE ONLY public.restaurant_information ALTER COLUMN id SET DEFAULT nextval('public.restaurant_information_id_seq'::regclass);
 H   ALTER TABLE public.restaurant_information ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    147277    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    147278    services id    DEFAULT     j   ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);
 :   ALTER TABLE public.services ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    234    235            �           2604    147279    type_dish id    DEFAULT     l   ALTER TABLE ONLY public.type_dish ALTER COLUMN id SET DEFAULT nextval('public.type_dish_id_seq'::regclass);
 ;   ALTER TABLE public.type_dish ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            �           2604    147280    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    147281    zones id    DEFAULT     d   ALTER TABLE ONLY public.zones ALTER COLUMN id SET DEFAULT nextval('public.zones_id_seq'::regclass);
 7   ALTER TABLE public.zones ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �          0    147260    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          postgres    false    240   t�       �          0    147085    booking 
   TABLE DATA           �   COPY public.booking (id, "numberOfGuest", "depositMoney", "totalMoney", "toTime", "comeInAt", "comeOutAt", number_table, "userId", "comboMenuId", "serviceId", "statusBooking", "statusPayment", "zoneId", created_at, updated_at) FROM stdin;
    public          postgres    false    223   դ       �          0    147114    combo_items 
   TABLE DATA           �   COPY public.combo_items (id, quantity, "totalPrice", "menuItemId", "comboMenuId", "comboCustomizedMenuId", status, created_at, updated_at) FROM stdin;
    public          postgres    false    229    �       �          0    147096    combo_menus 
   TABLE DATA           v   COPY public.combo_menus (id, "comboName", description, "totalPrice", "serviceId", created_at, updated_at) FROM stdin;
    public          postgres    false    225   �       �          0    147106    customized_combo_menus 
   TABLE DATA           r   COPY public.customized_combo_menus (id, "userId", "comboMenuId", created_at, updated_at, "bookingId") FROM stdin;
    public          postgres    false    227   ��       �          0    147075 	   feedbacks 
   TABLE DATA           g   COPY public.feedbacks (id, rating, comment, "userId", "bookingId", created_at, updated_at) FROM stdin;
    public          postgres    false    221   �       �          0    147123 	   menu_item 
   TABLE DATA           p   COPY public.menu_item (id, "dishName", description, price, image, "typeId", created_at, updated_at) FROM stdin;
    public          postgres    false    231   �       �          0    147164    notifications 
   TABLE DATA           w   COPY public.notifications (id, title, description, "userId", "isRead", type, link, created_at, updated_at) FROM stdin;
    public          postgres    false    239   �       �          0    147154    restaurant_information 
   TABLE DATA           `   COPY public.restaurant_information (id, filed, description, created_at, updated_at) FROM stdin;
    public          postgres    false    237   K�       �          0    147048    roles 
   TABLE DATA           /   COPY public.roles (id, "roleName") FROM stdin;
    public          postgres    false    217   h�       �          0    147143    services 
   TABLE DATA           e   COPY public.services (id, "serviceName", price, capacity, image, created_at, updated_at) FROM stdin;
    public          postgres    false    235   ��       �          0    147133 	   type_dish 
   TABLE DATA           X   COPY public.type_dish (id, "typeName", description, created_at, updated_at) FROM stdin;
    public          postgres    false    233   ��       �          0    147036    users 
   TABLE DATA           �   COPY public.users (id, name, phone, image, email, "dateOfBirth", gender, password, status, address, "hashedRt", created_at, updated_at, "roleId") FROM stdin;
    public          postgres    false    215   ��       �          0    147056    zones 
   TABLE DATA           J   COPY public.zones (id, "zoneName", "priceRent", "numberRoom") FROM stdin;
    public          postgres    false    219   �       �           0    0    booking_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.booking_id_seq', 24, true);
          public          postgres    false    222            �           0    0    combo_items_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.combo_items_id_seq', 76, true);
          public          postgres    false    228            �           0    0    combo_menus_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.combo_menus_id_seq', 8, true);
          public          postgres    false    224            �           0    0    customized_combo_menus_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.customized_combo_menus_id_seq', 5, true);
          public          postgres    false    226            �           0    0    feedbacks_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.feedbacks_id_seq', 4, true);
          public          postgres    false    220            �           0    0    menu_item_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.menu_item_id_seq', 71, true);
          public          postgres    false    230            �           0    0    notifications_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.notifications_id_seq', 6, true);
          public          postgres    false    238            �           0    0    restaurant_information_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.restaurant_information_id_seq', 1, false);
          public          postgres    false    236            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
          public          postgres    false    216            �           0    0    services_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.services_id_seq', 11, true);
          public          postgres    false    234            �           0    0    type_dish_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.type_dish_id_seq', 12, true);
          public          postgres    false    232            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 5, true);
          public          postgres    false    214            �           0    0    zones_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.zones_id_seq', 2, true);
          public          postgres    false    218            �           2606    147283 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    240            �           2606    147094    booking booking_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_pkey;
       public            postgres    false    223            �           2606    147121    combo_items combo_items_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.combo_items
    ADD CONSTRAINT combo_items_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.combo_items DROP CONSTRAINT combo_items_pkey;
       public            postgres    false    229            �           2606    147104    combo_menus combo_menus_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.combo_menus
    ADD CONSTRAINT combo_menus_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.combo_menus DROP CONSTRAINT combo_menus_pkey;
       public            postgres    false    225            �           2606    147112 2   customized_combo_menus customized_combo_menus_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.customized_combo_menus
    ADD CONSTRAINT customized_combo_menus_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.customized_combo_menus DROP CONSTRAINT customized_combo_menus_pkey;
       public            postgres    false    227            �           2606    147083    feedbacks feedbacks_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT feedbacks_pkey;
       public            postgres    false    221            �           2606    147131    menu_item menu_item_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT menu_item_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.menu_item DROP CONSTRAINT menu_item_pkey;
       public            postgres    false    231            �           2606    147174     notifications notifications_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public            postgres    false    239            �           2606    147162 2   restaurant_information restaurant_information_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.restaurant_information
    ADD CONSTRAINT restaurant_information_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.restaurant_information DROP CONSTRAINT restaurant_information_pkey;
       public            postgres    false    237            �           2606    147054    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    217            �           2606    147152    services services_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.services DROP CONSTRAINT services_pkey;
       public            postgres    false    235            �           2606    147141    type_dish type_dish_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.type_dish
    ADD CONSTRAINT type_dish_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.type_dish DROP CONSTRAINT type_dish_pkey;
       public            postgres    false    233            �           2606    147046    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2606    147063    zones zones_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.zones DROP CONSTRAINT zones_pkey;
       public            postgres    false    219            �           1259    147178 $   customized_combo_menus_bookingId_key    INDEX     w   CREATE UNIQUE INDEX "customized_combo_menus_bookingId_key" ON public.customized_combo_menus USING btree ("bookingId");
 :   DROP INDEX public."customized_combo_menus_bookingId_key";
       public            postgres    false    227            �           1259    147176    feedbacks_bookingId_key    INDEX     ]   CREATE UNIQUE INDEX "feedbacks_bookingId_key" ON public.feedbacks USING btree ("bookingId");
 -   DROP INDEX public."feedbacks_bookingId_key";
       public            postgres    false    221            �           1259    147175    users_email_key    INDEX     I   CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);
 #   DROP INDEX public.users_email_key;
       public            postgres    false    215                        2606    147199     booking booking_comboMenuId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT "booking_comboMenuId_fkey" FOREIGN KEY ("comboMenuId") REFERENCES public.combo_menus(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.booking DROP CONSTRAINT "booking_comboMenuId_fkey";
       public          postgres    false    223    225    3307                       2606    147204    booking booking_serviceId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT "booking_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public.services(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.booking DROP CONSTRAINT "booking_serviceId_fkey";
       public          postgres    false    223    3318    235                       2606    147194    booking booking_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT "booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.booking DROP CONSTRAINT "booking_userId_fkey";
       public          postgres    false    3296    215    223                       2606    147209    booking booking_zoneId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT "booking_zoneId_fkey" FOREIGN KEY ("zoneId") REFERENCES public.zones(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.booking DROP CONSTRAINT "booking_zoneId_fkey";
       public          postgres    false    219    223    3300                       2606    147244 2   combo_items combo_items_comboCustomizedMenuId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.combo_items
    ADD CONSTRAINT "combo_items_comboCustomizedMenuId_fkey" FOREIGN KEY ("comboCustomizedMenuId") REFERENCES public.customized_combo_menus(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.combo_items DROP CONSTRAINT "combo_items_comboCustomizedMenuId_fkey";
       public          postgres    false    229    3310    227            	           2606    147239 (   combo_items combo_items_comboMenuId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.combo_items
    ADD CONSTRAINT "combo_items_comboMenuId_fkey" FOREIGN KEY ("comboMenuId") REFERENCES public.combo_menus(id) ON UPDATE CASCADE ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.combo_items DROP CONSTRAINT "combo_items_comboMenuId_fkey";
       public          postgres    false    229    3307    225            
           2606    147234 '   combo_items combo_items_menuItemId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.combo_items
    ADD CONSTRAINT "combo_items_menuItemId_fkey" FOREIGN KEY ("menuItemId") REFERENCES public.menu_item(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.combo_items DROP CONSTRAINT "combo_items_menuItemId_fkey";
       public          postgres    false    231    3314    229                       2606    147214 &   combo_menus combo_menus_serviceId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.combo_menus
    ADD CONSTRAINT "combo_menus_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public.services(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.combo_menus DROP CONSTRAINT "combo_menus_serviceId_fkey";
       public          postgres    false    3318    225    235                       2606    147229 <   customized_combo_menus customized_combo_menus_bookingId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customized_combo_menus
    ADD CONSTRAINT "customized_combo_menus_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public.booking(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 h   ALTER TABLE ONLY public.customized_combo_menus DROP CONSTRAINT "customized_combo_menus_bookingId_fkey";
       public          postgres    false    227    3305    223                       2606    147224 >   customized_combo_menus customized_combo_menus_comboMenuId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customized_combo_menus
    ADD CONSTRAINT "customized_combo_menus_comboMenuId_fkey" FOREIGN KEY ("comboMenuId") REFERENCES public.combo_menus(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 j   ALTER TABLE ONLY public.customized_combo_menus DROP CONSTRAINT "customized_combo_menus_comboMenuId_fkey";
       public          postgres    false    3307    227    225                       2606    147219 9   customized_combo_menus customized_combo_menus_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customized_combo_menus
    ADD CONSTRAINT "customized_combo_menus_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 e   ALTER TABLE ONLY public.customized_combo_menus DROP CONSTRAINT "customized_combo_menus_userId_fkey";
       public          postgres    false    215    3296    227            �           2606    147189 "   feedbacks feedbacks_bookingId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "feedbacks_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public.booking(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT "feedbacks_bookingId_fkey";
       public          postgres    false    3305    221    223            �           2606    147184    feedbacks feedbacks_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "feedbacks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT "feedbacks_userId_fkey";
       public          postgres    false    215    221    3296                       2606    147249    menu_item menu_item_typeId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT "menu_item_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES public.type_dish(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.menu_item DROP CONSTRAINT "menu_item_typeId_fkey";
       public          postgres    false    231    3316    233                       2606    147254 '   notifications notifications_userId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.notifications DROP CONSTRAINT "notifications_userId_fkey";
       public          postgres    false    239    3296    215            �           2606    147179    users users_roleId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT "users_roleId_fkey";
       public          postgres    false    217    3298    215            �   Q  x�}�Kj\AE�ݫ��T#��)yY���(��~�����1�f��9�B��Yz5),�%"��K��才\�WmQ)���҃L{�c��ԙ�]�-��e�:P-��#�#�ő���_p�Ҷ�⺶��em��/����v�B�#��B��+f�"I�/��,�'��D�;�1Ѐ�so��tMe�6ydN�C9"�FD�6��b�W!%��D���o�E����-:J�"=Z��4�U�ڂ�h��$���X݂d�����)B6�6�r�EՇ44ˌ@�P��4��`x� �}���^����|]�[����o������ڗ���|>&�#      �     x���K�1���)� ��e�������L6��9Rnh�m�$Ч~|����A���)�/JB��OD�G��b�˷cPi`|e�������������/����ŸC�L5r(#�R���D�Yڛ4R��p�f,���@�W�*r�y�S%	��9͎A9�We-ڹ��[���^YYĲ{9��߾L�p<�}�>�x�J�!l�V� V��(���Z��}G�D��`P3��ױ}�Ž�}�ۯ�m�)�T���>��uZQjɄx��=ĭޅ�Ȭ�����ҽO̬�f��0@�g�[6,�R�< ��h:)��&L֬-e�{?�լU>>��%)X9 �v>�[\�dk6o��?2Z�t�I�Xw����ɸx��8�؂&)>��d.LGx��f�@�����%��V-U�2y�B�4g�Ff���#�u4^Gt�=�>te�|0iR��=��91��CoFH���h�0���ڇ~�(`X;�h(Y��@[c0eo��ΥIۺ���~š�VFk�񚭶$�X!��-A����R�8������U�      �   �  x���;��0�Z:�/�E�ԣ�$[,�I�<�`��H��XM��=�/��.��s�}�p�����Ǘ�W���B�%�ơr������97-��%+c>Z˨�kǇ*�Zp�2����"�}�3,R岓�U��8��8�k�>NFk�0������4���M�<�h�i\�vͶ���][�\Fok�j�K�9�('=jS}se`�z�$�_�� G���S-V�{n'֢�E.�B���c�2��|�X?1��`��i��J�1��qU�R.5����c����`���!rN��<Q�y�����_�~�����+MU�n�Vu�z)��e�0�.C��|�*̕y��f4��M�O���j-�{!^ս��� k|9{a.��X���kz_9��9�y���=h)�YlU��.�B�~5��m�T�wC�3Z �h���E�0���l��v0oTj�Ja�1��>�{�0Nn��4�H�f��C�������      �   �  x��TMk�0>˿����?�$>6;���N�8nk��r�ʁK=����a��&���+ka`1zP���?�+�Kc������x�$�t?���#%N�D�1��n�C���"9� ���������W�C��G�B�)��x���.�[%��w��C?��S/���DJ\��2U�ó0�I���R�$.u�m�l;.�N��i7w�Mu�'Oq�>�+q���c��%�Sa�'���AO^��o����x8*�t��*�t�W,	3�X���gi.g��O� 熳_��|��=�P%.#b�z������&�R�xm_�o�Hz4p�6�뢬�V�t4���4#�k����c���W�|����d	��G[��(g�r�{���	�Q28T�=GEd=dF���g0ԞG��WaԞ�ġN[Юu�c7Zަ��C���r*o8��S�� 5_#^ˋ��J|N��^���Ą�B�0�,/�5'W�Ѻ�d�sy���|c�C�`������T����g�|u��8�l5I�Ճ�}��s[NV>VV�h_�Q������Q�6��	��������'&�&��Y�oB~�0,������2�(�������q�B�Z�Z��2�c���x�8g[��r4o9�t��u0�<��B��wk��37DO�[Fڜ��&���6P4�jS�o�[�l˲� �(�      �   R   x�}˹�0��Pb�:����agr�f��i��EWtDî��������o��r������g4k�Y
q���K���^R      �   �   x�u�1n�@E��S=X����)�A[�VĄ��R�F�PDH(鼥��7ɄH�����y�r5k�.oϾ���/<�������L�b�T��;�R�����/��%8��j0P��(JɌR!�͍%J��r�y!��:����Ģ��lb��>W��1lY�ث�,'I>?ʵֿ��iS��ٝcع!����w�J�1�_�Y���� N-�R��G��'Z�(�      �   �  x��Xˎ��]�_Q�aWYj�H�@���"��HJ��!����,#Fx�i��aÎg� "/d��OrII-6%���fՑ}O�{�=�W>ܿFM�ES��W�Q�\��@3?�����M��
ac�xyg�����4{�%+�jv�%Ed��;?�\箈W�5�+����P�������w���t?�Z�>��̛�U�-bW������#�':�D����UC(?�?@���ԟ�O.h�����i��>rQ�7�����U��� �L�!E^���9���b��~G�R�]h��[�jH���w>r��������� ͚����b�����3��|_5�P	�}�P�쾏J�Ȥ��Lכ�ai-�j�	��B�ѥCZƄ����1y����	-��c��Կϑ���3ЅN��D~��1��4�5;Ú3�	!c��2����ߢ_���9�KW����l���c���Ѵ���P�V���t��)F�H�t����U��٢�h^RaB����(/��
�ٿ�ȗ�����.� �S���y�-Z5����01Fb����HT�_T���3�)���U�adBt��>�*����]���:��[.��R��Y)�Ji`L�$Rw�DT�fU�/�U\%"�H���C��Eu>�*ӕ_Z����]��	{�O�i���a���e�),k�9������� �	�"5C�[���C�5��wA�x�]Gd�c�I�j9Olk�[����,fn6�(<�UL(Ѹq�턫�����M����P�0��(�7}}�/��d�(Y�/C� U�N�b������d>0�����M�C{@JF�m&?S��沲VI��l�n��m���-\���h�:B��X������jG���lߩ�a��eF�>G��_V��p1�d�z�f�|z����1�R#��*��KHG�
r���g�N�>�@S�ڼ�>��KȌ12j��,�<���"41^lb��u��4�p�p������:)ZA=���؅=}X�����tQ�a<���"�b�k��fʡ<<�*�]�++ꞇ:�]nr�r>��ꡥ��A�=#W��Ws�s?���,��:11����r���A��4:�@��7���oIX��N�gsxRC�D����S�V�FQx�9�.V1�G\�T�o��˶ãnq�I�C�C4������X��A����{��ʤҭ_�q�|f����c35��=�\d�3}���=B�Bg���.1��׹���]�������+���13/�lW���� ��o�^��݋x�B��Fh��%aFOǷ�6�f���i��qV�]v(���0��A
�� �#��~4@l}���"��f�:�Σ�r�ɶ���vm��*�`>w�1�3���7����v�b�Կ;��9bS�}�n9��e�-��9J�/�Îm>-"!W9��&�jؼ����jb��{�;ޠ��H�ۑ\�M软�W>�Wư�R7{E��"�q­����nl�i��NSL0�L|���r��;�CM�經��?�K��߅�>�(J����Ƀ�nog��k�82��ĝk�]�	W������l���<�뷓ko����O�g��Eߝ����������I2�'�+^�Ymҵ\�Ql�����	��pT���+�
m�~t�����,h����.�5�A)t�e6͒��_y���V��e�'\Dyپ;���va�����ڰi��bS��ɓ�V��K &¸uAXh�d�p�7������A      �   $  x�͓;j�@���S��ڷ��B�&6)R��%�+b�B�8�Hn`�"U �]���I��0�m ��7��1��U��,�5]q�U���3�̮)�������V��]���Ǜk�;�(Gi��HФOw�ݺ�~��u�uN��������0Ε���<�
;��º�fA�/s��y��s��e�"x6�Ć�"5A�r��9�0P�虖�f�(>r��Ԝia�$^<H?�x�����`*�8�\�z����_��5Ĉ
M��
sy�C����oq�Wi!���!���H��	C Sl�      �      x������ � �      �       x�3�t��u�2�tt�������� E�      �     x�͑=N�0�k�����O���"!y�&vp�E{ D����)@�K�h`v]�L3���H��RP�>��U� 5��� �鹀�q�� P]M6V�^�He��w�{Y9c��u��rV�y������le'�ý5�*�E�i�����;1Z��-��<Ŝ�!��5��G�2LĒ"�I��Kf�J	��r|�`���TЄDy��a�㗮�;������%
�"'�'Y��!��z�>�N�ӓ�n�yz���z2��(!aʖ8�!��n��      �   9  x�}��N�0���)��||�=2����%��D��\��100@�'�bbb@���E�&82 ��,�����~(NƏ7m�*f����@K�1(�N t�#��ۺ÷�=&������0��mR�+"tB9Qps5n�9^t�=��HJR��H�~����p�	��S*�QU쟽����gXyw.�w�d�0g��2Ǒ�|���DRmD�#����wOݡ��I��G*�/���  ��J"G�!�pT_LY6܌�����c����BIi��"��V��n�{×Ch���
Sjee)�"Y��A}(ɭ      �   �  x���Ko�V���S�`�^�"E*����?�h60`Å��A�]T]T����f:�~�x���ߤ0RF���v���s�����D����Pl*��l��|��3��-�w�$�I�o�8u�5� x 򝈄�S���;+���>;���t�'�Y@�S�C�8Q̹iR��4S�g�E����I.eI�z~)ԳK�A���0�X�¹��WB˗�6�/Z�^���E��ɷ�F�(��p4ogSs�+wW{�Қ#c�S����^���U�rv����@��
D(ob�JP 'a��5�z��?�N�_\�����t�ե �"2��@�q��^��st��rL �P�>���k�.��fR0v[�ִI,��<4�on�By���;3!z:���u^YpJ�Uj���+ӻ������sDk�Nw6���y����w�N�N��IX�z�B�v�s�@�����
�$�-G��X�j+%~Di^����
����iY����Xo�d:0}mp�	��z��Ӣ�/"6�x�5�Y�hf�Զ{�xn/0��E�W���Za��o�#^w�U�v>`��B�|�3{.��.q�&;��D�a֚�3�B,��@�aC��*J%b�o�H�d(S�&R���}%���;ĸ�����~��d����8�F����S���,��<ފ��M{�i�×{	J-�SHb=>fO{l��m��gil������oe8y��|s�s�D�#�o�
���ut�I��a)��TAT��A��f�j��?z���      �   1   x�3���(U(�,�41 NS.#�XIƱw��K�4��p��qqq ~��     