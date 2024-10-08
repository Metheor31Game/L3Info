PGDMP         
                |           TP1.5 #   15.7 (Ubuntu 15.7-0ubuntu0.23.10.1) #   15.7 (Ubuntu 15.7-0ubuntu0.23.10.1) (    |           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            }           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ~           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16823    TP1.5    DATABASE     s   CREATE DATABASE "TP1.5" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'fr_FR.UTF-8';
    DROP DATABASE "TP1.5";
                userpostgres    false            �            1255    16897    checkauteur()    FUNCTION     �  CREATE FUNCTION public.checkauteur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	lesedits character;
BEGIN
	FOR lesedits IN 
	SELECT nomediteur AS lesedits FROM editeur WHERE nomediteur = (
		SELECT unediteur FROM contrat WHERE 
			unauteur = NEW.noauteur
		
	)
	LOOP
		IF lesedits = NEW.nomauteur 
		THEN RAISE EXCEPTION 'L''auteur ne peut pas avoir le même nom que son éditeur ';
		END IF;
	END LOOP;
	RETURN NEW;
	
END;$$;
 $   DROP FUNCTION public.checkauteur();
       public          userpostgres    false            �            1255    16892    checkexemplaire(integer)    FUNCTION       CREATE FUNCTION public.checkexemplaire(nolivre integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$DECLARE 
	exemp integer;
BEGIN 
	FOR exemp IN 	
		SELECT noexemplaire FROM exemplaire
		WHERE lelivre = nolivre
	LOOP
		RETURN NEXT exemp;
	END LOOP;
	RETURN;
END;$$;
 7   DROP FUNCTION public.checkexemplaire(nolivre integer);
       public          userpostgres    false            �            1255    16895    checklivre()    FUNCTION     H  CREATE FUNCTION public.checklivre() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF NEW.prix IS NULL THEN
		RAISE EXCEPTION 'prix ne peux pas etre null';
	END IF;
	IF NEW.prix > 0.10 * OLD.prix + OLD.prix THEN
		RAISE EXCEPTION 'le prix ne peux pas augmenter de plus de % ', OLD.prix*1.1;
	END IF;

	RETURN NEW;
END;$$;
 #   DROP FUNCTION public.checklivre();
       public          userpostgres    false            �            1259    16824    auteur    TABLE     �   CREATE TABLE public.auteur (
    noauteur integer NOT NULL,
    nomauteur character(40) NOT NULL,
    prenomauteur character(40) NOT NULL,
    emailauteur character(60) NOT NULL
);
    DROP TABLE public.auteur;
       public         heap    userpostgres    false            �            1259    16827    auteur_noAuteur_seq    SEQUENCE     �   ALTER TABLE public.auteur ALTER COLUMN noauteur ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."auteur_noAuteur_seq"
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          userpostgres    false    214            �            1259    16828    client    TABLE     �   CREATE TABLE public.client (
    noclient integer NOT NULL,
    nomclient character(40) NOT NULL,
    prenomclient character(40) NOT NULL,
    emailclient character(60) NOT NULL
);
    DROP TABLE public.client;
       public         heap    userpostgres    false            �            1259    16831    contrat    TABLE     e   CREATE TABLE public.contrat (
    unauteur integer NOT NULL,
    unediteur character(40) NOT NULL
);
    DROP TABLE public.contrat;
       public         heap    userpostgres    false            �            1259    16834    ecrit    TABLE     [   CREATE TABLE public.ecrit (
    unauteur integer NOT NULL,
    unlivre integer NOT NULL
);
    DROP TABLE public.ecrit;
       public         heap    userpostgres    false            �            1259    16837    editeur    TABLE     k   CREATE TABLE public.editeur (
    nomediteur character(40) NOT NULL,
    adresse character(60) NOT NULL
);
    DROP TABLE public.editeur;
       public         heap    userpostgres    false            �            1259    16840 
   exemplaire    TABLE     �   CREATE TABLE public.exemplaire (
    noexemplaire integer NOT NULL,
    lelivre integer NOT NULL,
    dateachat date,
    leclient integer
);
    DROP TABLE public.exemplaire;
       public         heap    userpostgres    false            �            1259    16843    livre    TABLE     �   CREATE TABLE public.livre (
    nolivre integer NOT NULL,
    typelivre character(10) NOT NULL,
    titre character(50) NOT NULL,
    prix integer NOT NULL,
    unediteur character(40)
);
    DROP TABLE public.livre;
       public         heap    userpostgres    false            �            1259    16846    testexemplaire    VIEW     �   CREATE VIEW public.testexemplaire AS
 SELECT DISTINCT livre.nolivre AS lelivre
   FROM public.livre
EXCEPT
 SELECT DISTINCT exemplaire.lelivre
   FROM public.exemplaire;
 !   DROP VIEW public.testexemplaire;
       public          userpostgres    false    220    221            r          0    16824    auteur 
   TABLE DATA           P   COPY public.auteur (noauteur, nomauteur, prenomauteur, emailauteur) FROM stdin;
    public          userpostgres    false    214   /       t          0    16828    client 
   TABLE DATA           P   COPY public.client (noclient, nomclient, prenomclient, emailclient) FROM stdin;
    public          userpostgres    false    216   �/       u          0    16831    contrat 
   TABLE DATA           6   COPY public.contrat (unauteur, unediteur) FROM stdin;
    public          userpostgres    false    217   D0       v          0    16834    ecrit 
   TABLE DATA           2   COPY public.ecrit (unauteur, unlivre) FROM stdin;
    public          userpostgres    false    218   z0       w          0    16837    editeur 
   TABLE DATA           6   COPY public.editeur (nomediteur, adresse) FROM stdin;
    public          userpostgres    false    219   �0       x          0    16840 
   exemplaire 
   TABLE DATA           P   COPY public.exemplaire (noexemplaire, lelivre, dateachat, leclient) FROM stdin;
    public          userpostgres    false    220    1       y          0    16843    livre 
   TABLE DATA           K   COPY public.livre (nolivre, typelivre, titre, prix, unediteur) FROM stdin;
    public          userpostgres    false    221   P1       �           0    0    auteur_noAuteur_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."auteur_noAuteur_seq"', 3, true);
          public          userpostgres    false    215            �           2606    16851    auteur auteur_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (noauteur);
 <   ALTER TABLE ONLY public.auteur DROP CONSTRAINT auteur_pkey;
       public            userpostgres    false    214            �           2606    16853    client client_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (noclient);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            userpostgres    false    216            �           2606    16855    editeur editeur_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.editeur
    ADD CONSTRAINT editeur_pkey PRIMARY KEY (nomediteur);
 >   ALTER TABLE ONLY public.editeur DROP CONSTRAINT editeur_pkey;
       public            userpostgres    false    219            �           2606    16857    exemplaire exemplaire_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_pkey PRIMARY KEY (noexemplaire);
 D   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT exemplaire_pkey;
       public            userpostgres    false    220            �           2606    16859    livre livre_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (nolivre);
 :   ALTER TABLE ONLY public.livre DROP CONSTRAINT livre_pkey;
       public            userpostgres    false    221            �           2606    16861    contrat pkContrat 
   CONSTRAINT     b   ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT "pkContrat" PRIMARY KEY (unauteur, unediteur);
 =   ALTER TABLE ONLY public.contrat DROP CONSTRAINT "pkContrat";
       public            userpostgres    false    217    217            �           2606    16863    ecrit pkEcrit 
   CONSTRAINT     \   ALTER TABLE ONLY public.ecrit
    ADD CONSTRAINT "pkEcrit" PRIMARY KEY (unauteur, unlivre);
 9   ALTER TABLE ONLY public.ecrit DROP CONSTRAINT "pkEcrit";
       public            userpostgres    false    218    218            �           2606    16865    auteur uqEmailAuteur 
   CONSTRAINT     X   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT "uqEmailAuteur" UNIQUE (emailauteur);
 @   ALTER TABLE ONLY public.auteur DROP CONSTRAINT "uqEmailAuteur";
       public            userpostgres    false    214            �           2606    16867    client uqEmailClient 
   CONSTRAINT     X   ALTER TABLE ONLY public.client
    ADD CONSTRAINT "uqEmailClient" UNIQUE (emailclient);
 @   ALTER TABLE ONLY public.client DROP CONSTRAINT "uqEmailClient";
       public            userpostgres    false    216            �           1259    16868    fki_fkLeClient    INDEX     K   CREATE INDEX "fki_fkLeClient" ON public.exemplaire USING btree (leclient);
 $   DROP INDEX public."fki_fkLeClient";
       public            userpostgres    false    220            �           1259    16869    fki_fkLeLivre    INDEX     I   CREATE INDEX "fki_fkLeLivre" ON public.exemplaire USING btree (lelivre);
 #   DROP INDEX public."fki_fkLeLivre";
       public            userpostgres    false    220            �           1259    16870    fki_fkUnEditeur    INDEX     H   CREATE INDEX "fki_fkUnEditeur" ON public.livre USING btree (unediteur);
 %   DROP INDEX public."fki_fkUnEditeur";
       public            userpostgres    false    221            �           2620    16896    livre trig_prix    TRIGGER     r   CREATE TRIGGER trig_prix BEFORE UPDATE OF prix ON public.livre FOR EACH ROW EXECUTE FUNCTION public.checklivre();
 (   DROP TRIGGER trig_prix ON public.livre;
       public          userpostgres    false    221    221    224            �           2606    16871    exemplaire fkLeClient    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT "fkLeClient" FOREIGN KEY (leclient) REFERENCES public.client(noclient) NOT VALID;
 A   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT "fkLeClient";
       public          userpostgres    false    220    216    3279            �           2606    16876    exemplaire fkLeLivre    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT "fkLeLivre" FOREIGN KEY (lelivre) REFERENCES public.livre(nolivre) NOT VALID;
 @   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT "fkLeLivre";
       public          userpostgres    false    3294    221    220            �           2606    16881    livre fkUnEditeur    FK CONSTRAINT     �   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT "fkUnEditeur" FOREIGN KEY (unediteur) REFERENCES public.editeur(nomediteur) NOT VALID;
 =   ALTER TABLE ONLY public.livre DROP CONSTRAINT "fkUnEditeur";
       public          userpostgres    false    219    221    3287            r   �   x���;�0Dk�9�%��(P�A�J�r6�`�F�	NOI��a�7�J�Pm�3cU��!p�����衛b-�;@��D�12f�ůf�V5V':3F)ש=�����8L��'��'aѬ7����A�ƞ9��Ls�@��%����~3�[�      t   o   x�3�tJ-.�L-J-V�8�sRsS�J(*L��萛����VDPpq�e���N�Ē��|�fr�AM$�=
\�@{rR�2�R	�����X�C0�8sa&�B1z\\\ ��P�      u   &   x�3��ILJ�QH�I-U���J�R�J(����� F�Y      v      x������ � �      w   y   x���1�0����'�M�u1�U�� ����sp�Ft��Y��2@yP>������Ǐ��y���������Sa�©e�en� Nb��za��jc.�S��Yr{�msbI�8��� ���B      x       x�3�4��".#N#(�.fg��qqq �8      y   y   x���1�0Eg����t�֩+��"�D2��BbI�l��W���=���iY�dBC�y�!P�+P�D�S�ҷ������i4���\�]�(�f\|���+���-��G��a��-�%"�.?�     