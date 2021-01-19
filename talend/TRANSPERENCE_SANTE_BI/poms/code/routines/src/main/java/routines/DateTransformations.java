package routines;

import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

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
public class DateTransformations {
	private final static String saisons[] =
	{
		"Hiver", "Hiver", "Printemps", "Printemps", "Ete", "Ete", 
		"Ete", "Ete", "Automne", "Automne", "Hiver", "Hiver"
	};
	
    
    /**
     * getAnnee: returns the year of a given date
     * 
     * 
     * {talendTypes} Date
     * 
     * {Category} User Defined
     * 
     * {param} Date input: The processed date
     * 
     * {example} date.toString() = "01-01-1998" -->  getYear(date) = 1998
     */
    public static int getAnnee(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	return c.get(Calendar.YEAR);
    }
    
    /**
     * getTrimestre: returns the trimester of a given date
     * 
     * 
     * {talendTypes} Date
     * 
     * {Category} User Defined
     * 
     * {param} Date input: The processed date
     * 
     * {example} date.toString() = "01-01-1998" -->  getQuarter(date) = Trimestre 1
     */
    public static String getTrimestre(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	int month = c.get(Calendar.MONTH);
		return (month >= Calendar.JANUARY && month <= Calendar.MARCH)     ? "T1" :
		       (month >= Calendar.APRIL && month <= Calendar.JUNE)        ? "T2" :
		       (month >= Calendar.JULY && month <= Calendar.SEPTEMBER)    ? "T3" :
		                                                                    "T4" ;
    }
    
    
   /**
    * getSemestre: returns the semester of a given date
    * 
    * 
    * {talendTypes} Date
    * 
    * {Category} User Defined
    * 
    * {param} Date input: The processed date
    * 
    * {example} date.toString() = "01-01-1998" -->  getQuarter(date) = Semestre 1
    */
    public static String getSemestre(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	int month = c.get(Calendar.MONTH);
		return (month >= Calendar.JANUARY && month <= Calendar.JUNE) ? "Semestre 1" : "Semestre 2";
    }
    
    /**
     * getMois: returns the French month of a given date
     * 
     * 
     * {talendTypes} Date
     * 
     * {Category} User Defined
     * 
     * {param} Date input: The processed date
     * 
     * {example} date.toString() = "01-01-1998" -->  getMonth(date) = Janvier
     */
    public static String getMois(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	return c.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.FRENCH);
    }
    
    
    /**
     * getMois: returns the French month of a given date
     * 
     * 
     * {talendTypes} Date
     * 
     * {Category} User Defined
     * 
     * {param} Date input: The processed date
     * 
     * {example} date.toString() = "01-01-1998" -->  getMonth(date) = Janvier
     */
    public static String getSaison(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	int month = c.get(Calendar.MONTH);
    	return DateTransformations.saisons[month];
    }
    
    public static int getNumJourMois(Date date)
    {
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	return c.get(Calendar.DAY_OF_MONTH);
    }
}
