package routines;

import java.text.Normalizer;

public class NatureAvantageIdGenerator {
	
	public static int getNatureAvantageId(String normalizedNatureAvantage) throws Exception
	{
		switch(normalizedNatureAvantage)
		{
			case "REPAS":
				return 1;
			case "HEBERGEMENT":
				return 2;
			case "ENQUETE":
				return 3;
			case "TRANSPORT":
				return 4;
			case "HONORAIRE & INDEMNITES":
				return 5;
			case "LOCATION":
				return 6;
			case "INSCRIPTION":
				return 7;
			case "DONS & CADEAUX":
				return 8;
			case "AUTRE":
				return 9;
			case "INCONNU":
				return 10;
			default:
				throw new Exception("Normalized Nature Avantage unkown : " + normalizedNatureAvantage + ".");
		}
	}
	
	public static String normalizeNatureAvantage(String natureAvantage)
	{
		String loweredWithoutAccents = Normalizer.normalize(natureAvantage.toLowerCase(), Normalizer.Form.NFD); 
		if(loweredWithoutAccents.contains("repas")
		|| loweredWithoutAccents.contains("restauration")
		|| loweredWithoutAccents.contains("dejeuner")
		|| loweredWithoutAccents.contains("frais de bouche")
		|| loweredWithoutAccents.contains("diner")
		|| loweredWithoutAccents.contains("pause")
		|| loweredWithoutAccents.contains("traiteur")
		|| loweredWithoutAccents.contains("restaurant")
		|| loweredWithoutAccents.contains("lunch")
		|| loweredWithoutAccents.contains("breakfast")
		|| loweredWithoutAccents.contains("lunch box")
		|| loweredWithoutAccents.contains("collation")
		|| loweredWithoutAccents.contains("rpas") //typo
		|| loweredWithoutAccents.contains("cocktail")
		|| loweredWithoutAccents.contains("champagne")
		|| loweredWithoutAccents.contains("déjeuner")
		|| loweredWithoutAccents.contains("erpas")) //typo
		{
			return "REPAS";
		}
		else if(loweredWithoutAccents.contains("hebergement")
		|| 		loweredWithoutAccents.contains("hébergement")
		|| 		loweredWithoutAccents.contains("hospitalite")
		|| 		loweredWithoutAccents.contains("hotel")
		|| 		loweredWithoutAccents.contains("nuitee"))
		{
			return "HEBERGEMENT";
		}
		else if(loweredWithoutAccents.contains("enquete"))
		{
			return "ENQUETE";
		}
		else if(loweredWithoutAccents.contains("transport")
		|| 		loweredWithoutAccents.contains("taxi")
		|| 		loweredWithoutAccents.contains("sncf")
		|| 		loweredWithoutAccents.contains("avion")
		|| 		loweredWithoutAccents.contains("carburant")
		|| 		loweredWithoutAccents.contains("stationnement")
		|| 		loweredWithoutAccents.contains("parking"))
		{
			return "TRANSPORT";
		}
		else if (loweredWithoutAccents.contains("inscription"))
		{
			return "INSCRIPTION";
		}
		else if (loweredWithoutAccents.contains("cadeaux")
		|| 		 loweredWithoutAccents.contains("cadeau")
		|| 		 loweredWithoutAccents.contains("dons ")
		|| 		 loweredWithoutAccents.contains("don "))
		{
			return "DONS & CADEAUX";
		}
		else if(loweredWithoutAccents.contains("honoraire")
		||		loweredWithoutAccents.contains("indemnite")
		||		loweredWithoutAccents.contains("remuneration")
		||		loweredWithoutAccents.contains("remboursement")
		||		loweredWithoutAccents.contains("frais"))
		{
			return "HONORAIRE & INDEMNITES";
		}
		else if(loweredWithoutAccents.contains("location"))
		{
			return "LOCATION";
		}
		else if(loweredWithoutAccents.isEmpty())
		{
			return "INCONNU";
		}
		else
		{
			return "AUTRE";
		}
		
	}
}
