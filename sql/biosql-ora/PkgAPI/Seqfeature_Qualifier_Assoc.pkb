--
-- API Package Body for Seqfeature_Qualifier_Assoc.
--
-- Scaffold auto-generated by gen-api.pl (H.Lapp, 2002).
--
-- $Id: Seqfeature_Qualifier_Assoc.pkb,v 1.1.1.2 2003-01-29 08:54:40 lapp Exp $
--

--
-- (c) Hilmar Lapp, hlapp at gnf.org, 2002.
-- (c) GNF, Genomics Institute of the Novartis Research Foundation, 2002.
--
-- You may distribute this module under the same terms as Perl.
-- Refer to the Perl Artistic License (see the license accompanying this
-- software package, or see http://www.perl.com/language/misc/Artistic.html)
-- for the terms under which you may use, modify, and redistribute this module.
-- 
-- THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
-- WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
-- MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--

CREATE OR REPLACE
PACKAGE BODY FeaOntA IS

CURSOR FeaOntA_c (
		FeaOntA_FEA_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.FEA_OID%TYPE,
		FeaOntA_ONT_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.ONT_OID%TYPE,
		FeaOntA_RANK	IN SG_SEQFEATURE_QUALIFIER_ASSOC.RANK%TYPE)
RETURN SG_SEQFEATURE_QUALIFIER_ASSOC%ROWTYPE IS
	SELECT t.* FROM SG_SEQFEATURE_QUALIFIER_ASSOC t
	WHERE
		FEA_OID = FeaOntA_FEA_OID
	AND	ONT_OID = FeaOntA_ONT_OID
	AND	RANK    = FeaOntA_RANK
	;

FUNCTION get_oid(
		FEA_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.FEA_OID%TYPE DEFAULT NULL,
		ONT_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.ONT_OID%TYPE DEFAULT NULL,
		FeaOntA_RANK	IN SG_SEQFEATURE_QUALIFIER_ASSOC.RANK%TYPE DEFAULT NULL,
		FeaOntA_VALUE	IN SG_SEQFEATURE_QUALIFIER_ASSOC.VALUE%TYPE DEFAULT NULL,
		Fea_ENT_OID	IN SG_SEQFEATURE.ENT_OID%TYPE DEFAULT NULL,
		Fea_ONT_OID	IN SG_SEQFEATURE.ONT_OID%TYPE DEFAULT NULL,
		Fea_RANK	IN SG_SEQFEATURE.RANK%TYPE DEFAULT NULL,
		Ont_NAME	IN SG_ONTOLOGY_TERM.NAME%TYPE DEFAULT NULL,
		Ont_Cat_OID	IN SG_ONTOLOGY_TERM.ONT_OID%TYPE DEFAULT NULL,
		Ont_IDENTIFIER	IN SG_ONTOLOGY_TERM.IDENTIFIER%TYPE DEFAULT NULL,
		do_DML		IN NUMBER DEFAULT BSStd.DML_NO)
RETURN INTEGER
IS
	pk	INTEGER DEFAULT NULL;
	FeaOntA_row FeaOntA_c%ROWTYPE;
	FEA_OID_	SG_SEQFEATURE.OID%TYPE DEFAULT FEA_OID;
	ONT_OID_	SG_ONTOLOGY_TERM.OID%TYPE DEFAULT ONT_OID;
BEGIN
	-- look up SG_SEQFEATURE
	IF (FEA_OID_ IS NULL) THEN
		FEA_OID_ := Fea.get_oid(
				ENT_OID => Fea_ENT_OID,
				Fea_RANK => Fea_RANK,
				ONT_OID => Fea_ONT_OID);
	END IF;
	-- look up SG_ONTOLOGY_TERM
	IF (ONT_OID_ IS NULL) THEN
		ONT_OID_ := Ont.get_oid(
				Ont_NAME => Ont_NAME,
				Ont_CAT_OID => Ont_CAT_OID,
				Ont_IDENTIFIER => Ont_IDENTIFIER);
	END IF;
	-- look up
	FOR FeaOntA_row IN FeaOntA_c (FEA_OID_, ONT_OID_, FeaOntA_RANK) LOOP
	        pk := 1;
	END LOOP;
	-- insert/update if requested
	IF (pk IS NULL) AND 
	   ((do_DML = BSStd.DML_I) OR (do_DML = BSStd.DML_UI)) THEN
	    	-- look up foreign keys if not provided:
		-- look up SG_SEQFEATURE successful?
		IF (FEA_OID_ IS NULL) THEN
			raise_application_error(-20101,
				'failed to look up Fea <' || Fea_ENT_OID || '|' || Fea_ONT_OID || '|' || Fea_RANK || '>');
		END IF;
		-- look up SG_ONTOLOGY_TERM successful?
		IF (ONT_OID_ IS NULL) THEN
			raise_application_error(-20101,
				'failed to look up Ont <' || Ont_NAME || '|' || Ont_CAT_OID || '|' || Ont_IDENTIFIER || '>');
		END IF;
	    	-- insert the record and obtain the primary key
	    	pk := do_insert(
		        FEA_OID => FEA_OID_,
		        ONT_OID => ONT_OID_,
			RANK => FeaOntA_RANK,
			VALUE => FeaOntA_VALUE);
	ELSIF (do_DML = BSStd.DML_U) OR (do_DML = BSStd.DML_UI) THEN
	        -- update the record (note that not provided FKs will not
		-- be changed nor looked up)
		do_update(
			FeaOntA_FEA_OID	=> FEA_OID_,
		        FeaOntA_ONT_OID => ONT_OID_,
			FeaOntA_RANK => FeaOntA_RANK,
			FeaOntA_VALUE => FeaOntA_VALUE);
	END IF;
	-- return the primary key
	RETURN pk;
END;

FUNCTION do_insert(
		FEA_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.FEA_OID%TYPE,
		ONT_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.ONT_OID%TYPE,
		RANK	IN SG_SEQFEATURE_QUALIFIER_ASSOC.RANK%TYPE,
		VALUE	IN SG_SEQFEATURE_QUALIFIER_ASSOC.VALUE%TYPE)
RETURN INTEGER
IS
BEGIN
	-- insert the record
	INSERT INTO SG_SEQFEATURE_QUALIFIER_ASSOC (
		FEA_OID,
		ONT_OID,
		RANK,
		VALUE)
	VALUES (FEA_OID,
		ONT_OID,
		RANK,
		VALUE)
	;
	-- return TRUE
	RETURN 1;
END;

PROCEDURE do_update(
		FeaOntA_FEA_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.FEA_OID%TYPE,
		FeaOntA_ONT_OID	IN SG_SEQFEATURE_QUALIFIER_ASSOC.ONT_OID%TYPE,
		FeaOntA_RANK	IN SG_SEQFEATURE_QUALIFIER_ASSOC.RANK%TYPE,
		FeaOntA_VALUE	IN SG_SEQFEATURE_QUALIFIER_ASSOC.VALUE%TYPE)
IS
BEGIN
	-- update the record (and leave attributes passed as NULL untouched)
	UPDATE SG_SEQFEATURE_QUALIFIER_ASSOC
	SET
		VALUE = NVL(FeaOntA_VALUE, VALUE)
	WHERE FEA_OID = FeaOntA_FEA_OID
	AND   ONT_OID = FeaOntA_ONT_OID
	AND   RANK    = FeaOntA_RANK
	;
END;

END FeaOntA;
/

