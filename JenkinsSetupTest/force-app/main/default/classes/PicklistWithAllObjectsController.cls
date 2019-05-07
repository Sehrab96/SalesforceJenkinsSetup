public class PicklistWithAllObjectsController {
    public string selectedObject { get; set; }
    public string currentfield { get; set; }
    
    public List<selectoption> getObjects() {
        List<selectoption> objects = new List<selectoption>();
        objects.add(new selectoption('--None--','--None--'));
        map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
        
        //System.debug(describe);
        for(string objectname:describe.keyset()) {
            System.debug(objectname);
            if(!(objectname.contains('history') || objectname.contains('feed')|| objectname.contains('share') ))
               {
            objects.add(new selectoption(objectname,describe.get(objectname).getdescribe().getname()));
            }}
        return objects;
    }
    
    
  public List<selectoption> getFields() {
		List<selectoption> fields = new List<selectoption>();
		map<string,schema.sobjecttype> describe = schema.getglobaldescribe();
      
		if(describe.containskey(selectedObject)) {
			map<string,schema.sobjectfield> fieldmap = describe.get(selectedObject).getdescribe().fields.getmap();
			for(string fieldname:fieldmap.keyset()) {
				fields.add(new selectoption(fieldname,fieldmap.get(fieldname).getdescribe().getlabel()));
			}
		}
		return fields;
	}
    
}


/*
 * 
    
    public PageReference loadfields(){
        return null;
    }*/