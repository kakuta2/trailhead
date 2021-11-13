public with sharing class TRG_InvoiceDetail extends TriggerHandler {
    public override void beforeInsert(List<Sobject> newList) {
        debugLog('beforeInsert');
        exec(newList);
    }
    public override void beforeUpdate(Map<Id, Sobject> oldMap, Map<Id, Sobject> newMap) {
        debugLog('beforeUpdate');
//        exec(newMap);
    }
    public override void beforeDelete(Map<Id, Sobject> oldMap) {
        debugLog('beforeDelete');
//        exec(oldMap);
    }

    public override void afterInsert(Map<Id, Sobject> newMap) {
        debugLog('afterInsert');
    }
    public override void afterUpdate(Map<Id, Sobject> oldMap, Map<Id, Sobject> newMap) {
        debugLog('afterUpdate');
    }
    public override void afterDelete(Map<Id, Sobject> oldMap) {
        debugLog('afterDelete');
    }
    public override void afterUndelete(Map<Id, Sobject> newMap) {
        debugLog('afterUndelete');
    }

    private void exec(Sobject[] details){
        debugLog('exec' + details);


        //請求明細の親請求IDを取得
        Set<Id> detailIdSet = new Set<Id>();
        for(InvoiceDetail__c detail:(InvoiceDetail__c[])details){
            debugLog('detail:' + detail.invoice__c);
            detailIdSet.add(detail.invoice__c);
        }

        //引数で渡された請求明細で、親請求の請求明細作成ステータスが「作成中」のものを取得
        //Invoice__c
        //InvoiceDetail__c
        //List<Invoice__c> invoiceList = [
        Map<Id,Invoice__c> invoiceIdMap = new Map<Id,Invoice__c>([
            SELECT ID
//            SELECT ID,Name ,(SELECT ID, Name From InvoiceDetail__r WHERE Invoice__c IN :detailIdSet) 
            FROM Invoice__c 
            WHERE status__c = '1'
            AND ID IN:detailIdSet
            ]);

        //請求明細作成ステータスが「作成中」のものが0より大きい場合
        if(invoiceIdMap.size() > 0){
            debugLog('invoiceIdMap:' + invoiceIdMap);
            Set<ID> invoiceIdSet = invoiceIdMap.keySet();
    //            debugLog(invoiceList.InvoiceDetail__r);
    
            //親の請求のステータスが「１」だった時にaddErrorする
            for(InvoiceDetail__c detail:(InvoiceDetail__c[])details){
                if(invoiceIdSet.contains(detail.invoice__c)){
                    detail.addError('作成中なのでだめです！');
                }
            }
    
        }

    }

    private void debugLog(Object msg){
        system.debug('◆◆TRG_InvoiceDetail#' + msg);
    }

}