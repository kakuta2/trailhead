public with sharing class TRG_Invoice extends TriggerHandler {
    public override void beforeInsert(List<Sobject> newList) {
        debugLog('beforeInsert2');
    }
    public override void beforeUpdate(Map<Id, Sobject> oldMap, Map<Id, Sobject> newMap) {
        debugLog('beforeUpdate');

    }
    public override void beforeDelete(Map<Id, Sobject> oldMap) {
        debugLog('beforeDelete');

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
    
    private void debugLog(Object msg){
        system.debug('◆◆TRG_Invoice#' + msg);
    }

}
