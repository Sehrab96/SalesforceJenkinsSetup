public class DatabaseHandler 
{  
    public static void deleteAll()
    {
        List< Schema.SObjectType> CustomObjectList = new List< Schema.SObjectType>(); // List to Store all the Custom Objects
        Map<Schema.SObjectType,List<SObject>> DeleteMap = new Map<Schema.SObjectType,List<SObject>>(); // Map to hold SObject and
        //the record for example -> (Account ,Select ID from ACCOUNT)
        /*Schema.getGlobalDescribe().Values() holds ALL THE OBJECTS in org */
        for(Schema.SObjectType AllObjectsIterator : Schema.getGlobalDescribe().Values()) // Traverse through all the objects
        {
            if(AllObjectsIterator.getDescribe().getName().contains('__c')){     // if current object is custom then add it 
                CustomObjectList.add(Schema.getGlobalDescribe().get(AllObjectsIterator.getDescribe().getName())); // to the CustomObjectList
            }
        } 
        
        for(Schema.SObjectType s : CustomObjectList )
        {
            DeleteMap.put(s,Database.query('select id,Name from ' + s));
        }  
        
        for(List<Sobject> s: DeleteMap.values()){
            System.debug(s);     
            //Delete s; -> Uncomment for Deleting all the Records of Custom Objects  
        }
    }   
}
		
/* 		String str;
        List <Sobject> n ;
        for(Schema.SObjectType s :maps.keySet()){
            str = String.valueOf(s);
            if(str == 'Student__c'){    
               n = (maps.get(s));
                Delete n;
            }
                
        }
         //System.debug(maps);
       
*/