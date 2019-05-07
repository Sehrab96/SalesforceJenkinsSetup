public class AccountsController {
    public string AccountName {get;set;}
    public Contact c {get;set;}
    public String LastName{get;set;}
    public String FirstName{get;set;}
    public Integer Phone{get;set;}
    public String RadioValue{get;set;}
    public Boolean ChooseExisting {get;set;}
    public Boolean NewAccount {get;set;}
    public String NewAccountName {get;set;}
     
    public List<Contact> contactList = new List<Contact>();
  
    public AccountsController(){
        ChooseExisting = false;
        NewAccount = false;
    }
    public List<SelectOption> getAllAccounts() { 
        List<SelectOption> options = new List<SelectOption>();
        List<Account> AccountList =[Select Name from Account];
        
      
        options.add(new SelectOption('','--None--'));
        for(Account a : AccountList)
        {
            options.add(new SelectOption(a.Name,a.Name));
        }
        return options;
    }   
    
    public void ShowDiv(){
        if(RadioValue == 'Choose Existing' ){
            ChooseExisting=true;
            NewAccount= false;
        }if(RadioValue == 'New Account' ){
            ChooseExisting=false;
            NewAccount= true;
        }
        

        
    }
    
    public List<SelectOption> getRadioOptions(){
        List<selectOption> options= new List<selectOption>();
        options.add(new SelectOption('Choose Existing','Choose Existing'));
        options.add(new SelectOption('New Account','New Account'));
        return options;
    }
    public List<Contact> getAllContacts()
    {
        if(AccountName != NULL || AccountName != '' || AccountName != '--None--')
        {
            return [Select FirstName,LastName,Phone from Contact where Account.Name = :AccountName];
        }
           
        return [Select LastName,Phone from Contact];
    }
      
      public void AddNewContact(){
          System.debug(LastName + Phone);
          c= new Contact();
          c.LastName = LastName;
          c.phone = String.valueOf(Phone);
          insert c;
      }
    
    }