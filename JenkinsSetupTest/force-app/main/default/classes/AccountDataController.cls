public class AccountDataController {
    public Account account {get;set;} // Object of Account used for Binding InputFields in Visual Force page
    public List<cAccount> accountList {get; set;} // List of cAccount Class(Wrapper Class)
    public  String act {get;set;} // String Variable to Store the Value of Type using a JavaScript Function
    public  Integer flag = 0; // Integer Variable for Error Displaying 
    
    public List<Account> getAllAccounts(){ // Returns the List of All Accounts
        return [Select Name,Type from Account];    
    }
    
    public List<cAccount> getAccountType(){ // This method returns a list of account where Type = ACT(String Variable)
        
        if( act!=NULL){     // Initally When Type is not choosen , Act is NULL . Comparing Account.Type with NULL will throw error
            accountlist= new List<cAccount>(); // Memory Allocation to the List
            for(Account a :[Select Name,Rating,Phone,BillingState,AccountNumber from Account where Type = :act])
            {
                accountlist.add(new cAccount(a,false)); // Insertion into List -> New cAccount with Account as 'a' and Boolean Checkbox = false ;
            }
        }
        return accountlist;
    }
    
    public List<Account> selectedAccounts = new List<Account>(); // Another List to store the Accounts for which Checkbox is selected
    
    public PageReference processSelected(){ // This Method adds the Accounts with Checkbox as true into SelectedAccounts List
        PageReference p = null;
        selectedAccounts.clear(); // Clears the List if it is having any previous records , else it may fetch values for other types
        flag = 1; // Flag = 0 shows that page has been loaded for first time and doesn't need to display Error . Setting it as '1' shows now if there is no checkbox selected Error should be displayed
        if(accountlist!=NULL){ // account list will NULL if No Account Type is choosen 
            for(cAccount cAcc :accountlist){
                if(cAcc.selected==true)
                {
                    selectedAccounts.add(cAcc.acc); // Adding Accounts to SelectedAccounts List if checkbox is true;
                }
            }
        }
        else{ // Error Display
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select Account Type');
            ApexPages.addMessage(myMsg); 
        }
        return p;
    }
    
    public List<Account> getSelectedAccounts() // This Method returns the List of Accounts Selected in Last Method
    {
        if(selectedAccounts.isEmpty() && flag == 1)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select Atleast One Account	');
            ApexPages.addMessage(myMsg); 
        }
        return selectedAccounts;
    }
    
    
    public void findAccountType() { // Works With JavaScript , Fetches Value of AccountType selected from Picklist 
        act =System.currentPageReference().getParameters().get('AccountType');  
    }
    
    public class cAccount { //Inner Class to Bind Each Account with A Checkbox 
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        public cAccount(Account a , Boolean Selected) {
            acc = a;
            selected = Selected;
            System.debug('Test');
        }
    }
}