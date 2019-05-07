public with sharing class CustomLookup_ctrl {      
    public String fieldTypeForSelectedField {get;set;}     
    public list<PhoneNumberDetail> listOfLookupsElement {get;set;}
    public String objectName {get;set;}
    public String fieldName {get;set;}
    public boolean isChecked {get;set;}
    public String phoneNumberPassToTextBox {get;set;}
    public String phoneNamePassToHdn {get;set;}
    public boolean isAllSelectCheckBox {get;set;}
    
    public Set<PhoneNumberDetail> selectedContacts {get;set;}
    
    /*Controller*/
    public CustomLookup_ctrl (){
        listOfLookupsElement = new list<PhoneNumberDetail>();        
        objectName = String.escapeSingleQuotes(ApexPages.CurrentPage().getParameters().get('oN'));
        fieldName = String.escapeSingleQuotes(ApexPages.CurrentPage().getParameters().get('fN'));
        isAllSelectCheckBox = false;
        
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
        selectedContacts = new Set<PhoneNumberDetail>();      
        getlistOfLookupsElement();
    }
    
    /*to get list of lookup element*/
    public void getlistOfLookupsElement(){
        try{ 
            listOfLookupsElement = new list<PhoneNumberDetail>();
            String query = 'SELECT Name,'+fieldName+' FROM '+objectName;
            list<SObject> s = Database.query(query);
            
            for(sObject sObj:s){ 
                listOfLookupsElement.add(new PhoneNumberDetail(String.valueOf(sObj.get('Name')),String.valueOf(sObj.get(fieldName)),false));                         
            } 
        }catch(Exception ex){
            apexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Parameter is not defined, Please contact your Administrator!'));
        }       
    }
    
    /*Event for check box checked*/
    public void onCheck(){
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
        for(PhoneNumberDetail pn:listOfLookupsElement){
            if(pn.isChecked){
                
                phoneNumberPassToTextBox +=pn.sObjectPhone+'\n';
                phoneNamePassToHdn += pn.sObjectNameField+'\n';
                    selectedContacts.add(pn);
                }
            
            
        else{
                if(selectedContacts.contains(pn))
                {
                    selectedContacts.remove(pn);
                }
            }
        }
        System.debug(selectedContacts);
    }
    
    /*Event for all select in single check*/
    public void onSelectAll(){
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
      	
            selectedContacts.clear();
        
        for(PhoneNumberDetail pn:listOfLookupsElement){
        		    
            if(isAllSelectCheckBox){
                pn.isChecked = true;
                selectedContacts.add(pn);
            }else{
                pn.isChecked = false;
            }           
            if(pn.isChecked){
                
                phoneNumberPassToTextBox += pn.sObjectPhone+'\n'; 
                phoneNamePassToHdn += pn.sObjectNameField+'\n';                    
            }
        }
        System.debug(selectedContacts);
        
    }
    /*P2l Detail wrapper*/
    public class PhoneNumberDetail{
        public boolean isChecked {get;set;}
        public string sObjectNameField {get;set;}
        public string sObjectPhone {get;set;}
        
        public PhoneNumberDetail(string sObjectNameField,string sObjectPhone,boolean isChecked ){
            this.sObjectNameField = sObjectNameField;
            this.sObjectPhone = sObjectPhone ;
            
            this.isChecked = isChecked ;
            
        }   
        
    }
}