public class TanyaController {
	 CustomIterable obj;
    public list<AccountInner> accInnerObj {get;set;}
    
    public TanyaController () {       
        string sQuery = 'SELECT Id, Name, NumberOfEmployees FROM Account Limit 36';
        obj = new CustomIterable(sQuery); 
        obj.setPageSize = 10;
        next();
    }
    
    public Boolean hasNext {
        get {
            return obj.hasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            return obj.hasPrevious();
        }
        set;
    }
    
    public void next() {
        accInnerObj = obj.next();
    }
    
    public void previous() {
        accInnerObj = obj.previous();
    }
}