@isTest
public class AccountDataControllerTest {
    public static Account a = new Account ();
    public static AccountDataController controller = new AccountDataController();
    public static AccountDataController.cAccount acc = new AccountDataController.cAccount(a,true);
    
    @testSetup static void setup(){
        a.Name = 'Test Account';
        a.Type = 'Prospect';
        a.AccountNumber = 'P892342';
        a.Rating = 'Hot';
        a.Phone = '9348734728';
        a.BillingState = 'IN'; 
        insert a;
        
        controller.act='Prospect';
        controller.account = a;
        acc.selected = true;
    }
    
    private static TestMethod void TestgetAllAccounts(){
        System.assertEquals(controller.getAllAccounts().size(), 1);
    }
    
    private static TestMethod void TestgetAccountType(){
        controller.act='Prospect';
        controller.accountList= controller.getAccountType();
        System.assertEquals(controller.accountList.size(), 1);
    }
    
    private static TestMethod void TestprocessSelected(){
        controller.accountList = new List<AccountDataController.cAccount>(); 
        acc.selected=true;
        controller.accountList.add(acc);
        controller.processSelected();
        System.assertEquals(controller.getselectedAccounts().size(), 1);
    }
    
    private static TestMethod void TestprocessSelectedwithEmptyAccountList(){
        controller.accountList= controller.getAccountType();
        controller.processSelected();
        System.assertEquals(controller.getselectedAccounts().size(), 0);
    } 
    
    private static TestMethod void TestfindAccountType(){
        ApexPages.currentPage().getParameters().put('AccountType','Customer - Direct');
        controller.findAccountType();
        System.assertEquals(controller.act ,'Customer - Direct' );
    }
    
    
}