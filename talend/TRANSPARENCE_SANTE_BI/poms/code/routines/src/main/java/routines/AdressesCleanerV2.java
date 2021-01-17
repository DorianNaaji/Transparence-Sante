package routines;

import java.text.Normalizer;

public class AdressesCleanerV2 {
	
	public static String generateId(String CP, String ville)
	{
		return normalizeField(CP) + "-" + normalizeField(ville);
	}
	
    private static String normalizeField(String toNormalize)
    {
    	return Normalizer.normalize(toNormalize.toLowerCase(), Normalizer.Form.NFD).trim(); 
    }
}
