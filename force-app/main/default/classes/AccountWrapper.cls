public with sharing class AccountWrapper {
    @AuraEnabled(cacheable=true)
    public static List<AccountListWrapper> getAllAccWithConCasesOpps(){
        List<AccountListWrapper> accWrapperList = new List<AccountListWrapper>();
        List<Account> accList = [SELECT Id, Name,
                                    (SELECT Id, FirstName, LastName, Name From Contacts),
                                    (SELECT Id, Name From Opportunities),
                                    (SELECT Id, CaseNumber From Cases)
                                    FROM Account LIMIT 5];

        if(!accList.isEmpty()){
            for(Account acc : accList){
                AccountListWrapper accWrapper = new AccountListWrapper();
                accWrapper.accRecord = acc;
                accWrapper.contactList = acc.Contacts;
                accWrapper.oppList = acc.Opportunities;
                accWrapper.casesList = acc.Cases;
                accWrapperList.add(accWrapper);
            }
        }

        return accWrapperList;
    }
      
    // wrapper class with @AuraEnabled and {get; set;} properties 
    public class AccountListWrapper{
        @AuraEnabled
        public Account accRecord{get;set;}
        @AuraEnabled
        public List<Contact> contactList{get;set;}
        @AuraEnabled
        public List<Opportunity> oppList{get;set;}
        @AuraEnabled
        public List<Case> casesList{get;set;}
    }
}
