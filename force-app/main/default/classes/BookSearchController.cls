public class BookSearchController {
    public Book__c book {get;set;} // Book type variable for Genre Field Binding on VF
    public String Genre {get;set;} // Variable to Store Genre Type from VF
    public String Authors{get;set;}// Variable to Store Author Name from VF 
    public String Publishers{get;set;} // Variable to Store Publisher Name from VF
    public String RadioValue {get;set;} // Variable to Store the Value of Radio to Show the Div
    public Boolean ShowGenre{get;set;} // Boolean Variable when true shows Genre Sort Picklist
    public Boolean ShowAuthor{get;set;} // Boolean Variable when true shows Author Sort Picklist
    public Boolean ShowPublisher{get;set;} // Boolean Variable when true shows Publisher Sort Picklist
    
    
    public BookSearchController() // Constructor disables all 3 Divs Visibility
    {
        ShowGenre = false;
        ShowAuthor = false;
        ShowPublisher = false;
    }
    
    public void ShowDiv(){ // Controls the Div with Sort Option's Visibility
        if(RadioValue=='Genre'){
            ShowGenre = true;
            ShowAuthor = false;
            ShowPublisher = false;
        }
        if(RadioValue=='Author'){
            ShowAuthor = true;
            ShowGenre = false;
            ShowPublisher = false;
        }
        if(RadioValue=='Publisher'){
            ShowPublisher = true;
            ShowGenre = false;
            ShowAuthor= false;
        }
    }
    
    public List<SelectOption> getRadioOptions() { // retuns RadioOptions for Radio to control The Sort Process
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Genre','Genre')); 
        options.add(new SelectOption('Author','Author')); 
        options.add(new SelectOption('Publisher','Publisher'));
        return options; 
    }
    
    public List<SelectOption> getAllAuthors() { // returns Picklist Values with All Author Names
        List<SelectOption> options = new List<SelectOption>();
        List<Author__c> authorList =[Select Name from Author__c];
        options.add(new SelectOption('','--None--'));
        for(Author__c a : authorList)
        {
            options.add(new SelectOption(a.Name,a.Name));
        }
        return options;
    }   
    
    public List<SelectOption> getAllPublishers() {//returns Picklist Values with All Publisher Names
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
        List<Publisher__c> publisherList = [Select Name from Publisher__c];
        for(Publisher__c a : publisherList)
        {
            options.add(new SelectOption(a.Name,a.Name));
        }
        return options;
    }    
    
    public void GenreValue() { // Works with Javascript to Fetch the value of a Picklist which is Dynamically bind with InputField
        Genre = System.currentPageReference().getParameters().get('Genre');  
        if(Genre==''){
            Genre = NULL;
        }
    }   
    
    public List<Book__c> getAllBookList(){ // Returns List of Books depending on Search Criteria
        {
            if(Genre!=NULL)
            {	   
                List <Book__c> BookList =  [Select  Name , Id , Author_Name__c, Publisher_Name__c,Genre__c from Book__c where Genre__c= :Genre order by Name]; 
                Genre=NULL;
                return BookList;
            }
            else if(Authors!=NULL)
            {	List <Book__c> BookList = [Select  Name , Author_Name__c, Publisher_Name__c,Genre__c from Book__c where Author_Name__c in (Select ID from Author__c where Name = :Authors) order by Name];
             Authors=NULL;	
             return BookList;    
            }
            else if(Publishers!=NULL)
            {	
                List <Book__c> BookList = [ Select  Name , Author_Name__c, Publisher_Name__c,Genre__c from Book__c where Publisher_Name__c in (Select ID from Publisher__c where Name = :Publishers) order by Name] ;
                Publishers = NULL; 
                return BookList;
            }
            return [Select  Name , Id , Author_Name__c, Publisher_Name__c,Genre__c from Book__c order by Name];    
        }
        
    }
}