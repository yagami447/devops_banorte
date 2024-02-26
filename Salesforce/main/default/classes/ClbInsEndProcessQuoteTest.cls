@isTest
public class ClbInsEndProcessQuoteTest {
    @testSetup 
    static void setup() {
        Account account = new Account(
            LastName = 'John'
        );
        insert account;
        
        Opportunity opportunity = new Opportunity(
        	Name = 'test opp',
            CloseDate = System.today() + 1,
            StageName = 'Open',
            AccountId = account.Id
        );
        insert opportunity;
        
        Quote quote = new Quote(
            Name = 'Test', 
            OpportunityId = opportunity.Id,
            Pricebook2Id =  Test.getStandardPricebookId()
        );
        insert quote;
    }
    
    
    static testmethod void createPolicy() {
        Test.startTest();  
        
        Quote quote = [SELECT Id, Status FROM Quote WHERE Name='Test' LIMIT 1];
        
        List<String> responseData = ClbInsEndProcessQuote.upsertProposal(new List<Quote>{
            quote
        });    
       
        System.assertEquals(false, responseData.isEmpty());
        Test.stopTest();
 
    }
}