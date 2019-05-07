public class RoomController {
    public static Room__c room = new Room__c();
    public static Temp_Room__c temproom = new Temp_Room__c();
    public static String RoomName {get;set;}
    public static Integer NumberofSystem {get;set;}
    
    public PageReference Save(){
        room.Name = RoomName;
        room.Number_of_System__c =NumberofSystem;
        insert room;
        return NULL;
    }
    public PageReference SaveasDraft(){
        temproom.Name = RoomName;
        temproom.Number_of_System__c =NumberofSystem;
        insert temproom;
        return NULL;
    }

}