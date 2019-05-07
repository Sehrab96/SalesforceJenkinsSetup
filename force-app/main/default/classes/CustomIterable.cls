global class CustomIterable implements Iterator<list<AccountInner>>{ 

   List<Account> accs {get; set;} 
   list<AccountInner> accInnerList {get; set;} 
   list<AccountInner> accInnerListRequested {get; set;} 
   AccountInner accInnerObj;
   Integer i {get; set;} 
   public Integer setPageSize {get; set;} 

   public CustomIterable(string sQuery){ 
       //accs = [SELECT Id, Name, NumberOfEmployees FROM Account Limit 36]; 
       accs = Database.Query(sQuery);
       accInnerList = new list<AccountInner>(); 
       accInnerListRequested = new list<AccountInner>();     
       for(Account a : accs) {
            accInnerObj = new AccountInner(false, a);
            accInnerList.add(accInnerObj);
       } 
       setPageSize = 10;
       i = 0; 
   }   

   global boolean hasNext(){ 
       if(i >= accInnerList.size()) {
           return false; 
       } else {
           return true; 
       }
   } 
   
   global boolean hasPrevious(){ 
       system.debug('I am in hasPrevious' + i);
       if(i <= setPageSize) {
           return false; 
       } else {
           return true; 
       }
   }   

   global list<AccountInner> next(){       
       system.debug('i value is ' + i);
       accInnerListRequested = new list<AccountInner>(); 
       integer startNumber;
       integer size = accInnerList.size();
       if(hasNext())
       {  
           if(size <= (i + setPageSize))
           {
               startNumber = i;
               i = size;
           }
           else
           {
               i = (i + setPageSize);
               startNumber = (i - setPageSize);
           }
           
           system.debug('i value is =====' + i);
           system.debug('i value is 2==== ' + (i - setPageSize));
           
           for(integer start = startNumber; start < i; start++)
           {
               accInnerListRequested.add(accInnerList[start]);
           }
       } 
       return accInnerListRequested;
   } 
   
   global list<AccountInner> previous(){      
       accInnerListRequested = new list<AccountInner>(); 
       system.debug('i value is previous before =====' + i);
       integer size = accInnerList.size(); 
       if(i == size)
       {
           if(math.mod(size, setPageSize) > 0)
           {    
               i = size - math.mod(size, setPageSize);
           }
           else
           {
               i = (size - setPageSize);
           } 
       }
       else
       {
           i = (i - setPageSize);
       }
       
       system.debug('i value is previous =====' + i);
       system.debug('i value is 2previous ==== ' + (i - setPageSize));
       
       for(integer start = (i - setPageSize); start < i; ++start)
       {
           accInnerListRequested.add(accInnerList[start]);
       } 
       return accInnerListRequested;
   }   
}