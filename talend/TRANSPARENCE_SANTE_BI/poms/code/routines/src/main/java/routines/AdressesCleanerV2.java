package routines;

import java.text.Normalizer;

public class AdressesCleanerV2 {
	
	private static String NA = "N/A";
	
	public static String generateId(String CP, String ville)
	{
		if(CP != null && CP.trim().chars().allMatch(Character::isDigit) && !CP.trim().equals("00000") && !CP.trim().equals("99999"))
		{
			return CP.trim() + "|" + normalizeField(ville);
		}
		else
		{
			return AdressesCleanerV2.NA;
		}
	}
	
    private static String normalizeField(String toNormalize)
    {
    	return Normalizer.normalize(toNormalize.toLowerCase(), Normalizer.Form.NFD).replaceAll("[\\p{InCombiningDiacriticalMarks}]", "")		
    			.trim()
    			.replace("-", "")
    			.replace(" ", "")
    			.replace("cedex", "")
    			.replace("cdx", "")
    			.replace("cx", "")
    			.replace("arrondissement", "")
    			.replaceAll("[0-9]","");	
    }

    
    public static String getNA()
    {
    	return NA;
    }
}
