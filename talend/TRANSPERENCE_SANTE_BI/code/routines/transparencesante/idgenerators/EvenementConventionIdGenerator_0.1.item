package routines;

import java.text.Normalizer;

public class EvenementConventionIdGenerator {

	public static int getEvenementConventionId(String normalizedEvenementConvention) throws Exception
	{
		switch(normalizedEvenementConvention)
		{
			case "ETUDE DE MARCHE":
				return 1;
			case "REUNION":
				return 2;
			case "CONGRES & CONFERENCES":
				return 3;
			case "FORMATION":
				return 4;
			case "INCONNU":
				return 5;
			case "AUTRE":
				return 6;
			default:
				throw new Exception("Evenement convention : " + normalizedEvenementConvention + " could not be processed.");
		}
	}
	
	
	// we only keep few of the evenement convention (Unique Values:233883).
	// the goal is to analyze more deeply this field with Python / profiling, etc. (notebook)
	
	public static String normalizeEvenementConvention(String evenementConvention)
	{
		String normalizedEvenementConvention = Normalizer.normalize(evenementConvention.toLowerCase(), Normalizer.Form.NFD); 
		
		if(normalizedEvenementConvention.contains("etude"))
		{
			return  "ETUDE DE MARCHE";
		}
		else if(normalizedEvenementConvention.contains("reunion"))
		{
			return "REUNION";
		}
		else if(normalizedEvenementConvention.contains("rencontres")
		||		normalizedEvenementConvention.contains("actualites")
		||		normalizedEvenementConvention.contains("actualite"))
		{
			return "CONGRES & CONFERENCES";
		}
		else if(normalizedEvenementConvention.contains("formation"))
		{
			return "FORMATION";
		}
		else if(normalizedEvenementConvention.isEmpty())
		{
			return "INCONNU";
		}
		else
		{
			return "AUTRE";
		}
	}
}
