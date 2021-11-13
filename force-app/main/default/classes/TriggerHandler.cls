public abstract class TriggerHandler {
    public void execute() {
        switch on Trigger.operationType {
            when BEFORE_INSERT  { this.beforeInsert(Trigger.new); }
            when BEFORE_UPDATE  { this.beforeUpdate(Trigger.oldMap, Trigger.newMap); }
            when BEFORE_DELETE  { this.beforeDelete(Trigger.oldMap); }
            when AFTER_INSERT   { this.afterInsert(Trigger.newMap); }
            when AFTER_UPDATE   { this.afterUpdate(Trigger.oldMap, Trigger.newMap); }
            when AFTER_DELETE   { this.afterDelete(Trigger.oldMap); }
            when AFTER_UNDELETE { this.afterUndelete(Trigger.newMap); }
        }
    }

    protected virtual void beforeInsert(List<Sobject> newList) {}
    protected virtual void beforeUpdate(Map<Id, Sobject> oldMap, Map<Id, Sobject> newMap) {}
    protected virtual void beforeDelete(Map<Id, Sobject> oldMap) {}
    protected virtual void afterInsert(Map<Id, Sobject> newMap) {}
    protected virtual void afterUpdate(Map<Id, Sobject> oldMap, Map<Id, Sobject> newMap) {}
    protected virtual void afterDelete(Map<Id, Sobject> oldMap) {}
    protected virtual void afterUndelete(Map<Id, Sobject> newMap) {}

    @TestVisible protected Boolean isFieldValueChanged(SObject oldObject, SObject newObject, SObjectField field) {
        Object oldValue = getFieldValue(oldObject, field);
        Object newValue = getFieldValue(newObject, field);
        return oldValue != newValue;
    }

    @TestVisible protected Object getFieldValue(SObject obj, SObjectField field) {
        Object fieldValue = (obj != null) && (field != null) ? obj.get(field) : null;
        return fieldValue;
    }
}