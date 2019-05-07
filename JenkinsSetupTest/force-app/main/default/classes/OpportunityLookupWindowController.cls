public class OpportunityLookupWindowController {
    public String searchString { get; set; }  
    public String accountId { get; set; }  
    public String opportunityId { get; set; }  
    
    public List<User> users { get; set; }  
    public OpportunityLookupWindowController(){  
        this.searchString = Apexpages.currentPage().getParameters().get('searchString');  
        this.accountId = Apexpages.currentPage().getParameters().get('accountId');  
        this.opportunityId = Apexpages.currentPage().getParameters().get('opportunityId');  
        this.retrieveTeamMembers();  
    }
    
    public void retrieveTeamMembers(){  
        if(this.searchString != null && this.searchString != ''){  
            performSearch();  
        }
        else {  
             
            this.users = [  
                SELECT Id, Name, FirstName, LastName, Email, Phone, Profile.Name, Profile.UserType   
                FROM User   
                ORDER BY LastName ASC, FirstName ASC];  
        }  
    }
    
    public void performSearch(){  
        String query = 'SELECT Id, Name, FirstName, LastName, Email, Phone, Profile.Name, Profile.UserType'  
            + ' FROM User'  
            + ' WHERE isActive = true'  
            + ' AND Profile.UserType = \'Standard\'';  
        if(this.searchString != null && this.searchString != ''){  
            query += ' AND (Name LIKE \'%' + String.escapeSingleQuotes(this.searchString) + '%\' OR Phone LIKE \'%' + String.escapeSingleQuotes(this.searchString) + '%\' OR Email LIKE \'%' + String.escapeSingleQuotes(this.searchString) + '%\')';  
        }       
        query += ' ORDER BY LastName ASC, FirstName ASC';  
        this.users = database.query(query);  
    }
    
}