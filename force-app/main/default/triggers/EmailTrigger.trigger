trigger EmailTrigger on Student__c(before insert){
Set<ID> setID= new Set<ID>();
Map<ID,String> mapIns = new Map<ID,String>();
for(Student__c eachStudent: trigger.new){
if(eachStudent.Maths_Instructor__c != null){
  setID.add(eachStudent.Maths_Instructor__c); 
 }
}

for(Instructor__c eachInst: [select ID,Email__c from Instructor__c where ID in :setID] )
    {
        mapIns.put(eachInst.ID,eachInst.Email__c);
    }
    
for(Student__c eachStudent: trigger.new){
eachStudent.Email__c = mapIns.get(eachStudent.Maths_Instructor__c);
}

}