package routines;

import java.text.Normalizer;
import java.util.Arrays;

public class AdressesCleanerV2 {
	
	private static String NA = "N/A";
	private static String[] FORBIDDEN_CPs = new String[] {"00000", "99999", "00000000", "000000", "0000"};
	
	public static String generateId(String CP, String ville)
	{
		String trimmedCP;
		if(CP != null)
		{
			trimmedCP = CP.trim();
		}
		else
		{
			return AdressesCleanerV2.NA; 
		}
		
		
		if(trimmedCP != null && trimmedCP.trim().chars().allMatch(Character::isDigit) && !Arrays.stream(FORBIDDEN_CPs).anyMatch(trimmedCP::equals))
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
