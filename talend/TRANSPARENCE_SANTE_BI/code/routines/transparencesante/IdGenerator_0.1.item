package routines;

import java.text.Normalizer;

/*
 * user specification: the function's comment should contain keys as follows: 1. write about the function's comment.but
 * it must be before the "{talendTypes}" key.
 * 
 * 2. {talendTypes} 's value must be talend Type, it is required . its value should be one of: String, char | Character,
 * long | Long, int | Integer, boolean | Boolean, byte | Byte, Date, double | Double, float | Float, Object, short |
 * Short
 * 
 * 3. {Category} define a category for the Function. it is required. its value is user-defined .
 * 
 * 4. {param} 's format is: {param} <type>[(<default value or closed list values>)] <name>[ : <comment>]
 * 
 * <type> 's value should be one of: string, int, list, double, object, boolean, long, char, date. <name>'s value is the
 * Function's parameter name. the {param} is optional. so if you the Function without the parameters. the {param} don't
 * added. you can have many parameters for the Function.
 * 
 * 5. {example} gives a example for the Function. it is optional.
 */
public class IdGenerator {
	
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
		|| loweredWithoutAccents.contains("rpas")
		|| loweredWithoutAccents.contains("cocktail")
		|| loweredWithoutAccents.contains("champagne")
		|| loweredWithoutAccents.contains("déjeuner")
		|| loweredWithoutAccents.contains("erpas"))
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
		else
		{
			return "AUTRE";
		}
		
	}
}
