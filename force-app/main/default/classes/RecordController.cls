public with sharing class RecordController {

public class applicationException extends Exception {}

public static boolean mycheckval { get; set; }
public List<selectOption> getRecordTypes() {
        List<selectOption> options = new List<selectOption>(); 
        options.add(new selectOption('', ' ')); 
        for(Address__c record : [SELECT Id,Name FROM Address__c])
         { 
            options.add(new selectOption(record.id, record.Name)); 
         }
        return options;
}

public static void check(){
    if(mycheckval){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Can\'t Change Primary Address'));
}
}
public String selectedrecordtype{get;set;}
}