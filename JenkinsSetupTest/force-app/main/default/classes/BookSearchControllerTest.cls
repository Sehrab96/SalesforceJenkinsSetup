@isTest
global class BookSearchControllerTest {
    
     static Book__c Book = new Book__c(); 
     static Book__c Book2 = new Book__c();
     static Author__c Author = new Author__c();
     static Author__c Author2 = new Author__c();
     static Publisher__c Publisher = new Publisher__c();
     static Publisher__c Publisher2 = new Publisher__c();     
     static BookSearchController controller = new BookSearchController();
    
    @testSetup static void setup(){
        /*INSERTING TEST-DUMMY DATA*/
        Author.Name = 'Author';
        Publisher.Name = 'Publisher';
        insert Author; 
        insert Publisher;
        Book.Name = 'Book';
        Book.Author_Name__c = Author.ID;
        Book.Publisher_Name__c = Publisher.ID;
        Book.Genre__c = 'Comedy';
        insert Book;
        
        Author2.Name = 'Author2';
        Publisher2.Name = 'Publisher2';
        insert Author2;
        insert Publisher2;
        Book2.Name = 'Book2';
        Book2.Author_Name__c = Author2.ID;
        Book2.Publisher_Name__c = Publisher2.ID;
        Book2.Genre__c = 'Fantasy';
        insert Book2;
        
        controller.book = Book;
        controller.Genre = 'Comedy';
        controller.Authors = 'Author';
        controller.Publishers = 'Publisher';
    }
    
    @isTest static void TestShowDivGenre(){
        Test.startTest();
        controller.RadioValue = 'Genre';
        controller.ShowDiv();
        System.assertEquals(controller.ShowGenre,true);
        System.assertEquals(controller.ShowAuthor,false);
        System.assertEquals(controller.ShowPublisher,false);      
        Test.stopTest();
    }
    
    @isTest static void TestShowDivAuthor(){
        Test.startTest();
        controller.RadioValue = 'Author';
        controller.ShowDiv();
        System.assertEquals(controller.ShowGenre,false);
        System.assertEquals(controller.ShowAuthor,true);
        System.assertEquals(controller.ShowPublisher,false);
        Test.stopTest();
    }
    
    @isTest static void TestShowDivPublisher(){
        Test.startTest();
        controller.RadioValue = 'Publisher';
        controller.ShowDiv();
        System.assertEquals(controller.ShowGenre,false);
        System.assertEquals(controller.ShowAuthor,false);
        System.assertEquals(controller.ShowPublisher,true);
        Test.stopTest();
    }
    
    @isTest static void TestgetRadioOptions(){
        Test.startTest();
        controller.RadioValue = 'Publisher';
        System.assertEquals(controller.getRadioOptions().size(),3); // Values are Genre , Author and Publisher
        Test.stopTest();
    }
    
    @isTest static void TestgetAllAuthors(){
        Test.startTest();
        controller.RadioValue = 'Publisher';
        System.assertEquals(controller.getAllAuthors().size(),3); // Values are --None-- , Author , Author2
        Test.stopTest();
    }
    
    @isTest static void TestgetAllPublishers(){
        Test.startTest();
        controller.RadioValue = 'Publisher';
        System.assertEquals(controller.getAllPublishers().size(),3); // Values are --None-- , Publisher , Publisher2
        Test.stopTest();
    }
    
    @isTest static void TestNoneGenreValue(){
        Test.startTest();
        ApexPages.currentPage().getParameters().put('Genre','');
        controller.GenreValue();
        System.assertEquals(controller.Genre,NULL);
        Test.stopTest();
    }
    
    @isTest static void TestOtherGenreValue(){
        Test.startTest();
        ApexPages.currentPage().getParameters().put('Genre','Horror');
        controller.GenreValue();
        System.assertEquals(controller.Genre,'Horror');
        Test.stopTest();
    }
    
    @isTest static void TestAllNullgetAllBookList(){
        
        Test.startTest();
        controller.Genre = NULL;
        controller.Authors = NULL;
        controller.Publishers = NULL;
        System.assertEquals(controller.getAllBookList().size(),2);
        Test.stopTest();
    }
    
    @isTest static void TestGenregetAllBookList(){
        Test.startTest();
        controller.Genre = 'Comedy';
        System.assertEquals(controller.getAllBookList().size(),1);
        Test.stopTest();       
    }
    
    @isTest static void TestAuthorgetAllBookList(){
        Test.startTest();
        controller.Authors = 'Author';
        System.assertEquals(controller.getAllBookList().size(),1);
        Test.stopTest();
    }
    
    @isTest static void TestPublishergetAllBookList(){
        Test.startTest();
        controller.Publishers = 'Publisher';
        System.assertEquals(controller.getAllBookList().size(),1);
        Test.stopTest();
    }
}