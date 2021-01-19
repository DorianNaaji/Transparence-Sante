package routines;

import java.text.Normalizer;

public class ObjetConventionIdGenerator {
	
	public static int getObjetConventionId(String normalizedObjetConvention) throws Exception
	{
		switch(normalizedObjetConvention)
		{
			case  "REMISE DE PRIX":
				return 1;
			case  "DON":
				return 2;
			case  "HOSPITALITE":
				return 3;
			case  "CONTRAT":
				return 4;
			case "FORMATION":
				return 5;
			case "ACHAT":
				return 6;
			case "ETUDE DE MARCHE":
				return 7;
			case "CONGRES & CONFERENCES":
				return 8;
			case "RECHERCHE":
				return 9;
			case "TEST MEDICAL DE PRODUIT COSMETIQUE":
				return 10;
			case "EDITION":
				return 11;
			case "PARRAINAGE":
				return 12;
			case "PRET DE MATERIEL":
				return 13;
			case "REUNION":
				return 14;
			case "COLLABORATION":
				return 15;
			case "INCONNU":
				return 16;
			case "AUTRE":
				return 17;
			default:
				throw new Exception("Objet convention : " + normalizedObjetConvention + "can't be processed.");
		}
	}
	
	public static String normalizeObjetConvention(String objetConvention, String objetConventionAutre)
	{
		String objetConventionNormalized = Normalizer.normalize(objetConvention.toLowerCase(), Normalizer.Form.NFD); 
		String objetConventionAutreNormalized = Normalizer.normalize(objetConventionAutre.toLowerCase(), Normalizer.Form.NFD); 
		
		if(objetConventionNormalized.equals("autre"))
		{
			if(objetConventionAutreNormalized.contains("enquete")
			|| objetConventionAutreNormalized.contains("etude de marche")
			|| objetConventionAutreNormalized.contains("marketing")
			|| objetConventionAutreNormalized.contains("enquete"))
			{
				return "ETUDE DE MARCHE";
			}
			else if(objetConventionAutreNormalized.contains("hospitalite")
			||		objetConventionAutreNormalized.contains("hospital") //typo
			||		objetConventionAutreNormalized.contains("hospitali") //typo
			||		objetConventionAutreNormalized.contains("hospitalit")) //typo
			{
				return "HOSPITALITE";
			}
			else if(objetConventionAutreNormalized.contains("reunion")
			||		objetConventionAutreNormalized.contains("participation"))
			{
				return "REUNION";
			}
			else if(objetConventionAutreNormalized.contains("formation"))
			{
				return "FORMATION";
			}
			else if(objetConventionAutreNormalized.contains("congres")
			||		objetConventionAutreNormalized.contains("manife")
			||		objetConventionAutreNormalized.contains("manifestation")
			||		objetConventionAutreNormalized.contains("orateur")
			||		objetConventionAutreNormalized.contains("invitation"))
			{
				return "CONGRES & CONFERENCES";
			}
			else if(objetConventionAutreNormalized.contains("achat"))
			{
				return "ACHAT";
			}
			else if(objetConventionAutreNormalized.contains("collaboration")
			||		objetConventionAutreNormalized.contains("collaborat")
			||		objetConventionAutreNormalized.contains("collabor"))
			{
				return "COLLABORATION";
			}
			else if(objetConventionAutreNormalized.contains("expert")
			||		objetConventionAutreNormalized.contains("contrat")
			||		objetConventionAutreNormalized.contains("investigateur")
			||		objetConventionAutreNormalized.contains("location"))
			{
				return "CONTRAT";
			}
			else if(objetConventionAutreNormalized.contains("recherche"))
			{
				return "RECHERCHE";
			}
			else if(objetConventionAutreNormalized.isEmpty())
			{
				return "INCONNU";
			}
			else
			{
				return "AUTRE";
			}
		}
		else
		{
			if(objetConventionNormalized.startsWith("remise"))
			{
				return  "REMISE DE PRIX";
			}
			else if(objetConventionNormalized.startsWith("Don"))
			{
				return  "DON";
			}
			else if(objetConventionNormalized.startsWith("hospitalite"))
			{
				return  "HOSPITALITE";
			}
			else if(objetConventionNormalized.startsWith("contrat") 
			||		objetConvention.contains("prestations de services")
			||		objetConvention.contains("partenariat"))
			{
				return  "CONTRAT";
			}
			else if(objetConventionNormalized.startsWith("formation"))
			{
				return "FORMATION";
			}
			else if(objetConventionNormalized.startsWith("achat")
			||		objetConventionNormalized.contains("cession de droits"))
			{
				return "ACHAT";
			}
			else if(objetConventionNormalized.contains("etude"))
			{
				return "ETUDE DE MARCHE";
			}
			else if(objetConventionNormalized.startsWith("inscription"))
			{
				return "CONGRES & CONFERENCES";
			}
			else if(objetConventionNormalized.startsWith("recherche"))
			{
				return "RECHERCHE";
			}
			else if(objetConventionNormalized.startsWith("evaluation")
			||		objetConventionNormalized.startsWith("vigilance"))
			{
				return "TEST MEDICAL DE PRODUIT COSMETIQUE";
			}
			else if(objetConventionNormalized.startsWith("edition"))
			{
				return "EDITION";
			}
			else if(objetConventionNormalized.startsWith("parrainage"))
			{
				return "PARRAINAGE";
			}
			else if(objetConventionNormalized.startsWith("pret"))
			{
				return "PRET DE MATERIEL";
			}
			else if(objetConventionNormalized.isEmpty())
			{
				return "INCONNU";
			}
			else
			{
				return "AUTRE";
			}
		}
	}
}
