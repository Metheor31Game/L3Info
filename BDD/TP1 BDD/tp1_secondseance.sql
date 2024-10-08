PGDMP     1                    |           tp1_db #   15.7 (Ubuntu 15.7-0ubuntu0.23.10.1) #   15.7 (Ubuntu 15.7-0ubuntu0.23.10.1) $    x           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            z           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            {           1262    16474    tp1_db    DATABASE     r   CREATE DATABASE tp1_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'fr_FR.UTF-8';
    DROP DATABASE tp1_db;
                userpostgres    false            �            1259    16475    auteur    TABLE     �   CREATE TABLE public.auteur (
    noauteur integer NOT NULL,
    nomauteur character(40) NOT NULL,
    prenomauteur character(40) NOT NULL,
    emailauteur character(60) NOT NULL
);
    DROP TABLE public.auteur;
       public         heap    userpostgres    false            �            1259    16532    auteur_noAuteur_seq    SEQUENCE     �   ALTER TABLE public.auteur ALTER COLUMN noauteur ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."auteur_noAuteur_seq"
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          userpostgres    false    214            �            1259    16478    client    TABLE     �   CREATE TABLE public.client (
    noclient integer NOT NULL,
    nomclient character(40) NOT NULL,
    prenomclient character(40) NOT NULL,
    emailclient character(60) NOT NULL
);
    DROP TABLE public.client;
       public         heap    userpostgres    false            �            1259    16481    contrat    TABLE     e   CREATE TABLE public.contrat (
    unauteur integer NOT NULL,
    unediteur character(40) NOT NULL
);
    DROP TABLE public.contrat;
       public         heap    userpostgres    false            �            1259    16484    ecrit    TABLE     [   CREATE TABLE public.ecrit (
    unauteur integer NOT NULL,
    unlivre integer NOT NULL
);
    DROP TABLE public.ecrit;
       public         heap    userpostgres    false            �            1259    16487    editeur    TABLE     k   CREATE TABLE public.editeur (
    nomediteur character(40) NOT NULL,
    adresse character(60) NOT NULL
);
    DROP TABLE public.editeur;
       public         heap    userpostgres    false            �            1259    16490 
   exemplaire    TABLE     �   CREATE TABLE public.exemplaire (
    noexemplaire integer NOT NULL,
    lelivre integer NOT NULL,
    dateachat date,
    leclient integer
);
    DROP TABLE public.exemplaire;
       public         heap    userpostgres    false            �            1259    16493    livre    TABLE     �   CREATE TABLE public.livre (
    nolivre integer NOT NULL,
    typelivre character(10) NOT NULL,
    titre character(50) NOT NULL,
    prix integer NOT NULL,
    unediteur character(40)
);
    DROP TABLE public.livre;
       public         heap    userpostgres    false            �            1259    16574    testexemplaire    VIEW     �   CREATE VIEW public.testexemplaire AS
 SELECT DISTINCT livre.nolivre AS lelivre
   FROM public.livre
EXCEPT
 SELECT DISTINCT exemplaire.lelivre
   FROM public.exemplaire;
 !   DROP VIEW public.testexemplaire;
       public          userpostgres    false    219    220            n          0    16475    auteur 
   TABLE DATA           P   COPY public.auteur (noauteur, nomauteur, prenomauteur, emailauteur) FROM stdin;
    public          userpostgres    false    214   �'       o          0    16478    client 
   TABLE DATA           P   COPY public.client (noclient, nomclient, prenomclient, emailclient) FROM stdin;
    public          userpostgres    false    215   ?(       p          0    16481    contrat 
   TABLE DATA           6   COPY public.contrat (unauteur, unediteur) FROM stdin;
    public          userpostgres    false    216   �(       q          0    16484    ecrit 
   TABLE DATA           2   COPY public.ecrit (unauteur, unlivre) FROM stdin;
    public          userpostgres    false    217   �(       r          0    16487    editeur 
   TABLE DATA           6   COPY public.editeur (nomediteur, adresse) FROM stdin;
    public          userpostgres    false    218   )       s          0    16490 
   exemplaire 
   TABLE DATA           P   COPY public.exemplaire (noexemplaire, lelivre, dateachat, leclient) FROM stdin;
    public          userpostgres    false    219   �)       t          0    16493    livre 
   TABLE DATA           K   COPY public.livre (nolivre, typelivre, titre, prix, unediteur) FROM stdin;
    public          userpostgres    false    220   �)       |           0    0    auteur_noAuteur_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."auteur_noAuteur_seq"', 3, true);
          public          userpostgres    false    221            �           2606    16497    auteur auteur_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (noauteur);
 <   ALTER TABLE ONLY public.auteur DROP CONSTRAINT auteur_pkey;
       public            userpostgres    false    214            �           2606    16499    client client_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (noclient);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            userpostgres    false    215            �           2606    16501    editeur editeur_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.editeur
    ADD CONSTRAINT editeur_pkey PRIMARY KEY (nomediteur);
 >   ALTER TABLE ONLY public.editeur DROP CONSTRAINT editeur_pkey;
       public            userpostgres    false    218            �           2606    16503    exemplaire exemplaire_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_pkey PRIMARY KEY (noexemplaire);
 D   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT exemplaire_pkey;
       public            userpostgres    false    219            �           2606    16538    livre livre_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (nolivre);
 :   ALTER TABLE ONLY public.livre DROP CONSTRAINT livre_pkey;
       public            userpostgres    false    220            �           2606    16507    contrat pkContrat 
   CONSTRAINT     b   ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT "pkContrat" PRIMARY KEY (unauteur, unediteur);
 =   ALTER TABLE ONLY public.contrat DROP CONSTRAINT "pkContrat";
       public            userpostgres    false    216    216            �           2606    16509    ecrit pkEcrit 
   CONSTRAINT     \   ALTER TABLE ONLY public.ecrit
    ADD CONSTRAINT "pkEcrit" PRIMARY KEY (unauteur, unlivre);
 9   ALTER TABLE ONLY public.ecrit DROP CONSTRAINT "pkEcrit";
       public            userpostgres    false    217    217            �           2606    16511    auteur uqEmailAuteur 
   CONSTRAINT     X   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT "uqEmailAuteur" UNIQUE (emailauteur);
 @   ALTER TABLE ONLY public.auteur DROP CONSTRAINT "uqEmailAuteur";
       public            userpostgres    false    214            �           2606    16513    client uqEmailClient 
   CONSTRAINT     X   ALTER TABLE ONLY public.client
    ADD CONSTRAINT "uqEmailClient" UNIQUE (emailclient);
 @   ALTER TABLE ONLY public.client DROP CONSTRAINT "uqEmailClient";
       public            userpostgres    false    215            �           1259    16514    fki_fkLeClient    INDEX     K   CREATE INDEX "fki_fkLeClient" ON public.exemplaire USING btree (leclient);
 $   DROP INDEX public."fki_fkLeClient";
       public            userpostgres    false    219            �           1259    16515    fki_fkLeLivre    INDEX     I   CREATE INDEX "fki_fkLeLivre" ON public.exemplaire USING btree (lelivre);
 #   DROP INDEX public."fki_fkLeLivre";
       public            userpostgres    false    219            �           1259    16516    fki_fkUnEditeur    INDEX     H   CREATE INDEX "fki_fkUnEditeur" ON public.livre USING btree (unediteur);
 %   DROP INDEX public."fki_fkUnEditeur";
       public            userpostgres    false    220            �           2606    16517    exemplaire fkLeClient    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT "fkLeClient" FOREIGN KEY (leclient) REFERENCES public.client(noclient) NOT VALID;
 A   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT "fkLeClient";
       public          userpostgres    false    215    219    3276            �           2606    16539    exemplaire fkLeLivre    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT "fkLeLivre" FOREIGN KEY (lelivre) REFERENCES public.livre(nolivre) NOT VALID;
 @   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT "fkLeLivre";
       public          userpostgres    false    220    3291    219            �           2606    16527    livre fkUnEditeur    FK CONSTRAINT     �   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT "fkUnEditeur" FOREIGN KEY (unediteur) REFERENCES public.editeur(nomediteur) NOT VALID;
 =   ALTER TABLE ONLY public.livre DROP CONSTRAINT "fkUnEditeur";
       public          userpostgres    false    220    3284    218            n   �   x���;�0Dk�9�%��(P�A�J�r6�`�F�	NOI��a�7�J�Pm�3cU��!p�����衛b-�;@��D�12f�ůf�V5V':3F)ש=�����8L��'��'aѬ7����A�ƞ9��Ls�@��%����~3�[�      o   o   x�3�tJ-.�L-J-V�8�sRsS�J(*L��萛����VDPpq�e���N�Ē��|�fr�AM$�=
\�@{rR�2�R	�����X�C0�8sa&�B1z\\\ ��P�      p   &   x�3��ILJ�QH�I-U���J�R�J(����� F�Y      q      x������ � �      r   y   x���1�0����'�M�u1�U�� ����sp�Ft��Y��2@yP>������Ǐ��y���������Sa�©e�en� Nb��za��jc.�S��Yr{�msbI�8��� ���B      s      x�3�4��".#N#(+F��� ;-a      t   z   x�3�,��M�S ������̢T���<�Ĕ|���Ѐ3'1)5G!)'��Z.#N��v�*�$*�%�%����jWYjQ	��9����R��S��	x�_���Ee@��=... -�?�     