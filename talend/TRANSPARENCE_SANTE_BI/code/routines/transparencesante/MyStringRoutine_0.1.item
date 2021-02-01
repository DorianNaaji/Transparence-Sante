package routines;

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
public class MyStringRoutine {
	public static String dateRegex = "^(?:(?:(?:0?[13578]|1[02])"
			+ "(\\/|-|\\.)31)\\1|(?:(?:0?[1,3-9]|1[0-2])(\\/|-|\\.)"
			+ "(?:29|30)\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})"
			+ "$|^(?:0?2(\\/|-|\\.)29\\3(?:(?:(?:1[6-9]|[2-9]\\d)"
			+ "?(?:0[48]|[2468][048]|[13579][26])|"
			+ "(?:(?:16|[2468][048]|[3579][26])00))))$|"
			+ "^(?:(?:0?[1-9])|(?:1[0-2]))(\\/|-|\\.)"
			+ "(?:0?[1-9]|1\\d|2[0-8])\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$";

	/**
	 * isNumeric: returns check if a string is a number
     * 
     * 
     * {talendTypes} Boolean
     * 
     * {Category} User Defined
     * 
     * {param} String input: The processed string
     * 
     * {example} string.toString() = "1998" -->  isNumeric(string) = true
	 */
	public static boolean isNumeric(String string) {
		String resultat = string.replaceAll("[^0-9]", "");
		return resultat.length() != 0;
	}
	
	public static boolean isNumericV2(String str) { 
		  try {  
		    Long.parseLong(str);  
		    return true;
		  } catch(NumberFormatException e){  
		    return false;  
		  }  
		}
	
	/**
	 * isFloat: returns check if a string is a number
     * 
     * 
     * {talendTypes} Boolean
     * 
     * {Category} User Defined
     * 
     * {param} String input: The processed string
     * 
     * {example} string.toString() = "1998.01" -->  isFloat(string) = true
	 */
	public static boolean isFloat(String string) {
		String floatRegex="^([+-]?\\d*\\.?\\d*)$";
		if(string.matches(floatRegex)) {
			 return true;
		 }
		 return false;
	}
	
	
	/**
	 * isDate: returns check if a string is respect a date format
     * 
     * 
     * {talendTypes} Boolean
     * 
     * {Category} User Defined
     * 
     * {param} String input: The processed string
     * 
     * {example} string.toString() = "01-01-1998" -->  isDate(string) = true
	 *  
	 */
	public static boolean isDate(String string) {
		 if(string.matches(dateRegex) && string.length() > 0) {
			 return true;
		 }
		 return false;
	 }
	
	/**
	 * concat: concat 3 string, replace the string which is null with N/A
     * 
     * 
     * {talendTypes} Boolean
     * 
     * {Category} User Defined
     * 
     * {param} String string: The processed string
     * {param} String string2: The processed string
     * {param} String string3: The processed string
     * 
     * {example} string = null  && string2 = null && string3 = c -->  concat(String string, String string2, String string3) = N/AN/Ac
     * {example} string = a  && string2 = null && string3 = c  -->  concat(String string, String string2, String string3) = aN/Ac
	 * {example} string = null  && string2 = b && string3 = c  -->  concat(String string, String string2, String string3) = N/Abc
	 * {example} string = a  && string2 = b && string3 = c  -->  concat(String string, String string2, String string3) = abc
	 */
	public static String concat(String string, String string2, String string3) {
		string = string == null ? "N/A" : string;
		string2 = string2 == null ? "N/A" : string2;
		string3 = string3 == null ? "N/A" : string3;
		return string + string2 + string3;
	}
	
}
