global  class SampleBatch implements  Database.Batchable<sObject>, Database.Stateful{

    public static final Integer COUNT = 2;
    public List<String> erroMsgList;
    public List<String> okMsgList;
    public Integer index;
    public List<Exception> exList;
    


    public SampleBatch(){
        erroMsgList = new List<String>();
        okMsgList = new List<String>();
        index= 0 ;
        exList = new List<Exception>();
    }

    global Database.querylocator start(Database.BatchableContext BC){
        System.debug('start');
        return Database.getQueryLocator('SELECT Id,Name,counter__c FROM Invoice__c ' + 
                                        'WHERE Name like \'TEST%\' ORDER BY Name');
    }

    global void execute(Database.BatchableContext BC, List<Invoice__c> scope){
        System.debug('execute');
        System.debug('scopesize:'+ scope.size());
        index += 1;

        List<Invoice__c> invoiceList = new List<Invoice__c>();

        for(Invoice__c invoice: scope){
            System.debug(invoice.Name);
            invoice.counter__c = invoice.counter__c + 1;
            invoiceList.add(invoice);
        }
        
        try{

            update invoiceList;
        }catch(Exception e){
            String errMsg = index + ':test' + scope.size();
            erroMsgList.add(errMsg);
            exList.add(e);
            System.debug('Exception:' + e.getMessage());
            throw e;
        }

        
        // try{
        //     if(scope.size() >= COUNT){
        //         //throw new MyException('test');
        //     }
        // }catch(Exception e){
        //     String errMsg = index + ':test' + scope.size();
        //     erroMsgList.add(errMsg);
        //     exList.add(e);
        //     System.debug('Exception:' + e.getMessage());
        //     throw e;
        // }

        String okMsg = index + ':test' + scope.size();
        okMsgList.add(okMsg);   

    }

    global void finish(Database.BatchableContext BC){
        System.debug('finish');

        AsyncApexJob a = [SELECT Id, Status, ExtendedStatus,NumberOfErrors, JobItemsProcessed,
                TotalJobItems, CreatedBy.Email
                FROM AsyncApexJob WHERE Id =:BC.getJobId()];
System.debug(a.Status);
System.debug(a.NumberOfErrors);
System.debug(a.JobItemsProcessed);
System.debug(a.TotalJobItems);
System.debug(a.ExtendedStatus);
System.debug('erroMsgList:' + erroMsgList.size());
System.debug('okMsgList:' + okMsgList.size());
System.debug('exList:' + exList.size());



for(String msg: erroMsgList){
    System.debug('errMsg:' + msg);
}
 
for(String msg: okMsgList){
    System.debug('okMsg:' + msg);
}
for(Exception ex: exList){
    System.debug('exception:' + ex.getMessage());
}

        // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // mail.setToAddresses(new String[]{'mokamoto@salesforce.com'});
        // mail.setReplyTo('noreply@salesforce.com');
        // mail.setSenderDisplayName('Batchプロセス');
        // mail.setSubject('Batch完了');
        // mail.setPlainTextBody('Batch完了しました。エラー' + a.NumberOfErrors +'件');
        // Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }    
    class MyException extends Exception{}
}