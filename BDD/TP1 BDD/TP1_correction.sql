PGDMP             	        
    {         	   librairie    15.2    15.2 3    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            J           1262    19151 	   librairie    DATABASE     |   CREATE DATABASE librairie WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE librairie;
                postgres    false            �            1255    19244    f_auteurprefere(integer)    FUNCTION     �  CREATE FUNCTION public.f_auteurprefere(cli integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	lAuteur Auteur.nomAuteur%TYPE ;
	nolAuteur Auteur.noAuteur%TYPE;
BEGIN
	SELECT INTO nolAuteur, lAuteur noAuteur, nomAuteur 
	FROM Auteur, Exemplaire, aEcrit
	WHERE noAuteur = unAuteur
	AND leLivre = unLivre
	AND leClient = cli
	GROUP BY noAuteur, nomAuteur
	HAVING COUNT (DISTINCT unLivre) = 
	( SELECT MAX(nbLivre) FROM 
	( SELECT noAuteur, nomAuteur ,COUNT (DISTINCT unLivre) AS nbLivre
	  FROM Auteur, Exemplaire, aEcrit
	WHERE noAuteur = unAuteur
	AND leLivre = unLivre
	AND leClient = cli
	GROUP BY noAuteur, nomAuteur) AS T);
	RETURN lAuteur;
END; $$;
 3   DROP FUNCTION public.f_auteurprefere(cli integer);
       public          postgres    false            �            1255    19249    f_exemplaires(integer)    FUNCTION       CREATE FUNCTION public.f_exemplaires(l integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	unEx Exemplaire.noExemplaire%TYPE ;
BEGIN
	FOR unEx IN SELECT noExemplaire FROM Exemplaire WHERE leLivre = l
	LOOP
		RETURN NEXT unEx;
	END LOOP;
	RETURN;
END; $$;
 /   DROP FUNCTION public.f_exemplaires(l integer);
       public          postgres    false            �            1255    19254    f_nom_auteur_editeur()    FUNCTION     �  CREATE FUNCTION public.f_nom_auteur_editeur() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	nomA Auteur.nomAuteur%TYPE;
BEGIN
	SELECT UPPER(nomAuteur) INTO nomA FROM Auteur WHERE NEW.unAuteur = noAuteur;
	IF UPPER(NEW.unEditeur) = UPPER(nomA) THEN
		RAISE NOTICE 'le nom d un Auteur ne peut etre egal au nom de son editeur';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END; $$;
 -   DROP FUNCTION public.f_nom_auteur_editeur();
       public          postgres    false            �            1255    19260    f_prixlivre()    FUNCTION       CREATE FUNCTION public.f_prixlivre() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.prix > 1.1*OLD.prix THEN
		RAISE NOTICE 'l augmentation de prix d un livre ne peut pas depasser 10 pour cent';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END; $$;
 $   DROP FUNCTION public.f_prixlivre();
       public          postgres    false            �            1255    19266    f_verifcontrat()    FUNCTION     y  CREATE FUNCTION public.f_verifcontrat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	un_Editeur1 Editeur.nomEditeur%TYPE;
	un_Editeur2 Editeur.nomEditeur%TYPE;
	OK BOOLEAN;
BEGIN
	OK = FALSE;
	SELECT INTO un_Editeur1 lEditeur FROM Livre WHERE noLivre = NEW.unLivre;
	FOR un_Editeur2 IN SELECT unEditeur FROM Contrat WHERE NEW.unAuteur = Contrat.unAuteur
	LOOP
		IF un_Editeur1 = un_Editeur2 THEN
			OK = TRUE;
		END IF;
	END LOOP;
	IF OK = FALSE THEN
		RAISE NOTICE 'tous les auteurs d un livre doivent avoir un contrat chez l editeur de ce livre';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END; $$;
 '   DROP FUNCTION public.f_verifcontrat();
       public          postgres    false            �            1259    19213    aecrit    TABLE     \   CREATE TABLE public.aecrit (
    unauteur integer NOT NULL,
    unlivre integer NOT NULL
);
    DROP TABLE public.aecrit;
       public         heap    postgres    false            �            1259    19157    auteur    TABLE     �   CREATE TABLE public.auteur (
    noauteur integer NOT NULL,
    nomauteur character varying(40),
    prenomauteur character varying(40),
    emailauteur character varying(40) NOT NULL
);
    DROP TABLE public.auteur;
       public         heap    postgres    false            �            1259    19549 	   cleauteur    SEQUENCE     r   CREATE SEQUENCE public.cleauteur
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.cleauteur;
       public          postgres    false            �            1259    19548 	   cleclient    SEQUENCE     r   CREATE SEQUENCE public.cleclient
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.cleclient;
       public          postgres    false            �            1259    19551    cleexemplaire    SEQUENCE     v   CREATE SEQUENCE public.cleexemplaire
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.cleexemplaire;
       public          postgres    false            �            1259    19550    clelivre    SEQUENCE     q   CREATE SEQUENCE public.clelivre
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.clelivre;
       public          postgres    false            �            1259    19164    client    TABLE     �   CREATE TABLE public.client (
    noclient integer NOT NULL,
    nomclient character varying(40),
    prenomclient character varying(40),
    emailclient character varying(40) NOT NULL
);
    DROP TABLE public.client;
       public         heap    postgres    false            �            1259    19533    contrat    TABLE     m   CREATE TABLE public.contrat (
    unauteur integer NOT NULL,
    unediteur character varying(40) NOT NULL
);
    DROP TABLE public.contrat;
       public         heap    postgres    false            �            1259    19152    editeur    TABLE     {   CREATE TABLE public.editeur (
    nomediteur character varying(40) NOT NULL,
    adresse character varying(40) NOT NULL
);
    DROP TABLE public.editeur;
       public         heap    postgres    false            �            1259    19182 
   exemplaire    TABLE     �   CREATE TABLE public.exemplaire (
    noexemplaire integer NOT NULL,
    lelivre integer NOT NULL,
    leclient integer,
    dateachat date DEFAULT CURRENT_DATE
);
    DROP TABLE public.exemplaire;
       public         heap    postgres    false            �            1259    19171    livre    TABLE     *  CREATE TABLE public.livre (
    nolivre integer NOT NULL,
    typelivre character varying(40),
    titre character varying(40),
    prix integer NOT NULL,
    lediteur character varying(40),
    CONSTRAINT cktype CHECK ((((typelivre)::text = 'BD'::text) OR ((typelivre)::text = 'POCHE'::text)))
);
    DROP TABLE public.livre;
       public         heap    postgres    false            �            1259    19232    surjectivite_exemplairede    VIEW     �   CREATE VIEW public.surjectivite_exemplairede AS
 SELECT livre.nolivre
   FROM public.livre
EXCEPT
 SELECT DISTINCT exemplaire.lelivre AS nolivre
   FROM public.exemplaire;
 ,   DROP VIEW public.surjectivite_exemplairede;
       public          postgres    false    218    217            �            1259    19236    surjectivite_livre_aecrit    VIEW     �   CREATE VIEW public.surjectivite_livre_aecrit AS
 SELECT livre.nolivre
   FROM public.livre
EXCEPT
 SELECT DISTINCT aecrit.unlivre AS nolivre
   FROM public.aecrit;
 ,   DROP VIEW public.surjectivite_livre_aecrit;
       public          postgres    false    217    219            ?          0    19213    aecrit 
   TABLE DATA           3   COPY public.aecrit (unauteur, unlivre) FROM stdin;
    public          postgres    false    219   Q@       ;          0    19157    auteur 
   TABLE DATA           P   COPY public.auteur (noauteur, nomauteur, prenomauteur, emailauteur) FROM stdin;
    public          postgres    false    215   n@       <          0    19164    client 
   TABLE DATA           P   COPY public.client (noclient, nomclient, prenomclient, emailclient) FROM stdin;
    public          postgres    false    216   �@       @          0    19533    contrat 
   TABLE DATA           6   COPY public.contrat (unauteur, unediteur) FROM stdin;
    public          postgres    false    222   *A       :          0    19152    editeur 
   TABLE DATA           6   COPY public.editeur (nomediteur, adresse) FROM stdin;
    public          postgres    false    214   VA       >          0    19182 
   exemplaire 
   TABLE DATA           P   COPY public.exemplaire (noexemplaire, lelivre, leclient, dateachat) FROM stdin;
    public          postgres    false    218   �A       =          0    19171    livre 
   TABLE DATA           J   COPY public.livre (nolivre, typelivre, titre, prix, lediteur) FROM stdin;
    public          postgres    false    217   �A       K           0    0 	   cleauteur    SEQUENCE SET     7   SELECT pg_catalog.setval('public.cleauteur', 2, true);
          public          postgres    false    224            L           0    0 	   cleclient    SEQUENCE SET     7   SELECT pg_catalog.setval('public.cleclient', 2, true);
          public          postgres    false    223            M           0    0    cleexemplaire    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.cleexemplaire', 3, true);
          public          postgres    false    226            N           0    0    clelivre    SEQUENCE SET     6   SELECT pg_catalog.setval('public.clelivre', 2, true);
          public          postgres    false    225            �           2606    19163    auteur auteur_emailauteur_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_emailauteur_key UNIQUE (emailauteur);
 G   ALTER TABLE ONLY public.auteur DROP CONSTRAINT auteur_emailauteur_key;
       public            postgres    false    215            �           2606    19161    auteur auteur_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auteur
    ADD CONSTRAINT auteur_pkey PRIMARY KEY (noauteur);
 <   ALTER TABLE ONLY public.auteur DROP CONSTRAINT auteur_pkey;
       public            postgres    false    215            �           2606    19170    client client_emailclient_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_emailclient_key UNIQUE (emailclient);
 G   ALTER TABLE ONLY public.client DROP CONSTRAINT client_emailclient_key;
       public            postgres    false    216            �           2606    19168    client client_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (noclient);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    216            �           2606    19156    editeur editeur_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.editeur
    ADD CONSTRAINT editeur_pkey PRIMARY KEY (nomediteur);
 >   ALTER TABLE ONLY public.editeur DROP CONSTRAINT editeur_pkey;
       public            postgres    false    214            �           2606    19187    exemplaire exemplaire_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT exemplaire_pkey PRIMARY KEY (noexemplaire);
 D   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT exemplaire_pkey;
       public            postgres    false    218            �           2606    19176    livre livre_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT livre_pkey PRIMARY KEY (nolivre);
 :   ALTER TABLE ONLY public.livre DROP CONSTRAINT livre_pkey;
       public            postgres    false    217            �           2606    19217    aecrit pkaecrit 
   CONSTRAINT     \   ALTER TABLE ONLY public.aecrit
    ADD CONSTRAINT pkaecrit PRIMARY KEY (unauteur, unlivre);
 9   ALTER TABLE ONLY public.aecrit DROP CONSTRAINT pkaecrit;
       public            postgres    false    219    219            �           2606    19537    contrat pkcontrat 
   CONSTRAINT     `   ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT pkcontrat PRIMARY KEY (unauteur, unediteur);
 ;   ALTER TABLE ONLY public.contrat DROP CONSTRAINT pkcontrat;
       public            postgres    false    222    222            �           2620    19261    livre prixlivre    TRIGGER     k   CREATE TRIGGER prixlivre BEFORE UPDATE ON public.livre FOR EACH ROW EXECUTE FUNCTION public.f_prixlivre();
 (   DROP TRIGGER prixlivre ON public.livre;
       public          postgres    false    230    217            �           2620    19267    aecrit verifcontrat    TRIGGER     |   CREATE TRIGGER verifcontrat BEFORE INSERT OR UPDATE ON public.aecrit FOR EACH ROW EXECUTE FUNCTION public.f_verifcontrat();
 ,   DROP TRIGGER verifcontrat ON public.aecrit;
       public          postgres    false    231    219            �           2606    19218    aecrit fkaecritauteur    FK CONSTRAINT     |   ALTER TABLE ONLY public.aecrit
    ADD CONSTRAINT fkaecritauteur FOREIGN KEY (unauteur) REFERENCES public.auteur(noauteur);
 ?   ALTER TABLE ONLY public.aecrit DROP CONSTRAINT fkaecritauteur;
       public          postgres    false    3220    219    215            �           2606    19223    aecrit fkaecritlivre    FK CONSTRAINT     x   ALTER TABLE ONLY public.aecrit
    ADD CONSTRAINT fkaecritlivre FOREIGN KEY (unlivre) REFERENCES public.livre(nolivre);
 >   ALTER TABLE ONLY public.aecrit DROP CONSTRAINT fkaecritlivre;
       public          postgres    false    219    217    3226            �           2606    19538    contrat fkcontratauteur    FK CONSTRAINT     ~   ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT fkcontratauteur FOREIGN KEY (unauteur) REFERENCES public.auteur(noauteur);
 A   ALTER TABLE ONLY public.contrat DROP CONSTRAINT fkcontratauteur;
       public          postgres    false    3220    215    222            �           2606    19543    contrat fkcontratediteur    FK CONSTRAINT     �   ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT fkcontratediteur FOREIGN KEY (unediteur) REFERENCES public.editeur(nomediteur);
 B   ALTER TABLE ONLY public.contrat DROP CONSTRAINT fkcontratediteur;
       public          postgres    false    222    214    3216            �           2606    19193    exemplaire fkexemplaireclient    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT fkexemplaireclient FOREIGN KEY (leclient) REFERENCES public.client(noclient);
 G   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT fkexemplaireclient;
       public          postgres    false    218    216    3224            �           2606    19188    exemplaire fkexemplairelivre    FK CONSTRAINT     �   ALTER TABLE ONLY public.exemplaire
    ADD CONSTRAINT fkexemplairelivre FOREIGN KEY (lelivre) REFERENCES public.livre(nolivre);
 F   ALTER TABLE ONLY public.exemplaire DROP CONSTRAINT fkexemplairelivre;
       public          postgres    false    218    3226    217            �           2606    19177    livre fklivreediteur    FK CONSTRAINT     ~   ALTER TABLE ONLY public.livre
    ADD CONSTRAINT fklivreediteur FOREIGN KEY (lediteur) REFERENCES public.editeur(nomediteur);
 >   ALTER TABLE ONLY public.livre DROP CONSTRAINT fklivreediteur;
       public          postgres    false    3216    217    214            ?      x������ � �      ;   L   x�3�LIU�ITp��+I��K��JM����IL�
8�%楧�qq:'�s:�$��p&&�xiE�`�=... ��      <   P   x�3��HLI�O��t,J��LJ��L��8$'d�$f��qq�����p�Ud��q������J@
c���� 2M�      @      x�3�LM�,I--2�2�1��b���� r�y      :   ?   x�KM�,I--2�4R(*MUHIUH,�,Vp�I��J�Hq��*$�)�$���Bdc���� ��<      >   )   x�3�4B##c]C]S.# 7�YĘ�1z\\\ �	      =   H   x�3��w�p��IT(H-.I�44�LM�,I--2�2�tr��IUH�O�HUH-Q ���/r8�`��b���� ��     