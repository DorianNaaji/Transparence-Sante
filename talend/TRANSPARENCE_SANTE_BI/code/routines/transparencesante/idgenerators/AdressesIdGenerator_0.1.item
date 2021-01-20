package routines;

import java.text.Normalizer;

public class AdressesIdGenerator {
	
	private final static String UNKNOWN = "INCONNU";
	private final static String NA = "N/A";


    public static String generateAdresseIdFromCodePostalAndVille(String benefCodePostal, String benefVille, String benefEtablissementCodePostal, String benefEtablissementVille) 
    {
    	String normalizedBenefCodePostal = AdressesIdGenerator.normalizeField(benefCodePostal);
		//String normalizedBenefVille = AdressesIdGenerator.normalizeField(benefVille);
		String normalizedBenefEtablissementCodePostal = AdressesIdGenerator.normalizeField(benefEtablissementCodePostal); 
		String normalizedBenefEtablissementVille = AdressesIdGenerator.normalizeField(benefEtablissementVille); 
		
		String displayBenefVille = benefVille.toUpperCase().replace("CEDEX", "");
		String displayBenefEtablissementVille =  benefEtablissementVille.toUpperCase().replace("CEDEX", "");
		
		if(normalizedBenefCodePostal.isEmpty() || normalizedBenefEtablissementVille.isEmpty())
		{
			if(normalizedBenefEtablissementCodePostal.isEmpty() || normalizedBenefEtablissementVille.isEmpty())
			{
				return AdressesIdGenerator.UNKNOWN;
			}
			else
			{
				return normalizedBenefEtablissementCodePostal + "-" + displayBenefEtablissementVille;
			}
		}
		else
		{
			return normalizedBenefCodePostal + "-" + displayBenefVille;
		}
    }
    
    private static String normalizeField(String toNormalize)
    {
    	return (Normalizer.normalize(toNormalize.toLowerCase(), Normalizer.Form.NFD)).replace("cedex", "").trim(); 
    }
    
    
    public static String getCodePostalFromNormalizedId(String id)
    {
    	return AdressesIdGenerator.getItemFromNormalizedId(id, 0);
    }
    
    public static String getVilleFromNormalizedId(String id)
    {
    	return AdressesIdGenerator.getItemFromNormalizedId(id, 1);
    }
    
    private static String getItemFromNormalizedId(String id, int index)
    {
    	if(id.contains("-"))
    	{
    		String[] splitted = id.split("-");
    		if(splitted.length > 1)
    		{
    			return id.split("-")[index];
    		}
    		else if(index == 0 & splitted.length == 1)
    		{
    			return id.split("-")[index];
    		}
    		else
    		{
    			return AdressesIdGenerator.NA;
    		}
    	}
    	else
    	{
    		return AdressesIdGenerator.NA;
    	}
    }
    
    
    public static String initialize_Region_Departement_Pays_PaysCode(String normalizedId)
    {
    	return normalizedId.equals(AdressesIdGenerator.UNKNOWN) ? AdressesIdGenerator.NA : "";
    }
    
    
    public static String getDepOrRegionValueFromNormalizedId(String normalizedId, String depOrRegion)
    {
    	if(normalizedId.equals(AdressesIdGenerator.UNKNOWN))
    	{
    		return AdressesIdGenerator.NA;
    	}
    	else
    	{
    		if(depOrRegion.equals(""))
    		{
    			return AdressesIdGenerator.NA;
    		}
    		else
    		{
    			return Normalizer.normalize(depOrRegion, Normalizer.Form.NFD);
    		}
    	}
    }
    
    public static String reNormalizedId(String id)
    {
    	if(id != null && !id.equals(""))
    	{
    		return Normalizer.normalize(id.toLowerCase(), Normalizer.Form.NFD)
    				.replace(" ", "")
    				.replace("-", "")
    				.replace("0000", "")
    				.replace("00000", "")
    				.replace("inconnu", UNKNOWN)
    				.replace("noncommunique", UNKNOWN)
    				.replace("nonconnue", UNKNOWN)
    				.replace("nonconnu",UNKNOWN)
    				.replace("nonrenseigne", UNKNOWN)
    				.trim();
    	}
    	else
    	{
    		return AdressesIdGenerator.UNKNOWN;
    	}
    }
}
