package internal;

import routines.DataOperation;
import routines.Mathematical;
import routines.Numeric;
import routines.Relational;
import routines.StringHandling;
import routines.TalendDataGenerator;
import routines.TalendDate;
import routines.TalendStringUtil;
import routines.TalendString;
import routines.EvenementConventionIdGenerator;
import routines.ObjetConventionIdGenerator;
import routines.NatureAvantageIdGenerator;
import routines.DateTransformations;
import routines.MyStringRoutine;
import routines.system.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;

@SuppressWarnings("unused")

public class TalendJavaSourceViewer59 {
	private static java.util.Properties context = new java.util.Properties();
	private static final java.util.Map<String, Object> globalMap = new java.util.HashMap<String, Object>();
	public void myFunction(){
	  if( 

// code sample : use input_row to define the condition.
// input_row.columnName1.equals("foo") ||!(input_row.columnName2.equals("bar"))
// replace the following expression by your own filter condition 
!(input_row.ISO3166_1_Alpha_2.replaceAll("[^A-Za-z0-9]", "")).equals("")&& !(input_row.official_name_fr.replaceAll("[^A-Za-z0-9]", "")).equals("") &&
input_row.ISO3166_1_Alpha_2 != null && input_row.official_name_fr != null
			
){
	}
	
}
}