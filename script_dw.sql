DROP DATABASE IF EXISTS transparence_sante_bi;
CREATE DATABASE `transparence_sante_bi` DEFAULT CHARACTER SET utf8 ;
USE transparence_sante_bi;
CREATE TABLE `adresse_dim` (
  `adresse_id` varchar(200) NOT NULL,
  `ville` varchar(200) NOT NULL,
  `code_postal` varchar(200) NOT NULL,
  `departement` varchar(200) NOT NULL,
  `region` varchar(200) NOT NULL,
  `pays_code` varchar(200) NOT NULL,
  `pays` varchar(200) NOT NULL,
  PRIMARY KEY (`adresse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `beneficiaire_dim` (
  `beneficiaire_id` varchar(50)  NOT NULL,
  `beneficiaire_moral_booleen` BOOLEAN NOT NULL,
  `beneficiaire_nom` varchar(200) NOT NULL,
  `beneficiaire_prenom` varchar(200) NOT NULL,
  `beneficiaire_denomination_sociale` varchar(200) NOT NULL,
  `beneficiaire_diplome` varchar(200) NOT NULL,
  PRIMARY KEY (`beneficiaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `categorie_beneficiaire_dim` (
  `categorie_beneficiaire_id` varchar(5) NOT NULL,
  `categorie_beneficiaire_nom` varchar(200) NOT NULL,
  PRIMARY KEY (`categorie_beneficiaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `entreprise_dim` (
  `entreprise_id` varchar(8) NOT NULL,
  `denomination_sociale_entreprise` varchar(200) NOT NULL,
  PRIMARY KEY (`entreprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `evenement_convention_dim` (
  `evenement_convention_id` int(2) NOT NULL,
  `evenement_convention_nom` varchar(200) NOT NULL,
  PRIMARY KEY (`evenement_convention_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `objet_convention_dim` (
  `objet_convention_id` int(2) NOT NULL,
  `objet_convention` varchar(200) NOT NULL,
  PRIMARY KEY (`objet_convention_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `qualite_beneficiaire_dim` (
  `qualite_beneficiaire_id` varchar(10) NOT NULL,
  `nom_qualite_beneficiaire` varchar(200) NOT NULL,
  PRIMARY KEY (`qualite_beneficiaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `secteur_activite_entreprise_dim` (
  `secteur_activite_entreprise_id` varchar(10) NOT NULL,
  `secteur_activite_entreprise_nom` varchar(200) NOT NULL,
  PRIMARY KEY (`secteur_activite_entreprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `specialite_beneficiaire_dim` (
  `specialite_beneficiaire_id` varchar(10) NOT NULL,
  `specialite_beneficiaire_nom` varchar(200) NOT NULL,
  PRIMARY KEY (`specialite_beneficiaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `temps_dim` (
  `date_id` date NOT NULL,
  `annee` int(4) NOT NULL,
  `trimestre` varchar(10) NOT NULL,
  `semestre` varchar(10) NOT NULL,
  `mois` varchar(10) NOT NULL,
  `saison` varchar(10) NOT NULL,
  `numero_jour_mois` int(2) NOT NULL,
  PRIMARY KEY (`date_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `titre_beneficiaire_dim` (
  `titre_beneficiaire_id` varchar(7) NOT NULL,
  `nom_titre_beneficiaire` varchar(200) NOT NULL,
  PRIMARY KEY (`titre_beneficiaire_id`, `nom_titre_beneficiaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `type_avantage_dim` (
  `type_avantage_id` int(2) NOT NULL,
  `type_avantage_nom` varchar(200) NOT NULL,
  PRIMARY KEY (`type_avantage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `avantage_remuneration_fact` (
  `ligne_id` int(11) NOT NULL,
  `entreprise_id` varchar(8) NOT NULL,
  `beneficiaire_id` varchar(50) NOT NULL,
  `categorie_beneficiaire_id` varchar(5) NOT NULL,
  `qualite_beneficiaire_id` varchar(5) NOT NULL,
  `titre_beneficiaire_id` varchar(7) NOT NULL,
  `adresse_beneficiaire_id` varchar(200) NOT NULL,
  `adresse_entreprise_id` varchar(200) NOT NULL,
  `specialite_beneficiaire_id` varchar(10) NOT NULL,
  `secteur_activite_entreprise_id` varchar(10) NOT NULL,
  `type_avantage_id` int(2) NOT NULL,
  `date_id` date NOT NULL,
  `is_avantage` BOOLEAN NOT NULL,
  `montant_ttc`  DECIMAL NULL,
  PRIMARY KEY (`ligne_id`, `entreprise_id`),
  CONSTRAINT `fk1_entreprise_id` FOREIGN KEY(`entreprise_id`) REFERENCES `entreprise_dim`(`entreprise_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_beneficiaire_id` FOREIGN KEY(`beneficiaire_id`) REFERENCES `beneficiaire_dim`(`beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_categorie_beneficaire_id` FOREIGN KEY(`categorie_beneficiaire_id`) REFERENCES `categorie_beneficiaire_dim`(`categorie_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_qualite_beneficiaire_id` FOREIGN KEY(`qualite_beneficiaire_id`) REFERENCES `qualite_beneficiaire_dim`(`qualite_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_titre_beneficiaire_id` FOREIGN KEY(`titre_beneficiaire_id`) REFERENCES `titre_beneficiaire_dim`(`titre_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_adresse_beneficiaire_id` FOREIGN KEY (`adresse_beneficiaire_id`) REFERENCES `adresse_dim` (`adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_adresse_entreprise_id` FOREIGN KEY (`adresse_entreprise_id`) REFERENCES `adresse_dim` (`adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_specialite_beneficiaire_id` FOREIGN KEY (`specialite_beneficiaire_id`) REFERENCES `specialite_beneficiaire_dim` (`specialite_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_secteur_activite_entreprise_id` FOREIGN KEY (`secteur_activite_entreprise_id`) REFERENCES `secteur_activite_entreprise_dim` (`secteur_activite_entreprise_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_avantage_id` FOREIGN KEY (`type_avantage_id`) REFERENCES `type_avantage_dim` (`type_avantage_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `convention_fact` (
  `ligne_id` int(11) NOT NULL,
  `entreprise_id` varchar(8) NOT NULL,
  `beneficiaire_id` varchar(50) NOT NULL,
  `categorie_beneficiaire_id` varchar(5) NOT NULL,
  `qualite_beneficiaire_id` varchar(5) NOT NULL,
  `titre_beneficiaire_id` varchar(7) NOT NULL,
  `adresse_beneficiaire_id` varchar(200) NOT NULL,
  `adresse_entreprise_id` varchar(200) NOT NULL,
  `specialite_beneficiaire_id` varchar(10) NOT NULL,
  `secteur_activite_entreprise_id` varchar(10) NOT NULL,
  `objet_convention_id` int(2) NOT NULL,
  `evenement_convention_id` int(2) NOT NULL,
  `date_debut_convention` date NOT NULL,
  `date_fin_convention` date NOT NULL,
  `date_signature_convention` date NOT NULL,
  `montant_convention` int(7) NOT NULL,
  `duree_convention` int(11) NOT NULL,
  PRIMARY KEY (`ligne_id`, `entreprise_id`),
  CONSTRAINT `fk2_entreprise_id` FOREIGN KEY(`entreprise_id`) REFERENCES `entreprise_dim`(`entreprise_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_beneficiaire_id` FOREIGN KEY(`beneficiaire_id`) REFERENCES `beneficiaire_dim`(`beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_categorie_beneficaire_id` FOREIGN KEY(`categorie_beneficiaire_id`) REFERENCES `categorie_beneficiaire_dim`(`categorie_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_qualite_beneficiaire_id` FOREIGN KEY(`qualite_beneficiaire_id`) REFERENCES `qualite_beneficiaire_dim`(`qualite_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_titre_beneficiaire_id` FOREIGN KEY(`titre_beneficiaire_id`) REFERENCES `titre_beneficiaire_dim`(`titre_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_adresse_beneficiaire_id` FOREIGN KEY (`adresse_beneficiaire_id`) REFERENCES `adresse_dim` (`adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_adresse_entreprise_id` FOREIGN KEY (`adresse_entreprise_id`) REFERENCES `adresse_dim` (`adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_specialite_beneficiaire_id` FOREIGN KEY (`specialite_beneficiaire_id`) REFERENCES `specialite_beneficiaire_dim` (`specialite_beneficiaire_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_secteur_activite_entreprise_id` FOREIGN KEY (`secteur_activite_entreprise_id`) REFERENCES `secteur_activite_entreprise_dim` (`secteur_activite_entreprise_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_objet_convention_id` FOREIGN KEY (`objet_convention_id`) REFERENCES `objet_convention_dim` (`objet_convention_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enevement_convention_id` FOREIGN KEY (`evenement_convention_id`) REFERENCES `evenement_convention_dim` (`evenement_convention_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_debut_convention` FOREIGN KEY (`date_debut_convention`) REFERENCES `temps_dim` (`date_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_fin_convention` FOREIGN KEY (`date_fin_convention`) REFERENCES `temps_dim` (`date_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_signature_convention` FOREIGN KEY (`date_signature_convention`) REFERENCES `temps_dim` (`date_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;